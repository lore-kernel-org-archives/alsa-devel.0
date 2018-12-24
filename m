From: Hui Wang <hui.wang@canonical.com>
Subject: [alsa-lib][PATCH] conf/ucm: kblrt5660: Add ucm setting
	for Dell Edge IoT platform
Date: Mon, 24 Dec 2018 16:34:46 +0800
Message-ID: <20181224083446.5806-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 514C82678D5
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2018 09:34:58 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

The new generation of Dell Edge IoT platform is based on Intel
Kabylake platform, and the audio codec is ALC3277 which is 100%
compatible with RT5660 in I2S mode.

The audio design on this IoT platform is as below:
 - Intel kabylake platform
 - connect the codec ALC3277 via SSP0
 - line-out and line-in with Micbias jacks
 - line-out mute control and jack detection of line-out and line-in
 - two HDMI ports with audio capability

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 configure.ac                          |  1 +
 src/conf/ucm/Makefile.am              |  1 +
 src/conf/ucm/kblrt5660/Hdmi1          | 20 +++++++
 src/conf/ucm/kblrt5660/Hdmi2          | 20 +++++++
 src/conf/ucm/kblrt5660/HiFi           | 85 +++++++++++++++++++++++++++
 src/conf/ucm/kblrt5660/Makefile.am    |  4 ++
 src/conf/ucm/kblrt5660/kblrt5660.conf | 18 ++++++
 7 files changed, 149 insertions(+)
 create mode 100755 src/conf/ucm/kblrt5660/Hdmi1
 create mode 100755 src/conf/ucm/kblrt5660/Hdmi2
 create mode 100755 src/conf/ucm/kblrt5660/HiFi
 create mode 100755 src/conf/ucm/kblrt5660/Makefile.am
 create mode 100755 src/conf/ucm/kblrt5660/kblrt5660.conf

diff --git a/configure.ac b/configure.ac
index d0cab2d6..6185a7eb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -745,6 +745,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/gpd-win-pocket-rt5645/Makefile \
 	  src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile \
 	  src/conf/ucm/HDAudio-Lenovo-DualCodecs/Makefile \
+	  src/conf/ucm/kblrt5660/Makefile \
 	  src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/Makefile \
 	  src/conf/ucm/PandaBoard/Makefile \
 	  src/conf/ucm/PandaBoardES/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 85c15090..993d02bb 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -29,6 +29,7 @@ GoogleNyan \
 gpd-win-pocket-rt5645 \
 HDAudio-Gigabyte-ALC1220DualCodecs \
 HDAudio-Lenovo-DualCodecs \
+kblrt5660 \
 LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216 \
 PandaBoard \
 PandaBoardES \
diff --git a/src/conf/ucm/kblrt5660/Hdmi1 b/src/conf/ucm/kblrt5660/Hdmi1
new file mode 100755
index 00000000..95e6187a
--- /dev/null
+++ b/src/conf/ucm/kblrt5660/Hdmi1
@@ -0,0 +1,20 @@
+# Usecase for device HDMI1/Display Port stereo playback on Intel KABYLAKE platforms
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
+                PlaybackPCM "hw:kblrt5660,2"
+                PlaybackChannels "2"
+                PlaybackPriority "2"
+                JackControl "HDMI/DP, pcm=4 Jack"
+        }
+}
+
diff --git a/src/conf/ucm/kblrt5660/Hdmi2 b/src/conf/ucm/kblrt5660/Hdmi2
new file mode 100755
index 00000000..f6d2feee
--- /dev/null
+++ b/src/conf/ucm/kblrt5660/Hdmi2
@@ -0,0 +1,20 @@
+# Usecase for device HDMI2/Display Port stereo playback on Intel KABYLAKE platforms
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
+                PlaybackPCM "hw:kblrt5660,3"
+                PlaybackChannels "2"
+                PlaybackPriority "3"
+                JackControl "HDMI/DP, pcm=5 Jack"
+        }
+}
+
diff --git a/src/conf/ucm/kblrt5660/HiFi b/src/conf/ucm/kblrt5660/HiFi
new file mode 100755
index 00000000..dbdb9006
--- /dev/null
+++ b/src/conf/ucm/kblrt5660/HiFi
@@ -0,0 +1,85 @@
+# UCM for Intel Kabylake platforms with RT5660
+# For Audio in I2S mode
+
+SectionVerb {
+
+	EnableSequence [
+	]
+
+	DisableSequence [
+	]
+
+	# ALSA PCM
+	Value {
+		# ALSA PCM device for HiFi
+		PlaybackPCM "hw:kblrt5660,0"
+		CapturePCM "hw:kblrt5660,1"
+	}
+}
+
+SectionDevice."LineOut" {
+	Comment "LineOut playback"
+
+	EnableSequence [
+		cdev "hw:kblrt5660"
+		cset "name='DAC1 Playback Volume' 30"
+		cset "name='OUT Playback Volume' 19"
+		cset "name='OUT Playback Switch' on"
+		cset "name='codec0_out mo media0_in mi Switch' on"
+		cset "name='DAC1 MIXL DAC1 Switch' on"
+		cset "name='DAC1 MIXR DAC1 Switch' on"
+		cset "name='Stereo DAC MIXL DAC L1 Switch' on"
+		cset "name='Stereo DAC MIXR DAC L1 Switch' off"
+		cset "name='Stereo DAC MIXR DAC R1 Switch' on"
+		cset "name='Stereo DAC MIXL DAC R1 Switch' off"
+		cset "name='LOUT MIX DAC Switch' on"
+		cset "name='Line Out Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:kblrt5660"
+		cset "name='Line Out Switch' off"
+		cset "name='DAC1 MIXL DAC1' off"
+		cset "name='DAC1 MIXR DAC1' off"
+	]
+
+	Value {
+		PlaybackChannels "2"
+		JackDev "rt5660-jack"
+		JackControl "Line Out Jack"
+	}
+}
+
+SectionDevice."LineIn" {
+	Comment "LineIn capture"
+
+	EnableSequence [
+		cdev "hw:kblrt5660"
+
+		cset "name='ADC Capture Volume' 30"
+		cset "name='IN1 Boost Volume' 30"
+		cset "name='IN2 Boost Volume' 30"
+		cset "name='STO1 ADC Boost Gain Volume' 1"
+		cset "name='RECMIXL BST1 Switch' off"
+		cset "name='RECMIXR BST1 Switch' on"
+		cset "name='RECMIXL BST2 Switch' on"
+		cset "name='RECMIXR BST2 Switch' off"
+		cset "name='Line In Switch' on"
+		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
+		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
+		cset "name='media0_out mo codec0_in mi Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:kblrt5660"
+		cset "name='Line In Switch' off"
+		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
+		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
+	]
+
+	Value {
+		CaptureChannels "2"
+		JackDev "rt5660-jack"
+		JackControl "Line In Jack"
+	}
+}
diff --git a/src/conf/ucm/kblrt5660/Makefile.am b/src/conf/ucm/kblrt5660/Makefile.am
new file mode 100755
index 00000000..83c3743a
--- /dev/null
+++ b/src/conf/ucm/kblrt5660/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/kblrt5660
+ucm_DATA = kblrt5660.conf HiFi Hdmi1 Hdmi2
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/kblrt5660/kblrt5660.conf b/src/conf/ucm/kblrt5660/kblrt5660.conf
new file mode 100755
index 00000000..c5e9420e
--- /dev/null
+++ b/src/conf/ucm/kblrt5660/kblrt5660.conf
@@ -0,0 +1,18 @@
+SectionUseCase."HiFi" {
+	File "HiFi"
+	Comment "Play HiFi quality Music"
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
+SectionDefaults [
+	cdev "hw:kblrt5660"
+]
-- 
2.17.1
