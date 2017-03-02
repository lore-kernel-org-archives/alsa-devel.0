From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH] ASoC: Intel: Update bxt_da7219_max98357a to
	add a new platform clock widget
Date: Thu,  2 Mar 2017 13:54:57 -0800
Message-ID: <1488491697-18576-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C008266569
 for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2017 22:55:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, vinod.koul@intel.com, alsa-devel@alsa-project.org
Cc: harshapriya.n@intel.com, sathyanarayana.nujella@intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds a platform clock widget to turn off the clock only when
both headset capture and headset playback are not in use. This removes
turning off the clock in hw_free so that the clock is on when
either capture or playback of headset is in progress.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 58 +++++++++++++++++++--------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 2cda06c..ed58809 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -55,6 +55,42 @@ enum {
 	BXT_DPCM_AUDIO_HDMI3_PB,
 };
 
+static inline struct snd_soc_dai *bxt_get_codec_dai(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *rtd;
+
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+
+		if (!strncmp(rtd->codec_dai->name, BXT_DIALOG_CODEC_DAI,
+			     strlen(BXT_DIALOG_CODEC_DAI)))
+			return rtd->codec_dai;
+	}
+
+	return NULL;
+}
+
+static int platform_clock_control(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *k, int  event)
+{
+	int ret = 0;
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_soc_card *card = dapm->card;
+	struct snd_soc_dai *codec_dai;
+
+	codec_dai = bxt_get_codec_dai(card);
+	if (!codec_dai) {
+		dev_err(card->dev, "Codec dai not found; Unable to stop PLL\n");
+		return -EIO;
+	}
+
+	if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		ret = snd_soc_dai_set_pll(codec_dai, 0,
+			DA7219_SYSCLK_MCLK, 0, 0);
+	}
+
+	return ret;
+}
+
 static const struct snd_kcontrol_new broxton_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
@@ -69,6 +105,8 @@ enum {
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
 	SND_SOC_DAPM_SPK("HDMI3", NULL),
+	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
+			platform_clock_control,	SND_SOC_DAPM_POST_PMD),
 };
 
 static const struct snd_soc_dapm_route broxton_map[] = {
@@ -109,6 +147,9 @@ enum {
 	/* DMIC */
 	{"dmic01_hifi", NULL, "DMIC01 Rx"},
 	{"DMIC01 Rx", NULL, "DMIC AIF"},
+
+	{ "Headphone Jack", NULL, "Platform Clock" },
+	{ "Headset Mic", NULL, "Platform Clock" },
 };
 
 static int broxton_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -265,25 +306,8 @@ static int broxton_da7219_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int broxton_da7219_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	ret = snd_soc_dai_set_pll(codec_dai, 0,
-			DA7219_SYSCLK_MCLK, 0, 0);
-	if (ret < 0) {
-		dev_err(codec_dai->dev, "failed to stop PLL: %d\n", ret);
-		return -EIO;
-	}
-
-	return ret;
-}
-
 static const struct snd_soc_ops broxton_da7219_ops = {
 	.hw_params = broxton_da7219_hw_params,
-	.hw_free = broxton_da7219_hw_free,
 };
 
 static int broxton_dmic_fixup(struct snd_soc_pcm_runtime *rtd,
-- 
1.9.1
