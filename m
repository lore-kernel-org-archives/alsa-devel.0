From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc.h: merge CONFIG_DEBUG_FS" to the
	asoc tree
Date: Wed,  9 May 2018 10:42:43 +0100 (BST)
Message-ID: <20180509094243.9A88244007A@finisterre.ee.mobilebroadband>
References: <87a7targ27.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7499F26774B
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 18:29:02 +0200 (CEST)
In-Reply-To: <87a7targ27.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc.h: merge CONFIG_DEBUG_FS

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From c8306238faf596ffdb01e5c96e0532be37a4a2a6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 May 2018 03:21:46 +0000
Subject: [PATCH] ASoC: soc.h: merge CONFIG_DEBUG_FS

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 21861f366dcb..600a7ebd10c0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -831,10 +831,6 @@ struct snd_soc_component {
 	/* attached dynamic objects */
 	struct list_head dobj_list;
 
-#ifdef CONFIG_DEBUG_FS
-	struct dentry *debugfs_root;
-#endif
-
 	/*
 	* DO NOT use any of the fields below in drivers, they are temporary and
 	* are going to be removed again soon. If you use them in driver code the
@@ -848,6 +844,7 @@ struct snd_soc_component {
 	int (*init)(struct snd_soc_component *component);
 
 #ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs_root;
 	const char *debugfs_prefix;
 #endif
 };
-- 
2.17.0
