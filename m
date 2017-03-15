From: fuweix.tang@intel.com
Subject: [PATCH v1 2/3] ucm-conf: broxton: add broxton-rt298
	conf files
Date: Wed, 15 Mar 2017 14:47:02 +0800
Message-ID: <dfa8a7e8c1a6ea2014019a7a9761e56c6f9c8d4c.1487897097.git.fuweix.tang@intel.com>
References: <cover.1487897097.git.fuweix.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 66010266FA8
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 07:46:58 +0100 (CET)
In-Reply-To: <cover.1487897097.git.fuweix.tang@intel.com>
In-Reply-To: <cover.1487897097.git.fuweix.tang@intel.com>
References: <cover.1487897097.git.fuweix.tang@intel.com>
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
Cc: Nishit Sharma <nishitx.sharma@intel.com>, G Kranthi <gudishax.kranthikumar@intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, Fuwei Tang <fuweix.tang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

This adds the UCM conf files for broxton enabling with rt298 codec on
I2S audio, HDMI and DMIC ports.

This patch is based on commit 360c976aaa05 ("conf/ucm: broxton: add broxton-rt298 conf files")
from alsa-lib by Vinod Koul <vinod.koul@intel.com>.
Original authorship is retained.

Signed-off-by: Nishit Sharma <nishitx.sharma@intel.com>
Signed-off-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Fuwei Tang <fuweix.tang@intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Reviewed-by: Vinod Koul <vinod.koul@intel.com>
Reviewed-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/Makefile.am b/Makefile.am
index e2baa04..5f86692 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -1 +1 @@
-SUBDIRS=
+SUBDIRS=broxton-rt298
diff --git a/broxton-rt298/Hdmi1 b/broxton-rt298/Hdmi1
new file mode 100644
index 0000000..48514f4
--- /dev/null
+++ b/broxton-rt298/Hdmi1
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
diff --git a/broxton-rt298/Hdmi2 b/broxton-rt298/Hdmi2
new file mode 100644
index 0000000..764f8b9
--- /dev/null
+++ b/broxton-rt298/Hdmi2
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
diff --git a/broxton-rt298/HiFi b/broxton-rt298/HiFi
new file mode 100644
index 0000000..2e2d6fe
--- /dev/null
+++ b/broxton-rt298/HiFi
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
diff --git a/broxton-rt298/Makefile.am b/broxton-rt298/Makefile.am
new file mode 100644
index 0000000..80f480e
--- /dev/null
+++ b/broxton-rt298/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/broxton-rt298
+ucm_DATA = broxton-rt298.conf HiFi Hdmi1 Hdmi2
+EXTRA_DIST = $(ucm_DATA)
diff --git a/broxton-rt298/broxton-rt298.conf b/broxton-rt298/broxton-rt298.conf
new file mode 100644
index 0000000..3f3d0be
--- /dev/null
+++ b/broxton-rt298/broxton-rt298.conf
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
diff --git a/configure.ac b/configure.ac
index 8aac3c8..1105dfc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -13,7 +13,8 @@ AM_INIT_AUTOMAKE
 # Checks for typedefs, structures, and compiler characteristics.
 
 # Checks for library functions.
-AC_CONFIG_FILES([Makefile])
+AC_CONFIG_FILES([Makefile
+		 broxton-rt298/Makefile])
 
 ALSA_CONFIG_DIR="/usr/share/alsa"
 AC_SUBST(ALSA_CONFIG_DIR)
-- 
2.7.4
