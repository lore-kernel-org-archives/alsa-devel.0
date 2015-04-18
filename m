From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 6/7] ASoC: hda: Add support for SSP register
	settings
Date: Sun, 19 Apr 2015 02:27:32 +0530
Message-ID: <1429390653-8194-7-git-send-email-vinod.koul@intel.com>
References: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F8AE26522D
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 23:02:55 +0200 (CEST)
In-Reply-To: <1429390653-8194-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Hardik T Shah <hardik.t.shah@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

SSP registers needs to be updated for the SSP copier module. Add support to
update the registers based on dai configuration.

Signed-off-by: Hardik T Shah <hardik.t.shah@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/hda/hda_dsp_ssp_config.c |  285 ++++++++++++++++++++++++
 sound/soc/hda/hda_dsp_ssp_config.h |  423 ++++++++++++++++++++++++++++++++++++
 2 files changed, 708 insertions(+)
 create mode 100644 sound/soc/hda/hda_dsp_ssp_config.c
 create mode 100644 sound/soc/hda/hda_dsp_ssp_config.h

diff --git a/sound/soc/hda/hda_dsp_ssp_config.c b/sound/soc/hda/hda_dsp_ssp_config.c
new file mode 100644
index 000000000000..8b79777fb8be
--- /dev/null
+++ b/sound/soc/hda/hda_dsp_ssp_config.c
@@ -0,0 +1,285 @@
+/*
+ *  hda_dsp_ssp_config.c - HDA DSP SSP register configuration functionality
+ *
+ *  Copyright (C) 2015 Intel Corp
+ *  Author:  Hardik Shah <hardik.t.shah@intel.com>
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+#include "hda_dsp_ssp_config.h"
+#include "hda_skl.h"
+
+#define HDA_SSP_MAX_FREQ_192 19200000
+
+struct hda_ssp_regs {
+	u32 hda_ssc0;
+	u32 hda_ssc1;
+	u32 hda_ssto;
+	u32 hda_sspsp;
+	u32 hda_sstsa;
+	u32 hda_ssrsa;
+	u32 hda_ssc2;
+	u32 hda_sspsp2;
+	u32 hda_ssc3;
+	u32 hda_ssioc;
+};
+
+
+static void azx_set_default_ssp_regs_v1(struct hda_ssp_regs *regs)
+{
+	regs->hda_ssc0 = 0;
+	regs->hda_ssc0 = (HDA_SSC0_FRF_DEF_V1 << HDA_SSC0_FRF_SHIFT) |
+			(HDA_SSC0_ECS_DEF_V1 << HDA_SSC0_ECS_SHIFT) |
+			(HDA_SSC0_SSE_DEF_V1 << HDA_SSC0_SSE_SHIFT) |
+			(HDA_SSC0_NCS_DEF_V1 << HDA_SSC0_NCS_SHIFT) |
+			(HDA_SSC0_RIM_DEF_V1 << HDA_SSC0_RIM_SHIFT) |
+			(HDA_SSC0_ACS_DEF_V1 << HDA_SSC0_ACS_SHIFT) |
+			(HDA_SSC0_MOD_DEF_V1 << HDA_SSC0_MOD_SHIFT);
+
+	regs->hda_ssc1 = 0;
+	regs->hda_ssc1 = (HDA_SSC1_RIE_DEF_V1 << HDA_SSC1_RIE_SHIFT) |
+			(HDA_SSC1_TIE_DEF_V1 << HDA_SSC1_TIE_SHIFT) |
+			(HDA_SSC1_LBM_DEF_V1 << HDA_SSC1_LBM_SHIFT) |
+			(HDA_SSC1_SPO_DEF_V1 << HDA_SSC1_SPO_SHIFT) |
+			(HDA_SSC1_SPH_DEF_V1 << HDA_SSC1_SPH_SHIFT) |
+			(HDA_SSC1_MWDS_DEF_V1 << HDA_SSC1_MWDS_SHIFT) |
+			(HDA_SSC1_EFWR_DEF_V1 << HDA_SSC1_EFWR_SHIFT) |
+			(HDA_SSC1_STRF_DEF_V1 << HDA_SSC1_STRF_SHIFT) |
+			(HDA_SSC1_IFS_DEF_V1 << HDA_SSC1_IFS_SHIFT) |
+			(HDA_SSC1_PINTE_DEF_V1 << HDA_SSC1_PINTE_SHIFT) |
+			(HDA_SSC1_TINTE_DEF_V1 << HDA_SSC1_TINTE_SHIFT) |
+			(HDA_SSC1_RSRE_DEF_V1 << HDA_SSC1_RSRE_SHIFT) |
+			(HDA_SSC1_TSRE_DEF_V1 << HDA_SSC1_TSRE_SHIFT) |
+			(HDA_SSC1_TRAIL_DEF_V1 << HDA_SSC1_TRAIL_SHIFT) |
+			(HDA_SSC1_RWOT_DEF_V1 << HDA_SSC1_RWOT_SHIFT) |
+			(HDA_SSC1_ECRB_DEF_V1 << HDA_SSC1_ECRB_SHIFT) |
+			(HDA_SSC1_ECRA_DEF_V1 << HDA_SSC1_ECRA_SHIFT) |
+			(HDA_SSC1_SCFR_DEF_V1 << HDA_SSC1_SCFR_SHIFT) |
+			(HDA_SSC1_EBCEI_DEF_V1 << HDA_SSC1_EBCEI_SHIFT) |
+			(HDA_SSC1_TTE_DEF_V1 << HDA_SSC1_TTE_SHIFT) |
+			(HDA_SSC1_TTELP_DEF_V1 << HDA_SSC1_TTELP_SHIFT);
+
+	regs->hda_ssto = 0;
+	regs->hda_ssto = HDA_SST0_TIMEOUT_DEF_V1 << HDA_SST0_TIMEOUT_SHIFT;
+
+	regs->hda_sspsp = 0;
+	regs->hda_sspsp = (HDA_SSPSP_ETDS_DEF_V1 << HDA_SSPSP_ETDS_SHIFT) |
+			(HDA_SSPSP_STRTDLY_DEF_V1 << HDA_SSPSP_STRTDLY_SHIFT) |
+			(HDA_SSPSP_DMYSTRT_DEF_V1 << HDA_SSPSP_DMYSTRT_SHIFT) |
+			(HDA_SSPSP_SFRMDLY_DEF_V1 << HDA_SSPSP_SFRMDLY_SHIFT) |
+			(HDA_SSPSP_DMYSTOP_DEF_V1 << HDA_SSPSP_DMYSTOP_SHIFT) |
+			(HDA_SSPSP_EDMYSTOP_DEF_V1 << HDA_SSPSP_EDMYSTOP_SHIFT);
+
+	regs->hda_sstsa = 0;
+	regs->hda_sstsa = (HDA_SSTSA_TXEN_DEF_V1 << HDA_SSTSA_TXEN_SHIFT) |
+			(HDA_SSTSA_TTSA_DEF_V1 << HDA_SSTSA_TTSA_SHIFT);
+
+	regs->hda_ssrsa = 0;
+	regs->hda_ssrsa = (HDA_SSRSA_RXEN_DEF_V1 << HDA_SSRSA_RXEN_SHIFT) |
+			(HDA_SSTSA_RTSA_DEF_V1 << HDA_SSRSA_RTSA_SHIFT);
+
+	regs->hda_ssc2 = 0;
+	regs->hda_ssc2 = (HDA_SSC2_TURM0_DEF_V1 << HDA_SSC2_TURM0_SHIFT) |
+		(HDA_SSC2_TURM1_DEF_V1 << HDA_SSC2_TURM1_SHIFT) |
+		(HDA_SSC2_PSPMB2BFMFD_DEF_V1 << HDA_SSC2_PSPMB2BFMFD_SHIFT) |
+		(HDA_SSC2_PSPSRWFDFD_DEF_V1 << HDA_SSC2_PSPSRWFDFD_SHIFT) |
+		(HDA_SSC2_PSPSTWFDFD_DEF_V1 << HDA_SSC2_PSPSTWFDFD_SHIFT) |
+		(HDA_SSC2_PSPMFSRTPFD_DEF_V1 << HDA_SSC2_PSPMFSRTPFD_SHIFT) |
+		(HDA_SSC2_ROFD_DEF_V1 << HDA_SSC2_ROFD_SHIFT) |
+		(HDA_SSC2_C2DFFD_DEF_V1 << HDA_SSC2_C2DFFD_SHIFT) |
+		(HDA_SSC2_TSAFD_DEF_V1 << HDA_SSC2_TSAFD_SHIFT) |
+		(HDA_SSC2_RSAFD_DEF_V1 << HDA_SSC2_RSAFD_SHIFT) |
+		(HDA_SSC2_RMFGFD_DEF_V1 << HDA_SSC2_RMFGFD_SHIFT) |
+		(HDA_SSC2_TURFD_DEF_V1 << HDA_SSC2_TURFD_SHIFT) |
+		(HDA_SSC2_TUDFD_DEF_V1 << HDA_SSC2_TUDFD_SHIFT) |
+		(HDA_SSC2_BCEFD_DEF_V1 << HDA_SSC2_BCEFD_SHIFT) |
+		(HDA_SSC2_SDFD_DEF_V1 << HDA_SSC2_SDFD_SHIFT) |
+		(HDA_SSC2_SDHFD_DEF_V1 << HDA_SSC2_SDHFD_SHIFT) |
+		(HDA_SSC2_SDPM_DEF_V1 << HDA_SSC2_SDPM_SHIFT) |
+		(HDA_SSC2_LJDFD_DEF_V1 << HDA_SSC2_LJDFD_SHIFT) |
+		(HDA_SSC2_MMRATF_DEF_V1 << HDA_SSC2_MMRATF_SHIFT) |
+		(HDA_SSC2_SMTATF_DEF_V1 << HDA_SSC2_SMTATF_SHIFT);
+
+	regs->hda_ssc3 = 0;
+	regs->hda_ssc3 = (HDA_SSC3_TFT_DEF_V1 << HDA_SSC3_TFT_SHIFT) |
+			(HDA_SSC3_RFT_DEF_V1 << HDA_SSC3_RFT_SHIFT);
+
+	regs->hda_ssioc = 0;
+	regs->hda_ssioc = (HDA_SSIOC_RXDPDEB_DEF_V1 << HDA_SSIOC_RXDPDEB_SHIFT) |
+		(HDA_SSIOC_TXDPDEB_DEF_V1 << HDA_SSIOC_TXDPDEB_SHIFT) |
+		(HDA_SSIOC_SFRMPDEB_DEF_V1 << HDA_SSIOC_SFRMPDEB_SHIFT) |
+		(HDA_SSIOC_SCLKPDEB_DEF_V1 << HDA_SSIOC_SCLKPDEB_SHIFT) |
+		(HDA_SSIOC_SFCR_DEF_V1 << HDA_SSIOC_SFCR_SHIFT) |
+		(HDA_SSIOC_SCOE_DEF_V1 << HDA_SSIOC_SCOE_SHIFT);
+
+	regs->hda_sspsp2 = 0;
+
+}
+
+static void azx_print_ssp_regs(struct sst_dsp_ctx *ctx,
+						struct hda_ssp_regs *regs)
+{
+	dev_dbg(ctx->dev, "ssc0\t\t %x\n", regs->hda_ssc0);
+	dev_dbg(ctx->dev, "ssc1\t\t %x\n", regs->hda_ssc1);
+	dev_dbg(ctx->dev, "sst0\t\t %x\n", regs->hda_ssto);
+	dev_dbg(ctx->dev, "sspsp\t\t %x\n", regs->hda_sspsp);
+	dev_dbg(ctx->dev, "sstsa\t\t %x\n", regs->hda_sstsa);
+	dev_dbg(ctx->dev, "ssrsa\t\t %x\n", regs->hda_ssrsa);
+	dev_dbg(ctx->dev, "ssc2\t\t %x\n", regs->hda_ssc2);
+	dev_dbg(ctx->dev, "sspsp2\t\t %x\n", regs->hda_sspsp2);
+	dev_dbg(ctx->dev, "ssc3\t\t %x\n", regs->hda_ssc3);
+	dev_dbg(ctx->dev, "ssioc\t\t %x\n", regs->hda_ssioc);
+}
+
+static int azx_find_ssp_clk_divisor(struct sst_dsp_ctx *ctx, int fs,
+			int slots, int s_fmt, int *div, int *dummy_bits)
+{
+	int divisor, mod;
+	int found = 0;
+	int req_bclk;
+	int dummy = 0;
+
+	dev_dbg(ctx->dev, "fs = %d, slots = %d s_fmt = %d\n", fs, slots, s_fmt);
+	req_bclk = fs * slots * s_fmt;
+	if (req_bclk == 0) {
+		dev_err(ctx->dev, "Required bit clock = 0\n");
+		return -EINVAL;
+	}
+	if (req_bclk > HDA_SSP_MAX_FREQ_192) {
+		dev_err(ctx->dev, "Bit clock is %d, greater than max SSP freq\n", req_bclk);
+		return -EINVAL;
+	}
+	dummy = 0;
+	/* Find the lowest bit clock possible for particular configuration */
+	do {
+		req_bclk = ((s_fmt * fs * slots) + (fs * dummy));
+		mod = HDA_SSP_MAX_FREQ_192 % req_bclk;
+		divisor = HDA_SSP_MAX_FREQ_192 / req_bclk;
+		if (!mod) {
+			found = 1;
+			break;
+		}
+		/* Dont add odd number of dummy bits, since I2S requires
+		 * dummy bit after each slot/channel
+		 */
+		dummy += 2;
+		if (dummy > (HDA_SSPSP2_FEP_MASK >> HDA_SSPSP2_FEP_SHIFT)) {
+			dev_err(ctx->dev, "Dummy bit greater than what SSP can support\n");
+			return -EINVAL;
+		}
+
+	} while (divisor > 0);
+	if (found) {
+		*div = divisor;
+		*dummy_bits = dummy;
+		return 0;
+	}
+	dev_err(ctx->dev, "Suitable divisor not found for SSP configuration\n");
+
+	return -EINVAL;
+}
+int azx_calculate_ssp_regs(struct sst_dsp_ctx *ctx, struct azx_dai_config *cfg,
+						void *ssp_regs)
+{
+	struct hda_ssp_regs regs;
+	int ret = 0;
+	int div, dummy;
+	int dss, edss;
+	int edmystop, dmystop;
+	struct azx_ssp_dai_config *ssp_cfg = &cfg->ssp_dai_config;
+
+	azx_set_default_ssp_regs_v1(&regs);
+	dev_dbg(ctx->dev, "Default value of registers set to:\n");
+	azx_print_ssp_regs(ctx, &regs);
+
+	if (ssp_cfg->fs_slave)
+		regs.hda_ssc1 |= HDA_SSC1_SFRMDIR_MASK;
+	if (ssp_cfg->bclk_slave)
+		regs.hda_ssc1 |= HDA_SSC1_SCLKDIR_MASK;
+	if (!ssp_cfg->fs_invert)
+		regs.hda_sspsp |= ((0x1 << HDA_SSPSP_SFRMP_SHIFT) &
+				HDA_SSPSP_SFRMP_MASK);
+	if (ssp_cfg->bclk_invert)
+		regs.hda_sspsp |= ((0x1 << HDA_SSPSP_SCMODE_SHIFT) &
+				HDA_SSPSP_SCMODE_MASK);
+
+	if (ssp_cfg->ssp_mode == HDA_SSP_MODE_I2S)
+		/* I2S mode, means 2 slots */
+		ssp_cfg->slots = 2;
+
+	ret = azx_find_ssp_clk_divisor(ctx, cfg->sampling_rate, ssp_cfg->slots,
+					cfg->s_fmt, &div, &dummy);
+	if (ret) {
+		dev_err(ctx->dev, "Clock disior not possible\n");
+		return -EINVAL;
+	}
+	/* Program dividier */
+	regs.hda_ssc0 |= ((div - 1) << HDA_SSC0_SRC_SHIFT) & HDA_SSC0_SCR_MASK;
+
+
+	if (ssp_cfg->slot_width != cfg->s_fmt) {
+		dev_err(ctx->dev, "slot_width must be equal to format bits\n");
+		return -EINVAL;
+	}
+
+	if (cfg->s_fmt > 16) {
+		edss = 1;
+		dss = cfg->s_fmt - 16;
+	} else {
+		edss = 0;
+		dss = cfg->s_fmt;
+	}
+	dss -= 1;
+	regs.hda_ssc0 |= ((dss << HDA_SSC0_DSS_SHIFT) & HDA_SSC0_DSS_MASK);
+	regs.hda_ssc0 |= ((edss << HDA_SSC0_EDSS_SHIFT) & HDA_SSC0_EDSS_MASK);
+
+	if (ssp_cfg->ssp_mode != HDA_SSP_MODE_I2S) {
+		regs.hda_sspsp2 |= (dummy << HDA_SSPSP2_FEP_SHIFT) &
+							HDA_SSPSP2_FEP_MASK;
+		regs.hda_sspsp |= (0x1 << HDA_SSPSP_SFRMWDTH_SHIFT) &
+					HDA_SSPSP_SFRMWDTH_MASK;
+		if (ssp_cfg->ssp_mode == HDA_SSP_MODE_DSP_A)
+			regs.hda_sspsp |= (0x1 << HDA_SSPSP_FSRT_SHIFT) &
+					HDA_SSPSP_FSRT_MASK;
+		else
+			regs.hda_sspsp &= ~(HDA_SSPSP_FSRT_MASK);
+	} else {
+		/* Divide dummy bits / 2 */
+		regs.hda_sspsp |= (0x1 << HDA_SSPSP_FSRT_SHIFT) &
+				HDA_SSPSP_FSRT_MASK;
+		dummy = dummy >> 1;
+		dmystop = dummy & 0x3;
+		edmystop = (dummy >> 2);
+		regs.hda_sspsp |= (dmystop << HDA_SSPSP_DMYSTOP_SHIFT) &
+							HDA_SSPSP_DMYSTOP_MASK;
+		regs.hda_sspsp |= (edmystop << HDA_SSPSP_EDMYSTOP_SHIFT) &
+						HDA_SSPSP_EDMYSTOP_MASK;
+		regs.hda_sspsp |= ((cfg->s_fmt + dummy) << HDA_SSPSP_SFRMWDTH_SHIFT) &
+							HDA_SSPSP_SFRMWDTH_MASK;
+		ssp_cfg->slots = 2;
+	}
+	if (ssp_cfg->slots > HDA_SSP_MAX_SLOTS) {
+		dev_err(ctx->dev, "Max slots = %d\n", HDA_SSP_MAX_SLOTS);
+		return -EINVAL;
+	}
+	regs.hda_ssc0 |= ((ssp_cfg->slots - 1) << HDA_SSC0_FRDC_SHIFT) &
+			HDA_SSC0_FRDC_MASK;
+
+	memcpy(ssp_regs, &regs, sizeof(struct hda_ssp_regs));
+	dev_dbg(ctx->dev, "Registers updated to\n");
+	azx_print_ssp_regs(ctx, &regs);
+	return 0;
+
+}
diff --git a/sound/soc/hda/hda_dsp_ssp_config.h b/sound/soc/hda/hda_dsp_ssp_config.h
new file mode 100644
index 000000000000..3d056d2da1ca
--- /dev/null
+++ b/sound/soc/hda/hda_dsp_ssp_config.h
@@ -0,0 +1,423 @@
+/*
+ *  hda_dsp_ssp_config.h - HDA DSP SSP register definition file.
+ *
+ *  Copyright (C) 2015 Intel Corp
+ *  Author: Hardik Shah <hardik.t.shah@intel.com>
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+
+#ifndef _INTEL_SSP_CONFIG_H_
+#define _INTEL_SSP_CONFIG_H_
+
+#define HDA_SSC0_DSS_MASK                          0xF
+#define HDA_SSC0_DSS_SHIFT                         0
+#define HDA_SSC0_FRF_MASK                          0x30
+#define HDA_SSC0_FRF_SHIFT                         4
+#define HDA_SSC0_ECS_MASK                          0x40
+#define HDA_SSC0_ECS_SHIFT                         6
+#define HDA_SSC0_SSE_MASK                          0x80
+#define HDA_SSC0_SSE_SHIFT                         7
+#define HDA_SSC0_SCR_MASK                          0xFFF00
+#define HDA_SSC0_SRC_SHIFT                         8
+#define HDA_SSC0_EDSS_MASK                         0x100000
+#define HDA_SSC0_EDSS_SHIFT                        20
+#define HDA_SSC0_NCS_MASK                          0x200000
+#define HDA_SSC0_NCS_SHIFT                         21
+#define HDA_SSC0_RIM_MASK                          0x400000
+#define HDA_SSC0_RIM_SHIFT                         22
+#define HDA_SSC0_TIM_MASK                          0x800000
+#define HDA_SSC0_TIM_SHIFT                         23
+#define HDA_SSC0_FRDC_MASK                         0x7000000
+#define HDA_SSC0_FRDC_SHIFT                        24
+#define HDA_SSC0_ACS_MASK                          0x40000000
+#define HDA_SSC0_ACS_SHIFT                         30
+#define HDA_SSC0_MOD_MASK                          0x80000000
+#define HDA_SSC0_MOD_SHIFT                         31
+
+#define HDA_SSC1_RIE_MASK                          0x1
+#define HDA_SSC1_RIE_SHIFT                         0
+#define HDA_SSC1_TIE_MASK                          0x2
+#define HDA_SSC1_TIE_SHIFT                         1
+#define HDA_SSC1_LBM_MASK                          0x4
+#define HDA_SSC1_LBM_SHIFT                         2
+#define HDA_SSC1_SPO_MASK                          0x8
+#define HDA_SSC1_SPO_SHIFT                         3
+#define HDA_SSC1_SPH_MASK                          0x10
+#define HDA_SSC1_SPH_SHIFT                         4
+#define HDA_SSC1_MWDS_MASK                         0x20
+#define HDA_SSC1_MWDS_SHIFT                        5
+#define HDA_SSC1_EFWR_MASK                         0x4000
+#define HDA_SSC1_EFWR_SHIFT                        14
+#define HDA_SSC1_STRF_MASK                         0x8000
+#define HDA_SSC1_STRF_SHIFT                        15
+#define HDA_SSC1_IFS_MASK                          0x10000
+#define HDA_SSC1_IFS_SHIFT                         16
+#define HDA_SSC1_PINTE_MASK                        0x40000
+#define HDA_SSC1_PINTE_SHIFT                       18
+#define HDA_SSC1_TINTE_MASK                        0x80000
+#define HDA_SSC1_TINTE_SHIFT                       19
+#define HDA_SSC1_RSRE_MASK                         0x100000
+#define HDA_SSC1_RSRE_SHIFT                        20
+#define HDA_SSC1_TSRE_MASK                         0x200000
+#define HDA_SSC1_TSRE_SHIFT                        21
+#define HDA_SSC1_TRAIL_MASK                        0x400000
+#define HDA_SSC1_TRAIL_SHIFT                       22
+#define HDA_SSC1_RWOT_MASK                         0x800000
+#define HDA_SSC1_RWOT_SHIFT                        23
+#define HDA_SSC1_SFRMDIR_MASK                      0x1000000
+#define HDA_SSC1_SFRMDIR_SHIFT                     24
+#define HDA_SSC1_SCLKDIR_MASK                      0x2000000
+#define HDA_SSC1_SCLKDIR_SHIFT                     25
+#define HDA_SSC1_ECRB_MASK                         0x4000000
+#define HDA_SSC1_ECRB_SHIFT                        26
+#define HDA_SSC1_ECRA_MASK                         0x8000000
+#define HDA_SSC1_ECRA_SHIFT                        27
+#define HDA_SSC1_SCFR_MASK                         0x10000000
+#define HDA_SSC1_SCFR_SHIFT                        28
+#define HDA_SSC1_EBCEI_MASK                        0x20000000
+#define HDA_SSC1_EBCEI_SHIFT                       29
+#define HDA_SSC1_TTE_MASK                          0x40000000
+#define HDA_SSC1_TTE_SHIFT                         30
+#define HDA_SSC1_TTELP_MASK                        0x80000000
+#define HDA_SSC1_TTELP_SHIFT                       31
+
+#define HDA_SST0_TIMEOUT_MASK                      0xFFFFFF
+#define HDA_SST0_TIMEOUT_SHIFT                     0
+
+#define HDA_SSPSP_SCMODE_MASK                      0x3
+#define HDA_SSPSP_SCMODE_SHIFT                     0
+#define HDA_SSPSP_SFRMP_MASK                       0x4
+#define HDA_SSPSP_SFRMP_SHIFT                      2
+#define HDA_SSPSP_ETDS_MASK                        0x8
+#define HDA_SSPSP_ETDS_SHIFT                       3
+#define HDA_SSPSP_STRTDLY_MASK                     0x70
+#define HDA_SSPSP_STRTDLY_SHIFT                    4
+#define HDA_SSPSP_DMYSTRT_MASK                     0x180
+#define HDA_SSPSP_DMYSTRT_SHIFT                    7
+#define HDA_SSPSP_SFRMDLY_MASK                     0xFE00
+#define HDA_SSPSP_SFRMDLY_SHIFT                    9
+#define HDA_SSPSP_SFRMWDTH_MASK                    0x3F0000
+#define HDA_SSPSP_SFRMWDTH_SHIFT                   16
+#define HDA_SSPSP_DMYSTOP_MASK                     0x1800000
+#define HDA_SSPSP_DMYSTOP_SHIFT                    23
+#define HDA_SSPSP_FSRT_MASK                        0x2000000
+#define HDA_SSPSP_FSRT_SHIFT                       25
+#define HDA_SSPSP_EDMYSTOP_MASK                    0x1C000000
+#define HDA_SSPSP_EDMYSTOP_SHIFT                   26
+
+#define HDA_SSTSA_TTSA_MASK                        0xFF
+#define HDA_SSTSA_TTSA_SHIFT                       0
+#define HDA_SSTSA_TXEN_MASK                        0x100
+#define HDA_SSTSA_TXEN_SHIFT                       8
+
+#define HDA_SSRSA_RTSA_MASK                        0xFF
+#define HDA_SSRSA_RTSA_SHIFT                       0
+#define HDA_SSRSA_RXEN_MASK                        0x100
+#define HDA_SSRSA_RXEN_SHIFT                       8
+
+#define HDA_SSC2_TURM0_MASK                        0x1
+#define HDA_SSC2_TURM0_SHIFT                       0
+#define HDA_SSC2_TURM1_MASK                        0x2
+#define HDA_SSC2_TURM1_SHIFT                       1
+#define HDA_SSC2_PSPMB2BFMFD_MASK                  0x4
+#define HDA_SSC2_PSPMB2BFMFD_SHIFT                 2
+#define HDA_SSC2_PSPSRWFDFD_MASK                   0x8
+#define HDA_SSC2_PSPSRWFDFD_SHIFT                  3
+#define HDA_SSC2_PSPSTWFDFD_MASK                   0x10
+#define HDA_SSC2_PSPSTWFDFD_SHIFT                  4
+#define HDA_SSC2_PSPMFSRTPFD_MASK                  0x20
+#define HDA_SSC2_PSPMFSRTPFD_SHIFT                 5
+#define HDA_SSC2_ROFD_MASK                         0x40
+#define HDA_SSC2_ROFD_SHIFT                        6
+#define HDA_SSC2_C2DFFD_MASK                       0x80
+#define HDA_SSC2_C2DFFD_SHIFT                      7
+#define HDA_SSC2_TSAFD_MASK                        0x100
+#define HDA_SSC2_TSAFD_SHIFT                       8
+#define HDA_SSC2_RSAFD_MASK                        0x200
+#define HDA_SSC2_RSAFD_SHIFT                       9
+#define HDA_SSC2_RMFGFD_MASK                       0x400
+#define HDA_SSC2_RMFGFD_SHIFT                      10
+#define HDA_SSC2_TURFD_MASK                        0x800
+#define HDA_SSC2_TURFD_SHIFT                       11
+#define HDA_SSC2_TUDFD_MASK                        0x1000
+#define HDA_SSC2_TUDFD_SHIFT                       12
+#define HDA_SSC2_BCEFD_MASK                        0x2000
+#define HDA_SSC2_BCEFD_SHIFT                       13
+
+#define HDA_SSC2_SDFD_MASK                         0x4000
+#define HDA_SSC2_SDFD_SHIFT                        14
+#define HDA_SSC2_SDHFD_MASK                        0x8000
+#define HDA_SSC2_SDHFD_SHIFT                       15
+#define HDA_SSC2_SDPM_MASK                         0x10000
+#define HDA_SSC2_SDPM_SHIFT                        16
+#define HDA_SSC2_LJDFD_MASK                        0x20000
+#define HDA_SSC2_LJDFD_SHIFT                       17
+#define HDA_SSC2_MMRATF_MASK                       0x40000
+#define HDA_SSC2_MMRATF_SHIFT                      18
+#define HDA_SSC2_SMTATF_MASK                       0x80000
+#define HDA_SSC2_SMTATF_SHIFT                      19
+
+#define HDA_SSPSP2_FEP_MASK                        0xFF
+#define HDA_SSPSP2_FEP_SHIFT                       0
+
+#define HDA_SSC3_TFL_MASK                          0x3F
+#define HDA_SSC3_TFL_SHIFT                         0
+#define HDA_SSC3_RFL_MASK                          0x3F00
+#define HDA_SSC3_RFL_SHIFT                         8
+#define HDA_SSC3_TFT_MASK                          0x3F0000
+#define HDA_SSC3_TFT_SHIFT                         16
+#define HDA_SSC3_RFT_MASK                          0x3F000000
+#define HDA_SSC3_RFT_SHIFT                         24
+
+#define HDA_SSIOC_RXDPDEB_MASK                     0x1
+#define HDA_SSIOC_RXDPDEB_SHIFT                    0
+#define HDA_SSIOC_TXDPDEB_MASK                     0x2
+#define HDA_SSIOC_TXDPDEB_SHIFT                    1
+#define HDA_SSIOC_SFRMPDEB_MASK                    0x4
+#define HDA_SSIOC_SFRMPDEB_SHIFT                   2
+#define HDA_SSIOC_SCLKPDEB_MASK                    0x8
+#define HDA_SSIOC_SCLKPDEB_SHIFT                   3
+#define HDA_SSIOC_SFCR_MASK                        0x10
+#define HDA_SSIOC_SFCR_SHIFT                       4
+#define HDA_SSIOC_SCOE_MASK                        0x20
+#define HDA_SSIOC_SCOE_SHIFT                       5
+
+
+
+
+
+
+/* Default Frame format is PSP */
+#define HDA_SSC0_FRF_DEF_V1				0x3
+/* On-chip clock used to derive SSP clock */
+#define HDA_SSC0_ECS_DEF_V1				0x0
+/* Modified by firmware */
+#define HDA_SSC0_SSE_DEF_V1				0x0
+/* Local clock use for bclk, instead of network clock */
+#define HDA_SSC0_NCS_DEF_V1					0x0
+/* Interrupt not required by firmware */
+#define HDA_SSC0_RIM_DEF_V1					0x0
+/* Interrupt not required by firmware */
+#define HDA_SSC0_TIM_DEF_V1					0x0
+/* Clock selectiion  by ECS and NCS bit */
+#define HDA_SSC0_ACS_DEF_V1					0x0
+/* SSP in network mode. */
+#define HDA_SSC0_MOD_DEF_V1					0x1
+
+/* Receive FIFO level interrupt is disabled, F/W int not req. */
+#define HDA_SSC1_RIE_DEF_V1					0x0
+/* Transmit FIFO level interrupt is disabled, F/W int not req. */
+#define HDA_SSC1_TIE_DEF_V1					0x0
+/* Normal serial port operation enable */
+#define HDA_SSC1_LBM_DEF_V1					0x0
+/* The inactive or idle state of SCLK is low */
+#define HDA_SSC1_SPO_DEF_V1					0x0
+/* SCLK is inactive one cycle at the start of a
+ * frame and 1/2 cycle at the end of a frame
+ */
+#define HDA_SSC1_SPH_DEF_V1					0x0
+/* 8 bit command words are transmitted */
+#define HDA_SSC1_MWDS_DEF_V1				0x0
+/* FIFO write / read special function is disabled
+ *(normal SSP operational mode)
+ */
+#define HDA_SSC1_EFWR_DEF_V1				0x0
+/* Transmit FIFO is selected for both writes and reads
+ * through the SSP Data register
+ */
+#define HDA_SSC1_STRF_DEF_V1				0x0
+/* Frame polarity is determined by SSP format and PSP polarity */
+#define HDA_SSC1_IFS_DEF_V1					0x0
+/* Peripheral Trailing Byte Interrupts are disabled, F/W int not req. */
+#define HDA_SSC1_PINTE_DEF_V1				0x0
+/* Receiver Time-out interrupts are disabled, F/W int not req. */
+#define HDA_SSC1_TINTE_DEF_V1				0x0
+/* Modified by firmware */
+#define HDA_SSC1_RSRE_DEF_V1				0x1
+/* Modified by firmware */
+#define HDA_SSC1_TSRE_DEF_V1				0x1
+/* DMA based, trailing bytes are handled by DMA. */
+#define HDA_SSC1_TRAIL_DEF_V1				0x1
+/* Transmit / Receive mode. */
+#define HDA_SSC1_RWOT_DEF_V1				0x0
+/* Clock request from other SSP is disabled */
+#define HDA_SSC1_ECRB_DEF_V1				0x0
+/* Clock request from other SSP is disabled */
+#define HDA_SSC1_ECRA_DEF_V1				0x0
+/* Clock input to SCLK is continuously running. (SSP slave mode) */
+#define HDA_SSC1_SCFR_DEF_V1				0x0
+/* Interrupt due to a bit count error is disabled, F/W int not req. */
+#define HDA_SSC1_EBCEI_DEF_V1				0x0
+/* TXD line will be tri-stated when not transmitting data */
+#define HDA_SSC1_TTE_DEF_V1				0x1
+/* TXD line will be tri-stated 1/2 clock edge after TXD is to be flopped */
+#define HDA_SSC1_TTELP_DEF_V1				0x1
+
+/* Value defines the time-out interval given by TIMEOUT/peripheral
+ * clock frequency.
+ */
+#define HDA_SST0_TIMEOUT_DEF_V1				0x0
+
+/* End of Transfer Data State 0: Low 1: Last value */
+#define HDA_SSPSP_ETDS_DEF_V1				0x0
+/* Programmed value sets start delay that is used to set the idle time
+ * of SCLK between transfers
+ */
+#define HDA_SSPSP_STRTDLY_DEF_V1				0x0
+/* Programmed value sets the number of SCLK after STRTDLY is complete
+ * that precede the transmit / receive data.
+ */
+#define HDA_SSPSP_DMYSTRT_DEF_V1				0x0
+/* Programmed value sets the number of half SCLK cycle from TXD / RXD
+ * being driven to SFRM being asserted
+ */
+#define HDA_SSPSP_SFRMDLY_DEF_V1				0x0
+/* With EDMYSTOP as higher order bits, the concatenated programmed value
+ * sets the number of SCLK cycles that follow the transmitted data.
+ * Concatenated dummy stop value of 0 . 31 is allowed.
+ */
+#define HDA_SSPSP_DMYSTOP_DEF_V1				0x0
+/* With EDMYSTOP as higher order bits, the concatenated programmed value
+ * sets the number of SCLK cycles that follow the transmitted data.
+ * Concatenated dummy stop value of 0 . 31 is allowed.
+ */
+#define HDA_SSPSP_EDMYSTOP_DEF_V1				0x0
+
+/* Firmware controls this at correct time */
+#define HDA_SSTSA_TXEN_DEF_V1				0x0
+/* SSP TX Time Slot Active */
+#define HDA_SSTSA_TTSA_DEF_V1				0xf
+
+/* Firmware controls this at correct time */
+#define HDA_SSRSA_RXEN_DEF_V1				0x0
+/* SSP RX Time Slot Active */
+#define HDA_SSTSA_RTSA_DEF_V1				0xf
+
+
+/* Mode 0 of transmit underrun fix.  In this mode, new data will always
+ * start at slot 0.  This function is only applied to SSP and PSP modes.
+ * 0: Disable mode 0.
+ * 1: Enable mode 0.
+ */
+#define HDA_SSC2_TURM0_DEF_V1				0x0
+/* Mode 1 of transmit underrun fix.  In this mode, new data will always
+ * start on the underrun slot.  This function is only applied to SSP
+ * and PSP modes.
+ * 0: Disable mode 1.
+ * 1: Enable mode 1.
+ * If both underrun modes are enabled, mode 1 has higher priority.
+ */
+#define HDA_SSC2_TURM1_DEF_V1				0x1
+/* Set to 1 to disable the fix for PSP master mode back to back frame
+ * assertion masking in network mode.
+ */
+#define HDA_SSC2_PSPMB2BFMFD_DEF_V1				0x0
+/* Set to 1 to disable the fix for PSP slave mode RXD wait for frame
+ * de-assertion before starting the second channel.
+ */
+#define HDA_SSC2_PSPSRWFDFD_DEF_V1				0x0
+/* Set to 1 to disable the fix for PSP slave mode TXD wait for frame
+ * de-assertion before starting the second channel.
+ */
+#define HDA_SSC2_PSPSTWFDFD_DEF_V1				0x0
+/* Set to 1 to disable the fix for PSP master mode FSRT with dummy
+ * stop & frame end padding capability.
+ */
+#define HDA_SSC2_PSPMFSRTPFD_DEF_V1				0x0
+/* When set to 1, new data will always start on the overflow slot when
+ * RX FIFO becomes free again.  When cleared to 0, new data may start
+ * on any slot when RX FIFO becomes free again.
+ * This function is only applied to SSP and PSP modes.
+ */
+#define HDA_SSC2_ROFD_DEF_V1				0x0
+/* Set to 1 to disable the fix for combi -> double flop clock crossing. */
+#define HDA_SSC2_C2DFFD_DEF_V1				0x0
+/* When cleared to 0, TX slot defined in SSTSA.TTSA is only enabled in the
+ * next frame after TX Enable (TXEN) bit set, with the enabled slot.
+ * When set to 1, TX Enable (TXEN) bit has no effect.
+ */
+#define HDA_SSC2_TSAFD_DEF_V1				0x0
+/* When cleared to 0, RX slot defined in SSRSA.RTSA is only enabled in the
+ * next frame after RX Enable (RXEN) bit set.  When set to 1,
+ * RX Enable (RXEN) bit has no effect.
+ */
+#define HDA_SSC2_RSAFD_DEF_V1				0x0
+/* When cleared to 0, SSP starts driving SFRM in master mode if RXEN
+ * is set, to allow RX only half duplex operation in master mode.
+ * When set to 1, RX Enable (RXEN) bit has no effect on the master mode
+ * SFRM generation.
+ */
+#define HDA_SSC2_RMFGFD_DEF_V1				0x0
+/* When cleared to 0, SSP will report an underrun if new data is written
+ * to an empty TX FIFO within 2 link clocks from the transmission of
+ * 1st data bit.  Set to 1 to disable fix.
+ */
+#define HDA_SSC2_TURFD_DEF_V1				0x0
+/* When cleared to 0, TX data will be masked to 0 when SSP underrun in the
+ * case of new data written to empty TX FIFO within 2 link clocks from the
+ * transmission of 1st data bit.  Set to 1 to disable fix.
+ */
+#define HDA_SSC2_TUDFD_DEF_V1				0x0
+/* Set to 1 to disable fix for bit count error bug at the beginning of
+ * SSP enabling.
+ */
+#define HDA_SSC2_BCEFD_DEF_V1				0x0
+/* Disable DMA finish function for SSP.  */
+#define HDA_SSC2_SDFD_DEF_V1				0x1
+/* For DMA HW Handshake fix.
+ * 1 . use original DMA request logic
+ * 0 . enable HW HS
+ */
+#define HDA_SSC2_SDHFD_DEF_V1				0x0
+/* When 1, SSP can be accessed by PIO else DMAC.  */
+#define HDA_SSC2_SDPM_DEF_V1				0x0
+/* Set to 1 to disable the fix for left justified I2S/PCM. */
+#define HDA_SSC2_LJDFD_DEF_V1				0x0
+/* Set to 1 for receive data to be sampled at the opposite clock edge
+ * specified in SSPSP.SCMODE[1:0]
+ */
+#define HDA_SSC2_MMRATF_DEF_V1				0x0
+/* Set to 1 for transmit data to be driven at the opposite clock edge
+ * specified in SSPSP.SCMODE[1:0]
+ */
+#define HDA_SSC2_SMTATF_DEF_V1				0x0
+
+
+/* Sets threshold level at which transmit FIFO asserts interrupt.
+ * This level should be set to the desired threshold value minus 1.
+ */
+#define HDA_SSC3_TFT_DEF_V1					0x7
+/* Sets threshold level at which receive FIFO asserts interrupt.
+ * This level should be set to the desired threshold value minus 1.
+ */
+#define HDA_SSC3_RFT_DEF_V1					0x7
+
+
+/* Clear to 0 to enable pull down on the SSPxRXD I/O buffer. */
+#define HDA_SSIOC_RXDPDEB_DEF_V1				0x0
+/* Clear to 0 to enable pull down on the SSPxTXD I/O buffer. */
+#define HDA_SSIOC_TXDPDEB_DEF_V1				0x0
+/* Clear to 0 to enable pull down on the SSPxSFRM I/O buffer. */
+#define HDA_SSIOC_SFRMPDEB_DEF_V1				0x0
+/* Clear to 0 to enable pull down on the SSPxSCLK I/O buffer. */
+#define HDA_SSIOC_SCLKPDEB_DEF_V1				0x0
+/* External Enable to force SSPSCLK to keep running. */
+#define HDA_SSIOC_SFCR_DEF_V1				0x0
+/* Enable the SSP SCLK I/O buffer output */
+#define HDA_SSIOC_SCOE_DEF_V1				0x1
+
+
+#endif /*_SOC_HDA_SSP_CONFIG_H_*/
-- 
1.7.9.5
