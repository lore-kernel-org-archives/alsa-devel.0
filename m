From: Naveen M <naveen.m@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: kbl: Add map for new DAIs for
	Multi-Playback & Echo Ref
Date: Wed,  2 Aug 2017 11:43:35 +0530
Message-ID: <1501654415-24590-4-git-send-email-naveen.m@intel.com>
References: <1501654415-24590-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 70A8426721A
 for <alsa-devel@alsa-project.org>; Wed,  2 Aug 2017 08:13:30 +0200 (CEST)
In-Reply-To: <1501654415-24590-1-git-send-email-naveen.m@intel.com>
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

Modified DAPM Machine map for machine to suit the toplogy change
required to enable features:
Multi-Endpoint Playback
Echo Reference Capture

Signed-off-by: Naveen M <naveen.m@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 6 +++---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 795e959..17cd5a5 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -99,12 +99,12 @@ enum {
 	/* CODEC BE connections */
 	{ "Left HiFi Playback", NULL, "ssp0 Tx" },
 	{ "Right HiFi Playback", NULL, "ssp0 Tx" },
-	{ "ssp0 Tx", NULL, "codec0_out" },
+	{ "ssp0 Tx", NULL, "spk_out" },
 
 	{ "AIF Playback", NULL, "ssp1 Tx" },
-	{ "ssp1 Tx", NULL, "codec1_out" },
+	{ "ssp1 Tx", NULL, "hs_out" },
 
-	{ "codec0_in", NULL, "ssp1 Rx" },
+	{ "hs_in", NULL, "ssp1 Rx" },
 	{ "ssp1 Rx", NULL, "AIF Capture" },
 
 	/* DMIC */
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 2d98982..73b3f05 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -107,12 +107,12 @@ enum {
 	/* CODEC BE connections */
 	{ "Left HiFi Playback", NULL, "ssp0 Tx" },
 	{ "Right HiFi Playback", NULL, "ssp0 Tx" },
-	{ "ssp0 Tx", NULL, "codec0_out" },
+	{ "ssp0 Tx", NULL, "spk_out" },
 
 	{ "AIF Playback", NULL, "ssp1 Tx" },
-	{ "ssp1 Tx", NULL, "codec1_out" },
+	{ "ssp1 Tx", NULL, "hs_out" },
 
-	{ "codec0_in", NULL, "ssp1 Rx" },
+	{ "hs_in", NULL, "ssp1 Rx" },
 	{ "ssp1 Rx", NULL, "AIF Capture" },
 
 	{ "codec1_in", NULL, "ssp0 Rx" },
-- 
1.9.1
