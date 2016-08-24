From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 9/9] ASoC: Intel: Skylake: Add 32bit support
Date: Wed, 24 Aug 2016 18:03:21 +0530
Message-ID: <1472042001-9582-10-git-send-email-vinod.koul@intel.com>
References: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B5F782675AC
 for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2016 14:25:47 +0200 (CEST)
In-Reply-To: <1472042001-9582-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Samaga Krishna <samaga.krishna@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Samaga Krishna <samaga.krishna@intel.com>

We also support 32bit playback, so add that in DAI capabilities.

Signed-off-by: Samaga Krishna <samaga.krishna@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 77bfd407f2a1..c7cdcba04c5d 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -648,7 +648,8 @@ static struct snd_soc_dai_driver skl_platform_dai[] = {
 		.channels_min = HDA_MONO,
 		.channels_max = HDA_STEREO,
 		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_8000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE |
+			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE,
 	},
 	.capture = {
 		.stream_name = "System Capture",
-- 
1.9.1
