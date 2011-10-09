From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/5] ASoC: Convert SMDK WM8580 to table based
	DAPM init
Date: Sun,  9 Oct 2011 11:28:33 +0100
Message-ID: <1318156113-3344-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1318156113-3344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3882245D8
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Oct 2011 12:28:38 +0200 (CEST)
In-Reply-To: <1318156113-3344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/smdk_wm8580.c |   39 +++++++--------------------------------
 1 files changed, 7 insertions(+), 32 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8580.c b/sound/soc/samsung/smdk_wm8580.c
index 9de6b13..81b4478 100644
--- a/sound/soc/samsung/smdk_wm8580.c
+++ b/sound/soc/samsung/smdk_wm8580.c
@@ -120,30 +120,24 @@ static struct snd_soc_ops smdk_ops = {
 };
 
 /* SMDK Playback widgets */
-static const struct snd_soc_dapm_widget wm8580_dapm_widgets_pbk[] = {
+static const struct snd_soc_dapm_widget smdk_wm8580_dapm_widgets[] = {
 	SND_SOC_DAPM_HP("Front", NULL),
 	SND_SOC_DAPM_HP("Center+Sub", NULL),
 	SND_SOC_DAPM_HP("Rear", NULL),
-};
 
-/* SMDK Capture widgets */
-static const struct snd_soc_dapm_widget wm8580_dapm_widgets_cpt[] = {
 	SND_SOC_DAPM_MIC("MicIn", NULL),
 	SND_SOC_DAPM_LINE("LineIn", NULL),
 };
 
 /* SMDK-PAIFTX connections */
-static const struct snd_soc_dapm_route audio_map_tx[] = {
+static const struct snd_soc_dapm_route smdk_wm8580_audio_map[] = {
 	/* MicIn feeds AINL */
 	{"AINL", NULL, "MicIn"},
 
 	/* LineIn feeds AINL/R */
 	{"AINL", NULL, "LineIn"},
 	{"AINR", NULL, "LineIn"},
-};
 
-/* SMDK-PAIFRX connections */
-static const struct snd_soc_dapm_route audio_map_rx[] = {
 	/* Front Left/Right are fed VOUT1L/R */
 	{"Front", NULL, "VOUT1L"},
 	{"Front", NULL, "VOUT1R"},
@@ -162,13 +156,6 @@ static int smdk_wm8580_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 
-	/* Add smdk specific Capture widgets */
-	snd_soc_dapm_new_controls(dapm, wm8580_dapm_widgets_cpt,
-				  ARRAY_SIZE(wm8580_dapm_widgets_cpt));
-
-	/* Set up PAIFTX audio path */
-	snd_soc_dapm_add_routes(dapm, audio_map_tx, ARRAY_SIZE(audio_map_tx));
-
 	/* Enabling the microphone requires the fitting of a 0R
 	 * resistor to connect the line from the microphone jack.
 	 */
@@ -177,21 +164,6 @@ static int smdk_wm8580_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int smdk_wm8580_init_paifrx(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
-	/* Add smdk specific Playback widgets */
-	snd_soc_dapm_new_controls(dapm, wm8580_dapm_widgets_pbk,
-				  ARRAY_SIZE(wm8580_dapm_widgets_pbk));
-
-	/* Set up PAIFRX audio path */
-	snd_soc_dapm_add_routes(dapm, audio_map_rx, ARRAY_SIZE(audio_map_rx));
-
-	return 0;
-}
-
 enum {
 	PRI_PLAYBACK = 0,
 	PRI_CAPTURE,
@@ -206,7 +178,6 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.codec_dai_name = "wm8580-hifi-playback",
 		.platform_name = "samsung-audio",
 		.codec_name = "wm8580.0-001b",
-		.init = smdk_wm8580_init_paifrx,
 		.ops = &smdk_ops,
 	},
 	[PRI_CAPTURE] = { /* Primary Capture i/f */
@@ -226,7 +197,6 @@ static struct snd_soc_dai_link smdk_dai[] = {
 		.codec_dai_name = "wm8580-hifi-playback",
 		.platform_name = "samsung-audio",
 		.codec_name = "wm8580.0-001b",
-		.init = smdk_wm8580_init_paifrx,
 		.ops = &smdk_ops,
 	},
 };
@@ -235,6 +205,11 @@ static struct snd_soc_card smdk = {
 	.name = "SMDK-I2S",
 	.dai_link = smdk_dai,
 	.num_links = 2,
+
+	.dapm_widgets = smdk_wm8580_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(smdk_wm8580_dapm_widgets),
+	.dapm_routes = smdk_wm8580_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(smdk_wm8580_audio_map),
 };
 
 static struct platform_device *smdk_snd_device;
-- 
1.7.6.3
