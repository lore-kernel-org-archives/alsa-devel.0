From: han.lu@intel.com
Subject: [PATCH 05/10] alsabat: refactor wav file process
Date: Wed,  2 Mar 2016 16:53:15 +0800
Message-ID: <83398e5f26ebcabc588eac91a25c5d6efc9c1d55.1456907242.git.han.lu@intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 233772614A1
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

1. Remove unnecessary message output.
2. Replace the code of wav header update with common function.
3. Update wav header information at unexpected exit.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index 47441e7..e00a16b 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -291,11 +291,10 @@ static int write_to_pcm(const struct pcm_container *sndpcm,
 
 static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 {
-	int err;
+	int err = 0;
 	int bytes = sndpcm->period_bytes; /* playback buffer size */
 	int frames = bytes * 8 / sndpcm->frame_bits; /* frame count */
 	FILE *fp = NULL;
-	struct wav_container wav;
 	int bytes_total = 0;
 
 	if (bat->debugplay) {
@@ -306,10 +305,8 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 			return -errno;
 		}
 		/* leave space for wav header */
-		err = fseek(fp, sizeof(wav), SEEK_SET);
-		if (err != 0) {
-			fprintf(bat->err, _("Seek file error: %d %d\n"),
-					err, -errno);
+		if (fseek(fp, sizeof(struct wav_container), SEEK_SET) != 0) {
+			fclose(fp);
 			return -errno;
 		}
 	}
@@ -322,11 +319,9 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 			break;
 
 		if (bat->debugplay) {
-			err = fwrite(sndpcm->buffer, 1, bytes, fp);
-			if (err != bytes) {
-				fprintf(bat->err, _("Write file error: "));
-				fprintf(bat->err, _("%s(%d)\n"),
-						snd_strerror(err), err);
+			if (fwrite(sndpcm->buffer, 1, bytes, fp) != bytes) {
+				update_wav_header(bat, fp, bytes_total);
+				fclose(fp);
 				return -EIO;
 			}
 			bytes_total += bytes;
@@ -343,25 +338,13 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 	}
 
 	if (bat->debugplay) {
-		/* update wav header */
-		prepare_wav_info(&wav, bat);
-		wav.chunk.length = bytes_total;
-		wav.header.length = (wav.chunk.length) + sizeof(wav.chunk)
-			+ sizeof(wav.format) + sizeof(wav.header) - 8;
-
-		rewind(fp);
-		err = write_wav_header(fp, &wav, bat);
-		if (err != 0) {
-			fprintf(bat->err, _("Write file error: %s %s(%d)\n"),
-					bat->debugplay, snd_strerror(err), err);
-			return err;
-		}
+		err = update_wav_header(bat, fp, bytes_total);
 		fclose(fp);
 	}
 
 	snd_pcm_drain(sndpcm->handle);
 
-	return 0;
+	return err;
 }
 
 /**
@@ -417,7 +400,7 @@ void *playback_alsa(struct bat *bat)
 	}
 
 	err = write_to_pcm_loop(&sndpcm, bat);
-	if (err != 0) {
+	if (err < 0) {
 		retval_play = 1;
 		goto exit4;
 	}
-- 
2.5.0
