From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 5/5] ASoC: codecs: tas5086: add support for pwm
	start mode config
Date: Mon, 24 Jun 2013 16:25:32 +0200
Message-ID: <1372083932-4318-5-git-send-email-zonque@gmail.com>
References: <1372083932-4318-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 19B0C265090
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:25:32 +0200 (CEST)
In-Reply-To: <1372083932-4318-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The TAS5086 has two alternative modes to start its PWM channels, Mid-Z
and Low-Z. Which one to use depends on how the PWM power stages are
connected to the TAS5086.

This patch adds 6 optional boolean properties to the DT bindings of the
driver which allow the user to configure each individual channel to the
Mid-Z scheme, and leaves all the others to the default (Low-Z).

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 .../devicetree/bindings/sound/ti,tas5086.txt       | 11 +++++++++++
 sound/soc/codecs/tas5086.c                         | 22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas5086.txt b/Documentation/devicetree/bindings/sound/ti,tas5086.txt
index e8310f1..f199f7d 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas5086.txt
+++ b/Documentation/devicetree/bindings/sound/ti,tas5086.txt
@@ -20,6 +20,17 @@ Optional properties:
 			When not specified, the hardware default of 1300ms
 			is retained.
 
+ - ti,mid-z-channel-X:	Boolean properties, X being a number from 1 to 6.
+			If given, channel X will start with the Mid-Z start
+			sequence, otherwise the default Low-Z scheme is used.
+
+			The correct configuration depends on how the power
+			stages connected to the PWM output pins work. Not all
+			power stages are compatible to Mid-Z - please refer
+			to the datasheets for more details.
+
+			Most systems should not set any of these properties.
+
 Examples:
 
 	i2c_bus {
diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 99e190d..fec9a28 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -88,6 +88,10 @@
 
 #define TAS5086_MAX_REGISTER		TAS5086_PWM_OUTPUT_MUX
 
+#define TAS5086_PWM_START_MIDZ_FOR_START_1	(1 << 7)
+#define TAS5086_PWM_START_MIDZ_FOR_START_2	(1 << 6)
+#define TAS5086_PWM_START_CHANNEL_MASK		(0x3f)
+
 /*
  * Default TAS5086 power-up configuration
  */
@@ -717,13 +721,31 @@ static int tas5086_probe(struct snd_soc_codec *codec)
 {
 	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
 	int charge_period = 1300000; /* hardware default is 1300 ms */
+	u8 pwm_start = TAS5086_PWM_START_CHANNEL_MASK;
 	int i, ret;
 
 	if (of_match_device(of_match_ptr(tas5086_dt_ids), codec->dev)) {
 		struct device_node *of_node = codec->dev->of_node;
 		of_property_read_u32(of_node, "ti,charge-period", &charge_period);
+
+		for (i = 0; i < 6; i++) {
+			char name[25];
+
+			snprintf(name, sizeof(name),
+				 "ti,mid-z-channel-%d", i + 1);
+
+			if (of_get_property(of_node, name, NULL) != NULL)
+				pwm_start &= ~(1 << i);
+		}
 	}
 
+	/*
+	 * Configure 'part 2' of the PWM starts to always use MID-Z, and tell
+	 * all configured mid-z channels to start start under 'part 2'.
+	 */
+	regmap_write(priv->regmap, TAS5086_PWM_START,
+		     TAS5086_PWM_START_MIDZ_FOR_START_2 | pwm_start);
+
 	/* lookup and set split-capacitor charge period */
 	if (charge_period == 0) {
 		regmap_write(priv->regmap, TAS5086_SPLIT_CAP_CHARGE, 0);
-- 
1.8.1.4
