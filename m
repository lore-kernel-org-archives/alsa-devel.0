From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8316: Add support for inverted jack detect" to the asoc tree
Date: Mon,  1 Apr 2019 09:52:58 +0100 (BST)
Message-ID: <20190401085258.20BE0440083@finisterre.ee.mobilebroadband>
References: <20190329215045.6254-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329215045.6254-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8316: Add support for inverted jack detect

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

>From 0bbcedd6bb41b82b77115fc001441ff34e7c4ea7 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 29 Mar 2019 22:50:43 +0100
Subject: [PATCH] ASoC: es8316: Add support for inverted jack detect

On some devices (Teclast X98+ II tablet, maybe others), the jack
detection has been wired backwards, so when the ES8316 reports
headphones being present it means they are actually not plugged.

Use a quirk around this incorrect behaviour, which can be enabled
through the 'everest,jack-detect-inverted' boolean device property.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8316.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 6d4a323f786b..ec2770b3f77d 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -43,6 +43,7 @@ struct es8316_priv {
 	unsigned int sysclk;
 	unsigned int allowed_rates[NR_SUPPORTED_MCLK_LRCK_RATIOS];
 	struct snd_pcm_hw_constraint_list sysclk_constraints;
+	bool jd_inverted;
 };
 
 /*
@@ -577,6 +578,9 @@ static irqreturn_t es8316_irq(int irq, void *data)
 	if (!es8316->jack)
 		goto out;
 
+	if (es8316->jd_inverted)
+		flags ^= ES8316_GPIO_FLAG_HP_NOT_INSERTED;
+
 	dev_dbg(comp->dev, "gpio flags %#04x\n", flags);
 	if (flags & ES8316_GPIO_FLAG_HP_NOT_INSERTED) {
 		/* Jack removed, or spurious IRQ? */
@@ -592,6 +596,8 @@ static irqreturn_t es8316_irq(int irq, void *data)
 		/* Jack inserted, determine type */
 		es8316_enable_micbias_for_mic_gnd_short_detect(comp);
 		regmap_read(es8316->regmap, ES8316_GPIO_FLAG, &flags);
+		if (es8316->jd_inverted)
+			flags ^= ES8316_GPIO_FLAG_HP_NOT_INSERTED;
 		dev_dbg(comp->dev, "gpio flags %#04x\n", flags);
 		if (flags & ES8316_GPIO_FLAG_HP_NOT_INSERTED) {
 			/* Jack unplugged underneath us */
@@ -633,6 +639,14 @@ static void es8316_enable_jack_detect(struct snd_soc_component *component,
 {
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
 
+	/*
+	 * Init es8316->jd_inverted here and not in the probe, as we cannot
+	 * guarantee that the bytchr-es8316 driver, which might set this
+	 * property, will probe before us.
+	 */
+	es8316->jd_inverted = device_property_read_bool(component->dev,
+							"everest,jack-detect-inverted");
+
 	mutex_lock(&es8316->lock);
 
 	es8316->jack = jack;
-- 
2.20.1
