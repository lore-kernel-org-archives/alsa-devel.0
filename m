From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: jack: Use power efficient workqueue
Date: Thu, 18 Jul 2013 22:54:13 +0100
Message-ID: <1374184453-8956-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E49BD2655EE
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 23:54:16 +0200 (CEST)
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

The accessory detect debounce work is not performance sensitive so let
the scheduler run it wherever is most efficient rather than in a per CPU
workqueue by using the system power efficient workqueue.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/soc-jack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 0bb5ccc..7aa26b5 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -263,7 +263,7 @@ static irqreturn_t gpio_handler(int irq, void *data)
 	if (device_may_wakeup(dev))
 		pm_wakeup_event(dev, gpio->debounce_time + 50);
 
-	schedule_delayed_work(&gpio->work,
+	queue_delayed_work(system_power_efficient_wq, &gpio->work,
 			      msecs_to_jiffies(gpio->debounce_time));
 
 	return IRQ_HANDLED;
-- 
1.8.3.2
