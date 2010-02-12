From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: Make pmdown_time runtime configurable
Date: Fri, 12 Feb 2010 11:40:19 +0000
Message-ID: <1265974819-25151-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1265974819-25151-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D182A244AF
	for <alsa-devel@alsa-project.org>; Fri, 12 Feb 2010 12:40:22 +0100 (CET)
In-Reply-To: <1265974819-25151-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Grazvydas Ignotas <notasas@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Provide a sysfs file allowing userspace to inspect and change the
pmdown_time setting at runtime.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 94b9cde..c2008bc 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -130,6 +130,29 @@ static ssize_t codec_reg_show(struct device *dev,
 
 static DEVICE_ATTR(codec_reg, 0444, codec_reg_show, NULL);
 
+static ssize_t pmdown_time_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct snd_soc_device *socdev = dev_get_drvdata(dev);
+	struct snd_soc_card *card = socdev->card;
+
+	return sprintf(buf, "%d\n", card->pmdown_time);
+}
+
+static ssize_t pmdown_time_set(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct snd_soc_device *socdev = dev_get_drvdata(dev);
+	struct snd_soc_card *card = socdev->card;
+
+	strict_strtol(buf, 10, &card->pmdown_time);
+
+	return count;
+}
+
+static DEVICE_ATTR(pmdown_time, 0644, pmdown_time_show, pmdown_time_set);
+
 #ifdef CONFIG_DEBUG_FS
 static int codec_reg_open_file(struct inode *inode, struct file *file)
 {
@@ -1124,6 +1147,10 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	if (ret < 0)
 		printk(KERN_WARNING "asoc: failed to add dapm sysfs entries\n");
 
+	ret = device_create_file(card->socdev->dev, &dev_attr_pmdown_time);
+	if (ret < 0)
+		printk(KERN_WARNING "asoc: failed to add pmdown_time sysfs\n");
+
 	ret = device_create_file(card->socdev->dev, &dev_attr_codec_reg);
 	if (ret < 0)
 		printk(KERN_WARNING "asoc: failed to add codec sysfs files\n");
-- 
1.6.6.1
