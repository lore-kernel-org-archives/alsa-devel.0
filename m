From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 3/7] ASoC: sun4i-spdif: Add TX fifo bit flush quirks
Date: Mon, 27 May 2019 22:06:23 +0200
Message-ID: <20190527200627.8635-4-peron.clem@gmail.com>
References: <20190527200627.8635-1-peron.clem@gmail.com>
Reply-To: peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCELXIX7UICBBKMIWHTQKGQEYMDMW5Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190527200627.8635-1-peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Allwinner H6 has a different bit to flush the TX FIFO.

Add a quirks to prepare introduction of H6 SoC.

Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index b6c66a62e915..045d0cc4b62a 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -166,10 +166,12 @@
  *
  * @reg_dac_tx_data: TX FIFO offset for DMA config.
  * @has_reset: SoC needs reset deasserted.
+ * @val_fctl_ftx: TX FIFO flush bitmask.
  */
 struct sun4i_spdif_quirks {
 	unsigned int reg_dac_txdata;
 	bool has_reset;
+	unsigned int val_fctl_ftx;
 };
=20
 struct sun4i_spdif_dev {
@@ -180,16 +182,19 @@ struct sun4i_spdif_dev {
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct regmap *regmap;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
+	const struct sun4i_spdif_quirks *quirks;
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
+			   quirks->val_fctl_ftx, quirks->val_fctl_ftx);
=20
 	/* clear TX counter */
 	regmap_write(host->regmap, SUN4I_SPDIF_TXCNT, 0);
@@ -418,15 +423,18 @@ static struct snd_soc_dai_driver sun4i_spdif_dai =3D =
{
=20
 static const struct sun4i_spdif_quirks sun4i_a10_spdif_quirks =3D {
 	.reg_dac_txdata	=3D SUN4I_SPDIF_TXFIFO,
+	.val_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
 };
=20
 static const struct sun4i_spdif_quirks sun6i_a31_spdif_quirks =3D {
 	.reg_dac_txdata	=3D SUN4I_SPDIF_TXFIFO,
+	.val_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
 	.has_reset	=3D true,
 };
=20
 static const struct sun4i_spdif_quirks sun8i_h3_spdif_quirks =3D {
 	.reg_dac_txdata	=3D SUN8I_SPDIF_TXFIFO,
+	.val_fctl_ftx   =3D SUN4I_SPDIF_FCTL_FTX,
 	.has_reset	=3D true,
 };
=20
@@ -507,6 +515,7 @@ static int sun4i_spdif_probe(struct platform_device *pd=
ev)
 		dev_err(&pdev->dev, "Failed to determine the quirks to use\n");
 		return -ENODEV;
 	}
+	host->quirks =3D quirks;
=20
 	host->regmap =3D devm_regmap_init_mmio(&pdev->dev, base,
 						&sun4i_spdif_regmap_config);
--=20
2.20.1

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To view this discussion on the web, visit https://groups.google.com/d/msgid=
/linux-sunxi/20190527200627.8635-4-peron.clem%40gmail.com.
For more options, visit https://groups.google.com/d/optout.
