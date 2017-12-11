From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v2 03/11] ASoC: Intel: Skylake: add HDA BE DAIs
Date: Mon, 11 Dec 2017 16:22:55 +0530
Message-ID: <1512989583-10877-4-git-send-email-rakesh.a.ughreja@intel.com>
References: <1512989583-10877-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 71CDB267558
 for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2017 11:48:38 +0100 (CET)
In-Reply-To: <1512989583-10877-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Add support for HDA BE DAIs in SKL platform driver.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 02cdb1c..6cd6640 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -956,21 +956,39 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 	},
 },
 {
-	.name = "HD-Codec Pin",
+	.name = "Analog CPU DAI",
 	.ops = &skl_link_dai_ops,
 	.playback = {
-		.stream_name = "HD-Codec Tx",
-		.channels_min = HDA_STEREO,
+		.stream_name = "Analog CPU Playback",
+		.channels_min = HDA_MONO,
 		.channels_max = HDA_STEREO,
 		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
 	},
 	.capture = {
-		.stream_name = "HD-Codec Rx",
-		.channels_min = HDA_STEREO,
+		.stream_name = "Analog CPU Capture",
+		.channels_min = HDA_MONO,
 		.channels_max = HDA_STEREO,
 		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+},
+{
+	.name = "Digital CPU DAI",
+	.ops = &skl_link_dai_ops,
+	.playback = {
+		.stream_name = "Digital CPU Playback",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+	.capture = {
+		.stream_name = "Digital CPU Capture",
+		.channels_min = HDA_MONO,
+		.channels_max = HDA_STEREO,
+		.rates = SNDRV_PCM_RATE_48000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
 	},
 },
 };
-- 
2.7.4
