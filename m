From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/3] ASoC: Add sound card directory under
	debugfs/asoc/
Date: Fri,  5 Nov 2010 20:35:19 +0200
Message-ID: <1288982121-22201-2-git-send-email-jhnikula@gmail.com>
References: <1288982121-22201-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CFCA71037FC
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 19:35:20 +0100 (CET)
Received: by ewy22 with SMTP id 22so2093899ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 05 Nov 2010 11:35:20 -0700 (PDT)
In-Reply-To: <1288982121-22201-1-git-send-email-jhnikula@gmail.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

There will be need to have sound card specific debugfs entries. This patch
introduces a new debugfs/asoc/{card->name}/ directory but does not add yet
any entries there.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 include/sound/soc.h  |    4 ++++
 sound/soc/soc-core.c |   18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b048e08..95ce0dd 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -589,6 +589,10 @@ struct snd_soc_card {
 	struct list_head codec_dev_list;
 	struct list_head platform_dev_list;
 	struct list_head dai_dev_list;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_card_root;
+#endif
 };
 
 /* SoC machine DAI configuration, glues a codec and cpu DAI together */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index abbeadf..3819659 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -374,6 +374,20 @@ static const struct file_operations platform_list_fops = {
 	.llseek = default_llseek,/* read accesses f_pos */
 };
 
+static void soc_init_card_debugfs(struct snd_soc_card *card)
+{
+	card->debugfs_card_root = debugfs_create_dir(card->name,
+						     debugfs_root);
+	if (!card->debugfs_card_root)
+		dev_warn(card->dev,
+			 "ASoC: Failed to create codec debugfs directory\n");
+}
+
+static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
+{
+	debugfs_remove_recursive(card->debugfs_card_root);
+}
+
 #else
 
 static inline void soc_init_codec_debugfs(struct snd_soc_codec *codec)
@@ -1667,6 +1681,8 @@ static int soc_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&card->codec_dev_list);
 	INIT_LIST_HEAD(&card->platform_dev_list);
 
+	soc_init_card_debugfs(card);
+
 	ret = snd_soc_register_card(card);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "Failed to register card\n");
@@ -1694,6 +1710,8 @@ static int soc_remove(struct platform_device *pdev)
 		for (i = 0; i < card->num_rtd; i++)
 			soc_remove_dai_link(card, i);
 
+		soc_cleanup_card_debugfs(card);
+
 		/* remove the card */
 		if (card->remove)
 			card->remove(pdev);
-- 
1.7.2.3
