From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: apq8016-sbc: set default mclk rate" to the asoc tree
Date: Wed, 02 Aug 2017 18:29:53 +0100
Message-ID: <E1dcxSz-0003jr-B7@debutante>
References: <20170725234822.18763-3-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725234822.18763-3-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: apq8016-sbc: set default mclk rate

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 334822a3b21f5b622ae1954915003d636186e7b0 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 2 Aug 2017 15:17:47 +0200
Subject: [PATCH] ASoC: qcom: apq8016-sbc: set default mclk rate

MCLK for internal audio codec is expected to be at 9.6MHz by default.
This patch adds support to 9.6MHz to make the default case possible.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/apq8016_sbc.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index d084d7468299..f07aa1e1cdfe 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -34,13 +34,16 @@ struct apq8016_sbc_data {
 #define MIC_CTRL_QUA_WS_SLAVE_SEL_10	BIT(17)
 #define MIC_CTRL_TLMM_SCLK_EN		BIT(1)
 #define	SPKR_CTL_PRI_WS_SLAVE_SEL_11	(BIT(17) | BIT(16))
+#define DEFAULT_MCLK_RATE		9600000
 
 static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_codec *codec;
+	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 	struct snd_soc_card *card = rtd->card;
 	struct apq8016_sbc_data *pdata = snd_soc_card_get_drvdata(card);
-	int rval = 0;
+	int i, rval;
 
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
@@ -63,12 +66,24 @@ static int apq8016_sbc_dai_init(struct snd_soc_pcm_runtime *rtd)
 
 	default:
 		dev_err(card->dev, "unsupported cpu dai configuration\n");
-		rval = -EINVAL;
-		break;
+		return -EINVAL;
+
+	}
 
+	for (i = 0 ; i < dai_link->num_codecs; i++) {
+		struct snd_soc_dai *dai = rtd->codec_dais[i];
+
+		codec = dai->codec;
+		/* Set default mclk for internal codec */
+		rval = snd_soc_codec_set_sysclk(codec, 0, 0, DEFAULT_MCLK_RATE,
+				       SND_SOC_CLOCK_IN);
+		if (rval != 0 && rval != -ENOTSUPP) {
+			dev_warn(card->dev, "Failed to set mclk: %d\n", rval);
+			return rval;
+		}
 	}
 
-	return rval;
+	return 0;
 }
 
 static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
-- 
2.13.2
