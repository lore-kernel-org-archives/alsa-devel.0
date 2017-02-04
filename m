From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Drop unnecessary debugfs ifdef" to the
	asoc tree
Date: Sat, 04 Feb 2017 12:26:40 +0100
Message-ID: <E1cZyUK-00025z-Jl@finisterre>
References: <1485956255-19784-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 647B92606F7
 for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2017 12:27:11 +0100 (CET)
In-Reply-To: <1485956255-19784-1-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Drop unnecessary debugfs ifdef

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

>From d6075c2601800a8a45bf6f7c3d87afa8598779b5 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Wed, 1 Feb 2017 15:37:35 +0200
Subject: [PATCH] ASoC: Drop unnecessary debugfs ifdef

This is a relict of 6553bf06a369 ("ASoC: Don't try to register debugfs
entries if the parent does not exist").

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f1901bb1466e..7728cce019f9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4020,8 +4020,6 @@ static void __exit snd_soc_exit(void)
 	snd_soc_util_exit();
 	snd_soc_debugfs_exit();
 
-#ifdef CONFIG_DEBUG_FS
-#endif
 	platform_driver_unregister(&soc_driver);
 }
 module_exit(snd_soc_exit);
-- 
2.11.0
