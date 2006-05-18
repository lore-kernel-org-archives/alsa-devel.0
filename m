From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: A better pcm_file "infile" patch, and a declaration of being miffed.
Date: Thu, 18 May 2006 13:29:36 -0300
Message-ID: <446CA0F0.2000603@instant.com.br>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050301040500080904000705"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050301040500080904000705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

OK, this implements the "infile" parameter of pcm_file in a much cleaner 
way. Note that the the below new members of snd_pcm_file_t are not used 
now, but WILL be when I implement protection from fraction-of-frame reads:

       size_t rbuf_size_bytes;
       size_t rbuf_used_bytes;
       char *rbuf;

Now, the whole reason of this shebang was so I can use the "infile" AND 
convert rates in the process -- i.e., the app programs its microphone in 
whatever rate/format it wants, and ALSA converts the sound from the 
existing format to what the app needs.

The exact opposite of this already works for output -- I can force a 
file to be written in the same format, no matter how the app configures 
its sound output. For this, I use the .asoundrc that's also attached. 
But it doesn't work for input. Can someone help me?

Juan

--------------050301040500080904000705
Content-Type: text/x-patch;
 name="pcm_file-infile.3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_file-infile.3.patch"

diff -r 53656cf23f78 src/pcm/pcm_file.c
--- a/src/pcm/pcm_file.c	Thu May 18 11:26:00 2006 +0200
+++ b/src/pcm/pcm_file.c	Thu May 18 13:20:29 2006 -0300
@@ -46,6 +46,8 @@ typedef struct {
 	snd_pcm_generic_t gen;
 	char *fname;
 	int fd;
+	char *ifname;
+	int ifd;
 	int format;
 	snd_pcm_uframes_t appl_ptr;
 	snd_pcm_uframes_t file_ptr_bytes;
@@ -53,6 +55,9 @@ typedef struct {
 	size_t wbuf_size_bytes;
 	size_t wbuf_used_bytes;
 	char *wbuf;
+	size_t rbuf_size_bytes;
+	size_t rbuf_used_bytes;
+	char *rbuf;
 	snd_pcm_channel_area_t *wbuf_areas;
 	size_t buffer_bytes;
 } snd_pcm_file_t;
@@ -120,6 +125,10 @@ static int snd_pcm_file_close(snd_pcm_t 
 		free((void *)file->fname);
 		close(file->fd);
 	}
+	if (file->ifname) {
+		free((void *)file->ifname);
+		close(file->ifd);
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
+	if (file->ifd >= 0) {
+		n = /* bytesn = */ read(file->ifd, buffer, size * pcm->frame_bits / 8);
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
-	snd_pcm_sframes_t n = snd_pcm_readn(file->gen.slave, bufs, size);
+	snd_pcm_sframes_t n;
+
+	if (file->ifd >= 0) {
+		SNDERR("DEBUG: Noninterleaved read not yet implemented.\n");
+		return 0;	/* TODO: Noninterleaved read */
+	}
+
+	n = snd_pcm_readn(file->gen.slave, bufs, size);
 	if (n > 0) {
 		snd_pcm_areas_from_bufs(pcm, areas, bufs);
 		snd_pcm_file_add_frames(pcm, areas, 0, n);
@@ -365,8 +391,11 @@ static snd_pcm_fast_ops_t snd_pcm_file_f
  * \brief Creates a new File PCM
  * \param pcmp Returns created PCM handle
  * \param name Name of PCM
- * \param fname Filename (or NULL if file descriptor is available)
- * \param fd File descriptor
+ * \param fname Output filename (or NULL if file descriptor fd is available)
+ * \param fd Output file descriptor
+ * \param ifname Input filename (or NULL if file descriptor ifd is available)
+ * \param ifd Input file descriptor (if (ifd < 0) && (ifname == NULL), no input
+ *            redirection will be performed)
  * \param fmt File format ("raw" is supported only)
  * \param perm File permission
  * \param slave Slave PCM handle
@@ -377,8 +406,8 @@ static snd_pcm_fast_ops_t snd_pcm_file_f
  *          changed in future.
  */
 int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
-		      const char *fname, int fd, const char *fmt, int perm,
-		      snd_pcm_t *slave, int close_slave)
+		      const char *fname, int fd, const char *ifname, int ifd, 
+		      const char *fmt, int perm, snd_pcm_t *slave, int close_slave)
 {
 	snd_pcm_t *pcm;
 	snd_pcm_file_t *file;
@@ -395,7 +424,7 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, 
 	if (fname) {
 		fd = open(fname, O_WRONLY|O_CREAT, perm);
 		if (fd < 0) {
-			SYSERR("open %s failed", fname);
+			SYSERR("open %s for writing failed", fname);
 			return -errno;
 		}
 	}
@@ -405,10 +434,23 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, 
 			close(fd);
 		return -ENOMEM;
 	}
-	
+
+	if (ifname) {
+		ifd = open(ifname, O_RDONLY);	/* TODO: mind blocking mode */
+		if (ifd < 0) {
+			SYSERR("open %s for reading failed", ifname);
+			if (fname)
+				close(fd);
+			return -errno;
+		}
+	}
+
 	if (fname)
 		file->fname = strdup(fname);
+	if (ifname)
+		file->ifname = strdup(ifname);
 	file->fd = fd;
+	file->ifd = ifd;
 	file->format = format;
 	file->gen.slave = slave;
 	file->gen.close_slave = close_slave;
@@ -486,9 +528,9 @@ int _snd_pcm_file_open(snd_pcm_t **pcmp,
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
@@ -513,6 +555,17 @@ int _snd_pcm_file_open(snd_pcm_t **pcmp,
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
@@ -556,7 +609,7 @@ int _snd_pcm_file_open(snd_pcm_t **pcmp,
 	snd_config_delete(sconf);
 	if (err < 0)
 		return err;
-	err = snd_pcm_file_open(pcmp, name, fname, fd, format, perm, spcm, 1);
+	err = snd_pcm_file_open(pcmp, name, fname, fd, ifname, ifd, format, perm, spcm, 1);
 	if (err < 0)
 		snd_pcm_close(spcm);
 	return err;

--------------050301040500080904000705
Content-Type: text/plain;
 name="dot-asoundrc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dot-asoundrc"

pcm.fileout {
	type file
	file /home/jcastro/alsaout.raw
	infile /home/jcastro/alsain.raw
	slave.pcm null
}

pcm_slave.sl3 {
    pcm "fileout"
    format S16_LE
    channels 1
    rate 48000
}

pcm.complex_convert {
    type plug
    slave sl3
}

--------------050301040500080904000705--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
