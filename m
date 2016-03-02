From: han.lu@intel.com
Subject: [PATCH 04/10] alsabat: clean the thread loopback of
	alsa capture
Date: Wed,  2 Mar 2016 16:53:14 +0800
Message-ID: <53f8e7bf3595c2ab7db5de24adc899f82defe1a5.1456907242.git.han.lu@intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 75BA026145A
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 09:51:12 +0100 (CET)
In-Reply-To: <cover.1456907242.git.han.lu@intel.com>
In-Reply-To: <cover.1456907242.git.han.lu@intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@linux.intel.com, bernard.gautier@intel.com, edward.c.popescu@intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

1. Move file operations to sub loopback, so the structure is more
clear, for alsa and tinyalsa to share common functions.
2. Update wav header information after capture.
3. Remove redundant code and update comment.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index 5775748..47441e7 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -464,12 +464,27 @@ static int read_from_pcm(struct pcm_container *sndpcm,
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
+	if (fp == NULL) {
+		fprintf(bat->err, _("Cannot open file for capture: %s %d\n"),
+				bat->capture.file, -errno);
+		return -errno;
+	}
+	/* leave space for file header */
+	if (fseek(fp, sizeof(struct wav_container), SEEK_SET) != 0) {
+		fclose(fp);
+		return -errno;
+	}
 
 	while (remain > 0) {
 		size = (remain <= sndpcm->period_bytes) ?
@@ -479,15 +494,14 @@ static int read_from_pcm_loop(FILE *fp, int count,
 		/* read a chunk from pcm device */
 		err = read_from_pcm(sndpcm, frames, bat);
 		if (err != 0)
-			return err;
+			break;
 
 		/* write the chunk to file */
 		err = fwrite(sndpcm->buffer, 1, size, fp);
-		if (err != size) {
-			fprintf(bat->err, _("Write file error: %s(%d)\n"),
-					snd_strerror(err), err);
-			return -EIO;
-		}
+		if (err != size)
+			break;
+
+		bytes_read += size;
 		remain -= size;
 		bat->periods_played++;
 
@@ -496,7 +510,10 @@ static int read_from_pcm_loop(FILE *fp, int count,
 			break;
 	}
 
-	return 0;
+	err = update_wav_header(bat, fp, bytes_read);
+
+	fclose(fp);
+	return err;
 }
 
 static void pcm_cleanup(void *p)
@@ -504,21 +521,13 @@ static void pcm_cleanup(void *p)
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
 
@@ -542,47 +551,26 @@ void *record_alsa(struct bat *bat)
 		goto exit2;
 	}
 
-	remove(bat->capture.file);
-	fp = fopen(bat->capture.file, "w+");
-	if (fp == NULL) {
-		fprintf(bat->err, _("Cannot open file for capture: %s %d\n"),
-				bat->capture.file, -errno);
-		retval_record = 1;
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
-
-	err = write_wav_header(fp, &wav, bat);
-	if (err != 0) {
-		retval_record = 1;
-		goto exit4;
-	}
 
-	count = wav.chunk.length;
 	fprintf(bat->log, _("Recording ...\n"));
-	err = read_from_pcm_loop(fp, count, &sndpcm, bat);
+	err = read_from_pcm_loop(&sndpcm, bat);
 	if (err != 0) {
-		retval_record = 1;
-		goto exit4;
+		retval_record = err;
+		goto exit3;
 	}
 
-	/* Normally we will never reach this part of code (before fail_exit) as
-	   this thread will be cancelled by end of play thread. */
+	/* Normally we will never reach this part of code (unless error in
+	 * previous call) (before exit3) as this thread will be cancelled
+	 *  by end of play thread. Except in single line mode. */
 	pthread_cleanup_pop(0);
 	pthread_cleanup_pop(0);
-	pthread_cleanup_pop(0);
-
 	snd_pcm_drain(sndpcm.handle);
+	pthread_exit(&retval_record);
 
-exit4:
-	fclose(fp);
 exit3:
 	free(sndpcm.buffer);
 exit2:
-- 
2.5.0
