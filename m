From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] ASoC: es8316: Add support for inverted jack detect
Date: Fri, 29 Mar 2019 22:50:43 +0100
Message-ID: <20190329215045.6254-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

On some devices (Teclast X98+ II tablet, maybe others), the jack
detection has been wired backwards, so when the ES8316 reports
headphones being present it means they are actually not plugged.

Use a quirk around this incorrect behaviour, which can be enabled
through the 'everest,jack-detect-inverted' boolean device property.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
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
2.11.0
