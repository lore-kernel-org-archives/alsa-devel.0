From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: Mediatek: add memory interface data align" to the asoc
 tree
Date: Thu, 16 May 2019 11:17:16 +0100 (BST)
Message-ID: <20190516101716.3E67A1126D46@debutante.sirena.org.uk>
References: <20190516095438.15759-2-shunli.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190516095438.15759-2-shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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

   ASoC: Mediatek: add memory interface data align

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

>From 1628fc3f47717fc3c8d9cd5fd6c7bc7d3796927d Mon Sep 17 00:00:00 2001
From: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Date: Thu, 16 May 2019 17:54:37 +0800
Subject: [PATCH] ASoC: Mediatek: add memory interface data align

This supports two data align settings. One is S32_LE and
other is S24_LE.

Signed-off-by: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 7 +++++++
 sound/soc/mediatek/common/mtk-base-afe.h   | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index fded11d14cde..19048c3dc324 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -241,6 +241,7 @@ int mtk_afe_fe_prepare(struct snd_pcm_substream *substream,
 	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
 	struct mtk_base_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
 	int hd_audio = 0;
+	int hd_align = 1;
 
 	/* set hd mode */
 	switch (substream->runtime->format) {
@@ -249,9 +250,11 @@ int mtk_afe_fe_prepare(struct snd_pcm_substream *substream,
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		hd_audio = 1;
+		hd_align = 1;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
 		hd_audio = 1;
+		hd_align = 0;
 		break;
 	default:
 		dev_err(afe->dev, "%s() error: unsupported format %d\n",
@@ -262,6 +265,10 @@ int mtk_afe_fe_prepare(struct snd_pcm_substream *substream,
 	mtk_regmap_update_bits(afe->regmap, memif->data->hd_reg,
 			       1, hd_audio, memif->data->hd_shift);
 
+	mtk_regmap_update_bits(afe->regmap, memif->data->hd_align_reg,
+			       memif->data->hd_align_mshift,
+			       hd_align ? memif->data->hd_align_mshift : 0);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mtk_afe_fe_prepare);
diff --git a/sound/soc/mediatek/common/mtk-base-afe.h b/sound/soc/mediatek/common/mtk-base-afe.h
index bd8d5e0c6843..60cb609a9790 100644
--- a/sound/soc/mediatek/common/mtk-base-afe.h
+++ b/sound/soc/mediatek/common/mtk-base-afe.h
@@ -24,7 +24,9 @@ struct mtk_base_memif_data {
 	int enable_reg;
 	int enable_shift;
 	int hd_reg;
+	int hd_align_reg;
 	int hd_shift;
+	int hd_align_mshift;
 	int msb_reg;
 	int msb_shift;
 	int agent_disable_reg;
-- 
2.20.1
