From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: core - Codec debugfs init to use
	dev_warn()
Date: Wed, 15 Feb 2012 15:15:37 +0000
Message-ID: <1329318937-14488-4-git-send-email-lrg@ti.com>
References: <1329318937-14488-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 215BF103E0A
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 16:21:29 +0100 (CET)
Received: by mail-wi0-f177.google.com with SMTP id o1so708346wic.36
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 07:21:10 -0800 (PST)
In-Reply-To: <1329318937-14488-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Update the codec debugfs initialisation to use dev_warn() instead of
printk(KERN_WARNING).

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-core.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e1d6bfc..957b5ed 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -277,8 +277,7 @@ static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 	codec->debugfs_codec_root = debugfs_create_dir(codec->name,
 						       debugfs_card_root);
 	if (!codec->debugfs_codec_root) {
-		printk(KERN_WARNING
-		       "ASoC: Failed to create codec debugfs directory\n");
+		dev_warn(codec->dev, "Failed to create codec debugfs directory\n");
 		return;
 	}
 
@@ -291,8 +290,7 @@ static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
 						 codec->debugfs_codec_root,
 						 codec, &codec_reg_fops);
 	if (!codec->debugfs_reg)
-		printk(KERN_WARNING
-		       "ASoC: Failed to create codec register debugfs file\n");
+		dev_warn(codec->dev, "Failed to create codec register debugfs file\n");
 
 	snd_soc_dapm_debugfs_init(&codec->dapm, codec->debugfs_codec_root);
 }
-- 
1.7.5.4
