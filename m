From: Viorel Suman <viorel.suman@nxp.com>
Subject: [RFC PATCH] ASoC: fsl: Add Audio Mixer CPU DAI driver
Date: Tue, 18 Dec 2018 16:30:01 +0000
Message-ID: <1545150569-14897-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-eopbgr80052.outbound.protection.outlook.com [40.107.8.52])
 by alsa0.perex.cz (Postfix) with ESMTP id B4B1326782E
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 17:30:04 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

This patch implements Audio Mixer CPU DAI driver for NXP iMX8 SOCs.
The Audio Mixer is a on-chip functional module that allows mixing of
two audio streams into a single audio stream.

Audio Mixer datasheet is available here:
https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../devicetree/bindings/sound/fsl,amix.txt         |  45 ++
 sound/soc/fsl/Kconfig                              |   7 +
 sound/soc/fsl/Makefile                             |   3 +
 sound/soc/fsl/fsl_amix.c                           | 554 +++++++++++++++++++++
 sound/soc/fsl/fsl_amix.h                           | 101 ++++
 5 files changed, 710 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,amix.txt
 create mode 100644 sound/soc/fsl/fsl_amix.c
 create mode 100644 sound/soc/fsl/fsl_amix.h

diff --git a/Documentation/devicetree/bindings/sound/fsl,amix.txt b/Documentation/devicetree/bindings/sound/fsl,amix.txt
new file mode 100644
index 0000000..049144f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,amix.txt
@@ -0,0 +1,45 @@
+NXP Audio Mixer (AMIX).
+
+The Audio Mixer is a on-chip functional module that allows mixing of two
+audio streams into a single audio stream. Audio Mixer has two input serial
+audio interfaces. These are driven by two Synchronous Audio interface
+modules (SAI). Each input serial interface carries 8 audio channels in its
+frame in TDM manner. Mixer mixes audio samples of corresponding channels
+from two interfaces into a single sample. Before mixing, audio samples of
+two inputs can be attenuated based on configuration. The output of the
+Audio Mixer is also a serial audio interface. Like input interfaces it has
+the same TDM frame format. This output is used to drive the serial DAC TDM
+interface of audio codec and also sent to the external pins along with the
+receive path of normal audio SAI module for readback by the CPU.
+
+The output of Audio mixer can be selected from any of the three streams
+ - serial audio input 1
+ - serial audio input 2
+ - Mixed audio
+
+Mixing operation is independent of audio sample rate but the two audio
+input streams must have same audio sample rate with same number of channels
+in TDM frame to be eligible for mixing.
+
+Device driver required properties:
+=================================
+  - compatible		: Compatible list, contains "fsl,imx8qm-amix"
+
+  - reg			: Offset and length of the register set for the device.
+
+  - clocks		: Must contain an entry for each entry in clock-names.
+
+  - clock-names		: Must include the "ipg" for register access.
+
+  - power-domains	: Must contain the phandle to the AMIX power domain node
+
+Device driver configuration example:
+======================================
+  amix: amix@59840000 {
+    compatible = "fsl,imx8qm-amix";
+    reg = <0x0 0x59840000 0x0 0x10000>;
+    clocks = <&clk IMX8QXP_AUD_AMIX_IPG>;
+    clock-names = "ipg";
+    power-domains = <&pd_amix>;
+  };
+
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 2e75b5bc..0b08eb2 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -24,6 +24,13 @@ config SND_SOC_FSL_SAI
 	  This option is only useful for out-of-tree drivers since
 	  in-tree drivers select it automatically.
 
+config SND_SOC_FSL_AMIX
+	tristate "Audio Mixer (AMIX) module support"
+	select REGMAP_MMIO
+	help
+	  Say Y if you want to add Audio Mixer (AMIX)
+	  support for the NXP iMX CPUs.
+
 config SND_SOC_FSL_SSI
 	tristate "Synchronous Serial Interface module (SSI) support"
 	select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
index de94fa0..3263634 100644
--- a/sound/soc/fsl/Makefile
+++ b/sound/soc/fsl/Makefile
@@ -12,6 +12,7 @@ snd-soc-p1022-rdk-objs := p1022_rdk.o
 obj-$(CONFIG_SND_SOC_P1022_RDK) += snd-soc-p1022-rdk.o
 
 # Freescale SSI/DMA/SAI/SPDIF Support
+snd-soc-fsl-amix-objs := fsl_amix.o
 snd-soc-fsl-asoc-card-objs := fsl-asoc-card.o
 snd-soc-fsl-asrc-objs := fsl_asrc.o fsl_asrc_dma.o
 snd-soc-fsl-sai-objs := fsl_sai.o
@@ -21,6 +22,8 @@ snd-soc-fsl-spdif-objs := fsl_spdif.o
 snd-soc-fsl-esai-objs := fsl_esai.o
 snd-soc-fsl-utils-objs := fsl_utils.o
 snd-soc-fsl-dma-objs := fsl_dma.o
+
+obj-$(CONFIG_SND_SOC_FSL_AMIX) += snd-soc-fsl-amix.o
 obj-$(CONFIG_SND_SOC_FSL_ASOC_CARD) += snd-soc-fsl-asoc-card.o
 obj-$(CONFIG_SND_SOC_FSL_ASRC) += snd-soc-fsl-asrc.o
 obj-$(CONFIG_SND_SOC_FSL_SAI) += snd-soc-fsl-sai.o
diff --git a/sound/soc/fsl/fsl_amix.c b/sound/soc/fsl/fsl_amix.c
new file mode 100644
index 0000000..d752029
--- /dev/null
+++ b/sound/soc/fsl/fsl_amix.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP AMIX ALSA SoC Digital Audio Interface (DAI) driver
+ *
+ * Copyright 2017 NXP
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
+#include <sound/soc.h>
+#include <sound/pcm_params.h>
+
+#include "fsl_amix.h"
+
+#define SOC_ENUM_SINGLE_S(xreg, xshift, xtexts) \
+	SOC_ENUM_SINGLE(xreg, xshift, ARRAY_SIZE(xtexts), xtexts)
+
+static const char
+	*tdm_sel[] = { "TDM1", "TDM2", },
+	*mode_sel[] = { "Disabled", "TDM1", "TDM2", "Mixed", },
+	*width_sel[] = { "16b", "18b", "20b", "24b", "32b", },
+	*pol_sel[] = { "Positive edge", "Negative edge", },
+	*endis_sel[] = { "Disabled", "Enabled", },
+	*updn_sel[] = { "Downward", "Upward", },
+	*mask_sel[] = { "Unmask", "Mask", };
+
+static const struct soc_enum fsl_amix_enum[] = {
+/* FSL_AMIX_CTR enums */
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_MIXCLK_SHIFT, tdm_sel),
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_OUTSRC_SHIFT, mode_sel),
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_OUTWIDTH_SHIFT, width_sel),
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_OUTCKPOL_SHIFT, pol_sel),
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_MASKRTDF_SHIFT, mask_sel),
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_MASKCKDF_SHIFT, mask_sel),
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_SYNCMODE_SHIFT, endis_sel),
+SOC_ENUM_SINGLE_S(FSL_AMIX_CTR, FSL_AMIX_CTR_SYNCSRC_SHIFT, tdm_sel),
+/* FSL_AMIX_ATCR0 enums */
+SOC_ENUM_SINGLE_S(FSL_AMIX_ATCR0, 0, endis_sel),
+SOC_ENUM_SINGLE_S(FSL_AMIX_ATCR0, 1, updn_sel),
+/* FSL_AMIX_ATCR1 enums */
+SOC_ENUM_SINGLE_S(FSL_AMIX_ATCR1, 0, endis_sel),
+SOC_ENUM_SINGLE_S(FSL_AMIX_ATCR1, 1, updn_sel),
+};
+
+struct fsl_amix_state {
+	u8 tdms;
+	u8 clk;
+	char msg[64];
+};
+
+static const struct fsl_amix_state prms[4][4] = {{
+	/* DIS->DIS, do nothing */
+	{ .tdms = 0, .clk = 0, .msg = "" },
+	/* DIS->TDM1*/
+	{ .tdms = 1, .clk = 1, .msg = "DIS->TDM1: TDM1 not started!\n" },
+	/* DIS->TDM2*/
+	{ .tdms = 2, .clk = 2, .msg = "DIS->TDM2: TDM2 not started!\n" },
+	/* DIS->MIX */
+	{ .tdms = 3, .clk = 0, .msg = "DIS->MIX: Please start both TDMs!\n" }
+}, {	/* TDM1->DIS */
+	{ .tdms = 1, .clk = 0, .msg = "TDM1->DIS: TDM1 not started!\n" },
+	/* TDM1->TDM1, do nothing */
+	{ .tdms = 0, .clk = 0, .msg = "" },
+	/* TDM1->TDM2 */
+	{ .tdms = 3, .clk = 2, .msg = "TDM1->TDM2: Please start both TDMs!\n" },
+	/* TDM1->MIX */
+	{ .tdms = 3, .clk = 0, .msg = "TDM1->MIX: Please start both TDMs!\n" }
+}, {	/* TDM2->DIS */
+	{ .tdms = 2, .clk = 0, .msg = "TDM2->DIS: TDM2 not started!\n" },
+	/* TDM2->TDM1 */
+	{ .tdms = 3, .clk = 1, .msg = "TDM2->TDM1: Please start both TDMs!\n" },
+	/* TDM2->TDM2, do nothing */
+	{ .tdms = 0, .clk = 0, .msg = "" },
+	/* TDM2->MIX */
+	{ .tdms = 3, .clk = 0, .msg = "TDM2->MIX: Please start both TDMs!\n" }
+}, {	/* MIX->DIS */
+	{ .tdms = 3, .clk = 0, .msg = "MIX->DIS: Please start both TDMs!\n" },
+	/* MIX->TDM1 */
+	{ .tdms = 3, .clk = 1, .msg = "MIX->TDM1: Please start both TDMs!\n" },
+	/* MIX->TDM2 */
+	{ .tdms = 3, .clk = 2, .msg = "MIX->TDM2: Please start both TDMs!\n" },
+	/* MIX->MIX, do nothing */
+	{ .tdms = 0, .clk = 0, .msg = "" }
+}, };
+
+static int fsl_amix_state_trans(struct snd_soc_component *comp,
+				unsigned int *mask, unsigned int *ctr,
+				const struct fsl_amix_state prm)
+{
+	struct fsl_amix *priv = snd_soc_component_get_drvdata(comp);
+	/* Enforce all required TDMs are started */
+	if ((priv->tdms & prm.tdms) != prm.tdms) {
+		dev_dbg(comp->dev, prm.msg);
+		return -EINVAL;
+	}
+
+	switch (prm.clk) {
+	case 1:
+	case 2:
+		/* Set mix clock */
+		(*mask) |= FSL_AMIX_CTR_MIXCLK_MASK;
+		(*ctr)  |= FSL_AMIX_CTR_MIXCLK(prm.clk - 1);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int fsl_amix_put_mix_clk_src(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
+	struct fsl_amix *priv = snd_soc_component_get_drvdata(comp);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int *item = ucontrol->value.enumerated.item;
+	unsigned int reg_val, val, mix_clk;
+	int ret = 0;
+
+	/* Get current state */
+	ret = snd_soc_component_read(comp, FSL_AMIX_CTR, &reg_val);
+	if (ret)
+		return ret;
+
+	mix_clk = ((reg_val & FSL_AMIX_CTR_MIXCLK_MASK)
+			>> FSL_AMIX_CTR_MIXCLK_SHIFT);
+	val = snd_soc_enum_item_to_val(e, item[0]);
+
+	dev_dbg(comp->dev, "TDMs=x%08x, val=x%08x\n", priv->tdms, val);
+
+	/**
+	 * Ensure the current selected mixer clock is available
+	 * for configuration propagation
+	 */
+	if (!(priv->tdms & BIT(mix_clk))) {
+		dev_err(comp->dev,
+			"Started TDM%d needed for config propagation!\n",
+			mix_clk + 1);
+		return -EINVAL;
+	}
+
+	if (!(priv->tdms & BIT(val))) {
+		dev_err(comp->dev,
+			"The selected clock source has no TDM%d enabled!\n",
+			val + 1);
+		return -EINVAL;
+	}
+
+	return snd_soc_put_enum_double(kcontrol, ucontrol);
+}
+
+static int fsl_amix_put_out_src(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *comp = snd_kcontrol_chip(kcontrol);
+	struct fsl_amix *priv = snd_soc_component_get_drvdata(comp);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int *item = ucontrol->value.enumerated.item;
+	u32 out_src, mix_clk;
+	unsigned int reg_val, val, mask = 0, ctr = 0;
+	int ret = 0;
+
+	/* Get current state */
+	ret = snd_soc_component_read(comp, FSL_AMIX_CTR, &reg_val);
+	if (ret)
+		return ret;
+
+	/* "From" state */
+	out_src = ((reg_val & FSL_AMIX_CTR_OUTSRC_MASK)
+			>> FSL_AMIX_CTR_OUTSRC_SHIFT);
+	mix_clk = ((reg_val & FSL_AMIX_CTR_MIXCLK_MASK)
+			>> FSL_AMIX_CTR_MIXCLK_SHIFT);
+
+	/* "To" state */
+	val = snd_soc_enum_item_to_val(e, item[0]);
+
+	dev_dbg(comp->dev, "TDMs=x%08x, val=x%08x\n", priv->tdms, val);
+
+	/* Check if state is changing ... */
+	if (out_src == val)
+		return 0;
+	/**
+	 * Ensure the current selected mixer clock is available
+	 * for configuration propagation
+	 */
+	if (!(priv->tdms & BIT(mix_clk))) {
+		dev_err(comp->dev,
+			"Started TDM%d needed for config propagation!\n",
+			mix_clk + 1);
+		return -EINVAL;
+	}
+
+	/* Check state transition constraints */
+	ret = fsl_amix_state_trans(comp, &mask, &ctr, prms[out_src][val]);
+	if (ret)
+		return ret;
+
+	/* Complete transition to new state */
+	mask |= FSL_AMIX_CTR_OUTSRC_MASK;
+	ctr  |= FSL_AMIX_CTR_OUTSRC(val);
+
+	return snd_soc_component_update_bits(comp, FSL_AMIX_CTR, mask, ctr);
+}
+
+static const struct snd_kcontrol_new fsl_amix_snd_controls[] = {
+	/* FSL_AMIX_CTR controls */
+	SOC_ENUM_EXT("Mixing Clock Source", fsl_amix_enum[0],
+		     snd_soc_get_enum_double, fsl_amix_put_mix_clk_src),
+	SOC_ENUM_EXT("Output Source", fsl_amix_enum[1],
+		     snd_soc_get_enum_double, fsl_amix_put_out_src),
+	SOC_ENUM("Output Width", fsl_amix_enum[2]),
+	SOC_ENUM("Output Clock Polarity", fsl_amix_enum[3]),
+	SOC_ENUM("Frame Rate Diff Error", fsl_amix_enum[4]),
+	SOC_ENUM("Clock Freq Diff Error", fsl_amix_enum[5]),
+	SOC_ENUM("Sync Mode Config", fsl_amix_enum[6]),
+	SOC_ENUM("Sync Mode Clk Source", fsl_amix_enum[7]),
+	/* TDM1 Attenuation controls */
+	SOC_ENUM("TDM1 Attenuation", fsl_amix_enum[8]),
+	SOC_ENUM("TDM1 Attenuation Direction", fsl_amix_enum[9]),
+	SOC_SINGLE("TDM1 Attenuation Step Divider", FSL_AMIX_ATCR0,
+		   2, 0x00fff, 0),
+	SOC_SINGLE("TDM1 Attenuation Initial Value", FSL_AMIX_ATIVAL0,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM1 Attenuation Step Up Factor", FSL_AMIX_ATSTPUP0,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM1 Attenuation Step Down Factor", FSL_AMIX_ATSTPDN0,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM1 Attenuation Step Target", FSL_AMIX_ATSTPTGT0,
+		   0, 0x3ffff, 0),
+	/* TDM2 Attenuation controls */
+	SOC_ENUM("TDM2 Attenuation", fsl_amix_enum[10]),
+	SOC_ENUM("TDM2 Attenuation Direction", fsl_amix_enum[11]),
+	SOC_SINGLE("TDM2 Attenuation Step Divider", FSL_AMIX_ATCR1,
+		   2, 0x00fff, 0),
+	SOC_SINGLE("TDM2 Attenuation Initial Value", FSL_AMIX_ATIVAL1,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM2 Attenuation Step Up Factor", FSL_AMIX_ATSTPUP1,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM2 Attenuation Step Down Factor", FSL_AMIX_ATSTPDN1,
+		   0, 0x3ffff, 0),
+	SOC_SINGLE("TDM2 Attenuation Step Target", FSL_AMIX_ATSTPTGT1,
+		   0, 0x3ffff, 0),
+};
+
+static int fsl_amix_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *comp = dai->component;
+	u32 mask = 0, ctr = 0;
+
+	/* AMIX is working in DSP_A format only */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* For playback the AMIX is slave, and for record is master */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBM_CFM:
+	case SND_SOC_DAIFMT_CBS_CFS:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Output data will be written on positive edge of the clock */
+		ctr |= FSL_AMIX_CTR_OUTCKPOL(0);
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		/* Output data will be written on negative edge of the clock */
+		ctr |= FSL_AMIX_CTR_OUTCKPOL(1);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mask |= FSL_AMIX_CTR_OUTCKPOL_MASK;
+
+	return snd_soc_component_update_bits(comp, FSL_AMIX_CTR, mask, ctr);
+}
+
+static int fsl_amix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+				struct snd_soc_dai *dai)
+{
+	struct fsl_amix *priv = snd_soc_dai_get_drvdata(dai);
+
+	/* Capture stream shall not be handled */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		return 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		priv->tdms |= BIT(dai->driver->id);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		priv->tdms &= ~BIT(dai->driver->id);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops fsl_amix_dai_ops = {
+	.set_fmt      = fsl_amix_dai_set_fmt,
+	.trigger      = fsl_amix_dai_trigger,
+};
+
+static struct snd_soc_dai_driver fsl_amix_dai[] = {
+	{
+		.id   = 0,
+		.name = "amix-0",
+		.playback = {
+			.stream_name = "AMIX-Playback-0",
+			.channels_min = 8,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = FSL_AMIX_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AMIX-Capture-0",
+			.channels_min = 8,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = FSL_AMIX_FORMATS,
+		},
+		.ops = &fsl_amix_dai_ops,
+	},
+	{
+		.id   = 1,
+		.name = "amix-1",
+		.playback = {
+			.stream_name = "AMIX-Playback-1",
+			.channels_min = 8,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = FSL_AMIX_FORMATS,
+		},
+		.capture = {
+			.stream_name = "AMIX-Capture-1",
+			.channels_min = 8,
+			.channels_max = 8,
+			.rate_min = 8000,
+			.rate_max = 96000,
+			.rates = SNDRV_PCM_RATE_8000_96000,
+			.formats = FSL_AMIX_FORMATS,
+		},
+		.ops = &fsl_amix_dai_ops,
+	},
+};
+
+static const struct snd_soc_component_driver fsl_amix_component = {
+	.name		  = "fsl-amix-dai",
+	.controls	  = fsl_amix_snd_controls,
+	.num_controls	  = ARRAY_SIZE(fsl_amix_snd_controls),
+};
+
+static bool fsl_amix_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case FSL_AMIX_CTR:
+	case FSL_AMIX_STR:
+	case FSL_AMIX_ATCR0:
+	case FSL_AMIX_ATIVAL0:
+	case FSL_AMIX_ATSTPUP0:
+	case FSL_AMIX_ATSTPDN0:
+	case FSL_AMIX_ATSTPTGT0:
+	case FSL_AMIX_ATTNVAL0:
+	case FSL_AMIX_ATSTP0:
+	case FSL_AMIX_ATCR1:
+	case FSL_AMIX_ATIVAL1:
+	case FSL_AMIX_ATSTPUP1:
+	case FSL_AMIX_ATSTPDN1:
+	case FSL_AMIX_ATSTPTGT1:
+	case FSL_AMIX_ATTNVAL1:
+	case FSL_AMIX_ATSTP1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool fsl_amix_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case FSL_AMIX_CTR:
+	case FSL_AMIX_ATCR0:
+	case FSL_AMIX_ATIVAL0:
+	case FSL_AMIX_ATSTPUP0:
+	case FSL_AMIX_ATSTPDN0:
+	case FSL_AMIX_ATSTPTGT0:
+	case FSL_AMIX_ATCR1:
+	case FSL_AMIX_ATIVAL1:
+	case FSL_AMIX_ATSTPUP1:
+	case FSL_AMIX_ATSTPDN1:
+	case FSL_AMIX_ATSTPTGT1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct reg_default fsl_amix_reg[] = {
+	{ FSL_AMIX_CTR,       0x00060 },
+	{ FSL_AMIX_STR,       0x00003 },
+	{ FSL_AMIX_ATCR0,     0x00000 },
+	{ FSL_AMIX_ATIVAL0,   0x3FFFF },
+	{ FSL_AMIX_ATSTPUP0,  0x2AAAA },
+	{ FSL_AMIX_ATSTPDN0,  0x30000 },
+	{ FSL_AMIX_ATSTPTGT0, 0x00010 },
+	{ FSL_AMIX_ATTNVAL0,  0x00000 },
+	{ FSL_AMIX_ATSTP0,    0x00000 },
+	{ FSL_AMIX_ATCR1,     0x00000 },
+	{ FSL_AMIX_ATIVAL1,   0x3FFFF },
+	{ FSL_AMIX_ATSTPUP1,  0x2AAAA },
+	{ FSL_AMIX_ATSTPDN1,  0x30000 },
+	{ FSL_AMIX_ATSTPTGT1, 0x00010 },
+	{ FSL_AMIX_ATTNVAL1,  0x00000 },
+	{ FSL_AMIX_ATSTP1,    0x00000 },
+};
+
+static const struct regmap_config fsl_amix_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = FSL_AMIX_ATSTP1,
+	.reg_defaults = fsl_amix_reg,
+	.num_reg_defaults = ARRAY_SIZE(fsl_amix_reg),
+	.readable_reg = fsl_amix_readable_reg,
+	.writeable_reg = fsl_amix_writeable_reg,
+	.cache_type = REGCACHE_FLAT,
+};
+
+static int fsl_amix_probe(struct platform_device *pdev)
+{
+	struct fsl_amix *priv;
+	struct resource *res;
+	void __iomem *regs;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdev = pdev;
+
+	/* Get the addresses */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "ipg", regs,
+						 &fsl_amix_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&pdev->dev, "failed to init regmap\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	priv->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(priv->ipg_clk)) {
+		dev_err(&pdev->dev, "failed to get ipg clock\n");
+		return PTR_ERR(priv->ipg_clk);
+	}
+
+	platform_set_drvdata(pdev, priv);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_amix_component,
+					      fsl_amix_dai,
+					      ARRAY_SIZE(fsl_amix_dai));
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register ASoC DAI\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int fsl_amix_runtime_resume(struct device *dev)
+{
+	struct fsl_amix *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->ipg_clk);
+	if (ret) {
+		dev_err(dev, "Failed to enable IPG clock: %d\n", ret);
+		return ret;
+	}
+
+	regcache_cache_only(priv->regmap, false);
+	regcache_mark_dirty(priv->regmap);
+
+	return regcache_sync(priv->regmap);
+}
+
+static int fsl_amix_runtime_suspend(struct device *dev)
+{
+	struct fsl_amix *priv = dev_get_drvdata(dev);
+
+	regcache_cache_only(priv->regmap, true);
+
+	clk_disable_unprepare(priv->ipg_clk);
+
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops fsl_amix_pm = {
+	SET_RUNTIME_PM_OPS(fsl_amix_runtime_suspend,
+			   fsl_amix_runtime_resume,
+			   NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+static const struct of_device_id fsl_amix_ids[] = {
+	{ .compatible = "fsl,imx8qm-amix", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, fsl_amix_ids);
+
+static struct platform_driver fsl_amix_driver = {
+	.probe = fsl_amix_probe,
+	.driver = {
+		.name = "fsl-amix",
+		.of_match_table = fsl_amix_ids,
+		.pm = &fsl_amix_pm,
+	},
+};
+module_platform_driver(fsl_amix_driver);
+
+MODULE_DESCRIPTION("NXP AMIX ASoC DAI driver");
+MODULE_AUTHOR("Viorel Suman <viorel.suman@nxp.com>");
+MODULE_ALIAS("platform:fsl-amix");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/fsl/fsl_amix.h b/sound/soc/fsl/fsl_amix.h
new file mode 100644
index 0000000..5312683
--- /dev/null
+++ b/sound/soc/fsl/fsl_amix.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * NXP AMIX ALSA SoC Digital Audio Interface (DAI) driver
+ *
+ * Copyright 2017 NXP
+ */
+
+#ifndef __FSL_AMIX_H
+#define __FSL_AMIX_H
+
+#define FSL_AMIX_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			SNDRV_PCM_FMTBIT_S24_LE |\
+			SNDRV_PCM_FMTBIT_S32_LE)
+/* AMIX Registers */
+#define FSL_AMIX_CTR		0x200 /* Control */
+#define FSL_AMIX_STR		0x204 /* Status */
+
+#define FSL_AMIX_ATCR0		0x208 /* Attenuation Control */
+#define FSL_AMIX_ATIVAL0	0x20c /* Attenuation Initial Value */
+#define FSL_AMIX_ATSTPUP0	0x210 /* Attenuation step up factor */
+#define FSL_AMIX_ATSTPDN0	0x214 /* Attenuation step down factor */
+#define FSL_AMIX_ATSTPTGT0	0x218 /* Attenuation step target */
+#define FSL_AMIX_ATTNVAL0	0x21c /* Attenuation Value */
+#define FSL_AMIX_ATSTP0		0x220 /* Attenuation step number */
+
+#define FSL_AMIX_ATCR1		0x228 /* Attenuation Control */
+#define FSL_AMIX_ATIVAL1	0x22c /* Attenuation Initial Value */
+#define FSL_AMIX_ATSTPUP1	0x230 /* Attenuation step up factor */
+#define FSL_AMIX_ATSTPDN1	0x234 /* Attenuation step down factor */
+#define FSL_AMIX_ATSTPTGT1	0x238 /* Attenuation step target */
+#define FSL_AMIX_ATTNVAL1	0x23c /* Attenuation Value */
+#define FSL_AMIX_ATSTP1		0x240 /* Attenuation step number */
+
+/* AMIX Control Register */
+#define FSL_AMIX_CTR_MIXCLK_SHIFT	0
+#define FSL_AMIX_CTR_MIXCLK_MASK	BIT(FSL_AMIX_CTR_MIXCLK_SHIFT)
+#define FSL_AMIX_CTR_MIXCLK(i)		((i) << FSL_AMIX_CTR_MIXCLK_SHIFT)
+#define FSL_AMIX_CTR_OUTSRC_SHIFT	1
+#define FSL_AMIX_CTR_OUTSRC_MASK	(0x3 << FSL_AMIX_CTR_OUTSRC_SHIFT)
+#define FSL_AMIX_CTR_OUTSRC(i)		(((i) << FSL_AMIX_CTR_OUTSRC_SHIFT) \
+					      & FSL_AMIX_CTR_OUTSRC_MASK)
+#define FSL_AMIX_CTR_OUTWIDTH_SHIFT	3
+#define FSL_AMIX_CTR_OUTWIDTH_MASK	(0x7 << FSL_AMIX_CTR_OUTWIDTH_SHIFT)
+#define FSL_AMIX_CTR_OUTWIDTH(i)	(((i) << FSL_AMIX_CTR_OUTWIDTH_SHIFT) \
+					      & FSL_AMIX_CTR_OUTWIDTH_MASK)
+#define FSL_AMIX_CTR_OUTCKPOL_SHIFT	6
+#define FSL_AMIX_CTR_OUTCKPOL_MASK	BIT(FSL_AMIX_CTR_OUTCKPOL_SHIFT)
+#define FSL_AMIX_CTR_OUTCKPOL(i)	((i) << FSL_AMIX_CTR_OUTCKPOL_SHIFT)
+#define FSL_AMIX_CTR_MASKRTDF_SHIFT	7
+#define FSL_AMIX_CTR_MASKRTDF_MASK	BIT(FSL_AMIX_CTR_MASKRTDF_SHIFT)
+#define FSL_AMIX_CTR_MASKRTDF(i)	((i) << FSL_AMIX_CTR_MASKRTDF_SHIFT)
+#define FSL_AMIX_CTR_MASKCKDF_SHIFT	8
+#define FSL_AMIX_CTR_MASKCKDF_MASK	BIT(FSL_AMIX_CTR_MASKCKDF_SHIFT)
+#define FSL_AMIX_CTR_MASKCKDF(i)	((i) << FSL_AMIX_CTR_MASKCKDF_SHIFT)
+#define FSL_AMIX_CTR_SYNCMODE_SHIFT	9
+#define FSL_AMIX_CTR_SYNCMODE_MASK	BIT(FSL_AMIX_CTR_SYNCMODE_SHIFT)
+#define FSL_AMIX_CTR_SYNCMODE(i)	((i) << FSL_AMIX_CTR_SYNCMODE_SHIFT)
+#define FSL_AMIX_CTR_SYNCSRC_SHIFT	10
+#define FSL_AMIX_CTR_SYNCSRC_MASK	BIT(FSL_AMIX_CTR_SYNCSRC_SHIFT)
+#define FSL_AMIX_CTR_SYNCSRC(i)		((i) << FSL_AMIX_CTR_SYNCSRC_SHIFT)
+
+/* AMIX Status Register */
+#define FSL_AMIX_STR_RATEDIFF		BIT(0)
+#define FSL_AMIX_STR_CLKDIFF		BIT(1)
+#define FSL_AMIX_STR_MIXSTAT_SHIFT	2
+#define FSL_AMIX_STR_MIXSTAT_MASK	(0x3 << FSL_AMIX_STR_MIXSTAT_SHIFT)
+#define FSL_AMIX_STR_MIXSTAT(i)		((i & FSL_AMIX_STR_MIXSTAT_MASK) \
+					   >> FSL_AMIX_STR_MIXSTAT_SHIFT)
+/* AMIX Attenuation Control Register */
+#define FSL_AMIX_ATCR_AT_EN		BIT(0)
+#define FSL_AMIX_ATCR_AT_UPDN		BIT(1)
+#define FSL_AMIX_ATCR_ATSTPDIF_SHIFT	2
+#define FSL_AMIX_ATCR_ATSTPDFI_MASK	(0xfff << FSL_AMIX_ATCR_ATSTPDIF_SHIFT)
+
+/* AMIX Attenuation Initial Value Register */
+#define FSL_AMIX_ATIVAL_ATINVAL_MASK	0x3FFFF
+
+/* AMIX Attenuation Step Up Factor Register */
+#define FSL_AMIX_ATSTPUP_ATSTEPUP_MASK	0x3FFFF
+
+/* AMIX Attenuation Step Down Factor Register */
+#define FSL_AMIX_ATSTPDN_ATSTEPDN_MASK	0x3FFFF
+
+/* AMIX Attenuation Step Target Register */
+#define FSL_AMIX_ATSTPTGT_ATSTPTG_MASK	0x3FFFF
+
+/* AMIX Attenuation Value Register */
+#define FSL_AMIX_ATTNVAL_ATCURVAL_MASK	0x3FFFF
+
+/* AMIX Attenuation Step Number Register */
+#define FSL_AMIX_ATSTP_STPCTR_MASK	0x3FFFF
+
+#define FSL_AMIX_MAX_DAIS		2
+struct fsl_amix {
+	struct platform_device *pdev;
+	struct regmap *regmap;
+	struct clk *ipg_clk;
+	u8 tdms;
+};
+
+#endif /* __FSL_AMIX_H */
-- 
2.7.4
