From: yang.a.fang@intel.com
Subject: [PATCH 8/8] ASoc: Intel: boards: Add HDMI/DP links for
	nau88l25_ssm4567 machine
Date: Fri, 11 Dec 2015 11:29:13 -0800
Message-ID: <1449862153-68738-8-git-send-email-yang.a.fang@intel.com>
References: <1449862153-68738-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A47CF2666A9
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 20:31:22 +0100 (CET)
In-Reply-To: <1449862153-68738-1-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, rohit.m.ainapure@intel.com, james.ausmus@intel.com, vinod.koul@intel.com, joe.konno@intel.com, yang.a.fang@intel.com, sathyanarayana.nujella@intel.com, jeeja.kp@intel.com, vedang.patel@intel.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

From: "Fang, Yang A" <yang.a.fang@intel.com>

This machine supports HDMI/DP ports so add these ports and its FE and BE
DAIlinks

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c |   30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index f6c252c..c071812 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -93,6 +93,8 @@ static const struct snd_soc_dapm_widget skylake_widgets[] = {
 	SND_SOC_DAPM_SPK("Right Speaker", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
 	SND_SOC_DAPM_SINK("WoV Sink"),
+	SND_SOC_DAPM_SPK("DP", NULL),
+	SND_SOC_DAPM_SPK("HDMI", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
 			platform_clock_control, SND_SOC_DAPM_PRE_PMU |
 			SND_SOC_DAPM_POST_PMD),
@@ -112,6 +114,9 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	{"DMic", NULL, "SoC DMIC"},
 
 	{"WoV Sink", NULL, "hwd_in sink"},
+
+	{"HDMI", NULL, "hif5 Output"},
+	{"DP", NULL, "hif6 Output"},
 	/* CODEC BE connections */
 	{ "Left Playback", NULL, "ssp0 Tx"},
 	{ "Right Playback", NULL, "ssp0 Tx"},
@@ -126,6 +131,8 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	/* DMIC */
 	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
 	{ "DMIC01 Rx", NULL, "DMIC AIF" },
+	{ "hifi1", NULL, "iDisp Tx"},
+	{ "iDisp Tx", NULL, "iDisp_out"},
 	{ "Headphone Jack", NULL, "Platform Clock" },
 	{ "Headset Mic", NULL, "Platform Clock" },
 };
@@ -411,6 +418,19 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.dynamic = 1,
 		.ops = &skylake_dmic_ops,
 	},
+	{
+		.name = "Skl HDMI Port",
+		.stream_name = "Hdmi",
+		.cpu_dai_name = "HDMI Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.init = NULL,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+
 	/* Back End DAI links */
 	{
 		/* SSP0 - Codec */
@@ -459,6 +479,16 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.dpcm_capture = 1,
 		.no_pcm = 1,
 	},
+	{
+		.name = "iDisp",
+		.be_id = 3,
+		.cpu_dai_name = "iDisp Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi1",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+	},
 };
 
 /* skylake audio machine driver for SPT + NAU88L25 */
-- 
1.7.9.5
