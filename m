From: Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] ASoC: tlv320aic32x4: Add support for
	tlv320aic32x6
Date: Wed, 12 Jul 2017 13:36:59 -0500
Message-ID: <20170712183700.15310-1-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 43E4C2664EB
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 20:37:04 +0200 (CEST)
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
Cc: Dan Murphy <dmurphy@ti.com>, broonie@kernel.org, linux-kernel@vger.kernel.org, javier.martin@vista-silicon.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Add support for the tlv320aic32x6 family of devices.
These devices share the same register set as the tlv320aic32x4
and this driver can be re-used.

TLV320aic32x6 data sheets are here:
tlv320aic3256 - http://www.ti.com/lit/gpn/tlv320aic3256
tlv320aic3206 - http://www.ti.com/lit/gpn/tlv320aic3206

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tlv320aic32x4.txt | 4 +++-
 sound/soc/codecs/tlv320aic32x4-i2c.c                      | 2 ++
 sound/soc/codecs/tlv320aic32x4-spi.c                      | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
index 5e2741af27be..9651fc7503a4 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
@@ -3,7 +3,9 @@ Texas Instruments - tlv320aic32x4 Codec module
 The tlv320aic32x4 serial control bus communicates through I2C protocols
 
 Required properties:
- - compatible: Should be "ti,tlv320aic32x4"
+ - compatible - "string" - One of:
+	"ti,tlv320aic32x4" TLV320AIC3204
+	"ti,tlv320aic32x6" TLV320AIC3206, TLV320AIC3256
  - reg: I2C slave address
  - supply-*: Required supply regulators are:
     "iov" - digital IO power supply
diff --git a/sound/soc/codecs/tlv320aic32x4-i2c.c b/sound/soc/codecs/tlv320aic32x4-i2c.c
index 59606cf3008f..385fa2e9525a 100644
--- a/sound/soc/codecs/tlv320aic32x4-i2c.c
+++ b/sound/soc/codecs/tlv320aic32x4-i2c.c
@@ -47,12 +47,14 @@ static int aic32x4_i2c_remove(struct i2c_client *i2c)
 
 static const struct i2c_device_id aic32x4_i2c_id[] = {
 	{ "tlv320aic32x4", 0 },
+	{ "tlv320aic32x6", 1 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, aic32x4_i2c_id);
 
 static const struct of_device_id aic32x4_of_id[] = {
 	{ .compatible = "ti,tlv320aic32x4", },
+	{ .compatible = "ti,tlv320aic32x6", },
 	{ /* senitel */ }
 };
 MODULE_DEVICE_TABLE(of, aic32x4_of_id);
diff --git a/sound/soc/codecs/tlv320aic32x4-spi.c b/sound/soc/codecs/tlv320aic32x4-spi.c
index 724fcdd491b2..07d78ae51e05 100644
--- a/sound/soc/codecs/tlv320aic32x4-spi.c
+++ b/sound/soc/codecs/tlv320aic32x4-spi.c
@@ -48,12 +48,14 @@ static int aic32x4_spi_remove(struct spi_device *spi)
 
 static const struct spi_device_id aic32x4_spi_id[] = {
 	{ "tlv320aic32x4", 0 },
+	{ "tlv320aic32x6", 1 },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, aic32x4_spi_id);
 
 static const struct of_device_id aic32x4_of_id[] = {
 	{ .compatible = "ti,tlv320aic32x4", },
+	{ .compatible = "ti,tlv320aic32x6", },
 	{ /* senitel */ }
 };
 MODULE_DEVICE_TABLE(of, aic32x4_of_id);
-- 
2.13.2.516.ge629a7d28
