From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/2] ASoC: tlv320aic3x: List tlv320aic3106 as a supported
 device
Date: Tue, 16 Jul 2013 13:42:10 +0100
Message-ID: <1373978530-23027-2-git-send-email-broonie@kernel.org>
References: <1373978530-23027-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1373978530-23027-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Currently there is no specific handling for it but the tlv320aic3106 is
supported using this driver.

Signed-off-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/tlv320aic3x.txt | 1 +
 sound/soc/codecs/tlv320aic3x.c                          | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
index 26f65f9..705a6b1 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
@@ -8,6 +8,7 @@ Required properties:
     "ti,tlv320aic3x" - Generic TLV320AIC3x device
     "ti,tlv320aic33" - TLV320AIC33
     "ti,tlv320aic3007" - TLV320AIC3007
+    "ti,tlv320aic3106" - TLV320AIC3106
 
 
 - reg - <int> -  I2C slave address
diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index c9bb760..cad4fb1 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1492,6 +1492,7 @@ static const struct i2c_device_id aic3x_i2c_id[] = {
 	{ "tlv320aic3x", AIC3X_MODEL_3X },
 	{ "tlv320aic33", AIC3X_MODEL_33 },
 	{ "tlv320aic3007", AIC3X_MODEL_3007 },
+	{ "tlv320aic3106", AIC3X_MODEL_3X },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, aic3x_i2c_id);
@@ -1584,6 +1585,7 @@ static const struct of_device_id tlv320aic3x_of_match[] = {
 	{ .compatible = "ti,tlv320aic3x", },
 	{ .compatible = "ti,tlv320aic33" },
 	{ .compatible = "ti,tlv320aic3007" },
+	{ .compatible = "ti,tlv320aic3106" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, tlv320aic3x_of_match);
-- 
1.8.3.2
