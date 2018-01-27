From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 3/5] ASoC: Intel: board: Add BE DAI link for
	WoV and update DAPM machine map.
Date: Sat, 27 Jan 2018 09:50:23 +0530
Message-ID: <20180127042025.22042-4-guneshwor.o.singh@intel.com>
References: <20180127042025.22042-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id BCB9D2670BE
 for <alsa-devel@alsa-project.org>; Sat, 27 Jan 2018 05:21:29 +0100 (CET)
In-Reply-To: <20180127042025.22042-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, "Pawse,
 GuruprasadX" <guruprasadx.pawse@intel.com>, Pawse@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: "Pawse, GuruprasadX" <guruprasadx.pawse@intel.com>

Create BE DAI link for WoV and accordingly update the DAPM machine map

Signed-off-by: Pawse, GuruprasadX <guruprasadx.pawse@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/boards/bxt_rt298.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 7843104fadcb..58b56bf60c37 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -146,6 +146,9 @@ static const struct snd_soc_dapm_route geminilake_rt298_map[] = {
 	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
 	{ "DMIC01 Rx", NULL, "Capture" },
 
+	{ "dmic_voice", NULL, "DMIC16k Rx" },
+	{ "DMIC16k Rx", NULL, "Capture" },
+
 	{ "hifi3", NULL, "iDisp3 Tx"},
 	{ "iDisp3 Tx", NULL, "iDisp3_out"},
 	{ "hifi2", NULL, "iDisp2 Tx"},
@@ -456,6 +459,18 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.dpcm_capture = 1,
 		.no_pcm = 1,
 	},
+	{
+		.name = "dmic16k",
+		.id = 2,
+		.cpu_dai_name = "DMIC16k Pin",
+		.codec_name = "dmic-codec",
+		.codec_dai_name = "dmic-hifi",
+		.platform_name = "0000:00:0e.0",
+		.be_hw_params_fixup = broxton_dmic_fixup,
+		.ignore_suspend = 1,
+		.dpcm_capture = 1,
+		.no_pcm = 1,
+	},
 	{
 		.name = "iDisp1",
 		.id = 3,
-- 
2.16.1
