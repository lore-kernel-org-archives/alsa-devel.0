From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] conf/ucm: broxton: add broxton-rt298 conf files
Date: Thu, 12 Jan 2017 14:50:28 +0530
Message-ID: <1484212828-10041-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E9C0266639
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2017 10:20:51 +0100 (CET)
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
Cc: Nishit Sharma <nishitx.sharma@intel.com>, G Kranthi <gudishax.kranthikumar@intel.com>, tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

This adds the UCM conf files for broxton enabling with rt298 codec on
I2S audio, HDMI and DMIC ports.

Signed-off-by: Nishit Sharma <nishitx.sharma@intel.com>
Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 configure.ac                                  |   1 +
 src/conf/ucm/Makefile.am                      |   2 +-
 src/conf/ucm/broxton-rt298/Hdmi1              |  22 +++++
 src/conf/ucm/broxton-rt298/Hdmi2              |  14 +++
 src/conf/ucm/broxton-rt298/HiFi               | 129 ++++++++++++++++++++++++++
 src/conf/ucm/broxton-rt298/Makefile.am        |   4 +
 src/conf/ucm/broxton-rt298/broxton-rt298.conf |  58 ++++++++++++
 7 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 src/conf/ucm/broxton-rt298/Hdmi1
 create mode 100644 src/conf/ucm/broxton-rt298/Hdmi2
 create mode 100644 src/conf/ucm/broxton-rt298/HiFi
 create mode 100644 src/conf/ucm/broxton-rt298/Makefile.am
 create mode 100644 src/conf/ucm/broxton-rt298/broxton-rt298.conf

diff --git a/configure.ac b/configure.ac
index 71bd85271009..d645ab6c3e4c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -684,6 +684,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/topology/bxtrt298/Makefile \
 	  alsalisp/Makefile aserver/Makefile \
 	  test/Makefile test/lsb/Makefile \
+	  src/conf/ucm/broxton-rt298/Makefile \
 	  utils/Makefile utils/alsa-lib.spec utils/alsa.pc)
 
 dnl Create asoundlib.h dynamically according to configure options
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index a11d324e785b..ea9b3850e2dd 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -1 +1 @@
-SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 skylake-rt286 VEYRON-I2S chtrt5645 DB410c
+SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 skylake-rt286 VEYRON-I2S chtrt5645 DB410c broxton-rt298
diff --git a/src/conf/ucm/broxton-rt298/Hdmi1 b/src/conf/ucm/broxton-rt298/Hdmi1
new file mode 100644
index 000000000000..48514f47efaa
--- /dev/null
+++ b/src/conf/ucm/broxton-rt298/Hdmi1
@@ -0,0 +1,22 @@
+# Usecase for device HDMI1/Display Port stereo playback on Intel SKYLAKE/KABYLAKE platforms
+# For Audio in I2S mode
+
+SectionDevice."Hdmi1" {
+        Comment "HDMI/Display Port 1 Stereo"
+
+        EnableSequence [
+                exec "echo Hdmi1 EnableSequnece"
+        ]
+
+        DisableSequence [
+                exec "echo Hdmi1 DisableSequnece"
+        ]
+
+        Value {
+                PlaybackPCM "hw:broxtonrt298,4"
+                PlaybackChannels "2"
+                PlaybackPriority "3"
+                JackControl "HDMI/DP, pcm=4 Jack"
+        }
+}
+
diff --git a/src/conf/ucm/broxton-rt298/Hdmi2 b/src/conf/ucm/broxton-rt298/Hdmi2
new file mode 100644
index 000000000000..764f8b9995f8
--- /dev/null
+++ b/src/conf/ucm/broxton-rt298/Hdmi2
@@ -0,0 +1,14 @@
+# Usecase for device HDMI2/Display Port stereo playback on Intel Broxton platforms
+# For Audio in I2S mode
+
+SectionDevice."Hdmi2" {
+        Comment "HDMI/Display Port 2 Stereo"
+
+        Value {
+                PlaybackPCM "hw:broxtonrt298,5"
+                PlaybackChannels "2"
+                PlaybackPriority "4"
+                JackControl "HDMI/DP, pcm=5 Jack"
+        }
+}
+
diff --git a/src/conf/ucm/broxton-rt298/HiFi b/src/conf/ucm/broxton-rt298/HiFi
new file mode 100644
index 000000000000..2e2d6fec0cc6
--- /dev/null
+++ b/src/conf/ucm/broxton-rt298/HiFi
@@ -0,0 +1,129 @@
+# Usecase for stereo playback Speaker and Headset, Recording on DMIC and Headset MIC.
+# For Audio in I2S mode on Intel Broxton platforms
+
+SectionVerb {
+
+	EnableSequence [
+		cdev "hw:broxtonrt298"
+		cset "name='media0_out mo dmic01_hifi_in mi Switch' 1"
+	]
+
+	DisableSequence [
+		cdev "hw:broxtonrt298"
+	]
+
+	Value {
+		TQ "HiFi"
+		CapturePCM "hw:broxtonrt298,1"
+		PlaybackPCM "hw:broxtonrt298,0"
+	}
+}
+
+SectionDevice."dmiccap" {
+	Comment "DMIC Stereo"
+
+	ConflictingDevice [
+		"Headset"
+	]
+
+	EnableSequence [
+
+		cdev "hw:broxtonrt298"
+		exec "echo broxtonrt298 dmiccap called"
+		cset "name='media0_out mo dmic01_hifi_in mi Switch' 1"
+		cset "name='media0_out mo codec0_in mi Switch' 0"
+		cset "name='Mic Jack Switch' 0"
+
+	]
+
+	DisableSequence [
+		cdev "hw:broxtonrt298"
+		cset "name='media0_out mo codec0_in mi Switch' 1"
+		cset "name='media0_out mo dmic01_hifi_in mi Switch' 0"
+		cset "name='Mic Jack Switch' 1"
+		cset "name='ADC 0 Mux' 0"
+	]
+	Value {
+		CaptureChannels "2"
+		CapturePriority "2"
+	}
+}
+
+SectionDevice."Headphones" {
+	Comment "Headphones"
+
+	ConflictingDevice [
+		"Speaker"
+	]
+	EnableSequence [
+		cdev "hw:broxtonrt298"
+		exec "echo broxtonrt298 Headphone called"
+		cset "name='HPO L Switch' 1"
+		cset "name='HPO R Switch' 1"
+		cset "name='Headphone Jack Switch' 1"
+		cset "name='Speaker Playback Switch' 0,0"
+	]
+
+	DisableSequence [
+		cdev "hw:broxtonrt298"
+	]
+	Value {
+		PlaybackChannels "2"
+		PlaybackPriority "1"
+		JackControl "Headphone Jack"
+		JackHWMute "Speaker"
+	}
+}
+
+SectionDevice."Speaker" {
+	Comment "Speaker"
+
+	ConflictingDevice [
+		"Headphones"
+	]
+	EnableSequence [
+		cdev "hw:broxtonrt298"
+		exec "echo broxtonrt298 speaker called"
+		cset "name='SPO Switch' 1"
+		cset "name='Speaker Playback Switch' 1,1"
+		cset "name='Speaker Switch' 1"
+		cset "name='HPO L Switch' 0"
+		cset "name='HPO R Switch' 0"
+	]
+
+	DisableSequence [
+	]
+	Value {
+		PlaybackChannels "2"
+		PlaybackPriority "1"
+		JackHWMute "Headphones"
+	}
+}
+
+SectionDevice."Headset" {
+	Comment "Headset Mic"
+
+	ConflictingDevice [
+		"dmiccap"
+	]
+	EnableSequence [
+		cdev "hw:broxtonrt298"
+		exec "echo broxtonrt298 Headset called"
+		cset "name='media0_out mo codec0_in mi Switch' 1"
+		cset "name='ADC0 Capture Volume' 105,105"
+		cset "name='ADC 0 Mux' 0"
+		cset "name='Mic Jack Switch' 1"
+		cset "name='media0_out mo dmic01_hifi_in mi Switch' 0"
+	]
+
+	DisableSequence [
+		cdev "hw:broxtonrt298"
+		cset "name='media0_out mo dmic01_hifi_in mi Switch' 1"
+		cset "name='media0_out mo codec0_in mi Switch' 0"
+	]
+	Value {
+		CaptureChannels "2"
+		CapturePriority "2"
+		JackControl "Mic Jack"
+	}
+}
diff --git a/src/conf/ucm/broxton-rt298/Makefile.am b/src/conf/ucm/broxton-rt298/Makefile.am
new file mode 100644
index 000000000000..80f480ec4222
--- /dev/null
+++ b/src/conf/ucm/broxton-rt298/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/broxton-rt298
+ucm_DATA = broxton-rt298.conf HiFi Hdmi1 Hdmi2
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/broxton-rt298/broxton-rt298.conf b/src/conf/ucm/broxton-rt298/broxton-rt298.conf
new file mode 100644
index 000000000000..3f3d0be6fdf2
--- /dev/null
+++ b/src/conf/ucm/broxton-rt298/broxton-rt298.conf
@@ -0,0 +1,58 @@
+# UCM for Intel Broxton platforms
+# For Audio in I2S mode
+
+SectionUseCase."HiFi" {
+	File "HiFi"
+	Comment "Play and record HiFi quality Music"
+}
+
+SectionUseCase."Hdmi1" {
+        File "Hdmi1"
+        Comment "Play on Hdmi/DP 1"
+}
+
+SectionUseCase."Hdmi2" {
+        File "Hdmi2"
+        Comment "Play on Hdmi/DP 2"
+}
+
+ValueDefaults {
+	PlaybackCTL "hw:broxtonrt298"
+	CaptureCTL "hw:broxtonrt298"
+	CaptureChannels "2"
+	CapturePriority "2"
+}
+
+SectionDefaults [
+	cdev "hw:broxtonrt298"
+	exec "echo broxtonrt298 CONF Defaults"
+	cset "name='Headphone Jack Switch' 1"
+	cset "name='Speaker Switch' 1"
+	cset "name='Speaker Playback Switch' 0,0"
+	cset "name='Front DAC Switch' 1"
+	cset "name='Front RECMIX Switch' 0"
+	cset "name='Mic Jack Switch' 1"
+	cset "name='ADC 0 Mux' 2"
+	cset "name='ADC 1 Mux' 0"
+	cset "name='DAC0 Playback Volume' 100,100"
+	cset "name='HPO L Switch' 0"
+	cset "name='HPO Mux' 0"
+	cset "name='HPO R Switch' 0"
+	cset "name='Pin 5 Mux' 1"
+	cset "name='Pin 6 Mux' 2"
+	cset "name='Pin 7 Mux' 3"
+	cset "name='RECMIX Beep Switch' 0"
+	cset "name='RECMIX Line1 Switch' 0"
+	cset "name='RECMIX Mic1 Switch' 0"
+	cset "name='SPK Mux' 0"
+	cset "name='SPO Switch' 1"
+	cset "name='codec0_out mo codec0_in mi Switch' 0"
+	cset "name='codec0_out mo dmic01_hifi_in mi Switch' 0"
+	cset "name='codec0_out mo media0_in mi Switch' 1"
+	cset "name='codec1_out mo codec0_in mi Switch' 0"
+	cset "name='codec1_out mo dmic01_hifi_in mi Switch' 0"
+	cset "name='codec1_out mo media0_in mi Switch' 0"
+	cset "name='media0_out mo codec0_in mi Switch' 1"
+	cset "name='media0_out mo dmic01_hifi_in mi Switch' 1"
+	cset "name='media0_out mo media0_in mi Switch' 0"
+]
-- 
1.9.1
