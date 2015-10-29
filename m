From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Skylake: Fix the SSP0 Fmt
	fixup to 24 bit
Date: Thu, 29 Oct 2015 12:31:34 +0900
Message-ID: <1446089495-31250-1-git-send-email-vinod.koul@intel.com>
References: <1445905380-18167-18-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4811526531F
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 04:31:53 +0100 (CET)
In-Reply-To: <1445905380-18167-18-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

SSP0 FMT uses 24 bits so fix to the value to 24 bits

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_rt286.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index a73a431bd8b7..e6af48491229 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -112,12 +112,15 @@ static int skylake_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 			SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
 						SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 
 	/* The output is 48KHz, stereo, 16bits */
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
-	params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
 
+	/* set SSP0 to 24 bit */
+	snd_mask_none(fmt);
+	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
 	return 0;
 }
 
-- 
2.4.3
