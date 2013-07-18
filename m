From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 4/4] ASoC: wm8994: Use power efficient workqueue
Date: Thu, 18 Jul 2013 22:57:18 +0100
Message-ID: <1374184638-10691-4-git-send-email-broonie@kernel.org>
References: <1374184638-10691-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 026D22655FE
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2013 23:57:27 +0200 (CEST)
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
 sound/soc/codecs/wm8994.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 357f439..a8d7b0c 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -819,8 +819,9 @@ static int clk_sys_event(struct snd_soc_dapm_widget *w,
 		 * don't want false reports.
 		 */
 		if (wm8994->jackdet && !wm8994->clk_has_run) {
-			schedule_delayed_work(&wm8994->jackdet_bootstrap,
-					      msecs_to_jiffies(1000));
+			queue_delayed_work(system_power_efficient_wq,
+					   &wm8994->jackdet_bootstrap,
+					   msecs_to_jiffies(1000));
 			wm8994->clk_has_run = true;
 		}
 		break;
@@ -3487,7 +3488,8 @@ static irqreturn_t wm8994_mic_irq(int irq, void *data)
 
 	pm_wakeup_event(codec->dev, 300);
 
-	schedule_delayed_work(&priv->mic_work, msecs_to_jiffies(250));
+	queue_delayed_work(system_power_efficient_wq,
+			   &priv->mic_work, msecs_to_jiffies(250));
 
 	return IRQ_HANDLED;
 }
@@ -3575,8 +3577,9 @@ static void wm8958_mic_id(void *data, u16 status)
 		/* If nothing present then clear our statuses */
 		dev_dbg(codec->dev, "Detected open circuit\n");
 
-		schedule_delayed_work(&wm8994->open_circuit_work,
-				      msecs_to_jiffies(2500));
+		queue_delayed_work(system_power_efficient_wq,
+				   &wm8994->open_circuit_work,
+				   msecs_to_jiffies(2500));
 		return;
 	}
 
@@ -3690,8 +3693,9 @@ static irqreturn_t wm1811_jackdet_irq(int irq, void *data)
 				    WM1811_JACKDET_DB, 0);
 
 		delay = control->pdata.micdet_delay;
-		schedule_delayed_work(&wm8994->mic_work,
-				      msecs_to_jiffies(delay));
+		queue_delayed_work(system_power_efficient_wq,
+				   &wm8994->mic_work,
+				   msecs_to_jiffies(delay));
 	} else {
 		dev_dbg(codec->dev, "Jack not detected\n");
 
@@ -3936,8 +3940,9 @@ static irqreturn_t wm8958_mic_irq(int irq, void *data)
 	id_delay = wm8994->wm8994->pdata.mic_id_delay;
 
 	if (wm8994->mic_detecting)
-		schedule_delayed_work(&wm8994->mic_complete_work,
-				      msecs_to_jiffies(id_delay));
+		queue_delayed_work(system_power_efficient_wq,
+				   &wm8994->mic_complete_work,
+				   msecs_to_jiffies(id_delay));
 	else
 		wm8958_button_det(codec, reg);
 
-- 
1.8.3.2
