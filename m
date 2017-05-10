From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH] conf: topology: Fix index mismatch for skl and
	bxt
Date: Wed, 10 May 2017 13:46:53 +0530
Message-ID: <1494404213-2086-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A1E82667E7
 for <alsa-devel@alsa-project.org>; Wed, 10 May 2017 10:30:32 +0200 (CEST)
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The topology index in the conf is set to 1, where the driver expects index
set to 0. Fix the inconsistency.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 src/conf/topology/bxtrt298/bxt_i2s.conf | 62 ++++++++++++++++-----------------
 src/conf/topology/sklrt286/skl_i2s.conf | 56 ++++++++++++++---------------
 2 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/src/conf/topology/bxtrt298/bxt_i2s.conf b/src/conf/topology/bxtrt298/bxt_i2s.conf
index 3b7a54e3a323..6b38f4f3c5ae 100644
--- a/src/conf/topology/bxtrt298/bxt_i2s.conf
+++ b/src/conf/topology/bxtrt298/bxt_i2s.conf
@@ -2924,7 +2924,7 @@ SectionData."lib_data" {
 
 
 SectionControlMixer."media0_in mi Switch" {
-	index"1"
+	index"0"
 	invert "false"
 	max "1"
 	min"0"
@@ -2944,7 +2944,7 @@ SectionControlMixer."media0_in mi Switch" {
 	}
 }
 SectionControlMixer."dmic01_hifi_in mi Switch" {
-	index"1"
+	index"0"
 	invert "false"
 	max "1"
 	min"0"
@@ -2964,7 +2964,7 @@ SectionControlMixer."dmic01_hifi_in mi Switch" {
 	}
 }
 SectionControlMixer."codec0_in mi Switch" {
-	index"1"
+	index"0"
 	invert "false"
 	max "1"
 	min"0"
@@ -2986,7 +2986,7 @@ SectionControlMixer."codec0_in mi Switch" {
 
 
 SectionWidget."media0_in cpr 0" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "3"
@@ -2998,7 +2998,7 @@ SectionWidget."media0_in cpr 0" {
 	]
 }
 SectionWidget."media0_in mi" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -3011,7 +3011,7 @@ SectionWidget."media0_in mi" {
 	]
 }
 SectionWidget."codec0_in cpr 1" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "3"
@@ -3023,7 +3023,7 @@ SectionWidget."codec0_in cpr 1" {
 	]
 }
 SectionWidget."codec0_in mi" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -3036,12 +3036,12 @@ SectionWidget."codec0_in mi" {
 	]
 }
 SectionWidget."codec0_in" {
-	index"1"
+	index"0"
 	type"aif_in"
 	no_pm "true"
 }
 SectionWidget."codec0_out mo" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "1"
@@ -3059,7 +3059,7 @@ SectionWidget."codec0_out mo" {
 	]
 }
 SectionWidget."codec0_out cpr 2" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -3070,12 +3070,12 @@ SectionWidget."codec0_out cpr 2" {
 	]
 }
 SectionWidget."codec0_out" {
-	index"1"
+	index"0"
 	type"aif_out"
 	no_pm "true"
 }
 SectionWidget."media0_out mo" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "1"
@@ -3093,7 +3093,7 @@ SectionWidget."media0_out mo" {
 	]
 }
 SectionWidget."media0_out cpr 3" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -3104,7 +3104,7 @@ SectionWidget."media0_out cpr 3" {
 	]
 }
 SectionWidget."dmic01_hifi_in cpr 4" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "3"
@@ -3116,7 +3116,7 @@ SectionWidget."dmic01_hifi_in cpr 4" {
 	]
 }
 SectionWidget."dmic01_hifi_in mi" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -3129,12 +3129,12 @@ SectionWidget."dmic01_hifi_in mi" {
 	]
 }
 SectionWidget."dmic01_hifi" {
-	index"1"
+	index"0"
 	type"aif_in"
 	no_pm "true"
 }
 SectionWidget."codec1_out mo" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "1"
@@ -3152,7 +3152,7 @@ SectionWidget."codec1_out mo" {
 	]
 }
 SectionWidget."codec1_out cpr 5" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -3163,12 +3163,12 @@ SectionWidget."codec1_out cpr 5" {
 	]
 }
 SectionWidget."codec1_out" {
-	index"1"
+	index"0"
 	type"aif_out"
 	no_pm "true"
 }
 SectionWidget."hdmi1_pt_out cpr 6" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "3"
@@ -3180,7 +3180,7 @@ SectionWidget."hdmi1_pt_out cpr 6" {
 	]
 }
 SectionWidget."hdmi1_pt_out cpr 7" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -3191,12 +3191,12 @@ SectionWidget."hdmi1_pt_out cpr 7" {
 	]
 }
 SectionWidget."iDisp1_out" {
-	index"1"
+	index"0"
 	type"aif_out"
 	no_pm "true"
 }
 SectionWidget."hdmi2_pt_out cpr 8" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "3"
@@ -3208,7 +3208,7 @@ SectionWidget."hdmi2_pt_out cpr 8" {
 	]
 }
 SectionWidget."hdmi2_pt_out cpr 9" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -3219,12 +3219,12 @@ SectionWidget."hdmi2_pt_out cpr 9" {
 	]
 }
 SectionWidget."iDisp2_out" {
-	index"1"
+	index"0"
 	type"aif_out"
 	no_pm "true"
 }
 SectionWidget."hdmi3_pt_out cpr 10" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "3"
@@ -3236,7 +3236,7 @@ SectionWidget."hdmi3_pt_out cpr 10" {
 	]
 }
 SectionWidget."hdmi3_pt_out cpr 11" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -3247,12 +3247,12 @@ SectionWidget."hdmi3_pt_out cpr 11" {
 	]
 }
 SectionWidget."iDisp3_out" {
-	index"1"
+	index"0"
 	type"aif_out"
 	no_pm "true"
 }
 SectionWidget."mch_cap_in cpr 12" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "3"
@@ -3264,7 +3264,7 @@ SectionWidget."mch_cap_in cpr 12" {
 	]
 }
 SectionWidget."mch_cap_in cpr 13" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -3283,7 +3283,7 @@ SectionManifest."lib_data" {
 }
 
 SectionGraph."Pipeline 1 Graph" {
-	index"1"
+	index"0"
 	lines [
 		"media0_in mi, , media0_in cpr 0"
 		"media0_in cpr 0, , System Playback"
diff --git a/src/conf/topology/sklrt286/skl_i2s.conf b/src/conf/topology/sklrt286/skl_i2s.conf
index bb1fe4f8435f..fbf041bfd0cf 100644
--- a/src/conf/topology/sklrt286/skl_i2s.conf
+++ b/src/conf/topology/sklrt286/skl_i2s.conf
@@ -2604,7 +2604,7 @@ SectionData."hdmi3_pt_out cpr 12" {
 
 
 SectionControlMixer."media0_in mi Switch" {
-	index"1"
+	index"0"
 	invert "false"
 	max "1"
 	min"0"
@@ -2624,7 +2624,7 @@ SectionControlMixer."media0_in mi Switch" {
 	}
 }
 SectionControlMixer."codec0_in mi Switch" {
-	index"1"
+	index"0"
 	invert "false"
 	max "1"
 	min"0"
@@ -2644,7 +2644,7 @@ SectionControlMixer."codec0_in mi Switch" {
 	}
 }
 SectionControlMixer."dmic01_hifi_in mi Switch" {
-	index"1"
+	index"0"
 	invert "false"
 	max "1"
 	min"0"
@@ -2666,7 +2666,7 @@ SectionControlMixer."dmic01_hifi_in mi Switch" {
 
 
 SectionWidget."media0_in cpr 0" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "3"
@@ -2678,7 +2678,7 @@ SectionWidget."media0_in cpr 0" {
 	]
 }
 SectionWidget."media0_in mi" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -2691,7 +2691,7 @@ SectionWidget."media0_in mi" {
 	]
 }
 SectionWidget."media0_out mo" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "1"
@@ -2709,7 +2709,7 @@ SectionWidget."media0_out mo" {
 	]
 }
 SectionWidget."media0_out cpr 6" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -2720,7 +2720,7 @@ SectionWidget."media0_out cpr 6" {
 	]
 }
 SectionWidget."codec0_out mo" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "1"
@@ -2738,7 +2738,7 @@ SectionWidget."codec0_out mo" {
 	]
 }
 SectionWidget."codec0_out cpr 4" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -2749,12 +2749,12 @@ SectionWidget."codec0_out cpr 4" {
 	]
 }
 SectionWidget."codec0_out" {
-	index"1"
+	index"0"
 	type"aif_out"
 	no_pm "true"
 }
 SectionWidget."codec1_out mo" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "1"
@@ -2772,7 +2772,7 @@ SectionWidget."codec1_out mo" {
 	]
 }
 SectionWidget."codec1_out cpr 5" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -2783,12 +2783,12 @@ SectionWidget."codec1_out cpr 5" {
 	]
 }
 SectionWidget."codec1_out" {
-	index"1"
+	index"0"
 	type"aif_out"
 	no_pm "true"
 }
 SectionWidget."codec0_in cpr 1" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "3"
@@ -2800,7 +2800,7 @@ SectionWidget."codec0_in cpr 1" {
 	]
 }
 SectionWidget."codec0_in mi" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -2813,12 +2813,12 @@ SectionWidget."codec0_in mi" {
 	]
 }
 SectionWidget."codec0_in" {
-	index"1"
+	index"0"
 	type"aif_in"
 	no_pm "true"
 }
 SectionWidget."dmic01_hifi_in cpr 3" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "3"
@@ -2830,7 +2830,7 @@ SectionWidget."dmic01_hifi_in cpr 3" {
 	]
 }
 SectionWidget."dmic01_hifi_in mi" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -2843,12 +2843,12 @@ SectionWidget."dmic01_hifi_in mi" {
 	]
 }
 SectionWidget."dmic01_hifi" {
-	index"1"
+	index"0"
 	type"aif_in"
 	no_pm "true"
 }
 SectionWidget."hdmi1_pt_out cpr 7" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "3"
@@ -2860,7 +2860,7 @@ SectionWidget."hdmi1_pt_out cpr 7" {
 	]
 }
 SectionWidget."hdmi1_pt_out cpr 8" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -2871,12 +2871,12 @@ SectionWidget."hdmi1_pt_out cpr 8" {
 	]
 }
 SectionWidget."iDisp1_out" {
-	index"1"
+	index"0"
 	type"aif_out"
 	no_pm "true"
 }
 SectionWidget."hdmi2_pt_out cpr 9" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "3"
@@ -2888,7 +2888,7 @@ SectionWidget."hdmi2_pt_out cpr 9" {
 	]
 }
 SectionWidget."hdmi2_pt_out cpr 10" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -2899,12 +2899,12 @@ SectionWidget."hdmi2_pt_out cpr 10" {
 	]
 }
 SectionWidget."iDisp2_out" {
-	index"1"
+	index"0"
 	type"aif_out"
 	no_pm "true"
 }
 SectionWidget."hdmi3_pt_out cpr 11" {
-	index"1"
+	index"0"
 	type"mixer"
 	no_pm "true"
 	event_type "3"
@@ -2916,7 +2916,7 @@ SectionWidget."hdmi3_pt_out cpr 11" {
 	]
 }
 SectionWidget."hdmi3_pt_out cpr 12" {
-	index"1"
+	index"0"
 	type"pga"
 	no_pm "true"
 	event_type "4"
@@ -2927,7 +2927,7 @@ SectionWidget."hdmi3_pt_out cpr 12" {
 	]
 }
 SectionGraph."Pipeline 1 Graph" {
-	index"1"
+	index"0"
 	lines [
 		"media0_in mi, , media0_in cpr 0"
 		"media0_in cpr 0, , System Playback"
-- 
1.9.1
