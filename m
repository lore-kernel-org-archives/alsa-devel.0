From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Check list debugfs files for PAGE_SIZE
	overflow
Date: Wed, 13 Oct 2010 10:46:37 +0100
Message-ID: <1286963197-9477-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0A26D24437
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Oct 2010 11:46:42 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   51 ++++++++++++++++++++++++++++++++++---------------
 1 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index dc1c567..4cbfe46 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -275,15 +275,22 @@ static ssize_t codec_list_read_file(struct file *file, char __user *user_buf,
 				    size_t count, loff_t *ppos)
 {
 	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	ssize_t ret = 0;
+	ssize_t len, ret = 0;
 	struct snd_soc_codec *codec;
 
 	if (!buf)
 		return -ENOMEM;
 
-	list_for_each_entry(codec, &codec_list, list)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
-				codec->name);
+	list_for_each_entry(codec, &codec_list, list) {
+		len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
+			       codec->name);
+		if (len >= 0)
+			ret += len;
+		if (ret > PAGE_SIZE) {
+			ret = PAGE_SIZE;
+			break;
+		}
+	}
 
 	if (ret >= 0)
 		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
@@ -302,17 +309,23 @@ static ssize_t dai_list_read_file(struct file *file, char __user *user_buf,
 				  size_t count, loff_t *ppos)
 {
 	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	ssize_t ret = 0;
+	ssize_t len, ret = 0;
 	struct snd_soc_dai *dai;
 
 	if (!buf)
 		return -ENOMEM;
 
-	list_for_each_entry(dai, &dai_list, list)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s\n", dai->name);
+	list_for_each_entry(dai, &dai_list, list) {
+		len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n", dai->name);
+		if (len >= 0)
+			ret += len;
+		if (ret > PAGE_SIZE) {
+			ret = PAGE_SIZE;
+			break;
+		}
+	}
 
-	if (ret >= 0)
-		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
 
 	kfree(buf);
 
@@ -329,18 +342,24 @@ static ssize_t platform_list_read_file(struct file *file,
 				       size_t count, loff_t *ppos)
 {
 	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	ssize_t ret = 0;
+	ssize_t len, ret = 0;
 	struct snd_soc_platform *platform;
 
 	if (!buf)
 		return -ENOMEM;
 
-	list_for_each_entry(platform, &platform_list, list)
-		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
-				platform->name);
+	list_for_each_entry(platform, &platform_list, list) {
+		len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
+			       platform->name);
+		if (len >= 0)
+			ret += len;
+		if (ret > PAGE_SIZE) {
+			ret = PAGE_SIZE;
+			break;
+		}
+	}
 
-	if (ret >= 0)
-		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
 
 	kfree(buf);
 
@@ -3015,11 +3034,11 @@ int snd_soc_register_dais(struct device *dev,
 		}
 
 		dai->dev = dev;
+		dai->driver = &dai_drv[i];
 		if (dai->driver->id)
 			dai->id = dai->driver->id;
 		else
 			dai->id = i;
-		dai->driver = &dai_drv[i];
 		if (!dai->driver->ops)
 			dai->driver->ops = &null_dai_ops;
 
-- 
1.7.1
