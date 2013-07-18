From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/4] ASoC: wm8962: Use power efficient workqueue
Date: Thu, 18 Jul 2013 22:57:17 +0100
Message-ID: <1374184638-10691-3-git-send-email-broonie@kernel.org>
References: <1374184638-10691-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A5B6C265602
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 23:57:28 +0200 (CEST)
In-Reply-To: <1374184638-10691-1-git-send-email-broonie@kernel.org>
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
 sound/soc/codecs/wm8962.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index e2de9ec..f79df8b 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3046,8 +3046,9 @@ static irqreturn_t wm8962_irq(int irq, void *data)
 
 		pm_wakeup_event(dev, 300);
 
-		schedule_delayed_work(&wm8962->mic_work,
-				      msecs_to_jiffies(250));
+		queue_delayed_work(system_power_efficient_wq,
+				   &wm8962->mic_work,
+				   msecs_to_jiffies(250));
 	}
 
 	return IRQ_HANDLED;
-- 
1.8.3.2
