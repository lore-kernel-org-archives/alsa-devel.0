From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: kirkwood: make kirkwood_soc_platform
	const" to the asoc tree
Date: Wed, 27 Sep 2017 18:10:20 +0100 (BST)
Message-ID: <20170927171020.B0F14440056@finisterre.ee.mobilebroadband>
References: <1506528347-4370-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1051B266DE1
 for <alsa-devel@alsa-project.org>; Wed, 27 Sep 2017 19:10:52 +0200 (CEST)
In-Reply-To: <1506528347-4370-1-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, julia.lawall@lip6.fr, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: kirkwood: make kirkwood_soc_platform const

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

>From f5fe8c4589740bf45fd19c348e67981e977697cb Mon Sep 17 00:00:00 2001
From: Bhumika Goyal <bhumirks@gmail.com>
Date: Wed, 27 Sep 2017 21:35:47 +0530
Subject: [PATCH] ASoC: kirkwood: make kirkwood_soc_platform const

Make kirkwood_soc_platform const as it only passed to a const argument
of the function snd_soc_register_platform in the file referencing it.
Make the declaration const too.

Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/kirkwood/kirkwood-dma.c | 2 +-
 sound/soc/kirkwood/kirkwood.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index cf23af159acf..505b0ff03c3b 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -318,7 +318,7 @@ static void kirkwood_dma_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
-struct snd_soc_platform_driver kirkwood_soc_platform = {
+const struct snd_soc_platform_driver kirkwood_soc_platform = {
 	.ops		= &kirkwood_dma_ops,
 	.pcm_new	= kirkwood_dma_new,
 	.pcm_free	= kirkwood_dma_free_dma_buffers,
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index 90e32a781424..783cb1a4f30e 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -143,6 +143,6 @@ struct kirkwood_dma_data {
 	int burst;
 };
 
-extern struct snd_soc_platform_driver kirkwood_soc_platform;
+extern const struct snd_soc_platform_driver kirkwood_soc_platform;
 
 #endif
-- 
2.14.1
