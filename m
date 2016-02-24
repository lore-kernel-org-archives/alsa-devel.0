From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 6/7] ASoC: Intel: boards: Remove WoV sink in
	nau88125_ssm4567 machine
Date: Wed, 24 Feb 2016 11:27:43 +0530
Message-ID: <1456293464-19646-7-git-send-email-vinod.koul@intel.com>
References: <1456293464-19646-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 192E7266742
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
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 68caf24f9fbd..a75c09343f84 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -103,7 +103,6 @@ static const struct snd_soc_dapm_widget skylake_widgets[] = {
 	SND_SOC_DAPM_SPK("Left Speaker", NULL),
 	SND_SOC_DAPM_SPK("Right Speaker", NULL),
 	SND_SOC_DAPM_MIC("SoC DMIC", NULL),
-	SND_SOC_DAPM_SINK("WoV Sink"),
 	SND_SOC_DAPM_SPK("DP", NULL),
 	SND_SOC_DAPM_SPK("HDMI", NULL),
 	SND_SOC_DAPM_SUPPLY("Platform Clock", SND_SOC_NOPM, 0, 0,
@@ -124,8 +123,6 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	{"MIC", NULL, "Headset Mic"},
 	{"DMic", NULL, "SoC DMIC"},
 
-	{"WoV Sink", NULL, "hwd_in sink"},
-
 	{"HDMI", NULL, "hif5 Output"},
 	{"DP", NULL, "hif6 Output"},
 	/* CODEC BE connections */
@@ -225,7 +222,6 @@ static int skylake_nau8825_codec_init(struct snd_soc_pcm_runtime *rtd)
 	nau8825_enable_jack_detect(codec, &skylake_headset);
 
 	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
-	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "WoV Sink");
 
 	return ret;
 }
-- 
1.9.1
