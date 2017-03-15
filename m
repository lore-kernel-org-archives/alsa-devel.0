From: fuweix.tang@intel.com
Subject: [PATCH 2/2] conf/ucm: Remove conf files of
	skylake-rt286 platform
Date: Wed, 15 Mar 2017 14:45:40 +0800
Message-ID: <cd09ce7b8fdff38ed54fb39f33a74a0bbb65bd35.1487576432.git.fuweix.tang@intel.com>
References: <cover.1487576432.git.fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 00225266F30
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 07:45:41 +0100 (CET)
In-Reply-To: <cover.1487576432.git.fuweix.tang@intel.com>
In-Reply-To: <cover.1487576432.git.fuweix.tang@intel.com>
References: <cover.1487576432.git.fuweix.tang@intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Fuwei Tang <fuweix.tang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Fuwei Tang <fuweix.tang@intel.com>

Remove conf files of skylake-rt286 platform from alsa-lib.
The files will be moved to alsa-ucm-conf repo.

Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Reviewed-by: Vinod Koul <vinod.koul@intel.com>
Reviewed-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/configure.ac b/configure.ac
index 71bd852..9e916d7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -673,7 +673,6 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/PAZ00/Makefile \
 	  src/conf/ucm/GoogleNyan/Makefile \
 	  src/conf/ucm/broadwell-rt286/Makefile \
-	  src/conf/ucm/skylake-rt286/Makefile \
 	  src/conf/ucm/VEYRON-I2S/Makefile \
 	  src/conf/ucm/chtrt5645/Makefile \
 	  src/conf/ucm/DB410c/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index a11d324..7bf432e 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -1 +1 @@
-SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 skylake-rt286 VEYRON-I2S chtrt5645 DB410c
+SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 VEYRON-I2S chtrt5645 DB410c
diff --git a/src/conf/ucm/skylake-rt286/Hdmi1 b/src/conf/ucm/skylake-rt286/Hdmi1
deleted file mode 100644
index 0e00fc8..0000000
--- a/src/conf/ucm/skylake-rt286/Hdmi1
+++ /dev/null
@@ -1,20 +0,0 @@
-# Usecase for device HDMI1/Display Port stereo playback on Intel SKYLAKE/KABYLAKE platforms
-# For Audio in I2S mode
-
-SectionDevice."Hdmi1" {
-        Comment "HDMI/Display Port 1 Stereo"
-
-        EnableSequence [
-        ]
-
-        DisableSequence [
-        ]
-
-        Value {
-                PlaybackPCM "hw:skylakert286,4"
-                PlaybackChannels "2"
-                PlaybackPriority "3"
-                JackControl "HDMI/DP, pcm=4 Jack"
-        }
-}
-
diff --git a/src/conf/ucm/skylake-rt286/Hdmi2 b/src/conf/ucm/skylake-rt286/Hdmi2
deleted file mode 100644
index 89b31aa..0000000
--- a/src/conf/ucm/skylake-rt286/Hdmi2
+++ /dev/null
@@ -1,20 +0,0 @@
-# Usecase for device HDMI2/Display Port stereo playback on Intel SKYLAKE/KABYLAKE platforms
-# For Audio in I2S mode
-
-SectionDevice."Hdmi2" {
-        Comment "HDMI/Display Port 2 Stereo"
-
-        EnableSequence [
-        ]
-
-        DisableSequence [
-        ]
-
-        Value {
-                PlaybackPCM "hw:skylakert286,5"
-                PlaybackChannels "2"
-                PlaybackPriority "4"
-                JackControl "HDMI/DP, pcm=5 Jack"
-        }
-}
-
diff --git a/src/conf/ucm/skylake-rt286/HiFi b/src/conf/ucm/skylake-rt286/HiFi
deleted file mode 100644
index 41638f4..0000000
--- a/src/conf/ucm/skylake-rt286/HiFi
+++ /dev/null
@@ -1,129 +0,0 @@
-# Usecase for stereo playback Speaker and Headset, Recording on DMIC and Headset MIC.
-# For Audio in I2S mode on Intel SKYLAKE/KABYLAKE platforms
-
-SectionVerb {
-
-	EnableSequence [
-		cdev "hw:skylakert286"
-		cset "name='media0_out mo dmic01_hifi_in mi Switch' 1"
-	]
-
-	DisableSequence [
-		cdev "hw:skylakert286"
-	]
-
-	Value {
-		TQ "HiFi"
-		CapturePCM "hw:skylakert286,1"
-		PlaybackPCM "hw:skylakert286,0"
-	}
-}
-
-SectionDevice."Headphones" {
-	Comment "Headphones"
-
-	ConflictingDevice [
-		"Speaker"
-	]
-	EnableSequence [
-		cdev "hw:skylakert286"
-		cset "name='HPO L Switch' 1"
-		cset "name='HPO R Switch' 1"
-		cset "name='Headphone Jack Switch' 1"
-		cset "name='Speaker Playback Switch' 0,0"
-	]
-
-	DisableSequence [
-	]
-	Value {
-		PlaybackChannels "2"
-		PlaybackPriority "1"
-		JackControl "Headphone Jack"
-		JackHWMute "Speaker"
-	}
-}
-
-SectionDevice."Speaker" {
-	Comment "Speaker"
-
-	ConflictingDevice [
-		"Headphones"
-	]
-	EnableSequence [
-		cdev "hw:skylakert286"
-		cset "name='SPO Switch' 1"
-		cset "name='Speaker Playback Switch' 1,1"
-		cset "name='Speaker Switch' 1"
-		cset "name='HPO L Switch' 0"
-		cset "name='HPO R Switch' 0"
-	]
-
-	DisableSequence [
-	]
-	Value {
-		PlaybackChannels "2"
-		PlaybackPriority "1"
-		JackHWMute "Headphones"
-	}
-}
-
-SectionDevice."Headset" {
-	Comment "Headset Mic"
-
-	ConflictingDevice [
-		"dmiccap"
-	]
-	EnableSequence [
-		cdev "hw:skylakert286"
-		cset "name='media0_out mo codec0_in mi Switch' 1"
-		cset "name='ADC0 Capture Switch' 1,1"
-		cset "name='ADC 0 Mux' 0"
-		cset "name='Mic Jack Switch' 1"
-		cset "name='media0_out mo dmic01_hifi_in mi Switch' 0"
-	]
-
-	DisableSequence [
-		cdev "hw:skylakert286"
-		cset "name='media0_out mo dmic01_hifi_in mi Switch' 1"
-		cset "name='media0_out mo codec0_in mi Switch' 0"
-	]
-	Value {
-		CaptureChannels "2"
-		CapturePriority "2"
-		JackControl "Mic Jack"
-	}
-}
-
-
-SectionDevice."dmiccap" {
-	Comment "DMIC Stereo"
-
-	ConflictingDevice [
-		"Headpset"
-	]
-
-	EnableSequence [
-
-		cdev "hw:skylakert286"
-		cset "name='media0_out mo dmic01_hifi_in mi Switch' 1"
-		cset "name='media0_out mo codec0_in mi Switch' 0"
-		cset "name='ADC0 Capture Switch' 0,0"
-		cset "name='Mic Jack Switch' 0"
-		cset "name='ADC 0 Mux' 0"
-		
-	]
-
-	DisableSequence [
-		cdev "hw:skylakert286"
-		cset "name='media0_out mo codec0_in mi Switch' 1"
-		cset "name='media0_out mo dmic01_hifi_in mi Switch' 0"
-		cset "name='ADC0 Capture Switch' 1,1"
-		cset "name='Mic Jack Switch' 1"
-		cset "name='ADC 0 Mux' 2"
-	]
-	Value {
-		CaptureChannels "2"
-		CapturePriority "2"
-	}
-}
-
diff --git a/src/conf/ucm/skylake-rt286/Makefile.am b/src/conf/ucm/skylake-rt286/Makefile.am
deleted file mode 100644
index 9d6a85a..0000000
--- a/src/conf/ucm/skylake-rt286/Makefile.am
+++ /dev/null
@@ -1,4 +0,0 @@
-alsaconfigdir = @ALSA_CONFIG_DIR@
-ucmdir = $(alsaconfigdir)/ucm/skylake-rt286
-ucm_DATA = skylake-rt286.conf HiFi Hdmi1 Hdmi2
-EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/skylake-rt286/skylake-rt286.conf b/src/conf/ucm/skylake-rt286/skylake-rt286.conf
deleted file mode 100644
index 3e43228..0000000
--- a/src/conf/ucm/skylake-rt286/skylake-rt286.conf
+++ /dev/null
@@ -1,60 +0,0 @@
-# UCM for Intel SKYLAKE/KABYLAKE platforms
-# For Audio in I2S mode
-
-SectionUseCase."HiFi" {
-	File "HiFi"
-	Comment "Play and record HiFi quality Music"
-}
-
-SectionUseCase."Hdmi1" {
-        File "Hdmi1"
-        Comment "Play on Hdmi/DP 1"
-}
-
-SectionUseCase."Hdmi2" {
-        File "Hdmi2"
-        Comment "Play on Hdmi/DP 2"
-}
-
-ValueDefaults {
-	PlaybackCTL "hw:skylakert286"
-	CaptureCTL "hw:skylakert286"
-	CaptureChannels "2"
-	CapturePriority "2"	
-}
-
-SectionDefaults [
-	cdev "hw:skylakert286"
-	cset "name='Headphone Jack Switch' 1"
-	cset "name='Speaker Switch' 1"
-	cset "name='Speaker Playback Switch' 0,0"
-	cset "name='Front DAC Switch' 1"
-	cset "name='Front RECMIX Switch' 0"
-	cset "name='Mic Jack Switch' 1"
-	cset "name='ADC 0 Mux' 2"
-	cset "name='ADC 1 Mux' 0"
-	cset "name='ADC0 Capture Volume' 105,105"
-	cset "name='ADC0 Capture Switch' 1,1"
-	cset "name='AMIC Volume' 3"
-	cset "name='DAC0 Playback Volume' 100,100"
-	cset "name='HPO L Switch' 0"
-	cset "name='HPO Mux' 0"
-	cset "name='HPO R Switch' 0"
-	cset "name='Pin 5 Mux' 1"
-	cset "name='Pin 6 Mux' 2"
-	cset "name='Pin 7 Mux' 3"
-	cset "name='RECMIX Beep Switch' 0"
-	cset "name='RECMIX Line1 Switch' 0"
-	cset "name='RECMIX Mic1 Switch' 0"
-	cset "name='SPK Mux' 0"
-	cset "name='SPO Switch' 1"
-	cset "name='codec0_out mo codec0_in mi Switch' 0"
-	cset "name='codec0_out mo dmic01_hifi_in mi Switch' 0"
-	cset "name='codec0_out mo media0_in mi Switch' 1"
-	cset "name='codec1_out mo codec0_in mi Switch' 0"
-	cset "name='codec1_out mo dmic01_hifi_in mi Switch' 0"
-	cset "name='codec1_out mo media0_in mi Switch' 0"
-	cset "name='media0_out mo codec0_in mi Switch' 1"
-	cset "name='media0_out mo dmic01_hifi_in mi Switch' 1"
-	cset "name='media0_out mo media0_in mi Switch' 0"
-]
-- 
2.7.4
