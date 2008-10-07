From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH] [ALSA] Allow setting codec register with
	debugfs filesystem
Date: Tue,  7 Oct 2008 14:03:55 -0700
Message-ID: <1223413435-17571-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-03.inet.qwest.net (mpls-qmqp-03.inet.qwest.net
	[63.231.195.114])
	by alsa0.perex.cz (Postfix) with ESMTP id AE9E72443A
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 23:04:25 +0200 (CEST)
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
Cc: Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

i.e. echo 6 59 >/sys/kernel/debug/soc-audio.0/codec_reg
will set register 0x06 to a value of 0x59

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a1e0357..f5a6dbb 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -516,6 +516,10 @@ struct snd_soc_device {
 	struct delayed_work delayed_work;
 	struct work_struct deferred_resume_work;
 	void *codec_data;
+#ifdef CONFIG_SND_SOC_DEBUG_FS
+	struct dentry	*debugfs_root;
+	struct dentry	*debugfs_codec_reg;
+#endif
 };
 
 /* runtime channel data */
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 4dfda66..aad7e0b 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -22,6 +22,14 @@ if SND_SOC
 config SND_SOC_AC97_BUS
 	bool
 
+config SND_SOC_DEBUG_FS
+	boolean "changing codec registers through debugfs (DEVELOPMENT)"
+	depends on DEBUG_FS
+	help
+	   The ability to directly write codec registers through
+	   /sys/kernel/debug/xx/codec_reg is useful when developing
+	   a new codec.
+
 # All the supported Soc's
 source "sound/soc/at32/Kconfig"
 source "sound/soc/at91/Kconfig"
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ad38113..46827cb 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -962,10 +962,8 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 }
 
 /* codec register dump */
-static ssize_t codec_reg_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
+static ssize_t soc_codec_reg_show(struct snd_soc_device *devdata, char *buf)
 {
-	struct snd_soc_device *devdata = dev_get_drvdata(dev);
 	struct snd_soc_codec *codec = devdata->codec;
 	int i, step = 1, count = 0;
 
@@ -1002,8 +1000,113 @@ static ssize_t codec_reg_show(struct device *dev,
 
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
 
+#ifdef CONFIG_SND_SOC_DEBUG_FS
+static int code_reg_open_file(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+static ssize_t code_reg_read_file(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	ssize_t res;
+	struct snd_soc_device *devdata = file->private_data;
+	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+
+	res = soc_codec_reg_show(devdata, buf);
+	res = simple_read_from_buffer(user_buf, count, ppos, buf, res);
+	kfree(buf);
+	return res;
+}
+
+static ssize_t code_reg_write_file(struct file *file,
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
+	.open = code_reg_open_file,
+	.read = code_reg_read_file,
+	.write = code_reg_write_file,
+};
+
+static void soc_init_debugfs(struct snd_soc_device *socdev)
+{
+	struct dentry *root, *debugfs_codec_reg;
+	root = debugfs_create_dir(dev_name(socdev->dev), NULL);
+	if (IS_ERR(root) || !root)
+		goto exit1;
+
+	debugfs_codec_reg = debugfs_create_file("codec_reg", 0644,
+			root, socdev, &codec_reg_fops);
+	if (!debugfs_codec_reg)
+		goto exit2;
+
+	socdev->debugfs_root = root;
+	socdev->debugfs_codec_reg = debugfs_codec_reg;
+	return;
+exit2:
+	debugfs_remove(root);
+exit1:
+	dev_err(socdev->dev, "debugfs is not available\n");
+}
+
+static void soc_cleanup_debugfs(struct snd_soc_device *socdev)
+{
+	debugfs_remove(socdev->debugfs_codec_reg);
+	debugfs_remove(socdev->debugfs_root);
+	socdev->debugfs_codec_reg = NULL;
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
@@ -1217,6 +1320,7 @@ int snd_soc_register_card(struct snd_soc_device *socdev)
 	if (err < 0)
 		printk(KERN_WARNING "asoc: failed to add codec sysfs files\n");
 
+	soc_init_debugfs(socdev);
 	mutex_unlock(&codec->mutex);
 
 out:
@@ -1254,6 +1358,7 @@ free_card:
 	if (codec->card)
 		snd_card_free(codec->card);
 	device_remove_file(socdev->dev, &dev_attr_codec_reg);
+	soc_cleanup_debugfs(socdev);
 	mutex_unlock(&codec->mutex);
 }
 EXPORT_SYMBOL_GPL(snd_soc_free_pcms);
-- 
1.5.4.3
