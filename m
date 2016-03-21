From: han.lu@intel.com
Subject: [PATCH 2/3] alsabat: fix fopen and messages
Date: Mon, 21 Mar 2016 19:05:48 +0800
Message-ID: <efdc70d84df47da467f5b653fc8425eb8c18ab9d.1458558001.git.han.lu@intel.com>
References: <cover.1458558001.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CD4BD264F37
 for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2016 12:04:20 +0100 (CET)
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

All files should be opened in either "rb" or "wb" in current
usage.
Remove incorrect and unneccesary prints.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/bat/alsa.c b/bat/alsa.c
index 638012a..2540ab8 100644
--- a/bat/alsa.c
+++ b/bat/alsa.c
@@ -303,8 +303,8 @@ static int write_to_pcm_loop(struct pcm_container *sndpcm, struct bat *bat)
 		fp = fopen(bat->debugplay, "wb");
 		err = -errno;
 		if (fp == NULL) {
-			fprintf(bat->err, _("Cannot open file for capture: "));
-			fprintf(bat->err, _("%s %d\n"), bat->debugplay, err);
+			fprintf(bat->err, _("Cannot open file: %s %d\n"),
+					bat->debugplay, err);
 			return err;
 		}
 		/* leave space for wav header */
@@ -404,8 +404,7 @@ void *playback_alsa(struct bat *bat)
 		bat->fp = fopen(bat->playback.file, "rb");
 		err = -errno;
 		if (bat->fp == NULL) {
-			fprintf(bat->err, _("Cannot open file for capture: "));
-			fprintf(bat->err, _("%s %d\n"),
+			fprintf(bat->err, _("Cannot open file: %s %d\n"),
 					bat->playback.file, err);
 			retval_play = 1;
 			goto exit3;
@@ -545,10 +544,10 @@ void *record_alsa(struct bat *bat)
 	}
 
 	remove(bat->capture.file);
-	fp = fopen(bat->capture.file, "w+");
+	fp = fopen(bat->capture.file, "wb");
 	err = -errno;
 	if (fp == NULL) {
-		fprintf(bat->err, _("Cannot open file for capture: %s %d\n"),
+		fprintf(bat->err, _("Cannot open file: %s %d\n"),
 				bat->capture.file, err);
 		retval_record = 1;
 		goto exit3;
diff --git a/bat/analyze.c b/bat/analyze.c
index 63481fb..58781d6 100644
--- a/bat/analyze.c
+++ b/bat/analyze.c
@@ -296,7 +296,7 @@ int analyze_capture(struct bat *bat)
 	bat->fp = fopen(bat->capture.file, "rb");
 	err = -errno;
 	if (bat->fp == NULL) {
-		fprintf(bat->err, _("Cannot open file for capture: %s %d\n"),
+		fprintf(bat->err, _("Cannot open file: %s %d\n"),
 				bat->capture.file, err);
 		goto exit1;
 	}
diff --git a/bat/bat.c b/bat/bat.c
index 4821532..85a7282 100644
--- a/bat/bat.c
+++ b/bat/bat.c
@@ -469,8 +469,8 @@ static int bat_init(struct bat *bat)
 		bat->log = fopen(bat->logarg, "wb");
 		err = -errno;
 		if (bat->log == NULL) {
-			fprintf(bat->err, _("Cannot open file for capture:"));
-			fprintf(bat->err, _(" %s %d\n"), bat->logarg, err);
+			fprintf(bat->err, _("Cannot open file: %s %d\n"),
+					bat->logarg, err);
 			return err;
 		}
 		bat->err = bat->log;
@@ -533,8 +533,7 @@ static int bat_init(struct bat *bat)
 		bat->fp = fopen(bat->playback.file, "rb");
 		err = -errno;
 		if (bat->fp == NULL) {
-			fprintf(bat->err, _("Cannot open file for playback:"));
-			fprintf(bat->err, _(" %s %d\n"),
+			fprintf(bat->err, _("Cannot open file: %s %d\n"),
 					bat->playback.file, err);
 			return err;
 		}
-- 
2.5.0
