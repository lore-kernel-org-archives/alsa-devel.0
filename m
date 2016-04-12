From: vedang.patel@intel.com
Subject: [PATCH 2/3] ASoC: Intel: common: increase the loglevel
	of "FW Poll Status".
Date: Tue, 12 Apr 2016 15:08:21 -0700
Message-ID: <1460498902-30454-3-git-send-email-vedang.patel@intel.com>
References: <1460498902-30454-1-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 632672650F2
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 00:08:46 +0200 (CEST)
In-Reply-To: <1460498902-30454-1-git-send-email-vedang.patel@intel.com>
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
Cc: vinod.koul@intel.com, marc.herbert@intel.com, liam.r.girdwood@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com, Vedang Patel <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

For consistency with other log statements, change dev_info to dev_dbg
for a kernel print which is frequently printed by the driver.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 sound/soc/intel/common/sst-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index b5bbdf4..ff2196e 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -285,7 +285,7 @@ int sst_dsp_register_poll(struct sst_dsp *ctx, u32 offset, u32 mask,
 	}
 
 	reg = sst_dsp_shim_read_unlocked(ctx, offset);
-	dev_info(ctx->dev, "FW Poll Status: reg=%#x %s %s\n", reg, operation,
+	dev_dbg(ctx->dev, "FW Poll Status: reg=%#x %s %s\n", reg, operation,
 			(time < timeout) ? "successful" : "timedout");
 	ret = time < timeout ? 0 : -ETIME;
 
-- 
2.1.2
