From: han.lu@intel.com
Subject: [PATCH 06/10] alsabat: use common data generator
	function
Date: Wed,  2 Mar 2016 16:53:16 +0800
Message-ID: <11915a183d503fec4818957e4fec6a3332aa03ad.1456907242.git.han.lu@intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EFB32614D3
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 09:51:14 +0100 (CET)
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

Replace local data generator function with common function for
convenience to maintain.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index e00a16b..905be6e 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -16,7 +16,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdbool.h>
-#include <math.h>
 #include <stdint.h>
 #include <pthread.h>
 
@@ -27,7 +26,6 @@
 
 #include "common.h"
 #include "alsa.h"
-#include "bat-signal.h"
 
 struct pcm_container {
 	snd_pcm_t *handle;
@@ -205,59 +203,6 @@ static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
 	return 0;
 }
 
-/*
- * Generate buffer to be played either from input file or from generated data
- * Return value
- * <0 error
- * 0 ok
- * >0 break
- */
-static int generate_input_data(struct pcm_container *sndpcm, int bytes,
-		struct bat *bat)
-{
-	int err;
-	static int load;
-	int frames = bytes * 8 / sndpcm->frame_bits;
-
-	if (bat->playback.file != NULL) {
-		/* From input file */
-		load = 0;
-
-		while (1) {
-			err = fread(sndpcm->buffer + load, 1,
-					bytes - load, bat->fp);
-			if (0 == err) {
-				if (feof(bat->fp)) {
-					fprintf(bat->log,
-							_("End of playing.\n"));
-					return 1;
-				}
-			} else if (err < bytes - load) {
-				if (ferror(bat->fp)) {
-					fprintf(bat->err, _("Read file error"));
-					fprintf(bat->err, _(": %d\n"), err);
-					return -EIO;
-				}
-				load += err;
-			} else {
-				break;
-			}
-		}
-	} else {
-		/* Generate sine wave */
-		if ((bat->sinus_duration) && (load > bat->sinus_duration))
-			return 1;
-
-		err = generate_sine_wave(bat, frames, (void *)sndpcm->buffer);
-		if (err != 0)
-			return err;
-
-		load += frames;
-	}
-
-	return 0;
-}
-
 static int write_to_pcm(const struct pcm_container *sndpcm,
 		int frames, struct bat *bat)
 {
@@ -312,10 +257,8 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 	}
 
 	while (1) {
-		err = generate_input_data(sndpcm, bytes, bat);
-		if (err < 0)
-			return err;
-		else if (err > 0)
+		err = generate_input_data(bat, sndpcm->buffer, bytes, frames);
+		if (err != 0)
 			break;
 
 		if (bat->debugplay) {
diff --git a/bat/common.c b/bat/common.c
index bbf969e..2feec04 100644
--- a/bat/common.c
+++ b/bat/common.c
@@ -243,7 +243,7 @@ int update_wav_header(struct bat *bat, FILE *fp, int bytes)
  * 0 ok
  * >0 break
  */
-int generate_input_data0(struct bat *bat, void *buffer, int bytes, int frames)
+int generate_input_data(struct bat *bat, void *buffer, int bytes, int frames)
 {
 	int err;
 	static int load;
diff --git a/bat/common.h b/bat/common.h
index 0d92a8d..ff03fc1 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -193,4 +193,4 @@ void prepare_wav_info(struct wav_container *, struct bat *);
 int read_wav_header(struct bat *, char *, FILE *, bool);
 int write_wav_header(FILE *, struct wav_container *, struct bat *);
 int update_wav_header(struct bat *, FILE *, int);
-int generate_input_data0(struct bat *, void *, int, int);
+int generate_input_data(struct bat *, void *, int, int);
diff --git a/bat/tinyalsa.c b/bat/tinyalsa.c
index ab11247..4a5d606 100644
--- a/bat/tinyalsa.c
+++ b/bat/tinyalsa.c
@@ -179,7 +179,7 @@ static int play_sample(struct bat *bat, struct pcm *pcm,
 	}
 
 	do {
-		err = generate_input_data0(bat, buffer, bytes, frames);
+		err = generate_input_data(bat, buffer, bytes, frames);
 		if (err != 0)
 			break;
 
-- 
2.5.0
