From: han.lu@intel.com
Subject: [PATCH V3 1/6] alsabat: refactoring alsa capture thread
Date: Wed, 23 Mar 2016 15:52:42 +0800
Message-ID: <5b295d3f7969a125a63c2ef5fe5a199cefbe84bb.1458718230.git.han.lu@intel.com>
References: <cover.1458718230.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D796526145E
 for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2016 08:51:23 +0100 (CET)
In-Reply-To: <cover.1458718230.git.han.lu@intel.com>
In-Reply-To: <cover.1458718230.git.han.lu@intel.com>
References: <cover.1458718230.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Refactoring ALSA capture thread:
  1. Move file open/seek operations to sub function, so all file
  processes are now on a single function (read_from_pcm_loop()), so
  the structure is more reasonable, the function API is simplified
  and no need file cleanup in thread loop.
  2. Replace the wav header processing lines with a general function
  (update_wav_header()), which can be reused in other sections.
  3. Add pthread_exit() for thread to exit safely in single line mode,
  and correct comment.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index 79c86fe..666bcf2 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -465,12 +465,29 @@ static int read_from_pcm(struct pcm_container *sndpcm,
 	return 0;
 }
 
-static int read_from_pcm_loop(FILE *fp, int count,
-		struct pcm_container *sndpcm, struct bat *bat)
+static int read_from_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 {
 	int err = 0;
+	FILE *fp = NULL;
 	int size, frames;
-	int remain = count;
+	int bytes_read = 0;
+	int bytes_count = bat->frames * bat->frame_size;
+	int remain = bytes_count;
+
+	remove(bat->capture.file);
+	fp = fopen(bat->capture.file, "wb");
+	err = -errno;
+	if (fp == NULL) {
+		fprintf(bat->err, _("Cannot open file: %s %d\n"),
+				bat->capture.file, err);
+		return err;
+	}
+	/* leave space for file header */
+	if (fseek(fp, sizeof(struct wav_container), SEEK_SET) != 0) {
+		err = -errno;
+		fclose(fp);
+		return err;
+	}
 
 	while (remain > 0) {
 		size = (remain <= sndpcm->period_bytes) ?
@@ -489,6 +506,8 @@ static int read_from_pcm_loop(FILE *fp, int count,
 					snd_strerror(err), err);
 			return -EIO;
 		}
+
+		bytes_read += size;
 		remain -= size;
 		bat->periods_played++;
 
@@ -497,6 +516,9 @@ static int read_from_pcm_loop(FILE *fp, int count,
 			break;
 	}
 
+	update_wav_header(bat, fp, bytes_read);
+
+	fclose(fp);
 	return 0;
 }
 
@@ -505,21 +527,13 @@ static void pcm_cleanup(void *p)
 	snd_pcm_close(p);
 }
 
-static void file_cleanup(void *p)
-{
-	fclose(p);
-}
-
 /**
  * Record
  */
 void *record_alsa(struct bat *bat)
 {
 	int err = 0;
-	FILE *fp = NULL;
 	struct pcm_container sndpcm;
-	struct wav_container wav;
-	int count;
 
 	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
 
@@ -543,48 +557,27 @@ void *record_alsa(struct bat *bat)
 		goto exit2;
 	}
 
-	remove(bat->capture.file);
-	fp = fopen(bat->capture.file, "wb");
-	err = -errno;
-	if (fp == NULL) {
-		fprintf(bat->err, _("Cannot open file: %s %d\n"),
-				bat->capture.file, err);
-		retval_record = err;
-		goto exit3;
-	}
-
-	prepare_wav_info(&wav, bat);
-
 	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
 	pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
 	pthread_cleanup_push(pcm_cleanup, sndpcm.handle);
 	pthread_cleanup_push(free, sndpcm.buffer);
-	pthread_cleanup_push(file_cleanup, fp);
 
-	err = write_wav_header(fp, &wav, bat);
-	if (err != 0) {
-		retval_record = err;
-		goto exit4;
-	}
-
-	count = wav.chunk.length;
 	fprintf(bat->log, _("Recording ...\n"));
-	err = read_from_pcm_loop(fp, count, &sndpcm, bat);
+	err = read_from_pcm_loop(&sndpcm, bat);
 	if (err != 0) {
 		retval_record = err;
-		goto exit4;
+		goto exit3;
 	}
 
-	/* Normally we will never reach this part of code (before fail_exit) as
-	   this thread will be cancelled by end of play thread. */
-	pthread_cleanup_pop(0);
+	/* Normally we will never reach this part of code (unless error in
+	 * previous call) (before exit3) as this thread will be cancelled
+	 * by end of play thread. Except in single line mode. */
 	pthread_cleanup_pop(0);
 	pthread_cleanup_pop(0);
 
 	snd_pcm_drain(sndpcm.handle);
+	pthread_exit(&retval_record);
 
-exit4:
-	fclose(fp);
 exit3:
 	free(sndpcm.buffer);
 exit2:
diff --git a/bat/common.c b/bat/common.c
index 41aaf3a..e51bafd 100644
--- a/bat/common.c
+++ b/bat/common.c
@@ -195,3 +195,19 @@ int write_wav_header(FILE *fp, struct wav_container *wav, struct bat *bat)
 
 	return 0;
 }
+
+/* update wav header when data size changed */
+int update_wav_header(struct bat *bat, FILE *fp, int bytes)
+{
+	int err = 0;
+	struct wav_container wav;
+
+	prepare_wav_info(&wav, bat);
+	wav.chunk.length = bytes;
+	wav.header.length = (wav.chunk.length) + sizeof(wav.chunk)
+		+ sizeof(wav.format) + sizeof(wav.header) - 8;
+	rewind(fp);
+	err = write_wav_header(fp, &wav, bat);
+
+	return err;
+}
diff --git a/bat/common.h b/bat/common.h
index 30e39fc..d72a940 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -183,3 +183,4 @@ struct analyze {
 void prepare_wav_info(struct wav_container *, struct bat *);
 int read_wav_header(struct bat *, char *, FILE *, bool);
 int write_wav_header(FILE *, struct wav_container *, struct bat *);
+int update_wav_header(struct bat *, FILE *, int);
-- 
2.5.0
