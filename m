From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 9/9] ASoC: Intel: Skylake: Remove unused CPU
	dai's
Date: Mon, 17 Aug 2015 22:56:44 +0530
Message-ID: <1439832404-12424-10-git-send-email-vinod.koul@intel.com>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 65AB6260448
 for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2015 19:25:02 +0200 (CEST)
In-Reply-To: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
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
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

We need to create CPU DAI for each endpoint instance. For this we
should have one DMIC DAI, one HDA DAI and SSP DAI.  Thus, DMIC23,
HDA-SPK/AMIC was not required so this patch removes them

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 3e491149bf0c..c96411dc89f5 100644
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
1.9.1
