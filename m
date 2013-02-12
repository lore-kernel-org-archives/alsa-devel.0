From: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Subject: [PATCH] ASoC: Jack: add configurable option for
	irq_flag
Date: Tue, 12 Feb 2013 11:07:02 +0530
Message-ID: <1360647422-12404-1-git-send-email-omair.m.abdullah@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3095C261739
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2013 06:35:42 +0100 (CET)
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
Cc: vinod.koul@linux.intel.com, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, vaibhav.agarwal@intel.com, omair.m.abdullah@intel.com, Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vaibhav Agarwal <vaibhav.agarwal@intel.com>

For a jack using GPIO based detection, the framework sets it to trigger on both
edges (rising and falling). Some codecs may provide only a falling or rising edge
interrupt but not both.

This patch provides a configurable option for irq_flag during
snd_soc_jack_add_gpios(). If not configured, it sets the interrupt line to
trigger on both edges.

Signed-off-by: Vaibhav Agarwal <vaibhav.agarwal@intel.com>
Signed-off-by: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-jack.c |    7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a6a059c..d0286ad 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -585,6 +585,7 @@ struct snd_soc_jack_zone {
  * @report:       value to report when jack detected
  * @invert:       report presence in low state
  * @debouce_time: debouce time in ms
+ * @irq_flag:     Interrupt flags for GPIO-Irq line
  * @wake:	  enable as wake source
  * @jack_status_check: callback function which overrides the detection
  *		       to provide more complex checks (eg, reading an
@@ -597,6 +598,7 @@ struct snd_soc_jack_gpio {
 	int report;
 	int invert;
 	int debounce_time;
+	unsigned long irq_flags;
 	bool wake;
 
 	struct snd_soc_jack *jack;
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 0bb5ccc..c9f7953 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -318,10 +318,13 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		INIT_DELAYED_WORK(&gpios[i].work, gpio_work);
 		gpios[i].jack = jack;
 
+		if (!gpios[i].irq_flags)
+			gpios[i].irq_flags =
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
+
 		ret = request_any_context_irq(gpio_to_irq(gpios[i].gpio),
 					      gpio_handler,
-					      IRQF_TRIGGER_RISING |
-					      IRQF_TRIGGER_FALLING,
+					      gpios[i].irq_flags,
 					      gpios[i].name,
 					      &gpios[i]);
 		if (ret < 0)
-- 
1.7.4.1
