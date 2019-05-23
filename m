From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Mediatek: MT8183: enable dev runtime
	suspend and resume" to the asoc tree
Date: Thu, 23 May 2019 14:48:54 +0100 (BST)
Message-ID: <20190523134854.1DAAD1126D27@debutante.sirena.org.uk>
References: <1558536724-18293-1-git-send-email-jiaxin.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58519F8079B
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2019 15:48:55 +0200 (CEST)
In-Reply-To: <1558536724-18293-1-git-send-email-jiaxin.yu@mediatek.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, srv_heupstream@mediatek.com, garlic.tseng@mediatek.com, tzungbi@google.com, Mark Brown <broonie@kernel.org>, linux-mediatek@list.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Mediatek: MT8183: enable dev runtime suspend and resume

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

>From 5463eb5c2f758069d1db21ed2cf23339431c9481 Mon Sep 17 00:00:00 2001
From: Jiaxin Yu <jiaxin.yu@mediatek.com>
Date: Wed, 22 May 2019 22:52:04 +0800
Subject: [PATCH] ASoC: Mediatek: MT8183: enable dev runtime suspend and resume

System suspend will power off audio, so we need regcache sync when
system resume.

Remove pm_runtime_get_sync in dev probe and pm_runtime_put_sync in
dev remove.So that audio dev can triggle runitme suspend and resume.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 56c37323bc13..4a31106d3471 100644
--- a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
+++ b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
@@ -1142,8 +1142,6 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 	regcache_cache_only(afe->regmap, true);
 	regcache_mark_dirty(afe->regmap);
 
-	pm_runtime_get_sync(&pdev->dev);
-
 	/* init memif */
 	afe->memif_size = MT8183_MEMIF_NUM;
 	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
@@ -1235,11 +1233,10 @@ static int mt8183_afe_pcm_dev_probe(struct platform_device *pdev)
 
 static int mt8183_afe_pcm_dev_remove(struct platform_device *pdev)
 {
-	pm_runtime_put_sync(&pdev->dev);
-
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt8183_afe_runtime_suspend(&pdev->dev);
+
 	return 0;
 }
 
-- 
2.20.1
