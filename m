From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: Mediatek: MT8183: add I2S2 control path from UL2 and
 UL3" to the asoc tree
Date: Thu,  2 May 2019 03:18:10 +0100 (BST)
Message-ID: <20190502021810.2CF36441D3C@finisterre.ee.mobilebroadband>
References: <20190409091337.43934-2-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190409091337.43934-2-shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, tzungbi-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Mediatek: MT8183: add I2S2 control path from UL2 and UL3

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

>From d232591c9482ddb121b60782d2e7dac1c4880bdb Mon Sep 17 00:00:00 2001
From: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Tue, 9 Apr 2019 17:13:37 +0800
Subject: [PATCH] ASoC: Mediatek: MT8183: add I2S2 control path from UL2 and
 UL3

This patch add the control path from UL2 or UL3 to I2S2.
The patch is based on broonie tree "for-next" branch.

Signed-off-by: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 43be51bf0329..1bc0fafe5e29 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -291,11 +291,15 @@ static struct snd_soc_dai_driver mt8183_memif_dai_driver[] = {
 static const struct snd_kcontrol_new memif_ul1_ch1_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN21,
 				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH1", AFE_CONN21,
+				    I_I2S0_CH1, 1, 0),
 };
 
 static const struct snd_kcontrol_new memif_ul1_ch2_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN22,
 				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH2", AFE_CONN21,
+				    I_I2S0_CH2, 1, 0),
 };
 
 static const struct snd_kcontrol_new memif_ul2_ch1_mix[] = {
@@ -307,6 +311,8 @@ static const struct snd_kcontrol_new memif_ul2_ch1_mix[] = {
 				    I_DL2_CH1, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1", AFE_CONN5,
 				    I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH1", AFE_CONN5,
+				    I_I2S2_CH1, 1, 0),
 };
 
 static const struct snd_kcontrol_new memif_ul2_ch2_mix[] = {
@@ -318,16 +324,22 @@ static const struct snd_kcontrol_new memif_ul2_ch2_mix[] = {
 				    I_DL2_CH2, 1, 0),
 	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2", AFE_CONN6,
 				    I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH2", AFE_CONN6,
+				    I_I2S2_CH2, 1, 0),
 };
 
 static const struct snd_kcontrol_new memif_ul3_ch1_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1", AFE_CONN32,
 				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH1", AFE_CONN32,
+				    I_I2S2_CH1, 1, 0),
 };
 
 static const struct snd_kcontrol_new memif_ul3_ch2_mix[] = {
 	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2", AFE_CONN33,
 				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH2", AFE_CONN33,
+				    I_I2S2_CH2, 1, 0),
 };
 
 static const struct snd_kcontrol_new memif_ul4_ch1_mix[] = {
@@ -380,16 +392,22 @@ static const struct snd_soc_dapm_route mt8183_memif_routes[] = {
 	{"UL1", NULL, "UL1_CH2"},
 	{"UL1_CH1", "ADDA_UL_CH1", "ADDA Capture"},
 	{"UL1_CH2", "ADDA_UL_CH2", "ADDA Capture"},
+	{"UL1_CH1", "I2S0_CH1", "I2S0"},
+	{"UL1_CH2", "I2S0_CH2", "I2S0"},
 
 	{"UL2", NULL, "UL2_CH1"},
 	{"UL2", NULL, "UL2_CH2"},
 	{"UL2_CH1", "ADDA_UL_CH1", "ADDA Capture"},
 	{"UL2_CH2", "ADDA_UL_CH2", "ADDA Capture"},
+	{"UL2_CH1", "I2S2_CH1", "I2S2"},
+	{"UL2_CH2", "I2S2_CH2", "I2S2"},
 
 	{"UL3", NULL, "UL3_CH1"},
 	{"UL3", NULL, "UL3_CH2"},
 	{"UL3_CH1", "ADDA_UL_CH1", "ADDA Capture"},
 	{"UL3_CH2", "ADDA_UL_CH2", "ADDA Capture"},
+	{"UL3_CH1", "I2S2_CH1", "I2S2"},
+	{"UL3_CH2", "I2S2_CH2", "I2S2"},
 
 	{"UL4", NULL, "UL4_CH1"},
 	{"UL4", NULL, "UL4_CH2"},
@@ -421,7 +439,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL1_HD_SFT,
 		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 		.msb_reg = -1,
+		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_DL2] = {
 		.name = "DL2",
@@ -438,7 +458,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL2_HD_SFT,
 		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 		.msb_reg = -1,
+		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_DL3] = {
 		.name = "DL3",
@@ -455,7 +477,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = DL3_HD_SFT,
 		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 		.msb_reg = -1,
+		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_VUL2] = {
 		.name = "VUL2",
@@ -472,7 +496,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = VUL2_HD_SFT,
 		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 		.msb_reg = -1,
+		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_AWB] = {
 		.name = "AWB",
@@ -489,7 +515,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = AWB_HD_SFT,
 		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 		.msb_reg = -1,
+		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_AWB2] = {
 		.name = "AWB2",
@@ -506,7 +534,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = AWB2_HD_SFT,
 		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 		.msb_reg = -1,
+		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_VUL12] = {
 		.name = "VUL12",
@@ -523,7 +553,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = VUL12_HD_SFT,
 		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 		.msb_reg = -1,
+		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_MOD_DAI] = {
 		.name = "MOD_DAI",
@@ -540,7 +572,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = MOD_DAI_HD_SFT,
 		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 		.msb_reg = -1,
+		.msb_shift = -1,
 	},
 	[MT8183_MEMIF_HDMI] = {
 		.name = "HDMI",
@@ -553,10 +587,13 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.mono_reg = -1,
 		.mono_shift = -1,
 		.enable_reg = -1,	/* control in tdm for sync start */
+		.enable_shift = -1,
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_shift = HDMI_HD_SFT,
 		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
 		.msb_reg = -1,
+		.msb_shift = -1,
 	},
 };
 
@@ -671,6 +708,7 @@ static const struct mtk_base_irq_data irq_data[MT8183_IRQ_NUM] = {
 		.irq_cnt_shift = 0,
 		.irq_cnt_maskbit = 0x3ffff,
 		.irq_fs_reg = -1,
+		.irq_fs_shift = -1,
 		.irq_fs_maskbit = -1,
 		.irq_en_reg = AFE_IRQ_MCU_CON0,
 		.irq_en_shift = IRQ8_MCU_ON_SFT,
-- 
2.20.1
