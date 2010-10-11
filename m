From: Dan Carpenter <error27@gmail.com>
Subject: [patch] ASoC: soc: snprintf() doesn't return negative
Date: Mon, 11 Oct 2010 05:54:17 +0200
Message-ID: <20101011035416.GD5851@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id ABAFC2444E
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 05:54:36 +0200 (CEST)
Received: by wwb28 with SMTP id 28so2642572wwb.20
	for <alsa-devel@alsa-project.org>; Sun, 10 Oct 2010 20:54:35 -0700 (PDT)
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

In user space snprintf() returns negative on errors but the kernel
version only returns positives.  It could potentially return sizes
larger than the size of the buffer so we should check for that.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8751efd..8da307b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -284,8 +284,10 @@ static ssize_t codec_list_read_file(struct file *file, char __user *user_buf,
 		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
 				codec->name);
 
-	if (ret >= 0)
-		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	if (ret > PAGE_SIZE)
+		ret = PAGE_SIZE;
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
 
 	kfree(buf);
 
@@ -310,8 +312,10 @@ static ssize_t dai_list_read_file(struct file *file, char __user *user_buf,
 	list_for_each_entry(dai, &dai_list, list)
 		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s\n", dai->name);
 
-	if (ret >= 0)
-		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	if (ret > PAGE_SIZE)
+		ret = PAGE_SIZE;
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
 
 	kfree(buf);
 
@@ -338,8 +342,10 @@ static ssize_t platform_list_read_file(struct file *file,
 		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
 				platform->name);
 
-	if (ret >= 0)
-		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	if (ret > PAGE_SIZE)
+		ret = PAGE_SIZE;
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
 
 	kfree(buf);
