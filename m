From: Naveen M <naveen.m@intel.com>
Subject: [PATCH 1/3] ASoC: Intel: kbl: Add new FEs for
	Multi-Playback & Echo-Reference
Date: Wed,  2 Aug 2017 11:43:33 +0530
Message-ID: <1501654415-24590-2-git-send-email-naveen.m@intel.com>
References: <1501654415-24590-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 64043267026
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 08:13:25 +0200 (CEST)
In-Reply-To: <1501654415-24590-1-git-send-email-naveen.m@intel.com>
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Adding new frontends to support:
1. Parallel playback on 2 ports simultaneously
2. Echo reference capture capability

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 0ebea34a..f18b4c9 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -675,6 +675,32 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 	},
 },
 {
+	.name = "System Pin2",
+	.ops = &skl_pcm_dai_ops,
+	.playback = {
+		.stream_name = "Headset Playback",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000 |
+			SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	},
+},
+{
+	.name = "Echoref Pin",
+	.ops = &skl_pcm_dai_ops,
+	.capture = {
+		.stream_name = "Echoreference Capture",
+		.channels_min = HDA_STEREO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000 |
+			SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	},
+},
+{
 	.name = "Reference Pin",
 	.ops = &skl_pcm_dai_ops,
 	.capture = {
-- 
1.9.1
