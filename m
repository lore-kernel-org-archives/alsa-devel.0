From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/3] ASoC: Move codec debugfs directories under
	parent card directory
Date: Fri,  5 Nov 2010 20:35:20 +0200
Message-ID: <1288982121-22201-3-git-send-email-jhnikula@gmail.com>
References: <1288982121-22201-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AD66610380F
	for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2010 19:35:23 +0100 (CET)
Received: by mail-ey0-f179.google.com with SMTP id 24so1917808eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 05 Nov 2010 11:35:23 -0700 (PDT)
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

Make use of sound card debugfs directory and move codec directories under
the parent card debugfs directory.

debugfs/asoc/{codec dir} -> debugfs/asoc/{card->name}/{codec dir}.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/soc-core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3819659..a358ce9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -238,8 +238,10 @@ static const struct file_operations codec_reg_fops = {
 
 static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 {
-	codec->debugfs_codec_root = debugfs_create_dir(codec->name ,
-						       debugfs_root);
+	struct dentry *debugfs_card_root = codec->card->debugfs_card_root;
+
+	codec->debugfs_codec_root = debugfs_create_dir(codec->name,
+						       debugfs_card_root);
 	if (!codec->debugfs_codec_root) {
 		printk(KERN_WARNING
 		       "ASoC: Failed to create codec debugfs directory\n");
-- 
1.7.2.3
