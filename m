From: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2] ASoC: Mediatek: MT8183: set data align
Date: Thu, 16 May 2019 17:54:38 +0800
Message-ID: <20190516095438.15759-3-shunli.wang@mediatek.com>
References: <20190516095438.15759-1-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190516095438.15759-1-shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, tzungbi-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch sets register and bit information about
data align for every memory interface.

Signed-off-by: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 1bc0fafe5e29..ab2bce1d9b3d 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -437,7 +437,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = DL1_ON_SFT,
 		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = DL1_HD_SFT,
+		.hd_align_mshift = DL1_HD_ALIGN_MASK_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -456,7 +458,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = DL2_ON_SFT,
 		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = DL2_HD_SFT,
+		.hd_align_mshift = DL2_HD_ALIGN_MASK_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -475,7 +479,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = DL3_ON_SFT,
 		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = DL3_HD_SFT,
+		.hd_align_mshift = DL3_HD_ALIGN_MASK_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -494,7 +500,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = VUL2_ON_SFT,
 		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = VUL2_HD_SFT,
+		.hd_align_mshift = VUL2_HD_ALIGN_MASK_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -513,7 +521,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = AWB_ON_SFT,
 		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = AWB_HD_SFT,
+		.hd_align_mshift = AWB_HD_ALIGN_MASK_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -532,7 +542,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = AWB2_ON_SFT,
 		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = AWB2_HD_SFT,
+		.hd_align_mshift = AWB2_ALIGN_MASK_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -551,7 +563,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = VUL12_ON_SFT,
 		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = VUL12_HD_SFT,
+		.hd_align_mshift = VUL12_HD_ALIGN_MASK_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -570,7 +584,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.enable_reg = AFE_DAC_CON0,
 		.enable_shift = MOD_DAI_ON_SFT,
 		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = MOD_DAI_HD_SFT,
+		.hd_align_mshift = MOD_DAI_HD_ALIGN_MASK_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -589,7 +605,9 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.enable_reg = -1,	/* control in tdm for sync start */
 		.enable_shift = -1,
 		.hd_reg = AFE_MEMIF_HD_MODE,
+		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = HDMI_HD_SFT,
+		.hd_align_mshift = HDMI_HD_ALIGN_MASK_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
-- 
2.18.0
