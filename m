From: Naveen M <naveen.m@intel.com>
Subject: [PATCH v2] ASoC: Intel: kbl: Add map for Maxim IV
	Feedback
Date: Tue, 22 Aug 2017 14:49:22 +0530
Message-ID: <1503393562-31613-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 83919267578
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 11:19:32 +0200 (CEST)
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, naveen.m@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

MAX98927 provides IV feedback on the capture widget.
Here we are connecting the capture widget to SSP0_RX and
SSP0_RX to the algorithm running on host.

v2: rebased on newer kernel (d46b182)

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index c144214..8d2a1c0 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -107,6 +107,11 @@ enum {
 	{ "hs_in", NULL, "ssp1 Rx" },
 	{ "ssp1 Rx", NULL, "AIF Capture" },
 
+	/* IV feedback path */
+	{ "codec0_fb_in", NULL, "ssp0 Rx"},
+	{ "ssp0 Rx", NULL, "Left HiFi Capture" },
+	{ "ssp0 Rx", NULL, "Right HiFi Capture" },
+
 	/* DMIC */
 	{ "dmic01_hifi", NULL, "DMIC01 Rx" },
 	{ "DMIC01 Rx", NULL, "DMIC AIF" },
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index c2ef538..8d19da9 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -119,6 +119,11 @@ enum {
 	{ "codec1_in", NULL, "ssp0 Rx" },
 	{ "ssp0 Rx", NULL, "AIF1 Capture" },
 
+	/* IV feedback path */
+	{ "codec0_fb_in", NULL, "ssp0 Rx"},
+	{ "ssp0 Rx", NULL, "Left HiFi Capture" },
+	{ "ssp0 Rx", NULL, "Right HiFi Capture" },
+
 	/* DMIC */
 	{ "DMIC1L", NULL, "DMIC" },
 	{ "DMIC1R", NULL, "DMIC" },
-- 
1.9.1
