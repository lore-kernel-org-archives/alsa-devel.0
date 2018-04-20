From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH] ASoC: codecs: msm8916-wcd: use threaded IRQ
	handlers
Date: Fri, 20 Apr 2018 14:07:50 +0200
Message-ID: <20180420120750.356-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 202972673D4
 for <alsa-devel@alsa-project.org>; Fri, 20 Apr 2018 14:07:57 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-arm-msm@vger.kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

The handler for the mbhc switch irq calls into snd_soc_jack_report() which
in turn triggers a notifier chain that is blocking, which means it allows
its callbacks to sleep. This leads to a "scheduling while atomic" Ooops
when the jack notifier callback uses snd_soc_dapm_sync(), for instance.

Fix this by switching from atomic to threaded IRQ handlers.

Fixes: de66b3455023e ("ASoC: codecs: msm8916-wcd-analog: add MBHC support")
Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 12ee83d52405..52b4b6d836a4 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1187,10 +1187,12 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	ret = devm_request_irq(dev, irq, pm8916_mbhc_switch_irq_handler,
-			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
-			       IRQF_ONESHOT,
-			       "mbhc switch irq", priv);
+	ret = devm_request_threaded_irq(dev, irq, NULL,
+					pm8916_mbhc_switch_irq_handler,
+					IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING |
+					IRQF_ONESHOT,
+					"mbhc switch irq", priv);
 	if (ret)
 		dev_err(dev, "cannot request mbhc switch irq\n");
 
@@ -1201,10 +1203,12 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 			return irq;
 		}
 
-		ret = devm_request_irq(dev, irq, mbhc_btn_press_irq_handler,
-				       IRQF_TRIGGER_RISING |
-				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				       "mbhc btn press irq", priv);
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						mbhc_btn_press_irq_handler,
+						IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						"mbhc btn press irq", priv);
 		if (ret)
 			dev_err(dev, "cannot request mbhc button press irq\n");
 
@@ -1214,10 +1218,11 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 			return irq;
 		}
 
-		ret = devm_request_irq(dev, irq, mbhc_btn_release_irq_handler,
-				       IRQF_TRIGGER_RISING |
-				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				       "mbhc btn release irq", priv);
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						mbhc_btn_release_irq_handler,
+						IRQF_TRIGGER_RISING |
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						"mbhc btn release irq", priv);
 		if (ret)
 			dev_err(dev, "cannot request mbhc button release irq\n");
 
-- 
2.14.3
