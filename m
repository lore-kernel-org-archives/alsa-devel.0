From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: preallocate pages use platform device" to the asoc tree
Date: Fri, 27 Apr 2018 11:59:16 +0100
Message-ID: <E1fC15w-0003si-GB@debutante>
References: <20180427021135.16002-1-kaichieh.chuang@mediatek.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180427021135.16002-1-kaichieh.chuang@mediatek.com>
Sender: stable-owner@vger.kernel.org
Cc: KaiChieh Chuang <kaichieh.chuang@mediatek.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgbroonie@kernel.org, alsa-devel@alsa-project.org, ryder.lee@mediatek.com, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, Hidalgo.Huang@mediatek.com, linux-mediatek@lists.infradead.org, PC.Liao@mediatek.comkaichieh.chuang@mediatek.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: preallocate pages use platform device

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

>From 5845e6155d8f4a4a9bae2d4c1d1bb4a4d9a925c2 Mon Sep 17 00:00:00 2001
From: Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
Date: Fri, 27 Apr 2018 10:11:35 +0800
Subject: [PATCH] ASoC: mediatek: preallocate pages use platform device

preallocate pages should use platform device,
since we set dma mask for platform device.

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/mediatek/common/mtk-afe-platform-driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 53215b52e4f2..f8a06709f76d 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -64,14 +64,14 @@ static const struct snd_pcm_ops mtk_afe_pcm_ops = {
 static int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	size_t size;
-	struct snd_card *card = rtd->card->snd_card;
 	struct snd_pcm *pcm = rtd->pcm;
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
 	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
 
 	size = afe->mtk_afe_hardware->buffer_bytes_max;
 	return snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-						     card->dev, size, size);
+						     rtd->platform->dev,
+						     size, size);
 }
 
 static void mtk_afe_pcm_free(struct snd_pcm *pcm)
-- 
2.17.0
