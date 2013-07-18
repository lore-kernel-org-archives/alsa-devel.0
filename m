From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: sta32x: Use power efficient workqueue
Date: Thu, 18 Jul 2013 22:58:34 +0100
Message-ID: <1374184714-11900-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id D2633265621
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 23:59:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

None of the delayed work the driver schedules has particularly short delays
and it is not performance sensitive so let the scheduler run it wherever
is most efficient rather than in a per CPU workqueue by using the system
power efficient workqueue.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/sta32x.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
index cfb55fe..06edb39 100644
--- a/sound/soc/codecs/sta32x.c
+++ b/sound/soc/codecs/sta32x.c
@@ -363,16 +363,18 @@ static void sta32x_watchdog(struct work_struct *work)
 	}
 
 	if (!sta32x->shutdown)
-		schedule_delayed_work(&sta32x->watchdog_work,
-				      round_jiffies_relative(HZ));
+		queue_delayed_work(system_power_efficient_wq,
+				   &sta32x->watchdog_work,
+				   round_jiffies_relative(HZ));
 }
 
 static void sta32x_watchdog_start(struct sta32x_priv *sta32x)
 {
 	if (sta32x->pdata->needs_esd_watchdog) {
 		sta32x->shutdown = 0;
-		schedule_delayed_work(&sta32x->watchdog_work,
-				      round_jiffies_relative(HZ));
+		queue_delayed_work(system_power_efficient_wq,
+				   &sta32x->watchdog_work,
+				   round_jiffies_relative(HZ));
 	}
 }
 
-- 
1.8.3.2
