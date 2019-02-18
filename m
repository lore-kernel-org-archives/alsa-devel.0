From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: odroid: Ensure proper sample rate on pri/sec PCM" to the asoc tree
Date: Mon, 18 Feb 2019 18:52:23 +0000 (GMT)
Message-ID: <20190218185223.3FF701128008@debutante.sirena.org.uk>
References: <20190214160011.3940-1-s.nawrocki@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214160011.3940-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, sbkim73@samsung.com, lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: odroid: Ensure proper sample rate on pri/sec PCM

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

>From b5c16a24efc809554c4c651df6bd9b48b084a5a3 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 14 Feb 2019 17:00:11 +0100
Subject: [PATCH] ASoC: samsung: odroid: Ensure proper sample rate on pri/sec
 PCM

Currently when playing sound with different sample rates actual
sample rate will be determined by audio stream which starts first
on either primary or secondary PCM. The audio root clock will be
configured appropriately only for the first stream. As the hardware
is limited to same sample rate on both interfaces we need to disallow
streams with different sample rates. It is done by this patch by
returning error in FE hw_params if there is already active stream
running with different sample rate.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/odroid.c | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/sound/soc/samsung/odroid.c b/sound/soc/samsung/odroid.c
index 18bb3bfe0300..941e8c3f67a4 100644
--- a/sound/soc/samsung/odroid.c
+++ b/sound/soc/samsung/odroid.c
@@ -20,6 +20,11 @@ struct odroid_priv {
 	struct snd_soc_card card;
 	struct clk *clk_i2s_bus;
 	struct clk *sclk_i2s;
+
+	/* Spinlock protecting fields below */
+	spinlock_t lock;
+	unsigned int be_sample_rate;
+	bool be_active;
 };
 
 static int odroid_card_fe_startup(struct snd_pcm_substream *substream)
@@ -31,8 +36,25 @@ static int odroid_card_fe_startup(struct snd_pcm_substream *substream)
 	return 0;
 }
 
+static int odroid_card_fe_hw_params(struct snd_pcm_substream *substream,
+				      struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct odroid_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (priv->be_active && priv->be_sample_rate != params_rate(params))
+		ret = -EINVAL;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
+}
+
 static const struct snd_soc_ops odroid_card_fe_ops = {
 	.startup = odroid_card_fe_startup,
+	.hw_params = odroid_card_fe_hw_params,
 };
 
 static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
@@ -41,6 +63,7 @@ static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct odroid_priv *priv = snd_soc_card_get_drvdata(rtd->card);
 	unsigned int pll_freq, rclk_freq, rfs;
+	unsigned long flags;
 	int ret;
 
 	switch (params_rate(params)) {
@@ -87,11 +110,43 @@ static int odroid_card_be_hw_params(struct snd_pcm_substream *substream,
 			return ret;
 	}
 
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->be_sample_rate = params_rate(params);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int odroid_card_be_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct odroid_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		priv->be_active = true;
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		priv->be_active = false;
+		break;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	return 0;
 }
 
 static const struct snd_soc_ops odroid_card_be_ops = {
 	.hw_params = odroid_card_be_hw_params,
+	.trigger = odroid_card_be_trigger,
 };
 
 static struct snd_soc_dai_link odroid_card_dais[] = {
@@ -150,6 +205,7 @@ static int odroid_audio_probe(struct platform_device *pdev)
 	card->owner = THIS_MODULE;
 	card->fully_routed = true;
 
+	spin_lock_init(&priv->lock);
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = snd_soc_of_parse_card_name(card, "model");
-- 
2.20.1
