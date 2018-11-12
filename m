From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH v2 2/3] ASoC: pcm3060: Add DT property for single-ended output
Date: Mon, 12 Nov 2018 08:08:33 +0100
Message-ID: <20181112070834.16979-2-kmarinushkin@birdec.tech>
References: <20181105112036.GC5365@sirena.org.uk>
 <20181112070834.16979-1-kmarinushkin@birdec.tech>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181112070834.16979-1-kmarinushkin@birdec.tech>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kirill Marinushkin <kmarinushkin@birdec.tech>
List-Id: alsa-devel@alsa-project.org

DAC output may be differential (default) or single-ended.

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 sound/soc/codecs/pcm3060.c | 14 ++++++++++++++
 sound/soc/codecs/pcm3060.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 494d9d662be8..5f479aa61097 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -274,9 +274,23 @@ EXPORT_SYMBOL(pcm3060_regmap);
 
 /* device */
 
+static void pcm3060_parse_dt(const struct device_node *np,
+			     struct pcm3060_priv *priv)
+{
+	priv->out_se = of_property_read_bool(np, "ti,out-single-ended");
+}
+
 int pcm3060_probe(struct device *dev)
 {
 	int rc;
+	struct pcm3060_priv *priv = dev_get_drvdata(dev);
+
+	if (dev->of_node)
+		pcm3060_parse_dt(dev->of_node, priv);
+
+	if (priv->out_se)
+		regmap_update_bits(priv->regmap, PCM3060_REG64,
+				   PCM3060_REG_SE, PCM3060_REG_SE);
 
 	rc = devm_snd_soc_register_component(dev, &pcm3060_soc_comp_driver,
 					     pcm3060_dai,
diff --git a/sound/soc/codecs/pcm3060.h b/sound/soc/codecs/pcm3060.h
index fd89a68aa8a7..c895cf40ee10 100644
--- a/sound/soc/codecs/pcm3060.h
+++ b/sound/soc/codecs/pcm3060.h
@@ -25,6 +25,7 @@ struct pcm3060_priv_dai {
 struct pcm3060_priv {
 	struct regmap *regmap;
 	struct pcm3060_priv_dai dai[PCM3060_DAI_IDS_NUM];
+	u8 out_se: 1;
 };
 
 int pcm3060_probe(struct device *dev);
-- 
2.13.6
