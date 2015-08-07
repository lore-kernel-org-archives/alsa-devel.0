From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 13/13] ASoC: Intel: Skylake: Remove CPU dai
	that is not used
Date: Fri,  7 Aug 2015 23:52:29 +0530
Message-ID: <1438971749-874-14-git-send-email-subhransu.s.prusty@intel.com>
References: <1438971749-874-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C0852650DA
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 20:23:43 +0200 (CEST)
In-Reply-To: <1438971749-874-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

For each endpoint instance, need to create CPU dai,
Removed unused CPU dai DMIC23/HDA-SPK/HDA-AMIC dais.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 045c7d4..22ab7ac 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -579,17 +579,6 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	},
 },
 {
-	.name = "DMIC23 Pin",
-	.ops = &skl_dmic_dai_ops,
-	.capture = {
-		.stream_name = "DMIC23 Rx",
-		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
-		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
-	},
-},
-{
 	.name = "HD-Codec Pin",
 	.ops = &skl_link_dai_ops,
 	.playback = {
@@ -607,28 +596,6 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 },
-{
-	.name = "HD-Codec-SPK Pin",
-	.ops = &skl_link_dai_ops,
-	.playback = {
-		.stream_name = "HD-Codec-SPK Tx",
-		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	},
-},
-{
-	.name = "HD-Codec-AMIC Pin",
-	.ops = &skl_link_dai_ops,
-	.capture = {
-		.stream_name = "HD-Codec-AMIC Rx",
-		.channels_min = HDA_STEREO,
-		.channels_max = HDA_STEREO,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
-	},
-},
 };
 
 static int skl_platform_open(struct snd_pcm_substream *substream)
-- 
2.4.3
