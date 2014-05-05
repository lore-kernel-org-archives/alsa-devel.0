From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 5/8] ASoC: Intel: remove unused sst-mfld
	platform dais
Date: Mon,  5 May 2014 22:19:22 +0530
Message-ID: <1399308565-14620-6-git-send-email-vinod.koul@intel.com>
References: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 09B432619E9
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 19:02:56 +0200 (CEST)
In-Reply-To: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, jeeja.kp@intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

With DPCM we have media dai used and no sperate headset and speaker dai so
remove the speaker dai
The vibra is no longer supported thru audio, so remove

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c |   30 ------------------------------
 1 files changed, 0 insertions(+), 30 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 2beb959..3f9cd77 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -111,36 +111,6 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
 	},
 },
 {
-	.name = "Speaker-cpu-dai",
-	.id = 1,
-	.playback = {
-		.channels_min = SST_MONO,
-		.channels_max = SST_STEREO,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S24_LE,
-	},
-},
-{
-	.name = "Vibra1-cpu-dai",
-	.id = 2,
-	.playback = {
-		.channels_min = SST_MONO,
-		.channels_max = SST_MONO,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S24_LE,
-	},
-},
-{
-	.name = "Vibra2-cpu-dai",
-	.id = 3,
-	.playback = {
-		.channels_min = SST_MONO,
-		.channels_max = SST_STEREO,
-		.rates = SNDRV_PCM_RATE_48000,
-		.formats = SNDRV_PCM_FMTBIT_S24_LE,
-	},
-},
-{
 	.name = "Compress-cpu-dai",
 	.compress_dai = 1,
 	.playback = {
-- 
1.7.0.4
