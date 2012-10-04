From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] ALSA: ASoC: cs4271: add DT property for
	AMUTEB=BMUTEC feature
Date: Thu,  4 Oct 2012 13:53:59 +0200
Message-ID: <1349351639-17506-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 47E5C2615F5
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 13:54:25 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, Alexander Sverdlin <subaparts@yandex.ru>, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The CS4271 has a feature to sync its analog mute flags, so one mute
circuitry can be used for both channels.

Give DT uses access to this feature with a new property.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Alexander Sverdlin <subaparts@yandex.ru>
---
 Documentation/devicetree/bindings/sound/cs4271.txt |  2 ++
 sound/soc/codecs/cs4271.c                          | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/cs4271.txt b/Documentation/devicetree/bindings/sound/cs4271.txt
index c81b5fd..a850fb9 100644
--- a/Documentation/devicetree/bindings/sound/cs4271.txt
+++ b/Documentation/devicetree/bindings/sound/cs4271.txt
@@ -18,6 +18,8 @@ Optional properties:
 
  - reset-gpio: 	a GPIO spec to define which pin is connected to the chip's
 		!RESET pin
+ - cirrus,amuteb-eq-bmutec:	When given, the Codec's AMUTEB=BMUTEC flag
+				is enabled.
 
 Examples:
 
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index f994af3..56ec8dd2 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -474,11 +474,17 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 	struct cs4271_platform_data *cs4271plat = codec->dev->platform_data;
 	int ret;
 	int gpio_nreset = -EINVAL;
+	int amutec_eq_bmutec = 0;
 
 #ifdef CONFIG_OF
-	if (of_match_device(cs4271_dt_ids, codec->dev))
+	if (of_match_device(cs4271_dt_ids, codec->dev)) {
 		gpio_nreset = of_get_named_gpio(codec->dev->of_node,
 						"reset-gpio", 0);
+
+		if (!of_get_property(codec->dev->of_node,
+				     "cirrus,amutec-eq-bmutec", NULL))
+			amutec_eq_bmutec = 1;
+	}
 #endif
 
 	if (cs4271plat && gpio_is_valid(cs4271plat->gpio_nreset))
@@ -528,6 +534,11 @@ static int cs4271_probe(struct snd_soc_codec *codec)
 	/* Power-up sequence requires 85 uS */
 	udelay(85);
 
+	if (amutec_eq_bmutec)
+		snd_soc_update_bits(codec, CS4271_MODE2,
+				    CS4271_MODE2_MUTECAEQUB,
+				    CS4271_MODE2_MUTECAEQUB);
+
 	return snd_soc_add_codec_controls(codec, cs4271_snd_controls,
 		ARRAY_SIZE(cs4271_snd_controls));
 }
-- 
1.7.11.4
