From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: fix inversion between
	__iowrite32 and __ioread32" to the asoc tree
Date: Wed, 25 Jul 2018 17:40:02 +0100 (BST)
Message-ID: <20180725164002.7D9801123B08@debutante.sirena.org.uk>
References: <20180724211248.29427-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4253E267757
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 18:40:04 +0200 (CEST)
In-Reply-To: <20180724211248.29427-7-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: fix inversion between __iowrite32 and __ioread32

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

>From 9a0daaab31e9e39047ced79409313c34dae4635a Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 24 Jul 2018 16:12:48 -0500
Subject: [PATCH] ASoC: Intel: Atom: fix inversion between __iowrite32 and
 __ioread32

This looks like a copy/paste issue, but clearly there is an inversion
that is obvious when checking the arguments.

Detected with Sparse - now that we have fewer warnings this one was
easy to find.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst/sst_loader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index a686eef2cf7f..27413ebae956 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -44,15 +44,15 @@ void memcpy32_toio(void __iomem *dst, const void *src, int count)
 	/* __iowrite32_copy uses 32-bit count values so divide by 4 for
 	 * right count in words
 	 */
-	__iowrite32_copy(dst, src, count/4);
+	__iowrite32_copy(dst, src, count / 4);
 }
 
 void memcpy32_fromio(void *dst, const void __iomem *src, int count)
 {
-	/* __iowrite32_copy uses 32-bit count values so divide by 4 for
+	/* __ioread32_copy uses 32-bit count values so divide by 4 for
 	 * right count in words
 	 */
-	__iowrite32_copy(dst, src, count/4);
+	__ioread32_copy(dst, src, count / 4);
 }
 
 /**
-- 
2.18.0
