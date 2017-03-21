From: fuweix.tang@intel.com
Subject: [PATCH v2 3/3] ucm-conf: skylake: add skylake-rt286
	conf files
Date: Tue, 21 Mar 2017 11:15:33 +0800
Message-ID: <4b0ac4d762098ca38eef472fa18ed83bea929eb7.1490064444.git.fuweix.tang@intel.com>
References: <cover.1490064444.git.fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 40F5C266FBD
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 04:15:45 +0100 (CET)
In-Reply-To: <cover.1490064444.git.fuweix.tang@intel.com>
In-Reply-To: <cover.1490064444.git.fuweix.tang@intel.com>
References: <cover.1490064444.git.fuweix.tang@intel.com>
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
Cc: Nishit Sharma <nishitx.sharma@intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, Fuwei Tang <fuweix.tang@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Karthik D M <karthik.d.m@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This add the UCM conf files for skylake enabling I2S audio, HDMI and DMIC
ports.

This patch is based on commit 4dfae1adb314 ("conf/ucm: skylake: add skylake-rt286 conf files")
from alsa-lib by Vinod Koul <vinod.koul@intel.com>.
Original authorship is retained.

Signed-off-by: Karthik D M <karthik.d.m@intel.com>
Signed-off-by: Nishit Sharma <nishitx.sharma@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
---
 Makefile.am                      |   2 +-
 configure.ac                     |   3 +-
 skylake-rt286/Hdmi1              |  20 ++++++
 skylake-rt286/Hdmi2              |  20 ++++++
 skylake-rt286/HiFi               | 129 +++++++++++++++++++++++++++++++++++++++
 skylake-rt286/Makefile.am        |   4 ++
 skylake-rt286/skylake-rt286.conf |  60 ++++++++++++++++++
 7 files changed, 236 insertions(+), 2 deletions(-)
 create mode 100644 skylake-rt286/Hdmi1
 create mode 100644 skylake-rt286/Hdmi2
 create mode 100644 skylake-rt286/HiFi
 create mode 100644 skylake-rt286/Makefile.am
 create mode 100644 skylake-rt286/skylake-rt286.conf

diff --git a/Makefile.am b/Makefile.am
index 5f86692..f351b75 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1 +1 @@
-SUBDIRS=broxton-rt298
+SUBDIRS=broxton-rt298 skylake-rt286
diff --git a/configure.ac b/configure.ac
index c797f58..2503641 100644
--- a/configure.ac
+++ b/configure.ac
@@ -14,7 +14,8 @@ AM_INIT_AUTOMAKE
 
 # Checks for library functions.
 AC_CONFIG_FILES([Makefile
-		 broxton-rt298/Makefile])
+		 broxton-rt298/Makefile
+		 skylake-rt286/Makefile])
 
 ALSA_CONFIG_DIR="/usr/share/alsa"
 test "x$prefix" != xNONE && ALSA_CONFIG_DIR=$prefix
diff --git a/skylake-rt286/Hdmi1 b/skylake-rt286/Hdmi1
new file mode 100644
index 0000000..0e00fc8
--- /dev/null
+++ b/skylake-rt286/Hdmi1
@@ -0,0 +1,20 @@
+# Usecase for device HDMI1/Display Port stereo playback on Intel SKYLAKE/KABYLAKE platforms
+# For Audio in I2S mode
+
+SectionDevice."Hdmi1" {
+        Comment "HDMI/Display Port 1 Stereo"
+
+        EnableSequence [
+        ]
+
+        DisableSequence [
+        ]
+
+        Value {
+                PlaybackPCM "hw:skylakert286,4"
+                PlaybackChannels "2"
+                PlaybackPriority "3"
+                JackControl "HDMI/DP, pcm=4 Jack"
+        }
+}
+
diff --git a/skylake-rt286/Hdmi2 b/skylake-rt286/Hdmi2
new file mode 100644
index 0000000..89b31aa
--- /dev/null
+++ b/skylake-rt286/Hdmi2
@@ -0,0 +1,20 @@
+# Usecase for device HDMI2/Display Port stereo playback on Intel SKYLAKE/KABYLAKE platforms
+# For Audio in I2S mode
+
+SectionDevice."Hdmi2" {
+        Comment "HDMI/Display Port 2 Stereo"
+
+        EnableSequence [
+        ]
+
+        DisableSequence [
+        ]
+
+        Value {
+                PlaybackPCM "hw:skylakert286,5"
+                PlaybackChannels "2"
+                PlaybackPriority "4"
+                JackControl "HDMI/DP, pcm=5 Jack"
+        }
+}
+
diff --git a/skylake-rt286/HiFi b/skylake-rt286/HiFi
new file mode 100644
index 0000000..5f403db
--- /dev/null
+++ b/skylake-rt286/HiFi
@@ -0,0 +1,129 @@
+# Usecase for stereo playback Speaker and Headset, Recording on DMIC and Headset MIC.
+# For Audio in I2S mode on Intel SKYLAKE/KABYLAKE platforms
+
+SectionVerb {
+
+	EnableSequence [
+		cdev "hw:skylakert286"
+		cset "name='media0_out mo dmic01_hifi_in mi Switch' 1"
+	]
+
+	DisableSequence [
+		cdev "hw:skylakert286"
+	]
+
+	Value {
+		TQ "HiFi"
+		CapturePCM "hw:skylakert286,1"
+		PlaybackPCM "hw:skylakert286,0"
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
+		cdev "hw:skylakert286"
+		cset "name='HPO L Switch' 1"
+		cset "name='HPO R Switch' 1"
+		cset "name='Headphone Jack Switch' 1"
+		cset "name='Speaker Playback Switch' 0,0"
+	]
+
+	DisableSequence [
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
+		cdev "hw:skylakert286"
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
+		cdev "hw:skylakert286"
+		cset "name='media0_out mo codec0_in mi Switch' 1"
+		cset "name='ADC0 Capture Switch' 1,1"
+		cset "name='ADC 0 Mux' 0"
+		cset "name='Mic Jack Switch' 1"
+		cset "name='media0_out mo dmic01_hifi_in mi Switch' 0"
+	]
+
+	DisableSequence [
+		cdev "hw:skylakert286"
+		cset "name='media0_out mo dmic01_hifi_in mi Switch' 1"
+		cset "name='media0_out mo codec0_in mi Switch' 0"
+	]
+	Value {
+		CaptureChannels "2"
+		CapturePriority "2"
+		JackControl "Mic Jack"
+	}
+}
+
+
+SectionDevice."dmiccap" {
+	Comment "DMIC Stereo"
+
+	ConflictingDevice [
+		"Headpset"
+	]
+
+	EnableSequence [
+
+		cdev "hw:skylakert286"
+		cset "name='media0_out mo dmic01_hifi_in mi Switch' 1"
+		cset "name='media0_out mo codec0_in mi Switch' 0"
+		cset "name='ADC0 Capture Switch' 0,0"
+		cset "name='Mic Jack Switch' 0"
+		cset "name='ADC 0 Mux' 0"
+
+	]
+
+	DisableSequence [
+		cdev "hw:skylakert286"
+		cset "name='media0_out mo codec0_in mi Switch' 1"
+		cset "name='media0_out mo dmic01_hifi_in mi Switch' 0"
+		cset "name='ADC0 Capture Switch' 1,1"
+		cset "name='Mic Jack Switch' 1"
+		cset "name='ADC 0 Mux' 2"
+	]
+	Value {
+		CaptureChannels "2"
+		CapturePriority "2"
+	}
+}
+
diff --git a/skylake-rt286/Makefile.am b/skylake-rt286/Makefile.am
new file mode 100644
index 0000000..9d6a85a
--- /dev/null
+++ b/skylake-rt286/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/skylake-rt286
+ucm_DATA = skylake-rt286.conf HiFi Hdmi1 Hdmi2
+EXTRA_DIST = $(ucm_DATA)
diff --git a/skylake-rt286/skylake-rt286.conf b/skylake-rt286/skylake-rt286.conf
new file mode 100644
index 0000000..2a74744
--- /dev/null
+++ b/skylake-rt286/skylake-rt286.conf
@@ -0,0 +1,60 @@
+# UCM for Intel SKYLAKE/KABYLAKE platforms
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
+	PlaybackCTL "hw:skylakert286"
+	CaptureCTL "hw:skylakert286"
+	CaptureChannels "2"
+	CapturePriority "2"
+}
+
+SectionDefaults [
+	cdev "hw:skylakert286"
+	cset "name='Headphone Jack Switch' 1"
+	cset "name='Speaker Switch' 1"
+	cset "name='Speaker Playback Switch' 0,0"
+	cset "name='Front DAC Switch' 1"
+	cset "name='Front RECMIX Switch' 0"
+	cset "name='Mic Jack Switch' 1"
+	cset "name='ADC 0 Mux' 2"
+	cset "name='ADC 1 Mux' 0"
+	cset "name='ADC0 Capture Volume' 105,105"
+	cset "name='ADC0 Capture Switch' 1,1"
+	cset "name='AMIC Volume' 3"
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
2.7.4
