From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: davinci-mcasp: add missing semicolon
Date: Sun, 08 Mar 2015 22:10:14 +0100
Message-ID: <10196569.gafhWQrdaI@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AFA226054D
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 22:10:22 +0100 (CET)
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

A recent patch introduced a build error because of a trivial typo, this
gets it back to compile.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 6afda7f50754 ("ASoC: davinci-mcasp: Allow complete shutdown of McASP when not in use")
---
I'm guessing this was reported already, but if not, please apply this patch.

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
 
