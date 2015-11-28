From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 16/16] ASoc: Intel: Skylake: Fix the dapm
	machine map
Date: Sat, 28 Nov 2015 15:02:01 +0530
Message-ID: <1448703121-5831-17-git-send-email-vinod.koul@intel.com>
References: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A7EB62652CF
 for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2015 10:33:20 +0100 (CET)
In-Reply-To: <1448703121-5831-1-git-send-email-vinod.koul@intel.com>
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

DAPM Machine map for machine was not specifying the paths
correctly. The correct order would be:
"DMIC01 Rx" (SoC DMIC BE), connected to "DMIC AIF" (DMic Codec
AIF) and then "DMic" (DMic codec Input) connected to "SoC DMIC"
(Machine DMIC MIC Widget)

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_rt286.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 0a924901b9b6..51c4eb87e6ec 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -68,7 +68,7 @@ static const struct snd_soc_dapm_route skylake_rt286_map[] = {
 
 	/* digital mics */
 	{"DMIC1 Pin", NULL, "DMIC2"},
-	{"DMIC AIF", NULL, "SoC DMIC"},
+	{"DMic", NULL, "SoC DMIC"},
 
 	{"WoV Sink", NULL, "hwd_in sink"},
 
@@ -82,7 +82,7 @@ static const struct snd_soc_dapm_route skylake_rt286_map[] = {
 	{ "ssp0 Rx", NULL, "AIF1 Capture" },
 
 	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
-	{ "DMIC01 Rx", NULL, "Capture" },
+	{ "DMIC01 Rx", NULL, "DMIC AIF" },
 
 	{ "hif1", NULL, "iDisp Tx"},
 	{ "iDisp Tx", NULL, "iDisp_out"},
-- 
2.4.3
