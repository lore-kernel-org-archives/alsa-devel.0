From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Add support for tlv320aic32x6" to the asoc tree
Date: Mon, 17 Jul 2017 17:04:59 +0100
Message-ID: <E1dX8W3-0004d5-UC@debutante>
References: <20170712183700.15310-1-dmurphy@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170712183700.15310-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.orgbroonie@kernel.org, linux-kernel@vger.kernel.org, javier.martin@vista-silicon.com, lgirdwood@gmail.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Add support for tlv320aic32x6

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

>From fde0543f1129967dfa73f1fa3477c7fe12052da5 Mon Sep 17 00:00:00 2001
From: Dan Murphy <dmurphy@ti.com>
Date: Wed, 12 Jul 2017 13:36:59 -0500
Subject: [PATCH] ASoC: tlv320aic32x4: Add support for tlv320aic32x6

Add support for the tlv320aic32x6 family of devices.
These devices share the same register set as the tlv320aic32x4
and this driver can be re-used.

TLV320aic32x6 data sheets are here:
tlv320aic3256 - http://www.ti.com/lit/gpn/tlv320aic3256
tlv320aic3206 - http://www.ti.com/lit/gpn/tlv320aic3206

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.13.2
