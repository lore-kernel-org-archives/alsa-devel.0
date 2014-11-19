From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ASoC: Intel: cleanup runtime_pm
	initialization
Date: Wed, 19 Nov 2014 15:13:26 +0530
Message-ID: <1416390207-11020-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 45FAF26053C
 for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2014 10:49:35 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

For ACPI we missed to pm_runtime_enable() call which is required to tell PM
core that runtime on this device is enabled now. Since this is common to
both PCI and APCI move it out. Also for ACPI we do not require
pm_runtime_allow() call, so remove that

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/sst/sst.c b/sound/soc/intel/sst/sst.c
index b2b5604..9e68a7c 100644
--- a/sound/soc/intel/sst/sst.c
+++ b/sound/soc/intel/sst/sst.c
@@ -378,13 +378,13 @@ void sst_configure_runtime_pm(struct intel_sst_drv *ctx)
 	 * initially active. So change the state to active before
 	 * enabling the pm
 	 */
-	if (acpi_disabled) {
+	pm_runtime_enable(ctx->dev);
+
+	if (acpi_disabled)
 		pm_runtime_set_active(ctx->dev);
-		pm_runtime_enable(ctx->dev);
-	} else {
-		pm_runtime_allow(ctx->dev);
+	else
 		pm_runtime_put_noidle(ctx->dev);
-	}
+
 	sst_save_shim64(ctx, ctx->shim, ctx->shim_regs64);
 }
 EXPORT_SYMBOL_GPL(sst_configure_runtime_pm);
-- 
1.7.0.4
