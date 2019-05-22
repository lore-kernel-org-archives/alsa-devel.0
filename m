From: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH] ASoC: Mediatek: MT8183: enable dev runtime
	suspend and resume
Date: Wed, 22 May 2019 22:52:04 +0800
Message-ID: <1558536724-18293-1-git-send-email-jiaxin.yu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4376F80C20
 for <alsa-devel@alsa-project.org>; Wed, 22 May 2019 16:52:20 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, wsd_upstream@mediatek.com, srv_heupstream@mediatek.com, garlic.tseng@mediatek.com, Jiaxin Yu <jiaxin.yu@mediatek.com>, tzungbi@google.com, linux-mediatek@list.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

System suspend will power off audio, so we need regcache sync when
system resume.

Remove pm_runtime_get_sync in dev probe and pm_runtime_put_sync in
dev remove.So that audio dev can triggle runitme suspend and resume.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
Hi,
	This patch is based on for-next and test passed.
---
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c b/sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
index 56c3732..4a31106 100644
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
1.8.1.1.dirty
