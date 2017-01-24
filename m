From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: es8328-i2c: Add compatible for ES8388" to the asoc tree
Date: Tue, 24 Jan 2017 18:39:21 +0000
Message-ID: <E1cW601-0006aO-73@debutante>
References: <20170116081753.13666-2-romain.perier@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170116081753.13666-2-romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sjoerd Simons <sjoerd.simons-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8328-i2c: Add compatible for ES8388

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

>From 5f166156dbd4c0cf85632799ee7330d24deeec4e Mon Sep 17 00:00:00 2001
From: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Date: Mon, 23 Jan 2017 11:41:46 +0100
Subject: [PATCH] ASoC: es8328-i2c: Add compatible for ES8388

This commit adds a compatible string for everest,es8388. This is
an audio codec that is compatible with es8328.

Signed-off-by: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/es8328.txt | 2 +-
 sound/soc/codecs/es8328-i2c.c                      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/es8328.txt b/Documentation/devicetree/bindings/sound/es8328.txt
index 30ea8a318ae9..33fbf058c997 100644
--- a/Documentation/devicetree/bindings/sound/es8328.txt
+++ b/Documentation/devicetree/bindings/sound/es8328.txt
@@ -4,7 +4,7 @@ This device supports both I2C and SPI.
 
 Required properties:
 
-  - compatible : "everest,es8328"
+  - compatible  : Should be "everest,es8328" or "everest,es8388"
   - DVDD-supply : Regulator providing digital core supply voltage 1.8 - 3.6V
   - AVDD-supply : Regulator providing analog supply voltage 3.3V
   - PVDD-supply : Regulator providing digital IO supply voltage 1.8 - 3.6V
diff --git a/sound/soc/codecs/es8328-i2c.c b/sound/soc/codecs/es8328-i2c.c
index 2d05b5d3a6ce..318ab28c5351 100644
--- a/sound/soc/codecs/es8328-i2c.c
+++ b/sound/soc/codecs/es8328-i2c.c
@@ -20,12 +20,14 @@
 
 static const struct i2c_device_id es8328_id[] = {
 	{ "es8328", 0 },
+	{ "es8388", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, es8328_id);
 
 static const struct of_device_id es8328_of_match[] = {
 	{ .compatible = "everest,es8328", },
+	{ .compatible = "everest,es8388", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, es8328_of_match);
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
