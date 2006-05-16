From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Re: Another asinine question
Date: Tue, 16 May 2006 13:28:23 -0300
Message-ID: <4469FDA7.2090105@instant.com.br>
References: <4464A474.6070604@instant.com.br>	<s5h3bfa3x9e.wl%tiwai@suse.de>	<4469E2B2.4040800@instant.com.br> <s5hu07q2fx7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030800050606000501020104"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu07q2fx7.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030800050606000501020104
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:

>Juan Carlos Castro y Castro wrote:
>  
>
>>By the way, my pcm_file extensions DO work! It's the "plug" plugin 
>>that's not passing the reads! Stay tuned...
>>    
>>
>Great, feel free to submit the patches to alsa-devel ML (Cc to me).
>
Your wish is my command, Takashi-san. ;)

Note the interleaved read has not yet been implemented. Also, I'm not 
yet dealing with blocking versus non-blocking at the moment. When 
reading from a file, read()'s just keep getting zero bytes and arecord 
doesn't mind. Some deal of sophistication will have to be added.

Another thing: you'll see I just "hung" another snd_pcm_file_t structure 
at the bottom of the original one. I'll understand if that offends 
people's coding sensibilities -- it offended mine. :-/

--------------030800050606000501020104
Content-Type: text/x-patch;
 name="pcm_file-infile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_file-infile.patch"

diff -r 33b6942ac42d src/pcm/pcm_file.c
--- a/src/pcm/pcm_file.c	Fri Apr 28 15:55:32 2006 +0200
+++ b/src/pcm/pcm_file.c	Tue May 16 13:21:12 2006 -0300
@@ -42,7 +42,7 @@ typedef enum _snd_pcm_file_format {
 	SND_PCM_FILE_FORMAT_RAW
 } snd_pcm_file_format_t;
 
-typedef struct {
+typedef struct snd_pcm_file_t_struct {
 	snd_pcm_generic_t gen;
 	char *fname;
 	int fd;
@@ -55,6 +55,7 @@ typedef struct {
 	char *wbuf;
 	snd_pcm_channel_area_t *wbuf_areas;
 	size_t buffer_bytes;
+	struct snd_pcm_file_t_struct *nextfile;
 } snd_pcm_file_t;
 
 #endif /* DOC_HIDDEN */
@@ -120,6 +121,14 @@ static int snd_pcm_file_close(snd_pcm_t 
 		free((void *)file->fname);
 		close(file->fd);
 	}
+	if (file->nextfile) {
+		if (file->nextfile->fname) {
+			free((void *)file->nextfile->fname);
+			close(file->nextfile->fd);
+		}
+		free(file->nextfile);
+		file->nextfile = NULL;
+	}
 	return snd_pcm_generic_close(pcm);
 }
 
@@ -222,10 +231,20 @@ static snd_pcm_sframes_t snd_pcm_file_re
 {
 	snd_pcm_file_t *file = pcm->private_data;
 	snd_pcm_channel_area_t areas[pcm->channels];
-	snd_pcm_sframes_t n = snd_pcm_readi(file->gen.slave, buffer, size);
-	if (n > 0) {
-		snd_pcm_areas_from_buf(pcm, areas, buffer);
-		snd_pcm_file_add_frames(pcm, areas, 0, n);
+	snd_pcm_sframes_t n /* , bytesn */;
+
+	if (file->nextfile) {
+		n = /* bytesn = */ read(file->nextfile->fd, buffer, size * pcm->frame_bits / 8);
+		if (n > 0)
+			n = n * 8 / pcm->frame_bits;
+		/* SNDERR("DEBUG: channels = %d, sample_bits = %d, frame_bits = %d, bytes = %d, frames = %d",
+		        pcm->channels, pcm->sample_bits, pcm->frame_bits, bytesn, n); */
+	} else {
+		n = snd_pcm_readi(file->gen.slave, buffer, size);
+		if (n > 0) {
+			snd_pcm_areas_from_buf(pcm, areas, buffer);
+			snd_pcm_file_add_frames(pcm, areas, 0, n);
+		}
 	}
 	return n;
 }
@@ -234,7 +253,14 @@ static snd_pcm_sframes_t snd_pcm_file_re
 {
 	snd_pcm_file_t *file = pcm->private_data;
 	snd_pcm_channel_area_t areas[pcm->channels];
-	snd_pcm_sframes_t n = snd_pcm_writen(file->gen.slave, bufs, size);
+	snd_pcm_sframes_t n;
+
+	if (file->nextfile) {
+		SNDERR("DEBUG: Noninterleaved read not yet implemented.\n");
+		return 0;	/* Noninterleaved read not yet implemented */
+	}
+
+	n = snd_pcm_readn(file->gen.slave, bufs, size);
 	if (n > 0) {
 		snd_pcm_areas_from_bufs(pcm, areas, bufs);
 		snd_pcm_file_add_frames(pcm, areas, 0, n);
@@ -377,11 +403,11 @@ static snd_pcm_fast_ops_t snd_pcm_file_f
  *          changed in future.
  */
 int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
-		      const char *fname, int fd, const char *fmt, int perm,
-		      snd_pcm_t *slave, int close_slave)
+		      const char *fname, int fd, const char *ifname, int ifd, 
+		      const char *fmt, int perm, snd_pcm_t *slave, int close_slave)
 {
 	snd_pcm_t *pcm;
-	snd_pcm_file_t *file;
+	snd_pcm_file_t *file, *ifile;
 	snd_pcm_file_format_t format;
 	int err;
 	assert(pcmp);
@@ -395,7 +421,7 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, 
 	if (fname) {
 		fd = open(fname, O_WRONLY|O_CREAT, perm);
 		if (fd < 0) {
-			SYSERR("open %s failed", fname);
+			SYSERR("open %s for writing failed", fname);
 			return -errno;
 		}
 	}
@@ -405,7 +431,34 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, 
 			close(fd);
 		return -ENOMEM;
 	}
-	
+
+	if (ifname) {
+		ifd = open(ifname, O_RDONLY);
+		if (ifd < 0) {
+			SYSERR("open %s for reading failed", ifname);
+			if (fname)
+				close(fd);
+			return -errno;
+		}
+	}
+	if (ifd) {
+		ifile = calloc(1, sizeof(snd_pcm_file_t));
+		if (!ifile) {
+			if (ifname)
+				close(ifd);
+			if (fname)
+				close(fd);
+			return -ENOMEM;
+		}
+		if (ifname)
+			ifile->fname = strdup(ifname);
+		ifile->fd = ifd;
+		ifile->format = format;
+		ifile->gen.slave = slave;		/* Do I really have to do this? */
+		ifile->gen.close_slave = close_slave;	/* And this?                    */
+		file->nextfile = ifile;
+	}
+
 	if (fname)
 		file->fname = strdup(fname);
 	file->fd = fd;
@@ -486,9 +539,9 @@ int _snd_pcm_file_open(snd_pcm_t **pcmp,
 	int err;
 	snd_pcm_t *spcm;
 	snd_config_t *slave = NULL, *sconf;
-	const char *fname = NULL;
+	const char *fname = NULL, *ifname = NULL;
 	const char *format = NULL;
-	long fd = -1;
+	long fd = -1, ifd = -1;
 	int perm = 0600;
 	snd_config_for_each(i, next, conf) {
 		snd_config_t *n = snd_config_iterator_entry(i);
@@ -513,6 +566,17 @@ int _snd_pcm_file_open(snd_pcm_t **pcmp,
 			err = snd_config_get_string(n, &fname);
 			if (err < 0) {
 				err = snd_config_get_integer(n, &fd);
+				if (err < 0) {
+					SNDERR("Invalid type for %s", id);
+					return -EINVAL;
+				}
+			}
+			continue;
+		}
+		if (strcmp(id, "infile") == 0) {
+			err = snd_config_get_string(n, &ifname);
+			if (err < 0) {
+				err = snd_config_get_integer(n, &ifd);
 				if (err < 0) {
 					SNDERR("Invalid type for %s", id);
 					return -EINVAL;
@@ -556,7 +620,7 @@ int _snd_pcm_file_open(snd_pcm_t **pcmp,
 	snd_config_delete(sconf);
 	if (err < 0)
 		return err;
-	err = snd_pcm_file_open(pcmp, name, fname, fd, format, perm, spcm, 1);
+	err = snd_pcm_file_open(pcmp, name, fname, fd, ifname, ifd, format, perm, spcm, 1);
 	if (err < 0)
 		snd_pcm_close(spcm);
 	return err;

--------------030800050606000501020104--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
