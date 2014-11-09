From: Anil Kumar <anilk4.v@gmail.com>
Subject: [PATCH] ASoC: davinvi-mcasp: Balance pm_runtime_enable() on probe failure
Date: Sun,  9 Nov 2014 18:15:14 +0530
Message-ID: <1415537114-9642-1-git-send-email-anilk4.v@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.de, peter.ujfalusi@ti.com, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, anilk4.v@gmail.com
List-Id: alsa-devel@alsa-project.org

If probe fails then we need to call pm_runtime_disable() to balance
out the previous pm_runtime_enable() call.

Signed-off-by: Anil Kumar <anilk4.v@gmail.com>
---
:100644 100644 0eed9b1... 99c747d... M	sound/soc/davinci/davinci-mcasp.c
 sound/soc/davinci/davinci-mcasp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 0eed9b1..99c747d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1235,6 +1235,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (IS_ERR_VALUE(ret)) {
 		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
+		pm_runtime_disable(&pdev->dev);
 		return ret;
 	}
 
-- 
1.9.2
