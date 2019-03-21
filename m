From: "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH v2 4/7] ASoC: tlv320aic26: Fix module autoload
Date: Thu, 21 Mar 2019 18:15:46 -0400
Message-ID: <20190321221549.13765-5-jcormier@criticallink.com>
References: <20190321221549.13765-1-jcormier@criticallink.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321221549.13765-1-jcormier@criticallink.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Cc: Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Greg Gluszek <greg.gluszek@criticallink.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add the missing MODULE_DEVICE_TABLE() for OF and SPI to export
the information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519
https://lkml.org/lkml/2014/9/11/458

Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/tlv320aic26.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 5c9b320b918c..db1d1704ae5c 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -368,6 +368,12 @@ static int aic26_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
+static const struct spi_device_id tlv320aic26_id_table[] = {
+	{ "tlv320aic26" },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, tlv320aic26_id_table);
+
 static const struct of_device_id tlv320aic26_of_match[] = {
 	{ .compatible = "ti,tlv320aic26", },
 	{},
@@ -380,6 +386,7 @@ static struct spi_driver aic26_spi = {
 		.of_match_table = of_match_ptr(tlv320aic26_of_match),
 	},
 	.probe = aic26_spi_probe,
+	.id_table = tlv320aic26_id_table,
 };
 
 module_spi_driver(aic26_spi);
-- 
2.21.0
