From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert DAPM pop time configuration to
	debugfs
Date: Thu, 28 Aug 2008 12:46:24 +0100
Message-ID: <1219923984-5267-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DE4C810384E
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Aug 2008 13:46:25 +0200 (CEST)
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

Pop time configuration is a debugging feature which shouldn't be used in
normal operation so move it to debugfs where it is clearer. This also
simplifies the code since debugfs provides standard facilities for
exposing simple integer values to user space.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

It would be nice to apply this to 2.6.27 since the sysfs file was only
added in the 2.6.27 cycle but it's not critical either way.

 sound/soc/soc-dapm.c |   53 ++++++++++++++++++-------------------------------
 1 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7a88f76..c016426 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -38,6 +38,7 @@
 #include <linux/bitops.h>
 #include <linux/platform_device.h>
 #include <linux/jiffies.h>
+#include <linux/debugfs.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -67,7 +68,9 @@ static int dapm_status = 1;
 module_param(dapm_status, int, 0);
 MODULE_PARM_DESC(dapm_status, "enable DPM sysfs entries");
 
-static unsigned int pop_time;
+static struct dentry *asoc_debugfs;
+
+static u32 pop_time;
 
 static void pop_wait(void)
 {
@@ -817,51 +820,35 @@ static ssize_t dapm_widget_show(struct device *dev,
 
 static DEVICE_ATTR(dapm_widget, 0444, dapm_widget_show, NULL);
 
-/* pop/click delay times */
-static ssize_t dapm_pop_time_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "%d\n", pop_time);
-}
-
-static ssize_t dapm_pop_time_store(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t count)
-
-{
-	unsigned long val;
-
-	if (strict_strtoul(buf, 10, &val) >= 0)
-		pop_time = val;
-	else
-		printk(KERN_ERR "Unable to parse pop_time setting\n");
-
-	return count;
-}
-
-static DEVICE_ATTR(dapm_pop_time, 0744, dapm_pop_time_show,
-		   dapm_pop_time_store);
-
 int snd_soc_dapm_sys_add(struct device *dev)
 {
 	int ret = 0;
 
-	if (dapm_status) {
-		ret = device_create_file(dev, &dev_attr_dapm_widget);
+	if (!dapm_status)
+		return 0;
 
-		if (ret == 0)
-			ret = device_create_file(dev, &dev_attr_dapm_pop_time);
-	}
+	ret = device_create_file(dev, &dev_attr_dapm_widget);
+	if (ret != 0)
+		return ret;
 
-	return ret;
+	asoc_debugfs = debugfs_create_dir("asoc", NULL);
+	if (!IS_ERR(asoc_debugfs))
+		debugfs_create_u32("dapm_pop_time", 0744, asoc_debugfs,
+				   &pop_time);
+	else
+		asoc_debugfs = NULL;
+
+	return 0;
 }
 
 static void snd_soc_dapm_sys_remove(struct device *dev)
 {
 	if (dapm_status) {
-		device_remove_file(dev, &dev_attr_dapm_pop_time);
 		device_remove_file(dev, &dev_attr_dapm_widget);
 	}
+
+	if (asoc_debugfs)
+		debugfs_remove_recursive(asoc_debugfs);
 }
 
 /* free all dapm widgets and resources */
-- 
1.5.6.5
