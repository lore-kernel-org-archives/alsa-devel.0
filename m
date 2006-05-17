From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Re: Another asinine question
Date: Wed, 17 May 2006 11:48:06 -0300
Message-ID: <446B37A6.2080503@instant.com.br>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030902050008040405010705"
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
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030902050008040405010705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ooops, forgot to send this to the list...

Takashi Iwai wrote:

>>>Great, feel free to submit the patches to alsa-devel ML (Cc to me).
>>>      
>>>
>>Your wish is my command, Takashi-san. ;)
>>
>>Note the interleaved read has not yet been implemented. Also, I'm not 
>>yet dealing with blocking versus non-blocking at the moment. When 
>>reading from a file, read()'s just keep getting zero bytes and arecord 
>>doesn't mind. Some deal of sophistication will have to be added.
>>    
>>
>That's OK.  We can extend the feature later.
>  
>
>>Another thing: you'll see I just "hung" another snd_pcm_file_t structure 
>>at the bottom of the original one. I'll understand if that offends 
>>people's coding sensibilities -- it offended mine. :-/
>>    
>>
>Does't only one file descriptor instead of the whole snd_pcm_file
>struct suffice?  Actually, it's used only in readi().
>  
>
Not really, especially when I finally tackle _readn. And even in the 
noninterleaved case, there's always the possibility read() will return a 
number of bytes that's not a multiple of the frame size (especially if 
the file is a named pipe). I'll need ->wbuf and some of those indexes to 
keep the remaining bytes for the next read.

>>@@ -377,11 +403,11 @@ static snd_pcm_fast_ops_t snd_pcm_file_f
>>  *          changed in future.
>>  */
>> int snd_pcm_file_open(snd_pcm_t **pcmp, const char *name,
>>-		      const char *fname, int fd, const char *fmt, int perm,
>>-		      snd_pcm_t *slave, int close_slave)
>>+		      const char *fname, int fd, const char *ifname, int ifd, 
>>+		      const char *fmt, int perm, snd_pcm_t *slave, int close_slave)
>>    
>>
>Don't forget to change the doxygen comment for this function.
>  
>
OK. Tell me if the two-line description for the ifd param is kosher.

>>(snip) +		}
>>+	}
>>+	if (ifd) {
>>    
>>
>Should be "if (ifd >= 0)".
>  
>
Oops.

>Also, please make a patch against the latest HG repository.
>The typo in readn() was already fixed, so your last patch conflicts
>with the latest tree.
>  
>
hg pull -u only gave me new things this morning. Updated and patch attached.

Juan



--------------030902050008040405010705
Content-Type: text/x-patch;
 name="pcm_file-infile.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_file-infile.2.patch"

diff -r 372caededbb6 src/pcm/pcm_file.c
--- a/src/pcm/pcm_file.c	Fri May 12 15:33:44 2006 +0200
+++ b/src/pcm/pcm_file.c	Wed May 17 10:55:59 2006 -0300
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
-	snd_pcm_sframes_t n = snd_pcm_readn(file->gen.slave, bufs, size);
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
@@ -377,11 +406,11 @@ static snd_pcm_fast_ops_t snd_pcm_file_f
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
@@ -395,7 +424,7 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, 
 	if (fname) {
 		fd = open(fname, O_WRONLY|O_CREAT, perm);
 		if (fd < 0) {
-			SYSERR("open %s failed", fname);
+			SYSERR("open %s for writing failed", fname);
 			return -errno;
 		}
 	}
@@ -405,7 +434,34 @@ int snd_pcm_file_open(snd_pcm_t **pcmp, 
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
+	if (ifd >= 0) {
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
@@ -486,9 +542,9 @@ int _snd_pcm_file_open(snd_pcm_t **pcmp,
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
@@ -513,6 +569,17 @@ int _snd_pcm_file_open(snd_pcm_t **pcmp,
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
@@ -556,7 +623,7 @@ int _snd_pcm_file_open(snd_pcm_t **pcmp,
 	snd_config_delete(sconf);
 	if (err < 0)
 		return err;
-	err = snd_pcm_file_open(pcmp, name, fname, fd, format, perm, spcm, 1);
+	err = snd_pcm_file_open(pcmp, name, fname, fd, ifname, ifd, format, perm, spcm, 1);
 	if (err < 0)
 		snd_pcm_close(spcm);
 	return err;


--------------030902050008040405010705--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
