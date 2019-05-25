From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 3/7] ASoC: sun4i-spdif: Add TX fifo bit flush quirks
Date: Sat, 25 May 2019 18:23:19 +0200
Message-ID: <20190525162323.20216-4-peron.clem@gmail.com>
References: <20190525162323.20216-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190525162323.20216-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
List-Id: alsa-devel@alsa-project.org

Allwinner H6 has a different bit to flush the TX FIFO.

Add a quirks to prepare introduction of H6 SoC.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index b6c66a62e915..8317bbee0712 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -166,10 +166,12 @@
  *
  * @reg_dac_tx_data: TX FIFO offset for DMA config.
  * @has_reset: SoC needs reset deasserted.
+ * @reg_fctl_ftx: TX FIFO flush bitmask.
  */
 struct sun4i_spdif_quirks {
 	unsigned int reg_dac_txdata;
 	bool has_reset;
+	unsigned int reg_fctl_ftx;
 };
 
 struct sun4i_spdif_dev {
@@ -180,16 +182,19 @@ struct sun4i_spdif_dev {
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct regmap *regmap;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
+	const struct sun4i_spdif_quirks *quirks;
 };
 
 static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
 {
+	const struct sun4i_spdif_quirks *quirks = host->quirks;
+
 	/* soft reset SPDIF */
 	regmap_write(host->regmap, SUN4I_SPDIF_CTL, SUN4I_SPDIF_CTL_RESET);
 
 	/* flush TX FIFO */
 	regmap_update_bits(host->regmap, SUN4I_SPDIF_FCTL,
-			   SUN4I_SPDIF_FCTL_FTX, SUN4I_SPDIF_FCTL_FTX);
+			   quirks->reg_fctl_ftx, quirks->reg_fctl_ftx);
 
 	/* clear TX counter */
 	regmap_write(host->regmap, SUN4I_SPDIF_TXCNT, 0);
@@ -418,15 +423,18 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 
 static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 };
 
 static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 	.has_reset	= true,
 };
 
 static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks = {
 	.reg_dac_txdata	= SUN8I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   = SUN4I_SPDIF_FCTL_FTX,
 	.has_reset	= true,
 };
 
@@ -507,6 +515,7 @@ static int sun4i_spdif_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
 		return -ENODEV;
 	}
+	host->quirks = quirks;
 
 	host->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 						&sun4i_spdif_regmap_config);
-- 
2.20.1
