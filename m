From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/5] ASoC: sun4i-spdif: Add support for H6 SoC
Date: Fri, 19 Apr 2019 21:17:27 +0200
Message-ID: <20190419191730.9437-3-peron.clem@gmail.com>
References: <20190419191730.9437-1-peron.clem@gmail.com>
Reply-To: peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCELXIX7UICBBDF45DSQKGQEQABRJRI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190419191730.9437-1-peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Allwinner H6 has a different mapping for the fifo register controller.

Actually only the fifo tx flush bit is used.

Add a new quirk to know the correct fifo tx flush bit.

Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 42 ++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index b4af4aabead1..19e4bf9caa24 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -75,6 +75,18 @@
 	#define SUN4I_SPDIF_FCTL_RXOM(v)		((v) << 0)
 	#define SUN4I_SPDIF_FCTL_RXOM_MASK		GENMASK(1, 0)
=20
+#define SUN50I_H6_SPDIF_FCTL (0x14)
+	#define SUN50I_H6_SPDIF_FCTL_HUB_EN		BIT(31)
+	#define SUN50I_H6_SPDIF_FCTL_FTX		BIT(30)
+	#define SUN50I_H6_SPDIF_FCTL_FRX		BIT(29)
+	#define SUN50I_H6_SPDIF_FCTL_TXTL(v)		((v) << 12)
+	#define SUN50I_H6_SPDIF_FCTL_TXTL_MASK		GENMASK(19, 12)
+	#define SUN50I_H6_SPDIF_FCTL_RXTL(v)		((v) << 4)
+	#define SUN50I_H6_SPDIF_FCTL_RXTL_MASK		GENMASK(10, 4)
+	#define SUN50I_H6_SPDIF_FCTL_TXIM		BIT(2)
+	#define SUN50I_H6_SPDIF_FCTL_RXOM(v)		((v) << 0)
+	#define SUN50I_H6_SPDIF_FCTL_RXOM_MASK		GENMASK(1, 0)
+
 #define SUN4I_SPDIF_FSTA	(0x18)
 	#define SUN4I_SPDIF_FSTA_TXE			BIT(14)
 	#define SUN4I_SPDIF_FSTA_TXECNTSHT		(8)
@@ -169,16 +181,25 @@ struct sun4i_spdif_dev {
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct regmap *regmap;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
+	const struct sun4i_spdif_quirks *quirks;
+};
+
+struct sun4i_spdif_quirks {
+	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
+	unsigned int reg_fctl_ftx;	/* TX FIFO flush bitmask */
+	bool has_reset;
 };
=20
 static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
 {
+	const struct sun4i_spdif_quirks *quirks =3D host->quirks;
+
 	/* soft reset SPDIF */
 	regmap_write(host->regmap, SUN4I_SPDIF_CTL, SUN4I_SPDIF_CTL_RESET);
=20
 	/* flush TX FIFO */
 	regmap_update_bits(host->regmap, SUN4I_SPDIF_FCTL,
-			   SUN4I_SPDIF_FCTL_FTX, SUN4I_SPDIF_FCTL_FTX);
+			   quirks->reg_fctl_ftx, quirks->reg_fctl_ftx);
=20
 	/* clear TX counter */
 	regmap_write(host->regmap, SUN4I_SPDIF_TXCNT, 0);
@@ -405,22 +426,26 @@ static struct snd_soc_dai_driver sun4i_spdif_dai =3D =
{
 	.name =3D "spdif",
 };
=20
-struct sun4i_spdif_quirks {
-	unsigned int reg_dac_txdata;	/* TX FIFO offset for DMA config */
-	bool has_reset;
-};
-
 static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks =3D {
 	.reg_dac_txdata	=3D SUN4I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
 };
=20
 static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks =3D {
 	.reg_dac_txdata	=3D SUN4I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
 	.has_reset	=3D true,
 };
=20
 static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks =3D {
 	.reg_dac_txdata	=3D SUN8I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
+	.has_reset	=3D true,
+};
+
+static const struct sun4i_spdif_quirks sun50i_h6_spdif_quirks =3D {
+	.reg_dac_txdata	=3D SUN8I_SPDIF_TXFIFO,
+	.reg_fctl_ftx   =3D SUN50I_H6_SPDIF_FCTL_FTX,
 	.has_reset	=3D true,
 };
=20
@@ -437,6 +462,10 @@ static const struct of_device_id sun4i_spdif_of_match[=
] =3D {
 		.compatible =3D "allwinner,sun8i-h3-spdif",
 		.data =3D &sun8i_h3_spdif_quirks,
 	},
+	{
+		.compatible =3D "allwinner,sun50i-h6-spdif",
+		.data =3D &sun50i_h6_spdif_quirks,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_spdif_of_match);
@@ -501,6 +530,7 @@ static int sun4i_spdif_probe(struct platform_device *pd=
ev)
 		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
 		return -ENODEV;
 	}
+	host->quirks =3D quirks;
=20
 	host->regmap =3D devm_regmap_init_mmio(&pdev->dev, base,
 						&sun4i_spdif_regmap_config);
--=20
2.17.1

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
