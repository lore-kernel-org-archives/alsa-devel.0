From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: dpcm: fix the BE state on hw_free
Date: Mon,  1 Feb 2016 22:26:40 +0530
Message-ID: <1454345800-13261-1-git-send-email-vinod.koul@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

While performing hw_free, DPCM checks the BE state but leaves out
the suspend state. The suspend state needs to be checked as well,
as we might be suspended and then usermode closes rather than
resuming the audio stream.

This was found by a stress testing of system with playback in
loop and killed after few seconds running in background and second
script running suspend-resume test in loop

Cc: stable@vger.kernel.org
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index bd5d3757acf6..659a7e9b2b81 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1753,7 +1753,8 @@ int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED) &&
-		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
 			continue;
 
 		dev_dbg(be->dev, "ASoC: hw_free BE %s\n",
-- 
1.9.1
