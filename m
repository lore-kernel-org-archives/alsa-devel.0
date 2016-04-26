From: vedang.patel@intel.com
Subject: [PATCH v2 2/3] ASoC: Intel: common: increase the
	loglevel of "FW Poll Status".
Date: Tue, 26 Apr 2016 16:03:09 -0700
Message-ID: <1461711790-7277-3-git-send-email-vedang.patel@intel.com>
References: <1460498902-30454-4-git-send-email-vedang.patel@intel.com>
 <1461711790-7277-1-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E03A26589A
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 01:03:23 +0200 (CEST)
In-Reply-To: <1461711790-7277-1-git-send-email-vedang.patel@intel.com>
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

Change-Id: I26fbd7bb66b68f4319d08b6bd4e604b519df1a9e
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
