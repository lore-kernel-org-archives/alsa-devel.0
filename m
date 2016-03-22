From: han.lu@intel.com
Subject: [PATCH 2/6] alsabat: use common wav process function
	in playback loop
Date: Tue, 22 Mar 2016 13:10:25 +0800
Message-ID: <7fa5973df8a6b84f663935fb747a32ba2fb9a3fc.1458623090.git.han.lu@intel.com>
References: <cover.1458623090.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 86A9D2652AC
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 06:09:02 +0100 (CET)
In-Reply-To: <cover.1458623090.git.han.lu@intel.com>
In-Reply-To: <cover.1458623090.git.han.lu@intel.com>
References: <cover.1458623090.git.han.lu@intel.com>
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

Use common function to handle wav file process in playback loop.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index 666bcf2..5acc2bc 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -292,11 +292,10 @@ static int write_to_pcm(const struct pcm_container *sndpcm,
 
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
@@ -308,7 +307,7 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 			return err;
 		}
 		/* leave space for wav header */
-		if (fseek(fp, sizeof(wav), SEEK_SET) != 0) {
+		if (fseek(fp, sizeof(struct wav_container), SEEK_SET) != 0) {
 			err = -errno;
 			fclose(fp);
 			return err;
@@ -344,19 +343,7 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
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
+		update_wav_header(bat, fp, bytes_total);
 		fclose(fp);
 	}
 
-- 
2.5.0
