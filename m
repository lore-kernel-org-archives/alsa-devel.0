From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] soundwire: intel: Remove duplicate assignment
Date: Tue,  7 Aug 2018 17:28:37 +0530
Message-ID: <20180807115837.8172-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 81EF2267865
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2018 14:08:36 +0200 (CEST)
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
Cc: Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/intel.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index da7f91f1a588..c5ee97ee7886 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -845,9 +845,6 @@ static int intel_probe(struct platform_device *pdev)
 	sdw_intel_ops.read_prop = intel_prop_read;
 	sdw->cdns.bus.ops = &sdw_intel_ops;
 
-	sdw_intel_ops.read_prop = intel_prop_read;
-	sdw->cdns.bus.ops = &sdw_intel_ops;
-
 	platform_set_drvdata(pdev, sdw);
 
 	ret = sdw_add_bus_master(&sdw->cdns.bus);
-- 
2.14.4
