From: Jiaxin Yu <jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 2/2] ASoC: Mediatek: MT8183: fix compile error
Date: Tue, 21 May 2019 17:29:38 +0800
Message-ID: <1558430978-2440-3-git-send-email-jiaxin.yu@mediatek.com>
References: <1558430978-2440-1-git-send-email-jiaxin.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1558430978-2440-1-git-send-email-jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Jiaxin Yu <jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, tzungbi-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

mtk_regmap_update_bits() has been changed to take a shift and warn
when reg >= 0 but shift < 0.So the hd_align_mshift must not have shift.
Change it from XXX_HD_ALIGN_MASK_SFT to XXX_HD_ALIGN_MASK.

Fixes: cf61f5b01531 ("ASoC: Mediatek: MT8183: set data align")

Signed-off-by: Jiaxin Yu <jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
Hi,
	This patch is base on for-5.3 branch.
	And tested pass on kukui board locally.
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index ab2bce1..56c3732 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -439,7 +439,7 @@ static int mt8183_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = DL1_HD_SFT,
-		.hd_align_mshift = DL1_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = DL1_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -460,7 +460,7 @@ static int mt8183_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = DL2_HD_SFT,
-		.hd_align_mshift = DL2_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = DL2_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -481,7 +481,7 @@ static int mt8183_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = DL3_HD_SFT,
-		.hd_align_mshift = DL3_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = DL3_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -502,7 +502,7 @@ static int mt8183_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = VUL2_HD_SFT,
-		.hd_align_mshift = VUL2_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = VUL2_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -523,7 +523,7 @@ static int mt8183_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = AWB_HD_SFT,
-		.hd_align_mshift = AWB_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = AWB_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -544,7 +544,7 @@ static int mt8183_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = AWB2_HD_SFT,
-		.hd_align_mshift = AWB2_ALIGN_MASK_SFT,
+		.hd_align_mshift = AWB2_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -565,7 +565,7 @@ static int mt8183_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = VUL12_HD_SFT,
-		.hd_align_mshift = VUL12_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = VUL12_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -586,7 +586,7 @@ static int mt8183_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = MOD_DAI_HD_SFT,
-		.hd_align_mshift = MOD_DAI_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = MOD_DAI_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
@@ -607,7 +607,7 @@ static int mt8183_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
 		.hd_reg = AFE_MEMIF_HD_MODE,
 		.hd_align_reg = AFE_MEMIF_HDALIGN,
 		.hd_shift = HDMI_HD_SFT,
-		.hd_align_mshift = HDMI_HD_ALIGN_MASK_SFT,
+		.hd_align_mshift = HDMI_HD_ALIGN_SFT,
 		.agent_disable_reg = -1,
 		.agent_disable_shift = -1,
 		.msb_reg = -1,
-- 
1.8.1.1.dirty
