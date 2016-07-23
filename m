From: vedang.patel@intel.com
Subject: [PATCH] ASoC: Intel: Skylake: Fix NULL Pointer
	exception in dynamic_debug.
Date: Fri, 22 Jul 2016 17:17:23 -0700
Message-ID: <1469233043-91023-1-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 69B8D265713
 for <alsa-devel@alsa-project.org>; Sat, 23 Jul 2016 02:17:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, jeeja.kp@intel.com, broonie@kernel.org, Vedang Patel <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

The following bug was reported by sometime back:

https://lkml.org/lkml/2016/6/29/795

This commit fixes this bug by setting value for the prefix string.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
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
2.6.6
