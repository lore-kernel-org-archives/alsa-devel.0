From: Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH v5 3/3] ASoC: fsl: Add Audio Mixer machine driver
Date: Fri, 15 Feb 2019 14:01:38 +0000
Message-ID: <1550239285-12587-4-git-send-email-viorel.suman@nxp.com>
References: <1550239285-12587-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550239285-12587-1-git-send-email-viorel.suman@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch implements Audio Mixer machine driver for NXP iMX8 SOCs.
It connects together Audio Mixer and related SAI instances.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 sound/soc/fsl/Kconfig      |   9 ++
 sound/soc/fsl/Makefile     |   2 +
 sound/soc/fsl/imx-audmix.c | 327 +++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 338 insertions(+)
 create mode 100644 sound/soc/fsl/imx-audmix.c

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 0af2e056..d87c842 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -303,6 +303,15 @@ config SND_SOC_FSL_ASOC_CARD
 	 CS4271, CS4272 and SGTL5000.
 	 Say Y if you want to add support for Freescale Generic ASoC Sound Card.
=20
+config SND_SOC_IMX_AUDMIX
+	tristate "SoC Audio support for i.MX boards with AUDMIX"
+	select SND_SOC_FSL_AUDMIX
+	select SND_SOC_FSL_SAI
+	help
+	  SoC Audio support for i.MX boards with Audio Mixer
+	  Say Y if you want to add support for SoC audio on an i.MX board with
+	  an Audio Mixer.
+
 endif # SND_IMX_SOC
=20
 endmenu
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index 4172d5a..c0dd044 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -62,6 +62,7 @@ snd-soc-imx-es8328-objs :=3D imx-es8328.o
 snd-soc-imx-sgtl5000-objs :=3D imx-sgtl5000.o
 snd-soc-imx-spdif-objs :=3D imx-spdif.o
 snd-soc-imx-mc13783-objs :=3D imx-mc13783.o
+snd-soc-imx-audmix-objs :=3D imx-audmix.o
=20
 obj-$(CONFIG_SND_SOC_EUKREA_TLV320) +=3D snd-soc-eukrea-tlv320.o
 obj-$(CONFIG_SND_SOC_PHYCORE_AC97) +=3D snd-soc-phycore-ac97.o
@@ -71,3 +72,4 @@ obj-$(CONFIG_SND_SOC_IMX_ES8328) +=3D snd-soc-imx-es8328.=
o
 obj-$(CONFIG_SND_SOC_IMX_SGTL5000) +=3D snd-soc-imx-sgtl5000.o
 obj-$(CONFIG_SND_SOC_IMX_SPDIF) +=3D snd-soc-imx-spdif.o
 obj-$(CONFIG_SND_SOC_IMX_MC13783) +=3D snd-soc-imx-mc13783.o
+obj-$(CONFIG_SND_SOC_IMX_AUDMIX) +=3D snd-soc-imx-audmix.o
diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
new file mode 100644
index 0000000..72e37ca
--- /dev/null
+++ b/sound/soc/fsl/imx-audmix.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2017 NXP
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/clk.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <linux/pm_runtime.h>
+#include "fsl_sai.h"
+#include "fsl_audmix.h"
+
+struct imx_audmix {
+	struct platform_device *pdev;
+	struct snd_soc_card card;
+	struct platform_device *audmix_pdev;
+	struct platform_device *out_pdev;
+	struct clk *cpu_mclk;
+	int num_dai;
+	struct snd_soc_dai_link *dai;
+	int num_dai_conf;
+	struct snd_soc_codec_conf *dai_conf;
+	int num_dapm_routes;
+	struct snd_soc_dapm_route *dapm_routes;
+};
+
+static const u32 imx_audmix_rates[] =3D {
+	8000, 12000, 16000, 24000, 32000, 48000, 64000, 96000,
+};
+
+static const struct snd_pcm_hw_constraint_list imx_audmix_rate_constraints=
 =3D {
+	.count =3D ARRAY_SIZE(imx_audmix_rates),
+	.list =3D imx_audmix_rates,
+};
+
+static int imx_audmix_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
+	struct imx_audmix *priv =3D snd_soc_card_get_drvdata(rtd->card);
+	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct device *dev =3D rtd->card->dev;
+	unsigned long clk_rate =3D clk_get_rate(priv->cpu_mclk);
+	int ret;
+
+	if (clk_rate % 24576000 =3D=3D 0) {
+		ret =3D snd_pcm_hw_constraint_list(runtime, 0,
+						 SNDRV_PCM_HW_PARAM_RATE,
+						 &imx_audmix_rate_constraints);
+		if (ret < 0)
+			return ret;
+	} else {
+		dev_warn(dev, "mclk may be not supported %lu\n", clk_rate);
+	}
+
+	ret =3D snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS=
,
+					   1, 8);
+	if (ret < 0)
+		return ret;
+
+	return snd_pcm_hw_constraint_mask64(runtime, SNDRV_PCM_HW_PARAM_FORMAT,
+					    FSL_AUDMIX_FORMATS);
+}
+
+static int imx_audmix_fe_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
+	struct device *dev =3D rtd->card->dev;
+	bool tx =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
+	unsigned int fmt =3D SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF;
+	u32 channels =3D params_channels(params);
+	int ret, dir;
+
+	/* For playback the AUDMIX is slave, and for record is master */
+	fmt |=3D tx ? SND_SOC_DAIFMT_CBS_CFS : SND_SOC_DAIFMT_CBM_CFM;
+	dir  =3D tx ? SND_SOC_CLOCK_OUT : SND_SOC_CLOCK_IN;
+
+	/* set DAI configuration */
+	ret =3D snd_soc_dai_set_fmt(rtd->cpu_dai, fmt);
+	if (ret) {
+		dev_err(dev, "failed to set cpu dai fmt: %d\n", ret);
+		return ret;
+	}
+
+	ret =3D snd_soc_dai_set_sysclk(rtd->cpu_dai, FSL_SAI_CLK_MAST1, 0, dir);
+	if (ret) {
+		dev_err(dev, "failed to set cpu sysclk: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Per datasheet, AUDMIX expects 8 slots and 32 bits
+	 * for every slot in TDM mode.
+	 */
+	ret =3D snd_soc_dai_set_tdm_slot(rtd->cpu_dai, BIT(channels) - 1,
+				       BIT(channels) - 1, 8, 32);
+	if (ret)
+		dev_err(dev, "failed to set cpu dai tdm slot: %d\n", ret);
+
+	return ret;
+}
+
+static int imx_audmix_be_hw_params(struct snd_pcm_substream *substream,
+				   struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
+	struct device *dev =3D rtd->card->dev;
+	bool tx =3D substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK;
+	unsigned int fmt =3D SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF;
+	int ret;
+
+	if (!tx)
+		return 0;
+
+	/* For playback the AUDMIX is slave */
+	fmt |=3D SND_SOC_DAIFMT_CBM_CFM;
+
+	/* set AUDMIX DAI configuration */
+	ret =3D snd_soc_dai_set_fmt(rtd->cpu_dai, fmt);
+	if (ret)
+		dev_err(dev, "failed to set AUDMIX DAI fmt: %d\n", ret);
+
+	return ret;
+}
+
+static struct snd_soc_ops imx_audmix_fe_ops =3D {
+	.startup =3D imx_audmix_fe_startup,
+	.hw_params =3D imx_audmix_fe_hw_params,
+};
+
+static struct snd_soc_ops imx_audmix_be_ops =3D {
+	.hw_params =3D imx_audmix_be_hw_params,
+};
+
+static int imx_audmix_probe(struct platform_device *pdev)
+{
+	struct device_node *np =3D pdev->dev.of_node;
+	struct device_node *audmix_np =3D NULL, *out_cpu_np =3D NULL;
+	struct platform_device *audmix_pdev =3D NULL;
+	struct platform_device *cpu_pdev;
+	struct of_phandle_args args;
+	struct imx_audmix *priv;
+	int i, num_dai, ret;
+	const char *fe_name_pref =3D "HiFi-AUDMIX-FE-";
+	char *be_name, *be_pb, *be_cp, *dai_name, *capture_dai_name;
+
+	if (pdev->dev.parent) {
+		audmix_np =3D pdev->dev.parent->of_node;
+	} else {
+		dev_err(&pdev->dev, "Missing parent device.\n");
+		return -EINVAL;
+	}
+
+	if (!audmix_np) {
+		dev_err(&pdev->dev, "Missign DT node for parent device.\n");
+		return -EINVAL;
+	}
+
+	audmix_pdev =3D of_find_device_by_node(audmix_np);
+	if (!audmix_pdev) {
+		dev_err(&pdev->dev, "Missing AUDMIX platform device for %s\n",
+			np->full_name);
+		return -EINVAL;
+	}
+
+	num_dai =3D of_count_phandle_with_args(audmix_np, "dais", NULL);
+	if (num_dai !=3D FSL_AUDMIX_MAX_DAIS) {
+		dev_err(&pdev->dev, "Need 2 dais to be provided for %s\n",
+			audmix_np->full_name);
+		return -EINVAL;
+	}
+
+	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->num_dai =3D 2 * num_dai;
+	priv->dai =3D devm_kzalloc(&pdev->dev, priv->num_dai *
+				 sizeof(struct snd_soc_dai_link), GFP_KERNEL);
+	if (!priv->dai)
+		return -ENOMEM;
+
+	priv->num_dai_conf =3D num_dai;
+	priv->dai_conf =3D devm_kzalloc(&pdev->dev, priv->num_dai_conf *
+				      sizeof(struct snd_soc_codec_conf),
+				      GFP_KERNEL);
+	if (!priv->dai_conf)
+		return -ENOMEM;
+
+	priv->num_dapm_routes =3D 3 * num_dai;
+	priv->dapm_routes =3D devm_kzalloc(&pdev->dev, priv->num_dapm_routes *
+					 sizeof(struct snd_soc_dapm_route),
+					 GFP_KERNEL);
+	if (!priv->dapm_routes)
+		return -ENOMEM;
+
+	for (i =3D 0; i < num_dai; i++) {
+		ret =3D of_parse_phandle_with_args(audmix_np, "dais", NULL, i,
+						 &args);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "of_parse_phandle_with_args failed\n");
+			return ret;
+		}
+
+		cpu_pdev =3D of_find_device_by_node(args.np);
+		if (!cpu_pdev) {
+			dev_err(&pdev->dev, "failed to find SAI platform device\n");
+			return -EINVAL;
+		}
+
+		dai_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s%s",
+					  fe_name_pref, args.np->full_name + 1);
+
+		dev_info(pdev->dev.parent, "DAI FE name:%s\n", dai_name);
+
+		if (i =3D=3D 0) {
+			out_cpu_np =3D args.np;
+			capture_dai_name =3D
+				devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
+					       dai_name, "CPU-Capture");
+		}
+
+		priv->dai[i].name =3D dai_name;
+		priv->dai[i].stream_name =3D "HiFi-AUDMIX-FE";
+		priv->dai[i].codec_dai_name =3D "snd-soc-dummy-dai";
+		priv->dai[i].codec_name =3D "snd-soc-dummy";
+		priv->dai[i].cpu_of_node =3D args.np;
+		priv->dai[i].cpu_dai_name =3D dev_name(&cpu_pdev->dev);
+		priv->dai[i].platform_of_node =3D args.np;
+		priv->dai[i].dynamic =3D 1;
+		priv->dai[i].dpcm_playback =3D 1;
+		priv->dai[i].dpcm_capture =3D (i =3D=3D 0 ? 1 : 0);
+		priv->dai[i].ignore_pmdown_time =3D 1;
+		priv->dai[i].ops =3D &imx_audmix_fe_ops;
+
+		/* Add AUDMIX Backend */
+		be_name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
+					 "audmix-%d", i);
+		be_pb =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
+				       "AUDMIX-Playback-%d", i);
+		be_cp =3D devm_kasprintf(&pdev->dev, GFP_KERNEL,
+				       "AUDMIX-Capture-%d", i);
+
+		priv->dai[num_dai + i].name =3D be_name;
+		priv->dai[num_dai + i].codec_dai_name =3D "snd-soc-dummy-dai";
+		priv->dai[num_dai + i].codec_name =3D "snd-soc-dummy";
+		priv->dai[num_dai + i].cpu_of_node =3D audmix_np;
+		priv->dai[num_dai + i].cpu_dai_name =3D be_name;
+		priv->dai[num_dai + i].platform_name =3D "snd-soc-dummy";
+		priv->dai[num_dai + i].no_pcm =3D 1;
+		priv->dai[num_dai + i].dpcm_playback =3D 1;
+		priv->dai[num_dai + i].dpcm_capture  =3D 1;
+		priv->dai[num_dai + i].ignore_pmdown_time =3D 1;
+		priv->dai[num_dai + i].ops =3D &imx_audmix_be_ops;
+
+		priv->dai_conf[i].of_node =3D args.np;
+		priv->dai_conf[i].name_prefix =3D dai_name;
+
+		priv->dapm_routes[i].source =3D
+			devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s %s",
+				       dai_name, "CPU-Playback");
+		priv->dapm_routes[i].sink =3D be_pb;
+		priv->dapm_routes[num_dai + i].source   =3D be_pb;
+		priv->dapm_routes[num_dai + i].sink     =3D be_cp;
+		priv->dapm_routes[2 * num_dai + i].source =3D be_cp;
+		priv->dapm_routes[2 * num_dai + i].sink   =3D capture_dai_name;
+	}
+
+	cpu_pdev =3D of_find_device_by_node(out_cpu_np);
+	if (!cpu_pdev) {
+		dev_err(&pdev->dev, "failed to find SAI platform device\n");
+		return -EINVAL;
+	}
+	priv->cpu_mclk =3D devm_clk_get(&cpu_pdev->dev, "mclk1");
+	if (IS_ERR(priv->cpu_mclk)) {
+		ret =3D PTR_ERR(priv->cpu_mclk);
+		dev_err(&cpu_pdev->dev, "failed to get DAI mclk1: %d\n", ret);
+		return -EINVAL;
+	}
+
+	priv->audmix_pdev =3D audmix_pdev;
+	priv->out_pdev  =3D cpu_pdev;
+
+	priv->card.dai_link =3D priv->dai;
+	priv->card.num_links =3D priv->num_dai;
+	priv->card.codec_conf =3D priv->dai_conf;
+	priv->card.num_configs =3D priv->num_dai_conf;
+	priv->card.dapm_routes =3D priv->dapm_routes;
+	priv->card.num_dapm_routes =3D priv->num_dapm_routes;
+	priv->card.dev =3D pdev->dev.parent;
+	priv->card.owner =3D THIS_MODULE;
+	priv->card.name =3D "imx-audmix";
+
+	platform_set_drvdata(pdev, &priv->card);
+	snd_soc_card_set_drvdata(&priv->card, priv);
+
+	ret =3D devm_snd_soc_register_card(pdev->dev.parent, &priv->card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static struct platform_driver imx_audmix_driver =3D {
+	.probe =3D imx_audmix_probe,
+	.driver =3D {
+		.name =3D "imx-audmix",
+		.pm =3D &snd_soc_pm_ops,
+	},
+};
+module_platform_driver(imx_audmix_driver);
+
+MODULE_DESCRIPTION("NXP AUDMIX ASoC machine driver");
+MODULE_AUTHOR("Viorel Suman <viorel.suman@nxp.com>");
+MODULE_ALIAS("platform:imx-audmix");
+MODULE_LICENSE("GPL v2");
--=20
2.7.4
