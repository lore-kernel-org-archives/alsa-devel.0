From: Naveen Manohar <naveen.m@intel.com>
Subject: [PATCH v2] ASoC: Intel: kbl: Modify map for Headset
	Playback to fix pop-noise
Date: Fri,  3 Nov 2017 17:09:26 +0530
Message-ID: <1509709166-26229-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 12A7E26709F
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 12:40:02 +0100 (CET)
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
Cc: vinod.koul@intel.com, broonie@kernel.org, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, naveen.m@intel.com, subhransu.s.prusty@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

Patch fixes wrong path in commit 0b06122fc8d0 ("ASoC: Intel: kbl: Add
map for new DAIs for Multi-Playback & Echo Ref") which resulted in pop
noise.
Current topology for Headset results in unwanted pop noise, while
switching from spk->hs at the start of Headset Playback.
Hence re-introduced mixin-mixout dsp module in topology for headset
playback pipe to fix the regression.
And the corresponding modification for headset route is updated here.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
---
v1->v2: updated commit message to suit the change more appropriately.

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
