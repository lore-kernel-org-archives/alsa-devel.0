From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Fix compilation error
Date: Fri, 6 Mar 2015 09:07:32 +0200
Message-ID: <1425625652-31217-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id ACB1C265AB2
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 08:07:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Introduced by commit:
6afda7f50754 ASoC: davinci-mcasp: Allow complete shutdown of McASP when not in use

I'm really sorry for this...

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 33cea0728cd2..d40b392b3da2 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1058,7 +1058,7 @@ static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
 	u32 reg;
 	int i;
 
-	context->pm_state = pm_runtime_enabled(mcasp->dev)
+	context->pm_state = pm_runtime_enabled(mcasp->dev);
 	if (!context->pm_state)
 		pm_runtime_get_sync(mcasp->dev);
 
-- 
2.3.0
