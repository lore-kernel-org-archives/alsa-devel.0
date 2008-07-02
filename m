From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Make pop/click debug wait times
	dynamically configurable
Date: Wed,  2 Jul 2008 11:51:20 +0100
Message-ID: <1214995880-2773-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1214995880-2773-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F301D24632
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jul 2008 12:51:23 +0200 (CEST)
In-Reply-To: <1214995880-2773-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

DAPM supports adding a compile time configurable delay to the widget power
sequences, aiding diagnosis of problems with pops and clicks being
generated during them. This patch converts this to be configurable at run
time via a sysfs file.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   67 +++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2536382..7c2dd4e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -54,16 +54,6 @@
 #define dbg(format, arg...)
 #endif
 
-#define POP_DEBUG 0
-#if POP_DEBUG
-#define POP_TIME 500 /* 500 msecs - change if pop debug is too fast */
-#define pop_wait(time) schedule_timeout_uninterruptible(msecs_to_jiffies(time))
-#define pop_dbg(format, arg...) printk(format, ## arg); pop_wait(POP_TIME)
-#else
-#define pop_dbg(format, arg...)
-#define pop_wait(time)
-#endif
-
 /* dapm power sequences - make this per codec in the future */
 static int dapm_up_seq[] = {
 	snd_soc_dapm_pre, snd_soc_dapm_micbias, snd_soc_dapm_mic,
@@ -80,6 +70,28 @@ static int dapm_status = 1;
 module_param(dapm_status, int, 0);
 MODULE_PARM_DESC(dapm_status, "enable DPM sysfs entries");
 
+static unsigned int pop_time;
+
+static void pop_wait(void)
+{
+	if (pop_time)
+		schedule_timeout_uninterruptible(msecs_to_jiffies(pop_time));
+}
+
+static void pop_dbg(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+
+	if (pop_time) {
+		vprintk(fmt, args);
+		pop_wait();
+	}
+
+	va_end(args);
+}
+
 /* create a new dapm widget */
 static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 	const struct snd_soc_dapm_widget *_widget)
@@ -217,9 +229,9 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 	change = old != new;
 	if (change) {
 		pop_dbg("pop test %s : %s in %d ms\n", widget->name,
-			widget->power ? "on" : "off", POP_TIME);
+			widget->power ? "on" : "off", pop_time);
 		snd_soc_write(codec, widget->reg, new);
-		pop_wait(POP_TIME);
+		pop_wait();
 	}
 	dbg("reg %x old %x new %x change %d\n", widget->reg, old, new, change);
 	return change;
@@ -803,20 +815,47 @@ static ssize_t dapm_widget_show(struct device *dev,
 
 static DEVICE_ATTR(dapm_widget, 0444, dapm_widget_show, NULL);
 
+/* pop/click delay times */
+static ssize_t dapm_pop_time_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", pop_time);
+}
+
+static ssize_t dapm_pop_time_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+
+{
+	if (strict_strtoul(buf, 10, &pop_time) < 0)
+		printk(KERN_ERR "Unable to parse pop_time setting\n");
+
+	return count;
+}
+
+static DEVICE_ATTR(dapm_pop_time, 0744, dapm_pop_time_show,
+		   dapm_pop_time_store);
+
 int snd_soc_dapm_sys_add(struct device *dev)
 {
 	int ret = 0;
 
-	if (dapm_status)
+	if (dapm_status) {
 		ret = device_create_file(dev, &dev_attr_dapm_widget);
 
+		if (ret == 0)
+			ret = device_create_file(dev, &dev_attr_dapm_pop_time);
+	}
+
 	return ret;
 }
 
 static void snd_soc_dapm_sys_remove(struct device *dev)
 {
-	if (dapm_status)
+	if (dapm_status) {
+		device_remove_file(dev, &dev_attr_dapm_pop_time);
 		device_remove_file(dev, &dev_attr_dapm_widget);
+	}
 }
 
 /* free all dapm widgets and resources */
-- 
1.5.6
