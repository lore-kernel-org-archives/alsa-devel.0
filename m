From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3060: Add clock select" to the asoc tree
Date: Tue, 12 Feb 2019 14:22:02 +0000 (GMT)
Message-ID: <20190212142202.5F4AF1128113@debutante.sirena.org.uk>
References: <20190211060839.21417-2-kmarinushkin@birdec.tech>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190211060839.21417-2-kmarinushkin@birdec.tech>
Sender: linux-kernel-owner@vger.kernel.org
To: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3060: Add clock select

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 1e61405e201515d5767106babb4d750661ba5dcd Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Date: Mon, 11 Feb 2019 07:08:39 +0100
Subject: [PATCH] ASoC: pcm3060: Add clock select

ADC and DAC can be clocked from separate or same sources CLK1 and CLK2.
By default, ADC is clocked from CLK1, and DAC - from CLK2.

This commits allows sound cards to selest a proper clock source during
`hw_params()` via `snd_soc_dai_set_sysclk()`. It makes possible to have a
single clock source for both ADC and DAC.

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3060.c | 27 +++++++++++++++++++++++++++
 sound/soc/codecs/pcm3060.h |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 543cb86fd764..32b26f1c2282 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -18,12 +18,39 @@ static int pcm3060_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 {
 	struct snd_soc_component *comp = dai->component;
 	struct pcm3060_priv *priv = snd_soc_component_get_drvdata(comp);
+	unsigned int reg;
+	unsigned int val;
 
 	if (dir != SND_SOC_CLOCK_IN) {
 		dev_err(comp->dev, "unsupported sysclock dir: %d\n", dir);
 		return -EINVAL;
 	}
 
+	switch (clk_id) {
+	case PCM3060_CLK_DEF:
+		val = 0;
+		break;
+
+	case PCM3060_CLK1:
+		val = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG_CSEL : 0);
+		break;
+
+	case PCM3060_CLK2:
+		val = (dai->id == PCM3060_DAI_ID_DAC ? 0 : PCM3060_REG_CSEL);
+		break;
+
+	default:
+		dev_err(comp->dev, "unsupported sysclock id: %d\n", clk_id);
+		return -EINVAL;
+	}
+
+	if (dai->id == PCM3060_DAI_ID_DAC)
+		reg = PCM3060_REG67;
+	else
+		reg = PCM3060_REG72;
+
+	regmap_update_bits(priv->regmap, reg, PCM3060_REG_CSEL, val);
+
 	priv->dai[dai->id].sclk_freq = freq;
 
 	return 0;
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index 6a027b4a845d..75931c9a9d85 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -17,6 +17,11 @@ extern const struct regmap_config pcm3060_regmap;
 #define PCM3060_DAI_ID_ADC	1
 #define PCM3060_DAI_IDS_NUM	2
 
+/* ADC and DAC can be clocked from separate or same sources CLK1 and CLK2 */
+#define PCM3060_CLK_DEF	0 /* default: CLK1->ADC, CLK2->DAC */
+#define PCM3060_CLK1		1
+#define PCM3060_CLK2		2
+
 struct pcm3060_priv_dai {
 	bool is_master;
 	unsigned int sclk_freq;
-- 
2.20.1
