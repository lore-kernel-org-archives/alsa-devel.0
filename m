From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: acpi_probe: fix error return path
Date: Wed, 18 Mar 2015 21:31:38 +0530
Message-ID: <1426694498-10811-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C1910260422
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 17:05:30 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

Fix the sst_acpi_probe memory allocation error path by setting right error
code and initiating the cleanup insteadof just returning

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/soc/intel/sst/sst_acpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
index b782dfdcdbba..b536ddd2517d 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -309,7 +309,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	ctx->shim_regs64 = devm_kzalloc(ctx->dev, sizeof(*ctx->shim_regs64),
 					GFP_KERNEL);
 	if (!ctx->shim_regs64) {
-		return -ENOMEM;
+		ret = -ENOMEM;
 		goto do_sst_cleanup;
 	}
 
-- 
1.7.9.5
