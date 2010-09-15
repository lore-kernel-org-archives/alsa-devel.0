From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Add debugfs listing of registered
	CODECs
Date: Wed, 15 Sep 2010 18:31:49 +0100
Message-ID: <1284571911-23123-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3A26B243E4
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Sep 2010 19:32:04 +0200 (CEST)
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

Help with diagnostics for machine driver setup by listing all the
registered CODECs in debugfs.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 59b99fb..5e4a1f4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -271,6 +271,33 @@ static void soc_cleanup_codec_debugfs(struct snd_soc_codec *codec)
 	debugfs_remove_recursive(codec->debugfs_codec_root);
 }
 
+static ssize_t codec_list_read_file(struct file *file, char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	ssize_t ret = 0;
+	struct snd_soc_codec *codec;
+
+	if (!buf)
+		return -ENOMEM;
+
+	list_for_each_entry(codec, &codec_list, list)
+		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
+				codec->name);
+
+	if (ret >= 0)
+		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+
+	kfree(buf);
+
+	return ret;
+}
+
+static const struct file_operations codec_list_fops = {
+	.read = codec_list_read_file,
+	.llseek = default_llseek,/* read accesses f_pos */
+};
+
 #else
 
 static inline void soc_init_codec_debugfs(struct snd_soc_codec *codec)
@@ -3192,6 +3219,11 @@ static int __init snd_soc_init(void)
 		       "ASoC: Failed to create debugfs directory\n");
 		debugfs_root = NULL;
 	}
+
+	if (!debugfs_create_file("codecs", 0444, debugfs_root, NULL,
+				 &codec_list_fops))
+		pr_warn("ASoC: Failed to create CODEC list debugfs file\n");
+
 #endif
 
 	return platform_driver_register(&soc_driver);
-- 
1.7.1
