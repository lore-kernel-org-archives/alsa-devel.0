From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: Remove unneeded dentry member
	from snd_soc_codec" to the asoc tree
Date: Mon, 07 Aug 2017 16:53:12 +0100
Message-ID: <E1dekLA-0005Uc-0T@debutante>
References: <1502075586-23581-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 925F0267459
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 17:53:19 +0200 (CEST)
In-Reply-To: <1502075586-23581-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: Remove unneeded dentry member from snd_soc_codec

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 353c64dd19ebc99786c3578ea0444e1b5b1bb172 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 7 Aug 2017 09:08:52 -0300
Subject: [PATCH] ASoC: soc-core: Remove unneeded dentry member from
 snd_soc_codec

There is no need to have the *debugfs_reg dentry member as part of
the snd_soc_codec structure as its only usage is inside
soc_init_codec_debugfs().

Use a local dentry variable instead.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 4 ----
 sound/soc/soc-core.c | 9 +++++----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 10b71beb9f13..aad3f14966f1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -903,10 +903,6 @@ struct snd_soc_codec {
 
 	/* component */
 	struct snd_soc_component component;
-
-#ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_reg;
-#endif
 };
 
 /* codec driver */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 921622a01944..558efdfd717d 100644
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
2.13.3
