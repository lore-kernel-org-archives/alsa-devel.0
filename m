From: Naveen Manohar <naveen.m@intel.com>
Subject: [PATCH] ASoC: Intel: kbl: Modify Headset map for
	Multi-Playback
Date: Fri,  3 Nov 2017 08:58:17 +0530
Message-ID: <1509679697-22154-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A92E0266DEA
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 04:29:01 +0100 (CET)
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

Current topology for Headset resulted in unwanted pop noise,
while switching from spk->hs at the start of Headset Playback.
Modified topology to fix the same.
This modification also requires headset route to be updated.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c        | 2 +-
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 6f9a8bc..6dcad0a 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -101,7 +101,7 @@ enum {
 	{ "ssp0 Tx", NULL, "spk_out" },
 
 	{ "AIF Playback", NULL, "ssp1 Tx" },
-	{ "ssp1 Tx", NULL, "hs_out" },
+	{ "ssp1 Tx", NULL, "codec1_out" },
 
 	{ "hs_in", NULL, "ssp1 Rx" },
 	{ "ssp1 Rx", NULL, "AIF Capture" },
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 6072164..271ae3c 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -109,7 +109,7 @@ enum {
 	{ "ssp0 Tx", NULL, "spk_out" },
 
 	{ "AIF Playback", NULL, "ssp1 Tx" },
-	{ "ssp1 Tx", NULL, "hs_out" },
+	{ "ssp1 Tx", NULL, "codec1_out" },
 
 	{ "hs_in", NULL, "ssp1 Rx" },
 	{ "ssp1 Rx", NULL, "AIF Capture" },
-- 
1.9.1
