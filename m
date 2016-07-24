From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Fix NULL Pointer
	exception in dynamic_debug." to the asoc tree
Date: Sun, 24 Jul 2016 22:06:19 +0100
Message-ID: <E1bRQbL-0003yi-5e@debutante>
References: <1469233043-91023-1-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5239626582D
 for <alsa-devel@alsa-project.org>; Sun, 24 Jul 2016 23:06:31 +0200 (CEST)
In-Reply-To: <1469233043-91023-1-git-send-email-vedang.patel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vedang Patel <vedang.patel@intel.com>
Cc: vinod.koul@intel.com, jeeja.kp@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Fix NULL Pointer exception in dynamic_debug.

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

>From 96bd6033c2046ffc3f88de422be831c1d68ace14 Mon Sep 17 00:00:00 2001
From: Vedang Patel <vedang.patel@intel.com>
Date: Fri, 22 Jul 2016 17:17:23 -0700
Subject: [PATCH] ASoC: Intel: Skylake: Fix NULL Pointer exception in
 dynamic_debug.

The following bug was reported by sometime back:

https://lkml.org/lkml/2016/6/29/795

This commit fixes this bug by setting value for the prefix string.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-ipc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index c141f24cae05..96f2f6889b18 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -692,7 +692,7 @@ int skl_ipc_init_instance(struct sst_generic_ipc *ipc,
 	 /* param_block_size must be in dwords */
 	u16 param_block_size = msg->param_data_size / sizeof(u32);
 
-	print_hex_dump_debug(NULL, DUMP_PREFIX_NONE,
+	print_hex_dump_debug("Param data:", DUMP_PREFIX_NONE,
 		16, 4, buffer, param_block_size, false);
 
 	header.primary = IPC_MSG_TARGET(IPC_MOD_MSG);
-- 
2.8.1
