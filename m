From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/7] ASoC: Intel: boards: Add IV feedback route
	for nau88l25_ssm4567 machine
Date: Wed, 24 Feb 2016 11:27:41 +0530
Message-ID: <1456293464-19646-5-git-send-email-vinod.koul@intel.com>
References: <1456293464-19646-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 90B8926667C
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 06:54:06 +0100 (CET)
In-Reply-To: <1456293464-19646-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Sathya Prakash M R <sathya.prakash.m.r@intel.com>

SSM4567 supports IV feedback for feedback to the speaker
protection algorithm

Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index ccc3d4a4f4b6..68caf24f9fbd 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -133,6 +133,9 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	{ "Right Playback", NULL, "ssp0 Tx"},
 	{ "ssp0 Tx", NULL, "codec0_out"},
 
+	/* IV feedback path */
+	{ "codec0_lp_in", NULL, "ssp0 Rx"},
+
 	{ "Playback", NULL, "ssp1 Tx"},
 	{ "ssp1 Tx", NULL, "codec1_out"},
 
@@ -154,6 +157,14 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	{ "Headset Mic", NULL, "Platform Clock" },
 };
 
+static const struct snd_soc_pcm_stream skl_ssm4567_loop_params = {
+	.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	.rate_min = 48000,
+	.rate_max = 48000,
+	.channels_min = 4,
+	.channels_max = 4,
+};
+
 static struct snd_soc_codec_conf ssm4567_codec_conf[] = {
 	{
 		.dev_name = "i2c-INT343B:00",
@@ -499,6 +510,16 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
+	/* Codec-codec link */
+	{
+		.name = "Skylake IV loop",
+		.stream_name = "SKL IV Loop",
+		.cpu_dai_name = "SSP0 Pin",
+		.platform_name = "0000:00:1f.3",
+		.codecs = ssm4567_codec_components,
+		.num_codecs = ARRAY_SIZE(ssm4567_codec_components),
+		.params = &skl_ssm4567_loop_params,
+	},
 
 	/* Back End DAI links */
 	{
-- 
1.9.1
