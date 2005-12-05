From: Dirk Jagdmann <doj@cubic.org>
Subject: Re: [patch] split interleaved files in arecord when
 reaching 2GB
Date: Tue, 06 Dec 2005 00:24:45 +0100
Message-ID: <4394CC3D.1010108@cubic.org>
References: <43917AE1.3020002@cubic.org> <s5hr78rl01f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040108030406030600000503"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr78rl01f.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040108030406030600000503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

> It's a nice idea.  But, I prefer this as an option.
> For example, there is no 2GB limit for the raw format.
> We can set this on automatically for WAV format, though...

You're right. it makes no sense to split raw and au files. I have 
modified my patch to work with the fileformat table fmt_rec_table my 
adding a variable max_filesize. File split is set to ~2GB for wav, ~16MB 
for voc and LLONG_MAX for au and raw (which should not be reached in 
practice).

-- 
---> Dirk Jagdmann ^ doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org

--------------040108030406030600000503
Content-Type: text/plain;
 name="aplay-splitfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aplay-splitfiles.patch"

Index: alsa-utils-1.0.10/aplay/aplay.c
===================================================================
--- alsa-utils-1.0.10.orig/aplay/aplay.c	2005-12-05 23:16:19.000000000 +0100
+++ alsa-utils-1.0.10/aplay/aplay.c	2005-12-05 23:36:44.000000000 +0100
@@ -124,11 +124,12 @@
 	void (*start) (int fd, size_t count);
 	void (*end) (int fd);
 	char *what;
+	long long max_filesize;
 } fmt_rec_table[] = {
-	{	NULL,		end_raw,	N_("raw data")	},
-	{	begin_voc,	end_voc,	N_("VOC")	},
-	{	begin_wave,	end_wave,	N_("WAVE")	},
-	{	begin_au,	end_au,		N_("Sparc Audio")}
+	{	NULL,		end_raw,	N_("raw data"),		LLONG_MAX },
+	{	begin_voc,	end_voc,	N_("VOC"),		16000000 },
+	{	begin_wave,	end_wave,	N_("WAVE"),		2000000000 },
+	{	begin_au,	end_au,		N_("Sparc Audio"),	LLONG_MAX }
 };
 
 #if __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 95)
@@ -1985,33 +1986,6 @@
 	snd_pcm_drain(handle);
 }
 
-/* capturing raw data, this proc handels WAVE files and .VOCs (as one block) */
-
-void capture_go(int fd, off64_t count, int rtype, char *name)
-{
-	size_t c;
-	off64_t cur;
-	ssize_t r, err;
-
-	header(rtype, name);
-	set_params();
-
-	do {
-		for (cur = count; cur > 0; cur -= r) {
-			c = (cur <= chunk_bytes) ? cur : chunk_bytes;
-			c = c * 8 / bits_per_frame;
-			if ((size_t)(r = pcm_read(audiobuf, c)) != c)
-				break;
-			r = r * bits_per_frame / 8;
-			if ((err = write(fd, audiobuf, r)) != r) {
-				perror(name);
-				exit(EXIT_FAILURE);
-			}
-			if (err > 0)
-				fdcount += err;
-		}
-	} while (rtype == FORMAT_RAW && !timelimit);
-}
 
 /*
  *  let's play or capture it (capture_type says VOC/WAVE/raw)
@@ -2072,20 +2046,15 @@
 		close(fd);
 }
 
-static void capture(char *name)
+static void capture(char *name_)
 {
-	pbrec_count = LLONG_MAX;
-	if (!name || !strcmp(name, "-")) {
-		fd = fileno(stdout);
-		name = "stdout";
-	} else {
-		remove(name);
-		if ((fd = open64(name, O_WRONLY | O_CREAT, 0644)) == -1) {
-			perror(name);
-			exit(EXIT_FAILURE);
-		}
-	}
-	fdcount = 0;
+	int tostdout=0;		/* boolean which describes output stream */
+	int filecount=0;	/* number of files written */
+	char *name=name_;	/* current filename */
+	char namebuf[PATH_MAX+1];
+	off64_t cur;		/* number of bytes to capture */
+
+	/* get number of bytes to capture */
 	pbrec_count = calc_count();
 	/* WAVE-file should be even (I'm not sure), but wasting one byte
 	   isn't a problem (this can only be in 8 bit mono) */
@@ -2095,10 +2064,107 @@
 		pbrec_count -= pbrec_count % 2;
 	if (pbrec_count == 0)
 		pbrec_count -= 2;
-	if (fmt_rec_table[file_type].start)
-		fmt_rec_table[file_type].start(fd, pbrec_count);
-	capture_go(fd, pbrec_count, file_type, name);
-	fmt_rec_table[file_type].end(fd);
+
+	cur = pbrec_count;
+
+	/* display verbose output to console */
+	header(file_type, name);
+
+	/* setup sound hardware */
+	set_params();
+
+	/* write to stdout? */
+	if (!name || !strcmp(name, "-")) {
+		fd = fileno(stdout);
+		name = "stdout";
+		tostdout=1;
+		fdcount = 0;
+	}
+
+	do {
+		/* open a file to write */
+		if(!tostdout) {
+
+			/* upon the second file we start the numbering scheme */
+			if(filecount)
+			{
+				/* get a copy of the original filename */
+				char *s;
+				char buf[PATH_MAX+1];
+				strncpy(buf, name_, sizeof(buf));
+
+				/* separate extension from filename */
+				s=buf+strlen(buf);
+				while(s>buf && *s!='.' && *s!='/')
+					--s;
+				if(*s=='.')
+					*s++=0;
+				else if(*s=='/')
+					s=buf+strlen(buf);
+
+				/* upon first jump to this if block rename the first file */
+				if(filecount==1) {
+					if(*s)
+						snprintf(namebuf, sizeof(namebuf), "%s-01.%s", buf, s);
+					else
+						snprintf(namebuf, sizeof(namebuf), "%s-01", buf);
+					remove(namebuf);
+					rename(name, namebuf);
+					filecount=2;
+				}
+
+				/* name of the current file */
+				if(*s)
+					snprintf(namebuf, sizeof(namebuf), "%s-%02i.%s", buf, filecount, s);
+				else
+					snprintf(namebuf, sizeof(namebuf), "%s-%02i", buf, filecount);
+				name=namebuf;
+
+			}
+
+			/* open a new file */
+			remove(name);
+			if ((fd = open64(name, O_WRONLY | O_CREAT, 0644)) == -1) {
+				perror(name);
+				exit(EXIT_FAILURE);
+			}
+			fdcount = 0;
+			filecount++;
+		}
+
+		/* setup sample header */
+		if (fmt_rec_table[file_type].start)
+			fmt_rec_table[file_type].start(fd, pbrec_count);
+
+		/* capture */
+		do {
+			ssize_t r=0;
+			for (; cur > 0 && fdcount<fmt_rec_table[file_type].max_filesize; cur -= r) {
+				ssize_t err;
+				size_t c = (cur <= chunk_bytes) ? cur : chunk_bytes;
+				c = c * 8 / bits_per_frame;
+				if ((size_t)(r = pcm_read(audiobuf, c)) != c)
+					break;
+				r = r * bits_per_frame / 8;
+				if ((err = write(fd, audiobuf, r)) != r) {
+					perror(name);
+					exit(EXIT_FAILURE);
+				}
+				if (err > 0)
+					fdcount += err;
+			}
+			/* exit conditions:
+			   1) format_raw and a timelimit
+			   2) all requested samples/bytes have been captured (cur>0)
+			   3) filesize threshold was reached (fdcount<wrthreshold)
+			*/
+		} while (file_type == FORMAT_RAW && !timelimit && cur>0 && fdcount<fmt_rec_table[file_type].max_filesize);
+
+		/* finish sample container */
+		fmt_rec_table[file_type].end(fd);
+
+		/* repeat the loop when format is raw without timelimit or filesize threshold was reached */
+	} while((file_type == FORMAT_RAW && !timelimit) || fdcount>=fmt_rec_table[file_type].max_filesize);
 }
 
 void playbackv_go(int* fds, unsigned int channels, size_t loaded, off64_t count, int rtype, char **names)
Index: alsa-utils-1.0.10/aplay/aplay.1
===================================================================
--- alsa-utils-1.0.10.orig/aplay/aplay.1	2005-12-05 23:10:36.000000000 +0100
+++ alsa-utils-1.0.10/aplay/aplay.1	2005-12-05 23:23:28.000000000 +0100
@@ -10,7 +10,8 @@
 .SH DESCRIPTION
 \fBarecord\fP is a command-line soundfile recorder for the ALSA soundcard
 driver. It supports several file formats and multiple soundcards with
-multiple devices. 
+multiple devices. If recording with interleaved mode samples the file is
+automatically split before the 2GB filesize.
 
 \fBaplay\fP is much the same, only it plays instead of recording. For
 supported soundfile formats, the sampling rate, bit depth, and so
Index: alsa-utils-1.0.10/aplay/arecord.1
===================================================================
--- alsa-utils-1.0.10.orig/aplay/arecord.1	2005-12-05 23:10:36.000000000 +0100
+++ alsa-utils-1.0.10/aplay/arecord.1	2005-12-05 23:23:28.000000000 +0100
@@ -10,7 +10,8 @@
 .SH DESCRIPTION
 \fBarecord\fP is a command-line soundfile recorder for the ALSA soundcard
 driver. It supports several file formats and multiple soundcards with
-multiple devices. 
+multiple devices. If recording with interleaved mode samples the file is
+automatically split before the 2GB filesize.
 
 \fBaplay\fP is much the same, only it plays instead of recording. For
 supported soundfile formats, the sampling rate, bit depth, and so

--------------040108030406030600000503--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
