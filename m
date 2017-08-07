From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] ASoC: soc-core: Remove unneeded dentry
	member from snd_soc_codec
Date: Mon,  7 Aug 2017 00:13:05 -0300
Message-ID: <1502075586-23581-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D505266DBC
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 05:13:08 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id p3so6631783qtg.5
 for <alsa-devel@alsa-project.org>; Sun, 06 Aug 2017 20:13:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

There is no need to have the *debugfs_reg dentry member as part of
the snd_soc_codec structure as its only usage is inside
soc_init_codec_debugfs().

Use a local dentry variable instead.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 include/sound/soc.h  | 4 ----
 sound/soc/soc-core.c | 9 +++++----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9d6e1db..42e2e50 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -897,10 +897,6 @@ struct snd_soc_codec {
 
 	/* component */
 	struct snd_soc_component component;
-
-#ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_reg;
-#endif
 };
 
 /* codec driver */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 13c875e..e93a72c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -339,11 +339,12 @@ static void soc_cleanup_component_debugfs(struct snd_soc_component *component)
 static void soc_init_codec_debugfs(struct snd_soc_component *component)
 {
 	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
+	struct dentry *debugfs_reg;
 
-	codec->debugfs_reg = debugfs_create_file("codec_reg", 0644,
-						 codec->component.debugfs_root,
-						 codec, &codec_reg_fops);
-	if (!codec->debugfs_reg)
+	debugfs_reg = debugfs_create_file("codec_reg", 0644,
+					  codec->component.debugfs_root,
+					  codec, &codec_reg_fops);
+	if (!debugfs_reg)
 		dev_warn(codec->dev,
 			"ASoC: Failed to create codec register debugfs file\n");
 }
-- 
2.7.4
