From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Work around allmodconfig failure
Date: Thu, 28 Apr 2011 10:58:47 +0100
Message-ID: <1303984727-14401-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 699201037EE
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 11:58:40 +0200 (CEST)
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
 include/sound/soc.h   |    3 +++
 sound/soc/soc-core.c  |    4 ++++
 sound/soc/soc-utils.c |    6 ++----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index cb6b18b..6ce3e57 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -888,6 +888,9 @@ static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->dapm_list);
 }
 
+int snd_soc_util_init(void);
+void snd_soc_util_exit(void);
+
 #include <sound/soc-dai.h>
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 16be3e5..a823654 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3868,12 +3868,16 @@ static int __init snd_soc_init(void)
 		pr_warn("ASoC: Failed to create platform list debugfs file\n");
 #endif
 
+	snd_soc_util_init();
+
 	return platform_driver_register(&soc_driver);
 }
 module_init(snd_soc_init);
 
 static void __exit snd_soc_exit(void)
 {
+	snd_soc_util_exit();
+
 #ifdef CONFIG_DEBUG_FS
 	debugfs_remove_recursive(snd_soc_debugfs_root);
 #endif
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 2865791..ec921ec 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -82,7 +82,7 @@ static struct platform_driver soc_dummy_driver = {
 
 static struct platform_device *soc_dummy_dev;
 
-static int __init snd_soc_util_init(void)
+int __init snd_soc_util_init(void)
 {
 	int ret;
 
@@ -102,11 +102,9 @@ static int __init snd_soc_util_init(void)
 
 	return ret;
 }
-module_init(snd_soc_util_init);
 
-static void __exit snd_soc_util_exit(void)
+void __exit snd_soc_util_exit(void)
 {
 	platform_device_unregister(soc_dummy_dev);
 	platform_driver_unregister(&soc_dummy_driver);
 }
-module_exit(snd_soc_util_exit);
-- 
1.7.4.1
