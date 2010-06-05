From: Wan ZongShun <mcuos.com@gmail.com>
Subject: [PATCH] RTC/pxa: remove unnecessary private ops->ioctl()
Date: Sat, 05 Jun 2010 22:29:39 +0800
Message-ID: <4C0A5F53.6070600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Paul Gortmaker <p_gortmaker@yahoo.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>
List-Id: alsa-devel@alsa-project.org

Please, do not implement private ops->ioctl() unless absolutely necessary.
pxa series RTC driver's ioctl() is unnecessary, since RTC subsystem has implement
the ioctl() very well,so we can only use the API of '.alarm_irq_enable' and
'.update_irq_enable' to do enable irq action.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 drivers/rtc/rtc-pxa.c |   41 ++++++++++++++++++++++-------------------
 1 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index e9c6fa0..8ba4af8 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -236,32 +236,34 @@ static int pxa_periodic_irq_set_state(struct device *dev, int enabled)
 	return 0;
 }

-static int pxa_rtc_ioctl(struct device *dev, unsigned int cmd,
-		unsigned long arg)
+static int pxa_alarm_irq_enable(struct device *dev, unsigned int enabled)
 {
 	struct pxa_rtc *pxa_rtc = dev_get_drvdata(dev);
-	int ret = 0;

 	spin_lock_irq(&pxa_rtc->lock);
-	switch (cmd) {
-	case RTC_AIE_OFF:
-		rtsr_clear_bits(pxa_rtc, RTSR_RDALE1);
-		break;
-	case RTC_AIE_ON:
+
+	if (enabled)
 		rtsr_set_bits(pxa_rtc, RTSR_RDALE1);
-		break;
-	case RTC_UIE_OFF:
-		rtsr_clear_bits(pxa_rtc, RTSR_HZE);
-		break;
-	case RTC_UIE_ON:
+	else
+		rtsr_clear_bits(pxa_rtc, RTSR_RDALE1);
+
+	spin_unlock_irq(&pxa_rtc->lock);
+	return 0;
+}
+
+static int pxa_update_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct pxa_rtc *pxa_rtc = dev_get_drvdata(dev);
+
+	spin_lock_irq(&pxa_rtc->lock);
+
+	if (enabled)
 		rtsr_set_bits(pxa_rtc, RTSR_HZE);
-		break;
-	default:
-		ret = -ENOIOCTLCMD;
-	}
+	else
+		rtsr_clear_bits(pxa_rtc, RTSR_HZE);

 	spin_unlock_irq(&pxa_rtc->lock);
-	return ret;
+	return 0;
 }

 static int pxa_rtc_read_time(struct device *dev, struct rtc_time *tm)
@@ -340,11 +342,12 @@ static int pxa_rtc_proc(struct device *dev, struct seq_file *seq)
 static const struct rtc_class_ops pxa_rtc_ops = {
 	.open = pxa_rtc_open,
 	.release = pxa_rtc_release,
-	.ioctl = pxa_rtc_ioctl,
 	.read_time = pxa_rtc_read_time,
 	.set_time = pxa_rtc_set_time,
 	.read_alarm = pxa_rtc_read_alarm,
 	.set_alarm = pxa_rtc_set_alarm,
+	.alarm_irq_enable = pxa_alarm_irq_enable,
+	.update_irq_enable = pxa_update_irq_enable,
 	.proc = pxa_rtc_proc,
 	.irq_set_state = pxa_periodic_irq_set_state,
 	.irq_set_freq = pxa_periodic_irq_set_freq,
-- 
1.6.3.3
