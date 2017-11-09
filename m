From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 17/17] NOT FOR MERGING: Add demo jack detection policy for testing
Date: Wed, 8 Nov 2017 18:27:41 -0600
Message-ID: <20171109002741.10897-18-afd@ti.com>
References: <20171109002741.10897-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109002741.10897-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

---
 sound/soc/codecs/tlv320aic31xx.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 46cd132e93ef..12daba8f60cd 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1192,9 +1192,24 @@ static int aic31xx_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
+/* On a headphone jack event (headphones are inserted or removed from the
+ * the headphone jack) we disable the "Speaker External" widget and enable
+ * the "Headphone Jack" widget, on removal the opposite will occur. These
+ * widgets should be defined by, and their audio policy determined by, the
+ * parent sound card as only it can know how this CODEC is integrated into
+ * the bigger picture sound card device. Unfortunately the generic
+ * "simple-card" used to instantiate many of these CODECs on boards does
+ * not support this yet, so we do it here in the CODEC as an example.
+ */
+static struct snd_soc_jack_pin aic31xx_jack_pins[] = {
+	{ .pin = "Speaker External", .mask = SND_JACK_HEADPHONE, .invert = true, },
+	{ .pin = "Headphone Jack", .mask = SND_JACK_HEADPHONE, },
+};
+
 static int aic31xx_codec_probe(struct snd_soc_codec *codec)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_card *card = codec->component.card;
 	int i, ret;
 
 	dev_dbg(aic31xx->dev, "## %s\n", __func__);
@@ -1226,6 +1241,17 @@ static int aic31xx_codec_probe(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;
 
+	aic31xx->jack = devm_kzalloc(aic31xx->dev, sizeof(*aic31xx->jack), GFP_KERNEL);
+	if (!aic31xx->jack)
+		return -ENOMEM;
+	ret = snd_soc_card_jack_new(card, "Headphone Jack", AIC31XX_JACK_MASK,
+				    aic31xx->jack, aic31xx_jack_pins,
+				    ARRAY_SIZE(aic31xx_jack_pins));
+	if (ret) {
+		dev_err(codec->dev, "Cannot create jack\n");
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.15.0
