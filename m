From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/3] ASoC: Intel: Skylake: Add IVI feedback
	path in nau88125_ssm4567 machine
Date: Tue,  1 Mar 2016 07:59:11 +0530
Message-ID: <1456799352-22653-3-git-send-email-vinod.koul@intel.com>
References: <1456799352-22653-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A269426148F
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 03:26:50 +0100 (CET)
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

We can enable the IVI feedback path by connecting Left/Right
speaker sensors (codec) to  ssp0 Rx (soc-dsp). This way aDSP gets
feedback data from codec to DSP algorithms

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index a75c09343f84..f6a672c55be9 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -132,6 +132,8 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 
 	/* IV feedback path */
 	{ "codec0_lp_in", NULL, "ssp0 Rx"},
+	{ "ssp0 Rx", NULL, "Left Capture Sense" },
+	{ "ssp0 Rx", NULL, "Right Capture Sense" },
 
 	{ "Playback", NULL, "ssp1 Tx"},
 	{ "ssp1 Tx", NULL, "codec1_out"},
@@ -534,6 +536,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.ignore_pmdown_time = 1,
 		.be_hw_params_fixup = skylake_ssp_fixup,
 		.dpcm_playback = 1,
+		.dpcm_capture = 1,
 	},
 	{
 		/* SSP1 - Codec */
-- 
1.9.1
