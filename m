From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Remove /s from widget names on
	SMDK64xx WM8580
Date: Fri,  6 Aug 2010 18:35:30 +0100
Message-ID: <1281116132-25432-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7084C10395E
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 19:35:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

Otherwise debugfs gets upset when we try to create filenames with /
in them.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/s3c24xx/smdk64xx_wm8580.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 07e8e51..5853f66 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -138,9 +138,9 @@ static struct snd_soc_ops smdk64xx_ops = {
 
 /* SMDK64xx Playback widgets */
 static const struct snd_soc_dapm_widget wm8580_dapm_widgets_pbk[] = {
-	SND_SOC_DAPM_HP("Front-L/R", NULL),
-	SND_SOC_DAPM_HP("Center/Sub", NULL),
-	SND_SOC_DAPM_HP("Rear-L/R", NULL),
+	SND_SOC_DAPM_HP("Front", NULL),
+	SND_SOC_DAPM_HP("Center+Sub", NULL),
+	SND_SOC_DAPM_HP("Rear", NULL),
 };
 
 /* SMDK64xx Capture widgets */
@@ -162,16 +162,16 @@ static const struct snd_soc_dapm_route audio_map_tx[] = {
 /* SMDK-PAIFRX connections */
 static const struct snd_soc_dapm_route audio_map_rx[] = {
 	/* Front Left/Right are fed VOUT1L/R */
-	{"Front-L/R", NULL, "VOUT1L"},
-	{"Front-L/R", NULL, "VOUT1R"},
+	{"Front", NULL, "VOUT1L"},
+	{"Front", NULL, "VOUT1R"},
 
 	/* Center/Sub are fed VOUT2L/R */
-	{"Center/Sub", NULL, "VOUT2L"},
-	{"Center/Sub", NULL, "VOUT2R"},
+	{"Center+Sub", NULL, "VOUT2L"},
+	{"Center+Sub", NULL, "VOUT2R"},
 
 	/* Rear Left/Right are fed VOUT3L/R */
-	{"Rear-L/R", NULL, "VOUT3L"},
-	{"Rear-L/R", NULL, "VOUT3R"},
+	{"Rear", NULL, "VOUT3L"},
+	{"Rear", NULL, "VOUT3R"},
 };
 
 static int smdk64xx_wm8580_init_paiftx(struct snd_soc_codec *codec)
-- 
1.7.1
