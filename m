From: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v3 1/3] SoC: es8328-i2c: Add compatible for ES8323
Date: Fri, 12 May 2017 15:22:17 +0200
Message-ID: <20170512132227.24916-2-romain.perier@collabora.com>
References: <20170512132227.24916-1-romain.perier@collabora.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170512132227.24916-1-romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This commit adds a compatible string for everest,es8323. This is an
audio codec that is compatible with es8328 and can be found for example
on the Firefly-RK3288 board.

Signed-off-by: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/sound/es8328.txt | 5 ++++-
 sound/soc/codecs/es8328-i2c.c                      | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/es8328.txt b/Documentation/devicetree/bindings/sound/es8328.txt
index 33fbf058c997..86b6d6e99732 100644
--- a/Documentation/devicetree/bindings/sound/es8328.txt
+++ b/Documentation/devicetree/bindings/sound/es8328.txt
@@ -4,7 +4,10 @@ This device supports both I2C and SPI.
 
 Required properties:
 
-  - compatible  : Should be "everest,es8328" or "everest,es8388"
+  - compatible  : Should be one of the following:
+	- "everest,es8323"
+	- "everest,es8328"
+	- "everest,es8388"
   - DVDD-supply : Regulator providing digital core supply voltage 1.8 - 3.6V
   - AVDD-supply : Regulator providing analog supply voltage 3.3V
   - PVDD-supply : Regulator providing digital IO supply voltage 1.8 - 3.6V
diff --git a/sound/soc/codecs/es8328-i2c.c b/sound/soc/codecs/es8328-i2c.c
index 318ab28c5351..be3f03c35137 100644
--- a/sound/soc/codecs/es8328-i2c.c
+++ b/sound/soc/codecs/es8328-i2c.c
@@ -19,6 +19,7 @@
 #include "es8328.h"
 
 static const struct i2c_device_id es8328_id[] = {
+	{ "es8323", 0 },
 	{ "es8328", 0 },
 	{ "es8388", 0 },
 	{ }
@@ -26,6 +27,7 @@ static const struct i2c_device_id es8328_id[] = {
 MODULE_DEVICE_TABLE(i2c, es8328_id);
 
 static const struct of_device_id es8328_of_match[] = {
+	{ .compatible = "everest,es8323", },
 	{ .compatible = "everest,es8328", },
 	{ .compatible = "everest,es8388", },
 	{ }
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
