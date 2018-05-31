From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/5] conf/ucm: bytcr-rt5640: Add generic
	bytcr-rt5640 UCM profile
Date: Thu, 31 May 2018 17:10:22 +0200
Message-ID: <20180531151026.29521-2-hdegoede@redhat.com>
References: <20180531151026.29521-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CE7A26792B
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 17:10:30 +0200 (CEST)
In-Reply-To: <20180531151026.29521-1-hdegoede@redhat.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This commit adds the generic UCM profile for bytcr-rt5640 boards from:
https://github.com/plbossart/UCM, plus the fixes from this pull-req:
https://github.com/plbossart/UCM/pull/31

The profile has been split up into separate per input / output files to
allow for creation of long-name profiles with the specific input / output
combinations found on a board without needing to copy and paste things.

Note this profile exports all inputs and both stereo/mono speaker setups
even though a typical device will not use all. Ideally a long-name based
device specific profile made up of the various parts should be used
instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                                |   3 +
 src/conf/ucm/Makefile.am                    |   3 +
 src/conf/ucm/bytcr-rt5640/HiFi.conf         |  29 +++++
 src/conf/ucm/bytcr-rt5640/Makefile.am       |   4 +
 src/conf/ucm/bytcr-rt5640/bytcr-rt5640.conf |   8 ++
 src/conf/ucm/bytcr/Makefile.am              |   4 +
 src/conf/ucm/bytcr/PlatformEnableSeq.conf   | 115 ++++++++++++++++++++
 src/conf/ucm/rt5640/DigitalMics.conf        |  31 ++++++
 src/conf/ucm/rt5640/EnableSeq.conf          |  41 +++++++
 src/conf/ucm/rt5640/HeadPhones.conf         |  41 +++++++
 src/conf/ucm/rt5640/HeadsetMic.conf         |  48 ++++++++
 src/conf/ucm/rt5640/IN1-InternalMic.conf    |  50 +++++++++
 src/conf/ucm/rt5640/IN3-InternalMic.conf    |  50 +++++++++
 src/conf/ucm/rt5640/Makefile.am             |   5 +
 src/conf/ucm/rt5640/MonoSpeaker.conf        |  45 ++++++++
 src/conf/ucm/rt5640/Speaker.conf            |  45 ++++++++
 16 files changed, 522 insertions(+)
 create mode 100644 src/conf/ucm/bytcr-rt5640/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5640/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5640/bytcr-rt5640.conf
 create mode 100644 src/conf/ucm/bytcr/Makefile.am
 create mode 100644 src/conf/ucm/bytcr/PlatformEnableSeq.conf
 create mode 100644 src/conf/ucm/rt5640/DigitalMics.conf
 create mode 100644 src/conf/ucm/rt5640/EnableSeq.conf
 create mode 100644 src/conf/ucm/rt5640/HeadPhones.conf
 create mode 100644 src/conf/ucm/rt5640/HeadsetMic.conf
 create mode 100644 src/conf/ucm/rt5640/IN1-InternalMic.conf
 create mode 100644 src/conf/ucm/rt5640/IN3-InternalMic.conf
 create mode 100644 src/conf/ucm/rt5640/Makefile.am
 create mode 100644 src/conf/ucm/rt5640/MonoSpeaker.conf
 create mode 100644 src/conf/ucm/rt5640/Speaker.conf

diff --git a/configure.ac b/configure.ac
index 693b5d53..f6ee6ca8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -720,6 +720,8 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/Makefile \
 	  src/conf/ucm/broadwell-rt286/Makefile \
 	  src/conf/ucm/broxton-rt298/Makefile \
+	  src/conf/ucm/bytcr/Makefile \
+	  src/conf/ucm/bytcr-rt5640/Makefile \
 	  src/conf/ucm/bytcr-rt5651/Makefile \
 	  src/conf/ucm/chtrt5645/Makefile \
 	  src/conf/ucm/chtrt5645-mono-speaker-analog-mic/Makefile \
@@ -734,6 +736,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/PandaBoard/Makefile \
 	  src/conf/ucm/PandaBoardES/Makefile \
 	  src/conf/ucm/PAZ00/Makefile \
+	  src/conf/ucm/rt5640/Makefile \
 	  src/conf/ucm/SDP4430/Makefile \
 	  src/conf/ucm/skylake-rt286/Makefile \
 	  src/conf/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 38fc6b25..dc2d6857 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -2,6 +2,8 @@ SUBDIRS=\
 ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN \
 broadwell-rt286 \
 broxton-rt298 \
+bytcr \
+bytcr-rt5640 \
 bytcr-rt5651 \
 chtrt5645 \
 chtrt5645-mono-speaker-analog-mic \
@@ -16,6 +18,7 @@ LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216 \
 PandaBoard \
 PandaBoardES \
 PAZ00 \
+rt5640 \
 SDP4430 \
 skylake-rt286 \
 TECLAST-X80Pro-Defaultstring-CherryTrailCR \
diff --git a/src/conf/ucm/bytcr-rt5640/HiFi.conf b/src/conf/ucm/bytcr-rt5640/HiFi.conf
new file mode 100644
index 00000000..130671ca
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640/HiFi.conf
@@ -0,0 +1,29 @@
+# Use case Configuration for bytcr-rt5640
+
+<searchdir:ucm>
+
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+		<bytcr/PlatformEnableSeq.conf>
+		<rt5640/EnableSeq.conf>
+	]
+
+	DisableSequence [
+	]
+
+	Value {
+		PlaybackPCM "hw:bytcrrt5640"
+		CapturePCM "hw:bytcrrt5640"
+	}
+}
+
+<rt5640/Speaker.conf>
+<rt5640/MonoSpeaker.conf>
+<rt5640/HeadPhones.conf>
+
+<rt5640/DigitalMics.conf>
+<rt5640/IN1-InternalMic.conf>
+<rt5640/IN3-InternalMic.conf>
+<rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640/Makefile.am b/src/conf/ucm/bytcr-rt5640/Makefile.am
new file mode 100644
index 00000000..84ddf7b1
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5640
+ucm_DATA = bytcr-rt5640.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5640/bytcr-rt5640.conf b/src/conf/ucm/bytcr-rt5640/bytcr-rt5640.conf
new file mode 100644
index 00000000..676b4fd9
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640/bytcr-rt5640.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5640"
+]
diff --git a/src/conf/ucm/bytcr/Makefile.am b/src/conf/ucm/bytcr/Makefile.am
new file mode 100644
index 00000000..a0e5545e
--- /dev/null
+++ b/src/conf/ucm/bytcr/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr
+ucm_DATA = PlatformEnableSeq.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr/PlatformEnableSeq.conf b/src/conf/ucm/bytcr/PlatformEnableSeq.conf
new file mode 100644
index 00000000..b5ee2b41
--- /dev/null
+++ b/src/conf/ucm/bytcr/PlatformEnableSeq.conf
@@ -0,0 +1,115 @@
+# media mixer settings
+#   compress
+cset "name='media0_in Gain 0 Switch' on"
+cset "name='media0_in Gain 0 Volume' 0"
+
+#   normal
+cset "name='media1_in Gain 0 Switch' on"
+cset "name='media1_in Gain 0 Volume' 0"
+#   swm loopback
+cset "name='media2_in Gain 0 Switch' off"
+cset "name='media2_in Gain 0 Volume' 0%"
+#   deep buffer
+cset "name='media3_in Gain 0 Switch' on"
+cset "name='media3_in Gain 0 Volume' 0"
+
+cset "name='media0_out mix 0 media0_in Switch' on"
+cset "name='media0_out mix 0 media1_in Switch' on"
+cset "name='media0_out mix 0 media2_in Switch' off"
+cset "name='media0_out mix 0 media3_in Switch' on"
+
+cset "name='media1_out mix 0 media0_in Switch' off"
+cset "name='media1_out mix 0 media1_in Switch' off"
+cset "name='media1_out mix 0 media2_in Switch' off"
+cset "name='media1_out mix 0 media3_in Switch' off"
+
+cset "name='pcm0_in Gain 0 Switch' on"
+cset "name='pcm0_in Gain 0 Volume' 0"
+
+cset "name='pcm1_in Gain 0 Switch' off"
+cset "name='pcm1_in Gain 0 Volume' 0%"
+
+# codec0_out settings (used if SSP2 is connected)
+cset "name='codec_out0 mix 0 codec_in0 Switch' off"
+cset "name='codec_out0 mix 0 codec_in1 Switch' off"
+cset "name='codec_out0 mix 0 media_loop1_in Switch' off"
+cset "name='codec_out0 mix 0 media_loop2_in Switch' off"
+cset "name='codec_out0 mix 0 pcm0_in Switch' on"
+cset "name='codec_out0 mix 0 pcm1_in Switch' off"
+cset "name='codec_out0 mix 0 sprot_loop_in Switch' off"
+cset "name='codec_out0 Gain 0 Switch' on"
+cset "name='codec_out0 Gain 0 Volume' 0"
+
+# modem_out settings (used if SSP0 is connected)
+cset "name='modem_out mix 0 codec_in0 Switch' off"
+cset "name='modem_out mix 0 codec_in1 Switch' off"
+cset "name='modem_out mix 0 media_loop1_in Switch' off"
+cset "name='modem_out mix 0 media_loop2_in Switch' off"
+cset "name='modem_out mix 0 pcm0_in Switch' on"
+cset "name='modem_out mix 0 pcm1_in Switch' off"
+cset "name='modem_out mix 0 sprot_loop_in Switch' off"
+cset "name='modem_out Gain 0 Switch' on"
+cset "name='modem_out Gain 0 Volume' 0"
+
+# input settings
+
+# input used when SSP2 is connected
+cset "name='codec_in0 Gain 0 Switch' on"
+cset "name='codec_in0 Gain 0 Volume' 0"
+
+# input used when SSP0 is connected
+cset "name='modem_in Gain 0 Switch' on"
+cset "name='modem_in Gain 0 Volume' 0"
+
+# pcm1_out settings
+cset "name='pcm1_out mix 0 codec_in0 Switch' on"
+cset "name='pcm1_out mix 0 modem_in Switch' on"
+cset "name='pcm1_out mix 0 codec_in1 Switch' off"
+cset "name='pcm1_out mix 0 media_loop1_in Switch' off"
+cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
+cset "name='pcm1_out mix 0 pcm0_in Switch' off"
+cset "name='pcm1_out mix 0 pcm1_in Switch' off"
+cset "name='pcm1_out mix 0 sprot_loop_in Switch' off"
+
+cset "name='pcm1_out Gain 0 Switch' on"
+cset "name='pcm1_out Gain 0 Volume' 0"
+
+# disable codec_out1
+cset "name='codec_out1 mix 0 codec_in0 Switch' off"
+cset "name='codec_out1 mix 0 codec_in1 Switch' off"
+cset "name='codec_out1 mix 0 media_loop1_in Switch' off"
+cset "name='codec_out1 mix 0 media_loop2_in Switch' off"
+cset "name='codec_out1 mix 0 pcm0_in Switch' off"
+cset "name='codec_out1 mix 0 pcm1_in Switch' off"
+cset "name='codec_out1 mix 0 sprot_loop_in Switch' off"
+cset "name='codec_out1 Gain 0 Switch' off"
+cset "name='codec_out1 Gain 0 Volume' 0%"
+
+# disable codec_in1
+cset "name='codec_in1 Gain 0 Switch' off"
+cset "name='codec_in1 Gain 0 Volume' 0%"
+
+# disable all loops
+cset "name='media_loop1_out mix 0 codec_in0 Switch' off"
+cset "name='media_loop1_out mix 0 codec_in1 Switch' off"
+cset "name='media_loop1_out mix 0 media_loop1_in Switch' off"
+cset "name='media_loop1_out mix 0 media_loop2_in Switch' off"
+cset "name='media_loop1_out mix 0 pcm0_in Switch' off"
+cset "name='media_loop1_out mix 0 pcm1_in Switch' off"
+cset "name='media_loop1_out mix 0 sprot_loop_in Switch' off"
+
+cset "name='media_loop2_out mix 0 codec_in0 Switch' off"
+cset "name='media_loop2_out mix 0 codec_in1 Switch' off"
+cset "name='media_loop2_out mix 0 media_loop1_in Switch' off"
+cset "name='media_loop2_out mix 0 media_loop2_in Switch' off"
+cset "name='media_loop2_out mix 0 pcm0_in Switch' off"
+cset "name='media_loop2_out mix 0 pcm1_in Switch' off"
+cset "name='media_loop2_out mix 0 sprot_loop_in Switch' off"
+
+cset "name='sprot_loop_out mix 0 codec_in0 Switch' off"
+cset "name='sprot_loop_out mix 0 codec_in1 Switch' off"
+cset "name='sprot_loop_out mix 0 media_loop1_in Switch' off"
+cset "name='sprot_loop_out mix 0 media_loop2_in Switch' off"
+cset "name='sprot_loop_out mix 0 pcm0_in Switch' off"
+cset "name='sprot_loop_out mix 0 pcm1_in Switch' off"
+cset "name='sprot_loop_out mix 0 sprot_loop_in Switch' off"
diff --git a/src/conf/ucm/rt5640/DigitalMics.conf b/src/conf/ucm/rt5640/DigitalMics.conf
new file mode 100644
index 00000000..c7d54099
--- /dev/null
+++ b/src/conf/ucm/rt5640/DigitalMics.conf
@@ -0,0 +1,31 @@
+SectionDevice."DigitalMics" {
+	Comment "DigitalMics capture"
+
+	ConflictingDevice [
+		"IN1-InternalMics"
+		"IN3-InternalMics"
+		"HeadsetMic"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+		cset "name='Stereo ADC MIXL ADC2 Switch' on"
+		cset "name='Stereo ADC MIXR ADC2 Switch' on"
+		cset "name='Internal Mic Switch' on"
+
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5640"
+
+		cset "name='Stereo ADC MIXL ADC2 Switch' off"
+		cset "name='Stereo ADC MIXR ADC2 Switch' off"
+		cset "name='Internal Mic Switch' off"
+
+	]
+
+	Value {
+		CaptureChannels 2
+	}
+}
diff --git a/src/conf/ucm/rt5640/EnableSeq.conf b/src/conf/ucm/rt5640/EnableSeq.conf
new file mode 100644
index 00000000..62795fa6
--- /dev/null
+++ b/src/conf/ucm/rt5640/EnableSeq.conf
@@ -0,0 +1,41 @@
+# RT5640 default output routing
+cset "name='OUT MIXL DAC L1 Switch'  on"
+cset "name='OUT MIXR DAC R1 Switch'  on"
+
+# uncomment for loopback mic->speakers
+# cset "name='SPOL MIX BST1 Switch' on"
+# cset "name='SPOR MIX BST1 Switch' on"
+
+# uncomment for loopback playback -> capture
+# cset "name='RECMIXL OUT MIXL Switch' on"
+# cset "name='RECMIXR OUT MIXR Switch' on"
+
+# uncomment to enable swap between AIF1 and AIF2
+# warning: can only work with SSP0 firmware enabled
+cset "name='SDI select' 0"
+cset "name='DAI select' 0"
+#cset "name='SDI select' 1"
+#cset "name='DAI select' 1"
+
+cset "name='DAC2 Playback Switch' on"
+cset "name='DIG MIXL DAC L2 Switch' on"
+
+# Input Configuration
+cset "name='Stereo ADC1 Mux' ADC"
+cset "name='Stereo ADC2 Mux' DMIC1"
+cset "name='Mono ADC L1 Mux' 1"
+cset "name='Mono ADC R1 Mux' 1"
+
+# 47=0dB, 0.375 dB/step, set it to 6 dB to help with soft mics
+cset "name='ADC Capture Volume' 63"
+# Set ADC Boost Gain to 3dB higher vals result in too much noise
+cset "name='ADC Boost Gain' 1"
+# Set IN1/IN3 internal mic boost to 8 (max)
+# Set IN2 headset-mic boost to 1, headset mics are quite loud
+cset "name='IN1 Boost' 8"
+cset "name='IN2 Boost' 1"
+cset "name='IN3 Boost' 8"
+
+cset "name='Internal Mic Switch' off"
+cset "name='Headset Mic Switch' off"
+cset "name='ADC Capture Switch' on"
diff --git a/src/conf/ucm/rt5640/HeadPhones.conf b/src/conf/ucm/rt5640/HeadPhones.conf
new file mode 100644
index 00000000..0e7149e5
--- /dev/null
+++ b/src/conf/ucm/rt5640/HeadPhones.conf
@@ -0,0 +1,41 @@
+SectionDevice."Headphones" {
+	Comment "Headphones playback"
+
+	ConflictingDevice [
+		"Speaker"
+		"MonoSpeaker"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+ 		cset "name='DAC MIXL INF1 Switch'  on"
+ 		cset "name='DAC MIXR INF1 Switch'  on"
+ 		cset "name='Stereo DAC MIXL DAC L1 Switch'  on"
+ 		cset "name='Stereo DAC MIXR DAC R1 Switch'  on"
+		cset "name='Stereo DAC MIXL DAC L2 Switch'  on"
+ 		cset "name='Stereo DAC MIXR DAC R2 Switch'  on"
+ 		cset "name='HPO MIX HPVOL Switch'  on"
+ 		cset "name='Headphone Switch'  on"
+		cset "name='HP Channel Switch' on"
+ 		cset "name='Speaker Switch' off"
+		cset "name='HP L Playback Switch' on"
+		cset "name='HP R Playback Switch' on"
+		cset "name='HP Playback Volume' 29"
+
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5640"
+		cset "name='Headphone Switch' off"
+		cset "name='HP Channel Switch' off"
+		cset "name='HP L Playback Switch' off"
+		cset "name='HP R Playback Switch' off"
+		cset "name='HP Playback Volume' 0"
+	]
+
+	Value {
+		PlaybackChannels "2"
+		JackControl "Headphone Jack"
+	}
+}
diff --git a/src/conf/ucm/rt5640/HeadsetMic.conf b/src/conf/ucm/rt5640/HeadsetMic.conf
new file mode 100644
index 00000000..4d54eed0
--- /dev/null
+++ b/src/conf/ucm/rt5640/HeadsetMic.conf
@@ -0,0 +1,48 @@
+SectionDevice."HeadsetMic" {
+	Comment "Headset Mic capture"
+
+	ConflictingDevice [
+		"IN1-InternalMics"
+		"IN3-InternalMics"
+		"DigitalMics"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+		cset "name='Headset Mic Switch' on"
+
+		cset "name='RECMIXL BST2 Switch' on"
+		cset "name='RECMIXR BST2 Switch' on"
+
+		cset "name='Stereo ADC MIXL ADC1 Switch' on"
+		cset "name='Stereo ADC MIXR ADC1 Switch' on"
+
+		cset "name='Mono ADC MIXL ADC1 Switch' on"
+		cset "name='Mono ADC MIXR ADC1 Switch' on"
+
+		cset "name='Mono ADC Capture Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5640"
+
+		cset "name='Stereo ADC MIXL ADC1 Switch' off"
+		cset "name='Stereo ADC MIXR ADC1 Switch' off"
+
+		cset "name='RECMIXL BST2 Switch' off"
+		cset "name='RECMIXR BST2 Switch' off"
+
+		cset "name='Headset Mic Switch' off"
+
+		cset "name='Mono ADC MIXL ADC1 Switch' off"
+		cset "name='Mono ADC MIXR ADC1 Switch' off"
+
+		cset "name='Mono ADC Capture Switch' off"
+	]
+
+	Value {
+		CaptureChannels 2
+		JackControl "Headset Mic Jack"
+	}
+}
diff --git a/src/conf/ucm/rt5640/IN1-InternalMic.conf b/src/conf/ucm/rt5640/IN1-InternalMic.conf
new file mode 100644
index 00000000..d18c21db
--- /dev/null
+++ b/src/conf/ucm/rt5640/IN1-InternalMic.conf
@@ -0,0 +1,50 @@
+SectionDevice."IN1-InternalMics" {
+	Comment "Internal IN1 analog Mic capture"
+
+	ConflictingDevice [
+		"DigitalMics"
+		"HeadsetMic"
+		"IN3-InternalMics"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+		cset "name='Internal Mic Switch' on"
+
+		cset "name='RECMIXL BST1 Switch' on"
+		cset "name='RECMIXR BST1 Switch' on"
+		cset "name='RECMIXL BST3 Switch' off"
+		cset "name='RECMIXR BST3 Switch' off"
+
+		cset "name='Stereo ADC MIXL ADC1 Switch' on"
+		cset "name='Stereo ADC MIXR ADC1 Switch' on"
+
+		cset "name='Mono ADC MIXL ADC1 Switch' on"
+		cset "name='Mono ADC MIXR ADC1 Switch' on"
+
+		cset "name='Mono ADC Capture Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5640"
+
+		cset "name='Stereo ADC MIXL ADC1 Switch' off"
+		cset "name='Stereo ADC MIXR ADC1 Switch' off"
+
+		cset "name='RECMIXL BST1 Switch' off"
+		cset "name='RECMIXR BST1 Switch' off"
+
+		cset "name='Internal Mic Switch' off"
+
+		cset "name='Mono ADC MIXL ADC1 Switch' off"
+		cset "name='Mono ADC MIXR ADC1 Switch' off"
+
+		cset "name='Mono ADC Capture Switch' off"
+
+	]
+
+	Value {
+		CaptureChannels 2
+	}
+}
diff --git a/src/conf/ucm/rt5640/IN3-InternalMic.conf b/src/conf/ucm/rt5640/IN3-InternalMic.conf
new file mode 100644
index 00000000..17d85229
--- /dev/null
+++ b/src/conf/ucm/rt5640/IN3-InternalMic.conf
@@ -0,0 +1,50 @@
+SectionDevice."IN3-InternalMics" {
+	Comment "Internal IN3 analog Mic capture"
+
+	ConflictingDevice [
+		"DigitalMics"
+		"HeadsetMic"
+		"IN1-InternalMics"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+		cset "name='Internal Mic Switch' on"
+
+		cset "name='RECMIXL BST1 Switch' off"
+		cset "name='RECMIXR BST1 Switch' off"
+		cset "name='RECMIXL BST3 Switch' on"
+		cset "name='RECMIXR BST3 Switch' on"
+
+		cset "name='Stereo ADC MIXL ADC1 Switch' on"
+		cset "name='Stereo ADC MIXR ADC1 Switch' on"
+
+		cset "name='Mono ADC MIXL ADC1 Switch' on"
+		cset "name='Mono ADC MIXR ADC1 Switch' on"
+
+		cset "name='Mono ADC Capture Switch' on"
+
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5640"
+
+		cset "name='Stereo ADC MIXL ADC1 Switch' off"
+		cset "name='Stereo ADC MIXR ADC1 Switch' off"
+
+		cset "name='RECMIXL BST3 Switch' off"
+		cset "name='RECMIXR BST3 Switch' off"
+
+		cset "name='Internal Mic Switch' off"
+
+		cset "name='Mono ADC MIXL ADC1 Switch' off"
+		cset "name='Mono ADC MIXR ADC1 Switch' off"
+
+		cset "name='Mono ADC Capture Switch' off"
+	]
+
+	Value {
+		CaptureChannels 2
+	}
+}
diff --git a/src/conf/ucm/rt5640/Makefile.am b/src/conf/ucm/rt5640/Makefile.am
new file mode 100644
index 00000000..a6fbdc57
--- /dev/null
+++ b/src/conf/ucm/rt5640/Makefile.am
@@ -0,0 +1,5 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/rt5640
+ucm_DATA = DigitalMics.conf EnableSeq.conf HeadPhones.conf HeadsetMic.conf \
+	IN1-InternalMic.conf IN3-InternalMic.conf MonoSpeaker.conf Speaker.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/rt5640/MonoSpeaker.conf b/src/conf/ucm/rt5640/MonoSpeaker.conf
new file mode 100644
index 00000000..0fb54030
--- /dev/null
+++ b/src/conf/ucm/rt5640/MonoSpeaker.conf
@@ -0,0 +1,45 @@
+SectionDevice."MonoSpeaker" {
+	Comment "MonoSpeaker playback"
+
+	ConflictingDevice [
+		"Headphones"
+		"Speaker"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+		cset "name='DAC MIXL INF1 Switch' on"
+		cset "name='DAC MIXR INF1 Switch' on"
+		cset "name='Stereo DAC MIXL DAC L1 Switch' on"
+		cset "name='Stereo DAC MIXR DAC R1 Switch' on"
+		cset "name='Stereo DAC MIXL DAC L2 Switch'  on"
+		cset "name='Stereo DAC MIXR DAC R2 Switch'  on"
+		cset "name='SPK MIXL DAC L1 Switch' on"
+		cset "name='SPK MIXR DAC R1 Switch' on"
+		cset "name='SPOL MIX SPKVOL L Switch' on"
+# for mono speaker we apply left on right
+#		cset "name='SPOR MIX SPKVOL R Switch' on"
+		cset "name='SPOL MIX SPKVOL R Switch' on"
+		cset "name='Speaker Switch' on"
+		cset "name='Speaker Channel Switch' on"
+		cset "name='Headphone Switch' off"
+		cset "name='Speaker L Playback Switch' on"
+		cset "name='Speaker R Playback Switch' on"
+		cset "name='Speaker Playback Volume' 35"
+
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5640"
+		cset "name='Speaker Switch' off"
+		cset "name='Speaker Channel Switch' off"
+		cset "name='Speaker L Playback Switch' off"
+		cset "name='Speaker R Playback Switch' off"
+		cset "name='Speaker Playback Volume' 0"
+	]
+
+	Value {
+		PlaybackChannels "2"
+	}
+}
diff --git a/src/conf/ucm/rt5640/Speaker.conf b/src/conf/ucm/rt5640/Speaker.conf
new file mode 100644
index 00000000..b745ed06
--- /dev/null
+++ b/src/conf/ucm/rt5640/Speaker.conf
@@ -0,0 +1,45 @@
+SectionDevice."Speaker" {
+	Comment "Speaker playback"
+
+	ConflictingDevice [
+		"Headphones"
+		"MonoSpeaker"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+		cset "name='DAC MIXL INF1 Switch' on"
+		cset "name='DAC MIXR INF1 Switch' on"
+		cset "name='Stereo DAC MIXL DAC L1 Switch' on"
+		cset "name='Stereo DAC MIXR DAC R1 Switch' on"
+		cset "name='Stereo DAC MIXL DAC L2 Switch'  on"
+ 		cset "name='Stereo DAC MIXR DAC R2 Switch'  on"
+		cset "name='SPK MIXL DAC L1 Switch' on"
+		cset "name='SPK MIXR DAC R1 Switch' on"
+		cset "name='SPOL MIX SPKVOL L Switch' on"
+		cset "name='SPOR MIX SPKVOL R Switch' on"
+		# undo MonoSpeaker mixing of right channel to left speaker
+		cset "name='SPOL MIX SPKVOL R Switch' off"
+		cset "name='Speaker Switch' on"
+		cset "name='Speaker Channel Switch' on"
+		cset "name='Headphone Switch' off"
+		cset "name='Speaker L Playback Switch' on"
+		cset "name='Speaker R Playback Switch' on"
+		cset "name='Speaker Playback Volume' 35"
+
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5640"
+		cset "name='Speaker Switch' off"
+		cset "name='Speaker Channel Switch' off"
+		cset "name='Speaker L Playback Switch' off"
+		cset "name='Speaker R Playback Switch' off"
+		cset "name='Speaker Playback Volume' 0"
+	]
+
+	Value {
+		PlaybackChannels "2"
+	}
+}
-- 
2.17.0
