From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/4] ASoC: wm8350: Use power efficient workqueue
Date: Thu, 18 Jul 2013 22:57:15 +0100
Message-ID: <1374184638-10691-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0388A2655EE
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 23:57:24 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The accessory detect debounce work is not performance sensitive so let
the scheduler run it wherever is most efficient rather than in a per CPU
workqueue by using the system power efficient workqueue.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/wm8350.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 0e8b3aa..af1318d 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1301,7 +1301,8 @@ static irqreturn_t wm8350_hpl_jack_handler(int irq, void *data)
 	if (device_may_wakeup(wm8350->dev))
 		pm_wakeup_event(wm8350->dev, 250);
 
-	schedule_delayed_work(&priv->hpl.work, msecs_to_jiffies(200));
+	queue_delayed_work(system_power_efficient_wq,
+			   &priv->hpl.work, msecs_to_jiffies(200));
 
 	return IRQ_HANDLED;
 }
@@ -1318,7 +1319,8 @@ static irqreturn_t wm8350_hpr_jack_handler(int irq, void *data)
 	if (device_may_wakeup(wm8350->dev))
 		pm_wakeup_event(wm8350->dev, 250);
 
-	schedule_delayed_work(&priv->hpr.work, msecs_to_jiffies(200));
+	queue_delayed_work(system_power_efficient_wq,
+			   &priv->hpr.work, msecs_to_jiffies(200));
 
 	return IRQ_HANDLED;
 }
-- 
1.8.3.2
