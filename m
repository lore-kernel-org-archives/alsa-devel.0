From: han.lu@intel.com
Subject: [PATCH 3/3] alsabat: use variable for thread return
	value
Date: Mon, 21 Mar 2016 19:05:49 +0800
Message-ID: <441bb3b26f4546909d4583fdfaa468df8c3db3bd.1458558001.git.han.lu@intel.com>
References: <cover.1458558001.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C1E7626507F
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 12:04:21 +0100 (CET)
In-Reply-To: <cover.1458558001.git.han.lu@intel.com>
In-Reply-To: <cover.1458558001.git.han.lu@intel.com>
References: <cover.1458558001.git.han.lu@intel.com>
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

Use variable instead of 0/1 to indicate the return value of
playback and capture threads.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index 2540ab8..79c86fe 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -383,13 +383,13 @@ void *playback_alsa(struct bat *bat)
 	if (err != 0) {
 		fprintf(bat->err, _("Cannot open PCM playback device: "));
 		fprintf(bat->err, _("%s(%d)\n"), snd_strerror(err), err);
-		retval_play = 1;
+		retval_play = err;
 		goto exit1;
 	}
 
 	err = set_snd_pcm_params(bat, &sndpcm);
 	if (err != 0) {
-		retval_play = 1;
+		retval_play = err;
 		goto exit2;
 	}
 
@@ -406,20 +406,20 @@ void *playback_alsa(struct bat *bat)
 		if (bat->fp == NULL) {
 			fprintf(bat->err, _("Cannot open file: %s %d\n"),
 					bat->playback.file, err);
-			retval_play = 1;
+			retval_play = err;
 			goto exit3;
 		}
 		/* Skip header */
 		err = read_wav_header(bat, bat->playback.file, bat->fp, true);
 		if (err != 0) {
-			retval_play = 1;
+			retval_play = err;
 			goto exit4;
 		}
 	}
 
 	err = write_to_pcm_loop(&sndpcm, bat);
 	if (err != 0) {
-		retval_play = 1;
+		retval_play = err;
 		goto exit4;
 	}
 
@@ -533,13 +533,13 @@ void *record_alsa(struct bat *bat)
 	if (err != 0) {
 		fprintf(bat->err, _("Cannot open PCM capture device: "));
 		fprintf(bat->err, _("%s(%d)\n"), snd_strerror(err), err);
-		retval_record = 1;
+		retval_record = err;
 		goto exit1;
 	}
 
 	err = set_snd_pcm_params(bat, &sndpcm);
 	if (err != 0) {
-		retval_record = 1;
+		retval_record = err;
 		goto exit2;
 	}
 
@@ -549,7 +549,7 @@ void *record_alsa(struct bat *bat)
 	if (fp == NULL) {
 		fprintf(bat->err, _("Cannot open file: %s %d\n"),
 				bat->capture.file, err);
-		retval_record = 1;
+		retval_record = err;
 		goto exit3;
 	}
 
@@ -563,7 +563,7 @@ void *record_alsa(struct bat *bat)
 
 	err = write_wav_header(fp, &wav, bat);
 	if (err != 0) {
-		retval_record = 1;
+		retval_record = err;
 		goto exit4;
 	}
 
@@ -571,7 +571,7 @@ void *record_alsa(struct bat *bat)
 	fprintf(bat->log, _("Recording ...\n"));
 	err = read_from_pcm_loop(fp, count, &sndpcm, bat);
 	if (err != 0) {
-		retval_record = 1;
+		retval_record = err;
 		goto exit4;
 	}
 
-- 
2.5.0
