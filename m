From: Koro Chen <koro.chen@mediatek.com>
Subject: [PATCH] ASoC: mediatek: Fix unbalanced calls to runtime suspend/resume
Date: Tue, 23 Jun 2015 19:01:20 +0800
Message-ID: <1435057280-21316-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: matthias.bgg@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de
Cc: srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, s.hauer@pengutronix.de, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Koro Chen <koro.chen@mediatek.com>
List-Id: alsa-devel@alsa-project.org

This adds call to runtime suspend in dev remove. It fixs the problem that
suspend is not called in the case of CONFIG_PM=n. It also fixs build
warning when CONFIG_PM=n.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
---
 sound/soc/mediatek/mtk-afe-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index cc228db..9863da7 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -1199,6 +1199,8 @@ err_pm_disable:
 static int mtk_afe_pcm_dev_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		mtk_afe_runtime_suspend(&pdev->dev);
 	snd_soc_unregister_component(&pdev->dev);
 	snd_soc_unregister_platform(&pdev->dev);
 	return 0;
-- 
1.8.1.1.dirty
