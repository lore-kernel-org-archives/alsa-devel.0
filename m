From: han.lu@intel.com
Subject: [PATCH V2 4/6] alsabat: use general data generator
	function
Date: Tue, 22 Mar 2016 22:31:36 +0800
Message-ID: <11c2e108e2597d6d0516636d8de14af4ef7cdceb.1458655876.git.han.lu@intel.com>
References: <cover.1458655876.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7621D26172C
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2016 15:30:18 +0100 (CET)
In-Reply-To: <cover.1458655876.git.han.lu@intel.com>
In-Reply-To: <cover.1458655876.git.han.lu@intel.com>
References: <cover.1458655876.git.han.lu@intel.com>
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

Use general data generator to replace local function, so
other modules can reuse the data generator rather than
re-implement it.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index aae2eb0..94f47f4 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -16,7 +16,6 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdbool.h>
-#include <math.h>
 #include <stdint.h>
 #include <pthread.h>
 #include <errno.h>
@@ -28,7 +27,6 @@
 
 #include "common.h"
 #include "alsa.h"
-#include "bat-signal.h"
 
 struct pcm_container {
 	snd_pcm_t *handle;
@@ -206,59 +204,6 @@ static int set_snd_pcm_params(struct bat *bat, struct pcm_container *sndpcm)
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
@@ -315,7 +260,7 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 	}
 
 	while (1) {
-		err = generate_input_data(sndpcm, bytes, bat);
+		err = generate_input_data(bat, sndpcm->buffer, bytes, frames);
 		if (err != 0)
 			break;
 
diff --git a/bat/common.c b/bat/common.c
index e51bafd..11a7e4e 100644
--- a/bat/common.c
+++ b/bat/common.c
@@ -23,6 +23,7 @@
 
 #include "common.h"
 #include "alsa.h"
+#include "bat-signal.h"
 
 int retval_play;
 int retval_record;
@@ -211,3 +212,53 @@ int update_wav_header(struct bat *bat, FILE *fp, int bytes)
 
 	return err;
 }
+
+/*
+ * Generate buffer to be played either from input file or from generated data
+ * Return value
+ * <0 error
+ * 0 ok
+ * >0 break
+ */
+int generate_input_data(struct bat *bat, void *buffer, int bytes, int frames)
+{
+	int err;
+	static int load;
+
+	if (bat->playback.file != NULL) {
+		/* From input file */
+		load = 0;
+
+		while (1) {
+			err = fread(buffer + load, 1, bytes - load, bat->fp);
+			if (0 == err) {
+				if (feof(bat->fp)) {
+					fprintf(bat->log,
+							_("End of playing.\n"));
+					return 1;
+				}
+			} else if (err < bytes - load) {
+				if (ferror(bat->fp)) {
+					fprintf(bat->err, _("Read file error"));
+					fprintf(bat->err, _(": %d\n"), err);
+					return -EIO;
+				}
+				load += err;
+			} else {
+				break;
+			}
+		}
+	} else {
+		/* Generate sine wave */
+		if ((bat->sinus_duration) && (load > bat->sinus_duration))
+			return 1;
+
+		err = generate_sine_wave(bat, frames, buffer);
+		if (err != 0)
+			return err;
+
+		load += frames;
+	}
+
+	return 0;
+}
diff --git a/bat/common.h b/bat/common.h
index d72a940..37d1e4b 100644
--- a/bat/common.h
+++ b/bat/common.h
@@ -184,3 +184,4 @@ void prepare_wav_info(struct wav_container *, struct bat *);
 int read_wav_header(struct bat *, char *, FILE *, bool);
 int write_wav_header(FILE *, struct wav_container *, struct bat *);
 int update_wav_header(struct bat *, FILE *, int);
+int generate_input_data(struct bat *, void *, int, int);
-- 
2.5.0
