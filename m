From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix return of
	skl_get_queue_index" to the asoc tree
Date: Thu, 04 Feb 2016 12:16:14 +0000
Message-ID: <E1aRIpa-0001Dh-Fp@debutante>
References: <1454502594-21700-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5B1D261B23
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 13:16:19 +0100 (CET)
In-Reply-To: <1454502594-21700-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix return of skl_get_queue_index

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

>From 9cf3049e21e4e6873aae45df19c11f7243e2f03f Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Wed, 3 Feb 2016 17:59:48 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Fix return of skl_get_queue_index

In unbind modules, the skl_get_queue_index() can return error
if the pin is dynamic and module is not bound yet. So instead
of returning error this check should return success as modules
is not yet bound. This will let the module be bound when connected
pipes are enabled and will bind this as well.

So change the return value to 0

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-messages.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index de6dac496a0d..bb5f1d7d0cad 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -688,14 +688,14 @@ int skl_unbind_modules(struct skl_sst *ctx,
 	/* get src queue index */
 	src_index = skl_get_queue_index(src_mcfg->m_out_pin, dst_id, out_max);
 	if (src_index < 0)
-		return -EINVAL;
+		return 0;
 
 	msg.src_queue = src_index;
 
 	/* get dst queue index */
 	dst_index  = skl_get_queue_index(dst_mcfg->m_in_pin, src_id, in_max);
 	if (dst_index < 0)
-		return -EINVAL;
+		return 0;
 
 	msg.dst_queue = dst_index;
 
-- 
2.7.0.rc3
