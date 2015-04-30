From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Correct pm status check
	in suspend callback
Date: Thu, 30 Apr 2015 11:57:41 +0300
Message-ID: <1430384261-5373-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 982CD260672
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 10:57:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

pm_runtime_enabled() will only tell if the pm runtime has been enabled for
the device, which is done at probe time but will not tell the actual power
state of the device.
pm_runtime_active() provides this information.
This patch fixes a kernel crash when doing suspend when McASP is not
active.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Mark,

can you schedule this for the next -rc?

Thank you,
Peter

 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index ddf7e97d8f0b..1ab3fcdc6bba 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -1247,7 +1247,7 @@ static int davinci_mcasp_suspend(struct snd_soc_dai *dai)
 	u32 reg;
 	int i;
 
-	context->pm_state = pm_runtime_enabled(mcasp->dev);
+	context->pm_state = pm_runtime_active(mcasp->dev);
 	if (!context->pm_state)
 		pm_runtime_get_sync(mcasp->dev);
 
-- 
2.3.5
