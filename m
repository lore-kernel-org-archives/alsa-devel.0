From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: avoid using snd_soc_platform"
	to the asoc tree
Date: Tue,  1 May 2018 22:08:58 +0100 (BST)
Message-ID: <20180501210858.BD1D044007C@finisterre.ee.mobilebroadband>
References: <1524892886-25343-1-git-send-email-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 18657267663
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 23:09:02 +0200 (CEST)
In-Reply-To: <1524892886-25343-1-git-send-email-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, garlic.tseng@mediatek.com, broonie@kernel.org, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: avoid using snd_soc_platform

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

>From 9a67d11e34cc21afe2cbddaa8f50d2a5da098d6e Mon Sep 17 00:00:00 2001
From: Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
Date: Sat, 28 Apr 2018 13:21:26 +0800
Subject: [PATCH] ASoC: mediatek: avoid using snd_soc_platform

avoid using snd_soc_platform, which is removed after 4.18

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/common/mtk-afe-platform-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index d046ea8e543b..8966ee138387 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -62,7 +62,7 @@ static int mtk_afe_pcm_new(struct snd_soc_pcm_runtime *rtd)
 
 	size = afe->mtk_afe_hardware->buffer_bytes_max;
 	return snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
-						     rtd->platform->dev,
+						     afe->dev,
 						     size, size);
 }
 
-- 
2.17.0
