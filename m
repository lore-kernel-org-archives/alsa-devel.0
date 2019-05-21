From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: Mediatek: MT8183: fix compile error" to the asoc tree
Date: Tue, 21 May 2019 21:32:40 +0100 (BST)
Message-ID: <20190521203240.BC44C1126D16@debutante.sirena.org.uk>
References: <1558430978-2440-3-git-send-email-jiaxin.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1558430978-2440-3-git-send-email-jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jiaxin Yu <jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, tzungbi-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Mediatek: MT8183: fix compile error

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 383d30e72e682021fdaf0371ade1c58ad2c434a4 Mon Sep 17 00:00:00 2001
From: Jiaxin Yu <jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Tue, 21 May 2019 17:29:38 +0800
Subject: [PATCH] ASoC: Mediatek: MT8183: fix compile error

mtk_regmap_update_bits() has been changed to take a shift and warn
when reg >= 0 but shift < 0.So the hd_align_mshift must not have shift.
Change it from XXX_HD_ALIGN_MASK_SFT to XXX_HD_ALIGN_MASK.

Fixes: cf61f5b01531 ("ASoC: Mediatek: MT8183: set data align")

Signed-off-by: Jiaxin Yu <jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index ab2bce1d9b3d..56c37323bc13 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -439,7 +439,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = DL1_HD_SFT,
-		.hd_align_mshift = DL1_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = DL1_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -460,7 +460,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = DL2_HD_SFT,
-		.hd_align_mshift = DL2_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = DL2_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -481,7 +481,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = DL3_HD_SFT,
-		.hd_align_mshift = DL3_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = DL3_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -502,7 +502,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = VUL2_HD_SFT,
-		.hd_align_mshift = VUL2_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = VUL2_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -523,7 +523,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = AWB_HD_SFT,
-		.hd_align_mshift = AWB_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = AWB_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -544,7 +544,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = AWB2_HD_SFT,
-		.hd_align_mshift = AWB2_ALIGN_MASK_SFT,
+		.hd_align_mshift = AWB2_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -565,7 +565,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = VUL12_HD_SFT,
-		.hd_align_mshift = VUL12_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = VUL12_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -586,7 +586,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = MOD_DAI_HD_SFT,
-		.hd_align_mshift = MOD_DAI_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = MOD_DAI_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -607,7 +607,7 @@ static const struct mtk_base_memif_data memif_data[MT8183_MEMIF_NUM] = {
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = HDMI_HD_SFT,
-		.hd_align_mshift = HDMI_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = HDMI_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
-- 
2.20.1
