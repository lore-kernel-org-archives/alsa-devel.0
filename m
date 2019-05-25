From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 2/7] ASoC: sun4i-spdif: Move quirks to the top
Date: Sat, 25 May 2019 18:23:18 +0200
Message-ID: <20190525162323.20216-3-peron.clem@gmail.com>
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

The quirks are actually defines in the middle of the file with
short explanation.

Move this at the top and add a section to have coherency with
sun4i-i2s.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-spdif.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index b4af4aabead1..b6c66a62e915 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -161,6 +161,17 @@
 #define SUN4I_SPDIF_SAMFREQ_176_4KHZ		0xc
 #define SUN4I_SPDIF_SAMFREQ_192KHZ		0xe
 
+/**
+ * struct sun4i_spdif_quirks - Differences between SoC variants.
+ *
+ * @reg_dac_tx_data: TX FIFO offset for DMA config.
+ * @has_reset: SoC needs reset deasserted.
+ */
+struct sun4i_spdif_quirks {
+	unsigned int reg_dac_txdata;
+	bool has_reset;
+};
+
 struct sun4i_spdif_dev {
 	struct platform_device *pdev;
 	struct clk *spdif_clk;
@@ -405,11 +416,6 @@ static struct snd_soc_dai_driver sun4i_spdif_dai = {
 	.name = "spdif",
 };
 
-struct sun4i_spdif_quirks {
-	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
-	bool has_reset;
-};
-
 static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks = {
 	.reg_dac_txdata	= SUN4I_SPDIF_TXFIFO,
 };
-- 
2.20.1
