From: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] soundwire: intel: remove unused variables
Date: Thu, 22 Aug 2019 11:55:55 +0530
Message-ID: <20190822062555.30216-1-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20251F80147
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2019 08:27:33 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

Variables 'nval' and 'i' are no longer used sdw_master_read_intel_prop()
so remove them.

drivers/soundwire/intel.c: In function 'sdw_master_read_intel_prop':
drivers/soundwire/intel.c:829:12: warning: unused variable 'i' [-Wunused-variable]
  int nval, i;
            ^
drivers/soundwire/intel.c:829:6: warning: unused variable 'nval' [-Wunused-variable]
  int nval, i;
      ^~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 085f4ace103d ("soundwire: intel: read mclk_freq property from firmware")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/soundwire/intel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 459cc1e6355d..cad378f741c0 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -826,7 +826,6 @@ static int sdw_master_read_intel_prop(struct sdw_bus *bus)
 	struct sdw_master_prop *prop = &bus->prop;
 	struct fwnode_handle *link;
 	char name[32];
-	int nval, i;
 
 	/* Find master handle */
 	snprintf(name, sizeof(name),
-- 
2.20.1
