From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: Skylake: remove IVI codec
	loop in skl_nau88l25_ssm4567 machine
Date: Tue,  1 Mar 2016 07:59:12 +0530
Message-ID: <1456799352-22653-4-git-send-email-vinod.koul@intel.com>
References: <1456799352-22653-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F21226149E
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 03:26:52 +0100 (CET)
In-Reply-To: <1456799352-22653-1-git-send-email-vinod.koul@intel.com>
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

The IVI loop is removed in skl_nau88l25_ssm4567 machine as we
enable this path thru DAPM graph using the PCM device and not
thru loop

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index f6a672c55be9..5f1ca99ae9b0 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -156,14 +156,6 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	{ "Headset Mic", NULL, "Platform Clock" },
 };
 
-static const struct snd_soc_pcm_stream skl_ssm4567_loop_params = {
-	.formats = SNDRV_PCM_FMTBIT_S24_LE,
-	.rate_min = 48000,
-	.rate_max = 48000,
-	.channels_min = 4,
-	.channels_max = 4,
-};
-
 static struct snd_soc_codec_conf ssm4567_codec_conf[] = {
 	{
 		.dev_name = "i2c-INT343B:00",
@@ -508,16 +500,6 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
-	/* Codec-codec link */
-	{
-		.name = "Skylake IV loop",
-		.stream_name = "SKL IV Loop",
-		.cpu_dai_name = "SSP0 Pin",
-		.platform_name = "0000:00:1f.3",
-		.codecs = ssm4567_codec_components,
-		.num_codecs = ARRAY_SIZE(ssm4567_codec_components),
-		.params = &skl_ssm4567_loop_params,
-	},
 
 	/* Back End DAI links */
 	{
-- 
1.9.1
