From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: soc-core: Fix checking return value of
 debugfs_create_dir
Date: Sun, 14 Aug 2011 11:23:13 +0800
Message-ID: <1313292193.4421.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We have CONFIG_DEBUG_FS guard around the place calling debugfs_create_dir,
thus debugfs_create_dir returns NULL on failure.

Also use pr_warn to print the warning.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/soc-core.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ae93aa8..69d17ec 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3356,11 +3356,8 @@ static int __init snd_soc_init(void)
 {
 #ifdef CONFIG_DEBUG_FS
 	snd_soc_debugfs_root = debugfs_create_dir("asoc", NULL);
-	if (IS_ERR(snd_soc_debugfs_root) || !snd_soc_debugfs_root) {
-		printk(KERN_WARNING
-		       "ASoC: Failed to create debugfs directory\n");
-		snd_soc_debugfs_root = NULL;
-	}
+	if (!snd_soc_debugfs_root)
+		pr_warn("ASoC: Failed to create debugfs directory\n");
 
 	if (!debugfs_create_file("codecs", 0444, snd_soc_debugfs_root, NULL,
 				 &codec_list_fops))
-- 
1.7.4.1
