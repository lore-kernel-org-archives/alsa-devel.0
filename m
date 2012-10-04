From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2] ALSA: ASoC: cs4271: add support for
	AMUTEB=BMUTEC feature
Date: Thu,  4 Oct 2012 14:03:23 +0200
Message-ID: <1349352203-24035-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 3120C261616
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 14:03:29 +0200 (CEST)
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

Give users access to this feature with a new DT property and a flag in
the platform data.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Alexander Sverdlin <subaparts@yandex.ru>
---
 Documentation/devicetree/bindings/sound/cs4271.txt |  2 ++
 include/sound/cs4271.h                             |  1 +
 sound/soc/codecs/cs4271.c                          | 21 ++++++++++++++++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

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
 
diff --git a/include/sound/cs4271.h b/include/sound/cs4271.h
index 50a059e..6d9e15e 100644
--- a/include/sound/cs4271.h
+++ b/include/sound/cs4271.h
@@ -19,6 +19,7 @@
 
 struct cs4271_platform_data {
 	int gpio_nreset;	/* GPIO driving Reset pin, if any */
+	int amutec_eq_bmutec:1;	/* flag to enable AMUTEC=BMUTEC */
 };
 
 #endif /* __CS4271_H */
diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index f994af3..2ac5fe6 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -474,15 +474,25 @@ static int cs4271_probe(struct snd_soc_codec *codec)
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
 
-	if (cs4271plat && gpio_is_valid(cs4271plat->gpio_nreset))
-		gpio_nreset = cs4271plat->gpio_nreset;
+	if (cs4271plat) {
+		if (gpio_is_valid(cs4271plat->gpio_nreset))
+			gpio_nreset = cs4271plat->gpio_nreset;
+
+		amutec_eq_bmutec = cs4271plat->amutec_eq_bmutec;
+	}
 
 	if (gpio_nreset >= 0)
 		if (gpio_request(gpio_nreset, "CS4271 Reset"))
@@ -528,6 +538,11 @@ static int cs4271_probe(struct snd_soc_codec *codec)
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
