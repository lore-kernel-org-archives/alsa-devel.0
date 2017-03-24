From: jeeja.kp@intel.com
Subject: [PATCH v2 04/11] ASoC: Intel: Skylake: Add 16-bit
	constraint to FE bxt_rt298 machine
Date: Fri, 24 Mar 2017 23:10:27 +0530
Message-ID: <1490377234-30257-5-git-send-email-jeeja.kp@intel.com>
References: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D0DE02674CC
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 18:28:27 +0100 (CET)
In-Reply-To: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, G Kranthi <gudishax.kranthikumar@intel.com>, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: G Kranthi <gudishax.kranthikumar@intel.com>

Add constraint to FE to restrict sample format to 16-bit for bxt_rt298
machine

Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/intel/boards/bxt_rt298.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 176c080..1a68d04 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -274,12 +274,15 @@ static int bxt_fe_startup(struct snd_pcm_substream *substream)
 	 * on this platform for PCM device we support:
 	 *      48Khz
 	 *      stereo
+	 *	16-bit audio
 	 */
 
 	runtime->hw.channels_max = 2;
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
 				&constraints_channels);
 
+	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
+	snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
 	snd_pcm_hw_constraint_list(runtime, 0,
 				SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
 
-- 
2.5.0
