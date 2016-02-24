From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 5/7] ASoC: Intel: boards: Remove WoV sink in
	skl_rt286
Date: Wed, 24 Feb 2016 11:27:42 +0530
Message-ID: <1456293464-19646-6-git-send-email-vinod.koul@intel.com>
References: <1456293464-19646-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id DD17C26668D
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

WoV module needs to be triggered with PCM open, so remove this as
DAPM Sink and will be connected to FE

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_rt286.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 00b84c1ff07f..2016397a8e75 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -64,7 +64,6 @@ static const struct snd_soc_dapm_widget skylake_widgets[] = {
 	SND_SOC_DAPM_MIC("Mic Jack", NULL),
 	SND_SOC_DAPM_MIC("DMIC2", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
-	SND_SOC_DAPM_SINK("WoV Sink"),
 	SND_SOC_DAPM_SPK("HDMI1", NULL),
 	SND_SOC_DAPM_SPK("HDMI2", NULL),
 	SND_SOC_DAPM_SPK("HDMI3", NULL),
@@ -85,8 +84,6 @@ static const struct snd_soc_dapm_route skylake_rt286_map[] = {
 	{"DMIC1 Pin", NULL, "DMIC2"},
 	{"DMic", NULL, "SoC DMIC"},
 
-	{"WoV Sink", NULL, "hwd_in sink"},
-
 	{"HDMI1", NULL, "hif5 Output"},
 	{"HDMI2", NULL, "hif6 Output"},
 	{"HDMI3", NULL, "hif7 Output"},
@@ -139,7 +136,6 @@ static int skylake_rt286_codec_init(struct snd_soc_pcm_runtime *rtd)
 	rt286_mic_detect(codec, &skylake_headset);
 
 	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
-	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "WoV Sink");
 
 	return 0;
 }
-- 
1.9.1
