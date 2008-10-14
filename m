From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 1/1] [ALSA] Allow setting codec register with
	debugfs filesystem
Date: Mon, 13 Oct 2008 17:42:14 -0700
Message-ID: <1223944934-24546-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-03.inet.qwest.net (mpls-qmqp-03.inet.qwest.net
	[63.231.195.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C4D124687
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 02:42:49 +0200 (CEST)
In-Reply-To: <>
References: <>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

i.e. echo 6 59 >/sys/kernel/debug/soc-audio.0/codec_reg
will set register 0x06 to a value of 0x59.
Also, pop_time debugfs interface setup is moved so that it
is setup in the same function as codec_reg

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a1e0357..d33825d 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -425,6 +425,7 @@ struct snd_soc_codec {
 	short reg_cache_step;
 
 	/* dapm */
+	u32 pop_time;
 	struct list_head dapm_widgets;
 	struct list_head dapm_paths;
 	enum snd_soc_bias_level bias_level;
@@ -516,6 +517,9 @@ struct snd_soc_device {
 	struct delayed_work delayed_work;
 	struct work_struct deferred_resume_work;
 	void *codec_data;
+#ifdef CONFIG_DEBUG_FS
+	struct dentry	*debugfs_root;
+#endif
 };
 
 /* runtime channel data */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ad38113..db720b1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/bitops.h>
+#include <linux/debugfs.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -962,10 +963,8 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 }
 
 /* codec register dump */
-static ssize_t codec_reg_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
+static ssize_t soc_codec_reg_show(struct snd_soc_device *devdata, char *buf)
 {
-	struct snd_soc_device *devdata = dev_get_drvdata(dev);
 	struct snd_soc_codec *codec = devdata->codec;
 	int i, step = 1, count = 0;
 
@@ -1002,8 +1001,117 @@ static ssize_t codec_reg_show(struct device *dev,
 
 	return count;
 }
+static ssize_t codec_reg_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct snd_soc_device *devdata = dev_get_drvdata(dev);
+	return soc_codec_reg_show(devdata, buf);
+}
+
 static DEVICE_ATTR(codec_reg, 0444, codec_reg_show, NULL);
 
+#ifdef CONFIG_DEBUG_FS
+static int codec_reg_open_file(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+static ssize_t codec_reg_read_file(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	ssize_t ret;
+	struct snd_soc_device *devdata = file->private_data;
+	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	ret = soc_codec_reg_show(devdata, buf);
+	if (ret >= 0)
+		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	kfree(buf);
+	return ret;
+}
+
+static ssize_t codec_reg_write_file(struct file *file,
+		const char __user *user_buf, size_t count, loff_t *ppos)
+{
+	char buf[32];
+	int buf_size;
+	char *start = buf;
+	unsigned long reg, value;
+	int step = 1;
+	struct snd_soc_device *devdata = file->private_data;
+	struct snd_soc_codec *codec = devdata->codec;
+
+	buf_size = min(count, (sizeof(buf)-1));
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+	buf[buf_size] = 0;
+
+	if (codec->reg_cache_step)
+		step = codec->reg_cache_step;
+
+	while (*start == ' ')
+		start++;
+	reg = simple_strtoul(start, &start, 16);
+	if ((reg >= codec->reg_cache_size) || (reg % step))
+		return -EINVAL;
+	while (*start == ' ')
+		start++;
+	if (strict_strtoul(start, 16, &value))
+		return -EINVAL;
+	codec->write(codec, reg, value);
+	return buf_size;
+}
+
+static const struct file_operations codec_reg_fops = {
+	.open = codec_reg_open_file,
+	.read = codec_reg_read_file,
+	.write = codec_reg_write_file,
+};
+
+static void soc_init_debugfs(struct snd_soc_device *socdev)
+{
+	struct dentry *root, *file;
+	struct snd_soc_codec *codec = socdev->codec;
+	root = debugfs_create_dir(dev_name(socdev->dev), NULL);
+	if (IS_ERR(root) || !root)
+		goto exit1;
+
+	file = debugfs_create_file("codec_reg", 0644,
+			root, socdev, &codec_reg_fops);
+	if (!file)
+		goto exit2;
+
+	file = debugfs_create_u32("dapm_pop_time", 0744,
+			root, &codec->pop_time);
+	if (!file)
+		goto exit2;
+	socdev->debugfs_root = root;
+	return;
+exit2:
+	debugfs_remove_recursive(root);
+exit1:
+	dev_err(socdev->dev, "debugfs is not available\n");
+}
+
+static void soc_cleanup_debugfs(struct snd_soc_device *socdev)
+{
+	debugfs_remove_recursive(socdev->debugfs_root);
+	socdev->debugfs_root = NULL;
+}
+
+#else
+
+static inline void soc_init_debugfs(struct snd_soc_device *socdev)
+{
+}
+
+static inline void soc_cleanup_debugfs(struct snd_soc_device *socdev)
+{
+}
+#endif
+
 /**
  * snd_soc_new_ac97_codec - initailise AC97 device
  * @codec: audio codec
@@ -1217,6 +1325,7 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 	if (err < 0)
 		printk(KERN_WARNING "asoc: failed to add codec sysfs files\n");
 
+	soc_init_debugfs(socdev);
 	mutex_unlock(&codec->mutex);
 
 out:
@@ -1240,6 +1349,7 @@ void snd_soc_free_pcms(struct snd_soc_device *socdev)
 #endif
 
 	mutex_lock(&codec->mutex);
+	soc_cleanup_debugfs(socdev);
 #ifdef CONFIG_SND_SOC_AC97_BUS
 	for (i = 0; i < codec->num_dai; i++) {
 		codec_dai = &codec->dai[i];
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9ca9c08..1bd88ac 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -38,7 +38,6 @@
 #include <linux/bitops.h>
 #include <linux/platform_device.h>
 #include <linux/jiffies.h>
-#include <linux/debugfs.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -68,17 +67,13 @@ static int dapm_status = 1;
 module_param(dapm_status, int, 0);
 MODULE_PARM_DESC(dapm_status, "enable DPM sysfs entries");
 
-static struct dentry *asoc_debugfs;
-
-static u32 pop_time;
-
-static void pop_wait(void)
+static void pop_wait(u32 pop_time)
 {
 	if (pop_time)
 		schedule_timeout_uninterruptible(msecs_to_jiffies(pop_time));
 }
 
-static void pop_dbg(const char *fmt, ...)
+static void pop_dbg(u32 pop_time, const char *fmt, ...)
 {
 	va_list args;
 
@@ -86,7 +81,7 @@ static void pop_dbg(const char *fmt, ...)
 
 	if (pop_time) {
 		vprintk(fmt, args);
-		pop_wait();
+		pop_wait(pop_time);
 	}
 
 	va_end(args);
@@ -231,10 +226,11 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 
 	change = old != new;
 	if (change) {
-		pop_dbg("pop test %s : %s in %d ms\n", widget->name,
-			widget->power ? "on" : "off", pop_time);
+		pop_dbg(codec->pop_time, "pop test %s : %s in %d ms\n",
+			widget->name, widget->power ? "on" : "off",
+			codec->pop_time);
 		snd_soc_write(codec, widget->reg, new);
-		pop_wait();
+		pop_wait(codec->pop_time);
 	}
 	pr_debug("reg %x old %x new %x change %d\n", widget->reg,
 		 old, new, change);
@@ -822,23 +818,9 @@ static DEVICE_ATTR(dapm_widget, 0444, dapm_widget_show, NULL);
 
 int snd_soc_dapm_sys_add(struct device *dev)
 {
-	int ret = 0;
-
 	if (!dapm_status)
 		return 0;
-
-	ret = device_create_file(dev, &dev_attr_dapm_widget);
-	if (ret != 0)
-		return ret;
-
-	asoc_debugfs = debugfs_create_dir("asoc", NULL);
-	if (!IS_ERR(asoc_debugfs))
-		debugfs_create_u32("dapm_pop_time", 0744, asoc_debugfs,
-				   &pop_time);
-	else
-		asoc_debugfs = NULL;
-
-	return 0;
+	return device_create_file(dev, &dev_attr_dapm_widget);
 }
 
 static void snd_soc_dapm_sys_remove(struct device *dev)
@@ -846,9 +828,6 @@ static void snd_soc_dapm_sys_remove(struct device *dev)
 	if (dapm_status) {
 		device_remove_file(dev, &dev_attr_dapm_widget);
 	}
-
-	if (asoc_debugfs)
-		debugfs_remove_recursive(asoc_debugfs);
 }
 
 /* free all dapm widgets and resources */
-- 
1.5.4.3
