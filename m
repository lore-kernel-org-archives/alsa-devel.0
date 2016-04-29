From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 6/6] topology: Update PCM configurations in
	Broadwell text conf file
Date: Fri, 29 Apr 2016 11:03:45 +0800
Message-ID: <fdad9977185e878d400408187365f05732848a7e.1461898635.git.mengdong.lin@linux.intel.com>
References: <cover.1461898635.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AB302666FA
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 05:00:47 +0200 (CEST)
In-Reply-To: <cover.1461898635.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

To make this conf file a better example, update the name & ID of PCMs
(front-end DAI link) and their cpu DAI (front-end DAI), same as those
defined by Broadwell upstream driver.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/conf/topology/broadwell/broadwell.conf b/src/conf/topology/broadwell/broadwell.conf
index 05b3889..eb89377 100644
--- a/src/conf/topology/broadwell/broadwell.conf
+++ b/src/conf/topology/broadwell/broadwell.conf
@@ -272,18 +272,22 @@ SectionPCMCapabilities."Offload0 Playback" {
 SectionPCMCapabilities."Offload1 Playback" {
 	formats "S24_LE,S16_LE"
 	rate_min "8000"
-	rate_max "48000"
+	rate_max "192000"
 	channels_min "2"
 	channels_max "2"
 }
 
 # PCM devices exported by Firmware
-SectionPCM."System Pin" {
+SectionPCM."System Playback/Capture" {
 
 	index "1"
 
 	# used for binding to the PCM
-	ID "0"
+	id "0"
+
+	dai."System Pin" {
+		id "0"
+	}
 
 	pcm."playback" {
 
@@ -307,12 +311,16 @@ SectionPCM."System Pin" {
 	}
 }
 
-SectionPCM."Offload0 Pin" {
+SectionPCM."Offload0 Playback" {
 
 	index "1"
 
 	# used for binding to the PCM
-	ID "1"
+	id "1"
+
+	dai."Offload0 Pin" {
+		id "1"
+	}
 
 	pcm."playback" {
 
@@ -325,12 +333,16 @@ SectionPCM."Offload0 Pin" {
 	}
 }
 
-SectionPCM."Offload1 Pin" {
+SectionPCM."Offload1 Playback" {
 
 	index "1"
 
 	# used for binding to the PCM
-	ID "2"
+	id "2"
+
+	dai."Offload1 Pin" {
+		id "2"
+	}
 
 	pcm."playback" {
 
@@ -343,12 +355,16 @@ SectionPCM."Offload1 Pin" {
 	}
 }
 
-SectionPCM."Loopback Pin" {
+SectionPCM."Loopback PCM" {
 
 	index "1"
 
 	# used for binding to the PCM
-	ID "3"
+	id "3"
+
+	dai."Loopback Pin" {
+		id "3"
+	}
 
 	pcm."capture" {
 
-- 
2.5.0
