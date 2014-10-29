From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: dw_pdata can be static
Date: Wed, 29 Oct 2014 15:40:27 +0000
Message-ID: <1414597228-7070-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B2E632604D4
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 16:41:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: kbuild test robot <fengguang.wu@intel.com>

sound/soc/intel/sst-firmware.c:172:29: sparse: symbol 'dw_pdata' was not declared. Should it be static?

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 sound/soc/intel/sst-firmware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst-firmware.c b/sound/soc/intel/sst-firmware.c
index 692a6ae..35788ad 100644
--- a/sound/soc/intel/sst-firmware.c
+++ b/sound/soc/intel/sst-firmware.c
@@ -169,7 +169,7 @@ err:
 	return ret;
 }
 
-struct dw_dma_platform_data dw_pdata = {
+static struct dw_dma_platform_data dw_pdata = {
 	.is_private = 1,
 	.chan_allocation_order = CHAN_ALLOCATION_ASCENDING,
 	.chan_priority = CHAN_PRIORITY_ASCENDING,
-- 
2.1.0
