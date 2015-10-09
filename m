From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/4] ASoC: Intel: Skylake: Check CPA bit in DSP
	core power down
Date: Fri,  9 Oct 2015 09:01:48 +0100
Message-ID: <1444377711-9720-2-git-send-email-vinod.koul@intel.com>
References: <1444377711-9720-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 71414261A34
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 10:02:12 +0200 (CEST)
In-Reply-To: <1444377711-9720-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Skylake driver will set the SPA bit to 0 to turn off the DSP core.
Driver will poll the Current Power Active (CPA) bit to match the
Set Power Active (SPA) bit value. When CPA bit matches the value
of SPA bit, the achieved power state has reached.

In case of DSP power down, register that was polled is SPA
instead of CPA. This patch corrects the register to be polled
in case of DSP power down.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-sst-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-dsp.c b/sound/soc/intel/skylake/skl-sst-dsp.c
index 94875b008b0b..194bd0036454 100644
--- a/sound/soc/intel/skylake/skl-sst-dsp.c
+++ b/sound/soc/intel/skylake/skl-sst-dsp.c
@@ -175,7 +175,7 @@ static int skl_dsp_core_power_down(struct sst_dsp  *ctx)
 	/* poll with timeout to check if operation successful */
 	return sst_dsp_register_poll(ctx,
 			SKL_ADSP_REG_ADSPCS,
-			SKL_ADSPCS_SPA_MASK,
+			SKL_ADSPCS_CPA_MASK,
 			0,
 			SKL_DSP_PD_TO,
 			"Power down");
-- 
2.4.3
