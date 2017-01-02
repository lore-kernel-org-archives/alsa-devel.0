From: jeeja.kp@intel.com
Subject: [PATCH 1/6] ASoC: Intel: Common: Update dsp register
	poll implementation
Date: Mon,  2 Jan 2017 09:50:02 +0530
Message-ID: <1483330807-9518-2-git-send-email-jeeja.kp@intel.com>
References: <1483330807-9518-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AA5A2666EC
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 05:09:23 +0100 (CET)
In-Reply-To: <1483330807-9518-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, Jayachandran B <jayachandran.b@intel.com>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Poll implementation is not quite accurate, especially for smaller
values of timeout or timeout values close to the actual timeout needed

Use jiffies to set the timeout value and time_before() to get the
accurate time. So update the dsp register poll implementation to
provide accurate timeout using jiffies.

Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/common/sst-dsp.c | 52 ++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/sound/soc/intel/common/sst-dsp.c b/sound/soc/intel/common/sst-dsp.c
index c00ede4..11c0805 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -252,44 +252,44 @@ void sst_dsp_shim_update_bits_forced(struct sst_dsp *sst, u32 offset,
 EXPORT_SYMBOL_GPL(sst_dsp_shim_update_bits_forced);
 
 int sst_dsp_register_poll(struct sst_dsp *ctx, u32 offset, u32 mask,
-			 u32 target, u32 timeout, char *operation)
+			 u32 target, u32 time, char *operation)
 {
-	int time, ret;
 	u32 reg;
-	bool done = false;
+	unsigned long timeout;
+	int k = 0, s = 500;
 
 	/*
-	 * we will poll for couple of ms using mdelay, if not successful
-	 * then go to longer sleep using usleep_range
+	 * split the loop into sleeps of varying resolution. more accurately,
+	 * the range of wakeups are:
+	 * Phase 1(first 5ms): min sleep 0.5ms; max sleep 1ms.
+	 * Phase 2:( 5ms to 10ms) : min sleep 0.5ms; max sleep 10ms
+	 * (usleep_range (500, 1000) and usleep_range(5000, 10000) are
+	 * both possible in this phase depending on whether k > 10 or not).
+	 * Phase 3: (beyond 10 ms) min sleep 5ms; max sleep 10ms.
 	 */
 
-	/* check if set state successful */
-	for (time = 0; time < 5; time++) {
-		if ((sst_dsp_shim_read_unlocked(ctx, offset) & mask) == target) {
-			done = true;
-			break;
-		}
-		mdelay(1);
+	timeout = jiffies + msecs_to_jiffies(time);
+	while (((sst_dsp_shim_read_unlocked(ctx, offset) & mask) != target)
+		&& time_before(jiffies, timeout)) {
+		k++;
+		if (k > 10)
+			s = 5000;
+
+		usleep_range(s, 2*s);
 	}
 
-	if (done ==  false) {
-		/* sleeping in 10ms steps so adjust timeout value */
-		timeout /= 10;
+	reg = sst_dsp_shim_read_unlocked(ctx, offset);
 
-		for (time = 0; time < timeout; time++) {
-			if ((sst_dsp_shim_read_unlocked(ctx, offset) & mask) == target)
-				break;
+	if ((reg & mask) == target) {
+		dev_dbg(ctx->dev, "FW Poll Status: reg=%#x %s successful\n",
+					reg, operation);
 
-			usleep_range(5000, 10000);
-		}
+		return 0;
 	}
 
-	reg = sst_dsp_shim_read_unlocked(ctx, offset);
-	dev_dbg(ctx->dev, "FW Poll Status: reg=%#x %s %s\n", reg, operation,
-			(time < timeout) ? "successful" : "timedout");
-	ret = time < timeout ? 0 : -ETIME;
-
-	return ret;
+	dev_dbg(ctx->dev, "FW Poll Status: reg=%#x %s timedout\n",
+					reg, operation);
+	return -ETIME;
 }
 EXPORT_SYMBOL_GPL(sst_dsp_register_poll);
 
-- 
2.5.0
