From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: Fix UBSAN warning." to the
	asoc tree
Date: Tue, 19 Mar 2019 13:13:04 +0000 (GMT)
Message-ID: <20190319131304.6914111288E0@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4938F896B7
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 14:13:10 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pi-Hsun Shih <pihsun@chromium.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: Fix UBSAN warning.

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ed1666f6867059e1ed4e2e565a1c87c5580f1b38 Mon Sep 17 00:00:00 2001
From: Pi-Hsun Shih <pihsun@chromium.org>
Date: Wed, 6 Mar 2019 17:09:02 +0800
Subject: [PATCH] ASoC: mediatek: Fix UBSAN warning.

In sound/soc/mediatek/common/mtk-afe-fe-dai.c, when xxx_reg is -1, it's
a no-op to call mtk_regmap_update_bits, but since both xxx_reg and
xxx_shift are set to -1, the (1 << xxx_shift) in the argument would
trigger a UBSAN warning.

Fix the warning by setting those xxx_shift to 0 instead.

Note that since the code explicitly checks .mono_shift >= 0 and
.fs_shift >= 0 before using them in '<<' operator, those two members are
not set to 0.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c |  9 ++++-----
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 13 -------------
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c | 16 ----------------
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 16 ----------------
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 20 --------------------
 5 files changed, 4 insertions(+), 70 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index cf4978be062f..3830e582e188 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -197,11 +197,10 @@ int mtk_afe_fe_trigger(struct snd_pcm_substream *substream, int cmd,
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		if (memif->data->enable_shift >= 0)
-			mtk_regmap_update_bits(afe->regmap,
-					       memif->data->enable_reg,
-					       1 << memif->data->enable_shift,
-					       1 << memif->data->enable_shift);
+		mtk_regmap_update_bits(afe->regmap,
+				       memif->data->enable_reg,
+				       1 << memif->data->enable_shift,
+				       1 << memif->data->enable_shift);
 
 		/* set irq counter */
 		mtk_regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 968fba4d7533..7064a9fd6f74 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -994,7 +994,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 6,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "DL2",
@@ -1013,7 +1012,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 7,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "DL3",
@@ -1032,7 +1030,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 8,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "DL4",
@@ -1051,7 +1048,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 9,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "DL5",
@@ -1070,7 +1066,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 10,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "DLM",
@@ -1089,7 +1084,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 12,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "UL1",
@@ -1108,7 +1102,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 0,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "UL2",
@@ -1127,7 +1120,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "UL3",
@@ -1146,7 +1138,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 2,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "UL4",
@@ -1165,7 +1156,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 3,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "UL5",
@@ -1184,7 +1174,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 4,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "DLBT",
@@ -1203,7 +1192,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 13,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	{
 		.name = "ULBT",
@@ -1222,7 +1210,6 @@ static const struct mtk_base_memif_data memif_data[MT2701_MEMIF_NUM] = {
 		.agent_disable_reg = AUDIO_TOP_CON5,
 		.agent_disable_shift = 16,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 };
 
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index bff7d71d0742..08a6532da322 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -401,9 +401,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL1_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_DL2] = {
 		.name = "DL2",
@@ -420,9 +418,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL2_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_DL3] = {
 		.name = "DL3",
@@ -439,9 +435,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL3_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_VUL] = {
 		.name = "VUL",
@@ -458,9 +452,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = VUL_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_AWB] = {
 		.name = "AWB",
@@ -477,9 +469,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = AWB_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_VUL12] = {
 		.name = "VUL12",
@@ -496,9 +486,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = VUL_DATA2_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_DAI] = {
 		.name = "DAI",
@@ -515,9 +503,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DAI_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT6797_MEMIF_MOD_DAI] = {
 		.name = "MOD_DAI",
@@ -534,9 +520,7 @@ static const struct mtk_base_memif_data memif_data[MT6797_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = MOD_DAI_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 };
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 166aed28330d..0382896c162e 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -714,13 +714,11 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 21,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 1,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 0,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	}, {
 		.name = "DL2",
 		.id = MT8173_AFE_MEMIF_DL2,
@@ -732,13 +730,11 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 22,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 2,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 1,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	}, {
 		.name = "VUL",
 		.id = MT8173_AFE_MEMIF_VUL,
@@ -750,13 +746,11 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 27,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 3,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 6,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	}, {
 		.name = "DAI",
 		.id = MT8173_AFE_MEMIF_DAI,
@@ -768,13 +762,11 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = -1,
 		.mono_shift = -1,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 4,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 5,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	}, {
 		.name = "AWB",
 		.id = MT8173_AFE_MEMIF_AWB,
@@ -786,13 +778,11 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 24,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 6,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 3,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	}, {
 		.name = "MOD_DAI",
 		.id = MT8173_AFE_MEMIF_MOD_DAI,
@@ -804,13 +794,11 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = AFE_DAC_CON1,
 		.mono_shift = 30,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = 7,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 4,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	}, {
 		.name = "HDMI",
 		.id = MT8173_AFE_MEMIF_HDMI,
@@ -822,13 +810,10 @@ static const struct mtk_base_memif_data memif_data[MT8173_AFE_MEMIF_NUM] = {
 		.mono_reg = -1,
 		.mono_shift = -1,
 		.hd_reg = -1,
-		.hd_shift = -1,
 		.enable_reg = -1,
-		.enable_shift = -1,
 		.msb_reg = AFE_MEMIF_MSB,
 		.msb_shift = 8,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 	},
 };
 
@@ -914,7 +899,6 @@ static const struct mtk_base_irq_data irq_data[MT8173_AFE_IRQ_NUM] = {
 		.irq_en_reg = AFE_IRQ_MCU_CON,
 		.irq_en_shift = 12,
 		.irq_fs_reg = -1,
-		.irq_fs_shift = -1,
 		.irq_fs_maskbit = -1,
 		.irq_clr_reg = AFE_IRQ_CLR,
 		.irq_clr_shift = 4,
diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 4e045dd305a7..43be51bf0329 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -421,9 +421,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL1_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_DL2] = {
 		.name = "DL2",
@@ -440,9 +438,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL2_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_DL3] = {
 		.name = "DL3",
@@ -459,9 +455,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL3_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_VUL2] = {
 		.name = "VUL2",
@@ -478,9 +472,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = VUL2_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_AWB] = {
 		.name = "AWB",
@@ -497,9 +489,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = AWB_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_AWB2] = {
 		.name = "AWB2",
@@ -516,9 +506,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = AWB2_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_VUL12] = {
 		.name = "VUL12",
@@ -535,9 +523,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = VUL12_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_MOD_DAI] = {
 		.name = "MOD_DAI",
@@ -554,9 +540,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = MOD_DAI_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_HDMI] = {
 		.name = "HDMI",
@@ -569,13 +553,10 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.mono_reg = -1,
 		.mono_shift = -1,
 		.enable_reg = -1,	/* control in tdm for sync start */
-		.enable_shift = -1,
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = HDMI_HD_SFT,
 		.agent_disable_reg = -1,
-		.agent_disable_shift = -1,
 		.msb_reg = -1,
-		.msb_shift = -1,
 	},
 };
 
@@ -690,7 +671,6 @@ static const struct mtk_base_irq_data irq_data[MT8183_IRQ_NUM] = {
 		.irq_cnt_shift = 0,
 		.irq_cnt_maskbit = 0x3ffff,
 		.irq_fs_reg = -1,
-		.irq_fs_shift = -1,
 		.irq_fs_maskbit = -1,
 		.irq_en_reg = AFE_IRQ_MCU_CON0,
 		.irq_en_shift = IRQ8_MCU_ON_SFT,
-- 
2.20.1
