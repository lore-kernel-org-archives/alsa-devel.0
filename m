From: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv6][ 1/4] ASoC: eukrea-tlv320: Add DT support.
Date: Wed, 23 Oct 2013 11:16:03 +0200
Message-ID: <1382519766-17359-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Eric B=C3=A9nard <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>

Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/sound/eukrea-tlv320.txt    |   23 ++++
 sound/soc/fsl/Kconfig                              |    5 +-
 sound/soc/fsl/eukrea-tlv320.c                      |  135 ++++++++++++=
++++----
 3 files changed, 140 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/eukrea-tlv3=
20.txt

diff --git a/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt =
b/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
new file mode 100644
index 0000000..8791037
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/eukrea-tlv320.txt
@@ -0,0 +1,23 @@
+Audio complex for Eukrea boards with tlv320aic23 codec.
+
+Required properties:
+- compatible : "eukrea,eukrea-tlv320"
+- model : The user-visible name of this sound complex.
+- ssi-controller : The phandle of the SSI controller.
+- audio-codec : The phandle of the tlv320aic23 audio codec.
+- mux-int-port : The internal port of the i.MX audio muxer (AUDMUX).
+- mux-ext-port : The external port of the i.MX audio muxer.
+
+Note: The AUDMUX port numbering should start at 1, which is consistent=
 with
+hardware manual.
+
+Example:
+
+	sound {
+		compatible =3D "eukrea,eukrea-tlv320";
+		model =3D "imx51-eukrea-tlv320aic23";
+		ssi-controller =3D <&ssi2>;
+		fsl,audio-codec =3D <&tlv320aic23>;
+		mux-int-port =3D <2>;
+		mux-ext-port =3D <3>;
+	};
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index b7ab71f..9c3cd64 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -161,12 +161,15 @@ config SND_SOC_EUKREA_TLV320
 	depends on MACH_EUKREA_MBIMX27_BASEBOARD \
 		|| MACH_EUKREA_MBIMXSD25_BASEBOARD \
 		|| MACH_EUKREA_MBIMXSD35_BASEBOARD \
-		|| MACH_EUKREA_MBIMXSD51_BASEBOARD
+		|| MACH_EUKREA_MBIMXSD51_BASEBOARD \
+		|| OF
 	depends on I2C
 	select SND_SOC_TLV320AIC23
 	select SND_SOC_IMX_PCM_FIQ
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_SSI
+	select SND_SOC_FSL_SSI
+	select SND_SOC_IMX_PCM_DMA
 	help
 	  Enable I2S based access to the TLV320AIC23B codec attached
 	  to the SSI interface
diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv32=
0.c
index 9a4a0ca..92710cf 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -17,6 +17,8 @@
=20
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/device.h>
 #include <linux/i2c.h>
 #include <sound/core.h>
@@ -26,49 +28,64 @@
=20
 #include "../codecs/tlv320aic23.h"
 #include "imx-ssi.h"
+#include "fsl_ssi.h"
 #include "imx-audmux.h"
=20
 #define CODEC_CLOCK 12000000
=20
+struct eukrea_tlv320 {
+	char of;
+};
+
 static int eukrea_tlv320_hw_params(struct snd_pcm_substream *substream=
,
 			    struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
+	struct eukrea_tlv320 *priv =3D snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
 	int ret;
=20
-	ret =3D snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_NF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (ret) {
-		pr_err("%s: failed set cpu dai format\n", __func__);
-		return ret;
+	/* fsl_ssi lacks the set_fmt ops. */
+	if (!priv->of) {
+		ret =3D snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+					  SND_SOC_DAIFMT_NB_NF |
+					  SND_SOC_DAIFMT_CBM_CFM);
+		if (ret) {
+			dev_err(cpu_dai->dev,
+				"Failed to set the cpu dai format\n");
+			return ret;
+		}
 	}
=20
 	ret =3D snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
 				  SND_SOC_DAIFMT_NB_NF |
 				  SND_SOC_DAIFMT_CBM_CFM);
 	if (ret) {
-		pr_err("%s: failed set codec dai format\n", __func__);
+		dev_err(cpu_dai->dev,
+			"Failed to set the codec dai format.\n");
 		return ret;
 	}
=20
 	ret =3D snd_soc_dai_set_sysclk(codec_dai, 0,
 				     CODEC_CLOCK, SND_SOC_CLOCK_OUT);
 	if (ret) {
-		pr_err("%s: failed setting codec sysclk\n", __func__);
+		dev_err(cpu_dai->dev,
+			"Failed to set the codec dai sysclk.\n");
 		return ret;
 	}
-	snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
=20
-	ret =3D snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
-				SND_SOC_CLOCK_IN);
-	if (ret) {
-		pr_err("can't set CPU system clock IMX_SSP_SYS_CLK\n");
-		return ret;
-	}
+	/* fsl_ssi lacks the set_sysclk ops */
+	if (!priv->of) {
+		snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);
=20
+		ret =3D snd_soc_dai_set_sysclk(cpu_dai, IMX_SSP_SYS_CLK, 0,
+					SND_SOC_CLOCK_IN);
+		if (ret) {
+			dev_err(cpu_dai->dev, "Can't set CPU system clock IMX_SSP_SYS_CLK.\=
n");
+			return ret;
+		}
+	}
 	return 0;
 }
=20
@@ -80,7 +97,6 @@ static struct snd_soc_dai_link eukrea_tlv320_dai =3D =
{
 	.name		=3D "tlv320aic23",
 	.stream_name	=3D "TLV320AIC23",
 	.codec_dai_name	=3D "tlv320aic23-hifi",
-	.platform_name	=3D "imx-ssi.0",
 	.codec_name	=3D "tlv320aic23-codec.0-001a",
 	.cpu_dai_name	=3D "imx-ssi.0",
 	.ops		=3D &eukrea_tlv320_snd_ops,
@@ -97,8 +113,56 @@ static int eukrea_tlv320_probe(struct platform_devi=
ce *pdev)
 {
 	int ret;
 	int int_port =3D 0, ext_port;
+	struct platform_device *ssi_pdev;
+	struct device_node *np =3D pdev->dev.of_node;
+	struct device_node *ssi_np;
+	struct eukrea_tlv320 *priv;
+
+	priv =3D devm_kzalloc(&pdev->dev,
+				sizeof(struct eukrea_tlv320), GFP_KERNEL);
+	if (priv =3D=3D NULL)
+		return -ENOMEM;
=20
-	if (machine_is_eukrea_cpuimx27()) {
+	if (np) {
+		ssi_np =3D of_parse_phandle(pdev->dev.of_node,
+					  "ssi-controller", 0);
+		ssi_pdev =3D of_find_device_by_node(ssi_np);
+		if (!ssi_pdev) {
+			dev_err(&pdev->dev,
+				"ssi-controller missing or invalid.\n");
+			ret =3D -ENODEV;
+			goto err;
+		}
+
+		ret =3D of_property_read_u32(np, "mux-int-port", &int_port);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"mux-int-port missing or invalid\n");
+			return ret;
+		}
+		ret =3D of_property_read_u32(np, "mux-ext-port", &ext_port);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"mux-ext-port missing or invalid\n");
+			return ret;
+		}
+
+		/*
+		 * The port numbering in the hardware manual starts at 1, while
+		 * the audmux API expects it starts at 0.
+		 */
+		int_port--;
+		ext_port--;
+
+		eukrea_tlv320_dai.cpu_dai_name =3D dev_name(&ssi_pdev->dev);
+		eukrea_tlv320_dai.platform_of_node =3D ssi_np;
+		priv->of =3D 1;
+	} else {
+		eukrea_tlv320_dai.platform_name =3D "imx-ssi.0";
+	}
+
+	if (machine_is_eukrea_cpuimx27() ||
+	    of_find_compatible_node(NULL, NULL, "fsl,imx21-audmux")) {
 		imx_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
 			IMX_AUDMUX_V1_PCR_SYN |
 			IMX_AUDMUX_V1_PCR_TFSDIR |
@@ -115,8 +179,12 @@ static int eukrea_tlv320_probe(struct platform_dev=
ice *pdev)
 		);
 	} else if (machine_is_eukrea_cpuimx25sd() ||
 		   machine_is_eukrea_cpuimx35sd() ||
-		   machine_is_eukrea_cpuimx51sd()) {
-		ext_port =3D machine_is_eukrea_cpuimx25sd() ? 4 : 3;
+		   machine_is_eukrea_cpuimx51sd() ||
+		   of_find_compatible_node(NULL, NULL, "fsl,imx31-audmux")) {
+		if (!np)
+			ext_port =3D machine_is_eukrea_cpuimx25sd() ?
+				4 : 3;
+
 		imx_audmux_v2_configure_port(int_port,
 			IMX_AUDMUX_V2_PTCR_SYN |
 			IMX_AUDMUX_V2_PTCR_TFSDIR |
@@ -130,14 +198,29 @@ static int eukrea_tlv320_probe(struct platform_de=
vice *pdev)
 			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port)
 		);
 	} else {
-		/* return happy. We might run on a totally different machine */
-		return 0;
+		if (np) {
+			/* The eukrea,eukrea-tlv320 driver was explicitely
+			 * requested (through the device tree).
+			 */
+			dev_err(&pdev->dev,
+				"Missing audmux DT node.\n");
+			return -ENODEV;
+		} else {
+			/* Return happy.
+			 * We might run on a totally different machine.
+			 */
+			return 0;
+		}
 	}
=20
 	eukrea_tlv320.dev =3D &pdev->dev;
+	snd_soc_card_set_drvdata(&eukrea_tlv320, priv);
 	ret =3D snd_soc_register_card(&eukrea_tlv320);
+err:
 	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+	if (np)
+		of_node_put(ssi_np);
=20
 	return ret;
 }
@@ -149,13 +232,21 @@ static int eukrea_tlv320_remove(struct platform_d=
evice *pdev)
 	return 0;
 }
=20
+static const struct of_device_id imx_tlv320_dt_ids[] =3D {
+	{ .compatible =3D "eukrea,eukrea-tlv320"},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, imx_tlv320_dt_ids);
+
 static struct platform_driver eukrea_tlv320_driver =3D {
 	.driver =3D {
 		.name =3D "eukrea_tlv320",
 		.owner =3D THIS_MODULE,
+		.of_match_table =3D imx_tlv320_dt_ids,
 	},
 	.probe =3D eukrea_tlv320_probe,
-	.remove =3D eukrea_tlv320_remove,};
+	.remove =3D eukrea_tlv320_remove,
+};
=20
 module_platform_driver(eukrea_tlv320_driver);
=20
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
