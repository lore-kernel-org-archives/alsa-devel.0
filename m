From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ASoC: mediatek: mt2701: drop unnessary snd_soc_unregister_component()
Date: Fri, 16 Mar 2018 07:31:56 +0000
Message-ID: <1521185516-164333-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

It's not necessary to unregister a component registered
with devm_snd_soc_register_component().

Fixes: f1b5bf07365d ("ASoC: mt2701/mt8173: replace platform to componen")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index f7e0702..43837a3 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1561,8 +1561,6 @@ static int mt2701_afe_pcm_dev_remove(struct platform_device *pdev)
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mt2701_afe_runtime_suspend(&pdev->dev);
 
-	snd_soc_unregister_component(&pdev->dev);
-
 	return 0;
 }
