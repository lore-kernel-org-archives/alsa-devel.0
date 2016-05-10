From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/5] ASoC: da7213: Add DAI DAPM event to
	control DAI clocks
Date: Tue, 10 May 2016 16:11:04 +0100
Message-ID: <83d4df941ac77554f8d84ce5883bb782b5632000.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A19326524F
 for <alsa-devel@alsa-project.org>; Tue, 10 May 2016 17:11:05 +0200 (CEST)
In-Reply-To: <cover.1462892732.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

Currently, when Codec is I2S master DAI clocks are continuously
generated even if all audio streams have stopped. To improve
efficiency, control of the DAI clocks for master mode have been
moved to a DAPM widget event so they're only enabled as required.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7213.c | 35 ++++++++++++++++++++++++++++++++---
 sound/soc/codecs/da7213.h |  2 --
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 7278f93..701bd62 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -726,6 +726,36 @@ static const struct snd_kcontrol_new da7213_dapm_mixoutr_controls[] = {
 
 
 /*
+ * DAPM Events
+ */
+
+static int da7213_dai_event(struct snd_soc_dapm_widget *w,
+			    struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct da7213_priv *da7213 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Enable DAI clks for master mode */
+		if (da7213->master)
+			snd_soc_update_bits(codec, DA7213_DAI_CLK_MODE,
+					    DA7213_DAI_CLK_EN_MASK,
+					    DA7213_DAI_CLK_EN_MASK);
+		return 0;
+	case SND_SOC_DAPM_POST_PMD:
+		/* Disable DAI clks if in master mode */
+		if (da7213->master)
+			snd_soc_update_bits(codec, DA7213_DAI_CLK_MODE,
+					    DA7213_DAI_CLK_EN_MASK, 0);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+
+/*
  * DAPM widgets
  */
 
@@ -736,7 +766,8 @@ static const struct snd_soc_dapm_widget da7213_dapm_widgets[] = {
 
 	/* Use a supply here as this controls both input & output DAIs */
 	SND_SOC_DAPM_SUPPLY("DAI", DA7213_DAI_CTRL, DA7213_DAI_EN_SHIFT,
-			    DA7213_NO_INVERT, NULL, 0),
+			    DA7213_NO_INVERT, da7213_dai_event,
+			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 
 	/*
 	 * Input
@@ -1143,11 +1174,9 @@ static int da7213_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	/* Set master/slave mode */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM:
-		dai_clk_mode |= DA7213_DAI_CLK_EN_MASTER_MODE;
 		da7213->master = true;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
-		dai_clk_mode |= DA7213_DAI_CLK_EN_SLAVE_MODE;
 		da7213->master = false;
 		break;
 	default:
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 030fd69..5de5c29 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -178,8 +178,6 @@
 #define DA7213_DAI_BCLKS_PER_WCLK_MASK				(0x3 << 0)
 #define DA7213_DAI_CLK_POL_INV					(0x1 << 2)
 #define DA7213_DAI_WCLK_POL_INV					(0x1 << 3)
-#define DA7213_DAI_CLK_EN_SLAVE_MODE				(0x0 << 7)
-#define DA7213_DAI_CLK_EN_MASTER_MODE				(0x1 << 7)
 #define DA7213_DAI_CLK_EN_MASK					(0x1 << 7)
 
 /* DA7213_DAI_CTRL = 0x29 */
-- 
1.9.3
