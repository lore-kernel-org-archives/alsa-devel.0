From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH v2 1/6] ASoC: Intel: Skylake: Remove second
	shim read in register_poll
Date: Wed,  6 Dec 2017 16:34:01 +0530
Message-ID: <20171206110406.11400-2-guneshwor.o.singh@intel.com>
References: <20171206110406.11400-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CF7C2678CD
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 12:04:36 +0100 (CET)
In-Reply-To: <20171206110406.11400-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

No need to read the register again if the value read has already matched
the target during the loop. So remove the second shim read.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/common/sst-dsp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index 11c0805393ff..fd82f4b1d4a0 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -269,7 +269,7 @@ int sst_dsp_register_poll(struct sst_dsp *ctx, u32 offset, u32 mask,
 	 */
 
 	timeout = jiffies + msecs_to_jiffies(time);
-	while (((sst_dsp_shim_read_unlocked(ctx, offset) & mask) != target)
+	while ((((reg = sst_dsp_shim_read_unlocked(ctx, offset)) & mask) != target)
 		&& time_before(jiffies, timeout)) {
 		k++;
 		if (k > 10)
@@ -278,8 +278,6 @@ int sst_dsp_register_poll(struct sst_dsp *ctx, u32 offset, u32 mask,
 		usleep_range(s, 2*s);
 	}
 
-	reg = sst_dsp_shim_read_unlocked(ctx, offset);
-
 	if ((reg & mask) == target) {
 		dev_dbg(ctx->dev, "FW Poll Status: reg=%#x %s successful\n",
 					reg, operation);
-- 
2.15.1
