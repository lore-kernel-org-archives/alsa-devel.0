From: "Cormier, Jonathan" <jcormier@criticallink.com>
Subject: [PATCH v2 3/7] ASoC: tlv320aic26: Add device tree binding
Date: Thu, 21 Mar 2019 18:15:45 -0400
Message-ID: <20190321221549.13765-4-jcormier@criticallink.com>
References: <20190321221549.13765-1-jcormier@criticallink.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321221549.13765-1-jcormier@criticallink.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Cc: Bob Duke <bduke@criticallink.com>, Mike Williamson <michael.williamson@criticallink.com>, Greg Gluszek <greg.gluszek@criticallink.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add support for the TI tlv320aic26 sound codec

Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/tlv320aic26.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index b91b8d5f1ba3..5c9b320b918c 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -368,9 +368,16 @@ static int aic26_spi_probe(struct spi_device *spi)
 	return ret;
 }
 
+static const struct of_device_id tlv320aic26_of_match[] = {
+	{ .compatible = "ti,tlv320aic26", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tlv320aic26_of_match);
+
 static struct spi_driver aic26_spi = {
 	.driver = {
 		.name = "tlv320aic26-codec",
+		.of_match_table = of_match_ptr(tlv320aic26_of_match),
 	},
 	.probe = aic26_spi_probe,
 };
-- 
2.21.0
