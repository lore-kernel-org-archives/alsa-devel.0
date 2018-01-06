From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] conf/ucm: Add
	chtrt5645-mono-speaker-analog-mic configuration
Date: Sat,  6 Jan 2018 23:03:20 +0100
Message-ID: <20180106220320.5423-2-hdegoede@redhat.com>
References: <20180106220320.5423-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id E1840266F7F
 for <alsa-devel@alsa-project.org>; Sat,  6 Jan 2018 23:03:24 +0100 (CET)
In-Reply-To: <20180106220320.5423-1-hdegoede@redhat.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

Add a configuration for Cherry Trail boards which use a rt5645 codec
connected to a mono speaker and with an analog mic on IN2N + IN2P.

The chtrt5645-mono-speaker-analog-mic/HiFi.conf for this is based on the
latest version from https://github.com/plbossart/UCM/tree/master/chtrt5645
with all the unused input options removed and some changes made to make
the analog mic work.

This commit also adds 2 ucm dirs with the longname of 2 boards known to use
this setup, which simply contain a symlink to the generic
chtrt5645-mono-speaker-analog-mic entry.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                                       |   3 +
 src/conf/ucm/Makefile.am                           |   3 +
 .../Makefile.am                                    |   4 +
 ...TECLAST-X80Pro-Defaultstring-CherryTrailCR.conf |   1 +
 .../chtrt5645-mono-speaker-analog-mic/HiFi.conf    | 361 +++++++++++++++++++++
 .../chtrt5645-mono-speaker-analog-mic/Makefile.am  |   4 +
 .../chtrt5645-mono-speaker-analog-mic.conf         |   5 +
 src/conf/ucm/gpd-win-pocket-rt5645/Makefile.am     |   4 +
 .../gpd-win-pocket-rt5645.conf                     |   1 +
 9 files changed, 386 insertions(+)
 create mode 100644 src/conf/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR/Makefile.am
 create mode 120000 src/conf/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR/TECLAST-X80Pro-Defaultstring-CherryTrailCR.conf
 create mode 100644 src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
 create mode 100644 src/conf/ucm/chtrt5645-mono-speaker-analog-mic/Makefile.am
 create mode 100644 src/conf/ucm/chtrt5645-mono-speaker-analog-mic/chtrt5645-mono-speaker-analog-mic.conf
 create mode 100644 src/conf/ucm/gpd-win-pocket-rt5645/Makefile.am
 create mode 120000 src/conf/ucm/gpd-win-pocket-rt5645/gpd-win-pocket-rt5645.conf

diff --git a/configure.ac b/configure.ac
index 47c50fcf..2c51ce75 100644
--- a/configure.ac
+++ b/configure.ac
@@ -713,9 +713,11 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/broxton-rt298/Makefile \
 	  src/conf/ucm/bytcr-rt5651/Makefile \
 	  src/conf/ucm/chtrt5645/Makefile \
+	  src/conf/ucm/chtrt5645-mono-speaker-analog-mic/Makefile \
 	  src/conf/ucm/DAISY-I2S/Makefile \
 	  src/conf/ucm/DB410c/Makefile \
 	  src/conf/ucm/GoogleNyan/Makefile \
+	  src/conf/ucm/gpd-win-pocket-rt5645/Makefile \
 	  src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile \
 	  src/conf/ucm/HDAudio-Lenovo-DualCodecs/Makefile \
 	  src/conf/ucm/PandaBoard/Makefile \
@@ -723,6 +725,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/PAZ00/Makefile \
 	  src/conf/ucm/SDP4430/Makefile \
 	  src/conf/ucm/skylake-rt286/Makefile \
+	  src/conf/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR/Makefile \
 	  src/conf/ucm/tegraalc5632/Makefile \
 	  src/conf/ucm/VEYRON-I2S/Makefile \
 	  src/conf/topology/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 954e32b8..3b4f13a8 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -3,9 +3,11 @@ broadwell-rt286 \
 broxton-rt298 \
 bytcr-rt5651 \
 chtrt5645 \
+chtrt5645-mono-speaker-analog-mic \
 DAISY-I2S \
 DB410c \
 GoogleNyan \
+gpd-win-pocket-rt5645 \
 HDAudio-Gigabyte-ALC1220DualCodecs \
 HDAudio-Lenovo-DualCodecs \
 PandaBoard \
@@ -13,5 +15,6 @@ PandaBoardES \
 PAZ00 \
 SDP4430 \
 skylake-rt286 \
+TECLAST-X80Pro-Defaultstring-CherryTrailCR \
 tegraalc5632 \
 VEYRON-I2S
diff --git a/src/conf/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR/Makefile.am b/src/conf/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR/Makefile.am
new file mode 100644
index 00000000..f56a817c
--- /dev/null
+++ b/src/conf/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR
+ucm_DATA = TECLAST-X80Pro-Defaultstring-CherryTrailCR.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR/TECLAST-X80Pro-Defaultstring-CherryTrailCR.conf b/src/conf/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR/TECLAST-X80Pro-Defaultstring-CherryTrailCR.conf
new file mode 120000
index 00000000..1b1d4754
--- /dev/null
+++ b/src/conf/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR/TECLAST-X80Pro-Defaultstring-CherryTrailCR.conf
@@ -0,0 +1 @@
+../chtrt5645-mono-speaker-analog-mic/chtrt5645-mono-speaker-analog-mic.conf
\ No newline at end of file
diff --git a/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
new file mode 100644
index 00000000..7a0cd51c
--- /dev/null
+++ b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
@@ -0,0 +1,361 @@
+SectionVerb {
+	# ALSA PCM
+	Value {
+		TQ "HiFi"
+
+		# ALSA PCM device for HiFi
+		PlaybackPCM "hw:chtrt5645"
+		CapturePCM "hw:chtrt5645"
+	}
+
+	EnableSequence [
+		cdev "hw:chtrt5645"
+
+		# media mixer settings
+		#   compress
+		cset "name='media0_in Gain 0 Switch' on"
+		cset "name='media0_in Gain 0 Volume' 0"
+
+		#   normal
+		cset "name='media1_in Gain 0 Switch' on"
+		cset "name='media1_in Gain 0 Volume' 0"
+		#   swm loopback
+		cset "name='media2_in Gain 0 Switch' off"
+		cset "name='media2_in Gain 0 Volume' 0%"
+		#   deep buffer
+		cset "name='media3_in Gain 0 Switch' on"
+		cset "name='media3_in Gain 0 Volume' 0"
+
+		cset "name='media0_out mix 0 media0_in Switch' on"
+		cset "name='media0_out mix 0 media1_in Switch' on"
+		cset "name='media0_out mix 0 media2_in Switch' off"
+		cset "name='media0_out mix 0 media3_in Switch' on"
+
+		cset "name='media1_out mix 0 media0_in Switch' off"
+		cset "name='media1_out mix 0 media1_in Switch' off"
+		cset "name='media1_out mix 0 media2_in Switch' off"
+		cset "name='media1_out mix 0 media3_in Switch' off"
+
+		cset "name='pcm0_in Gain 0 Switch' on"
+		cset "name='pcm0_in Gain 0 Volume' 0"
+
+		cset "name='pcm1_in Gain 0 Switch' off"
+		cset "name='pcm1_in Gain 0 Volume' 0%"
+
+		# codec0_out settings (used if ssp2 is connected to aif1)
+		cset "name='codec_out0 mix 0 codec_in0 Switch' off"
+		cset "name='codec_out0 mix 0 codec_in1 Switch' off"
+		cset "name='codec_out0 mix 0 media_loop1_in Switch' off"
+		cset "name='codec_out0 mix 0 media_loop2_in Switch' off"
+		cset "name='codec_out0 mix 0 pcm0_in Switch' on"
+		cset "name='codec_out0 mix 0 pcm1_in Switch' off"
+		cset "name='codec_out0 mix 0 sprot_loop_in Switch' off"
+		cset "name='codec_out0 Gain 0 Switch' on"
+		cset "name='codec_out0 Gain 0 Volume' 0"
+
+		# modem_out settings (used if ssp0 is connected to aif2)
+		cset "name='modem_out mix 0 codec_in0 Switch' off"
+		cset "name='modem_out mix 0 codec_in1 Switch' off"
+		cset "name='modem_out mix 0 media_loop1_in Switch' off"
+		cset "name='modem_out mix 0 media_loop2_in Switch' off"
+		cset "name='modem_out mix 0 pcm0_in Switch' on"
+		cset "name='modem_out mix 0 pcm1_in Switch' off"
+		cset "name='modem_out mix 0 sprot_loop_in Switch' off"
+		cset "name='modem_out Gain 0 Switch' on"
+		cset "name='modem_out Gain 0 Volume' 0"
+
+		# input settings
+		# pcm1_out settings
+
+		# input used when SSP2 is connected
+		cset "name='codec_in0 Gain 0 Switch' on"
+		cset "name='codec_in0 Gain 0 Volume' 0"
+
+		# input used when SSP0 is connected
+		cset "name='modem_in Gain 0 Switch' on"
+		cset "name='modem_in Gain 0 Volume' 0"
+
+		cset "name='pcm1_out mix 0 codec_in0 Switch' on"
+		cset "name='pcm1_out mix 0 modem_in Switch' on"
+		cset "name='pcm1_out mix 0 codec_in1 Switch' off"
+		cset "name='pcm1_out mix 0 media_loop1_in Switch' off"
+		cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
+		cset "name='pcm1_out mix 0 pcm0_in Switch' off"
+		cset "name='pcm1_out mix 0 pcm1_in Switch' off"
+		cset "name='pcm1_out mix 0 sprot_loop_in Switch' off"
+
+		cset "name='pcm1_out Gain 0 Switch' on"
+		cset "name='pcm1_out Gain 0 Volume' 0"
+
+		# disable codec_out1
+		cset "name='codec_out1 mix 0 codec_in0 Switch' off"
+		cset "name='codec_out1 mix 0 codec_in1 Switch' off"
+		cset "name='codec_out1 mix 0 media_loop1_in Switch' off"
+		cset "name='codec_out1 mix 0 media_loop2_in Switch' off"
+		cset "name='codec_out1 mix 0 pcm0_in Switch' off"
+		cset "name='codec_out1 mix 0 pcm1_in Switch' off"
+		cset "name='codec_out1 mix 0 sprot_loop_in Switch' off"
+		cset "name='codec_out1 Gain 0 Switch' off"
+		cset "name='codec_out1 Gain 0 Volume' 0%"
+
+		# disable codec_in1
+		cset "name='codec_in1 Gain 0 Switch' off"
+		cset "name='codec_in1 Gain 0 Volume' 0%"
+
+		# disable all loops
+		cset "name='media_loop1_out mix 0 codec_in0 Switch' off"
+		cset "name='media_loop1_out mix 0 codec_in1 Switch' off"
+		cset "name='media_loop1_out mix 0 media_loop1_in Switch' off"
+		cset "name='media_loop1_out mix 0 media_loop2_in Switch' off"
+		cset "name='media_loop1_out mix 0 pcm0_in Switch' off"
+		cset "name='media_loop1_out mix 0 pcm1_in Switch' off"
+		cset "name='media_loop1_out mix 0 sprot_loop_in Switch' off"
+
+		cset "name='media_loop2_out mix 0 codec_in0 Switch' off"
+		cset "name='media_loop2_out mix 0 codec_in1 Switch' off"
+		cset "name='media_loop2_out mix 0 media_loop1_in Switch' off"
+		cset "name='media_loop2_out mix 0 media_loop2_in Switch' off"
+		cset "name='media_loop2_out mix 0 pcm0_in Switch' off"
+		cset "name='media_loop2_out mix 0 pcm1_in Switch' off"
+		cset "name='media_loop2_out mix 0 sprot_loop_in Switch' off"
+
+		cset "name='sprot_loop_out mix 0 codec_in0 Switch' off"
+		cset "name='sprot_loop_out mix 0 codec_in1 Switch' off"
+		cset "name='sprot_loop_out mix 0 media_loop1_in Switch' off"
+		cset "name='sprot_loop_out mix 0 media_loop2_in Switch' off"
+		cset "name='sprot_loop_out mix 0 pcm0_in Switch' off"
+		cset "name='sprot_loop_out mix 0 pcm1_in Switch' off"
+		cset "name='sprot_loop_out mix 0 sprot_loop_in Switch' off"
+
+		# Output Configuration
+		cset "name='DAC1 L Mux' IF1 DAC"
+		cset "name='DAC1 R Mux' IF1 DAC"
+		cset "name='DAC1 MIXL DAC1 Switch' 1"
+		cset "name='DAC1 MIXR DAC1 Switch' 1"
+		cset "name='Stereo DAC MIXL DAC L1 Switch' 1"
+		cset "name='Stereo DAC MIXR DAC R1 Switch' 1"
+
+		cset "name='DAC L2 Mux' IF2 DAC"
+		cset "name='DAC R2 Mux' IF2 DAC"
+		cset "name='Mono DAC MIXL DAC L2 Switch' on"
+		cset "name='Mono DAC MIXR DAC R2 Switch' on"
+		cset "name='DAC2 Playback Switch' on"
+
+		cset "name='HPOVOL MIXL DAC1 Switch' on"
+		cset "name='HPOVOL MIXR DAC1 Switch' on"
+		cset "name='HPOVOL MIXL DAC2 Switch' on"
+		cset "name='HPOVOL MIXR DAC2 Switch' on"
+		cset "name='HPO MIX HPVOL Switch' on"
+		cset "name='HPOVOL L Switch' on"
+		cset "name='HPOVOL R Switch' on"
+
+		cset "name='SPK MIXL DAC L1 Switch' on"
+		cset "name='SPK MIXR DAC R1 Switch' on"
+		cset "name='SPK MIXL DAC L2 Switch' on"
+		cset "name='SPK MIXR DAC R2 Switch' on"
+		cset "name='SPOL MIX SPKVOL L Switch' on"
+		cset "name='SPOR MIX SPKVOL R Switch' on"
+		cset "name='SPKVOL L Switch' on"
+		cset "name='SPKVOL R Switch' on"
+
+		# Input Configuration
+		cset "name='Stereo1 DMIC Mux' 0"
+		cset "name='Stereo1 ADC1 Mux' 1"
+		cset "name='Stereo1 ADC2 Mux' 1"
+		cset "name='ADC Capture Switch' on"
+		# 55/63
+		cset "name='ADC Capture Volume' 55"
+		# set ADC Boost to 0/3, higher vals cause a lot of white noise
+		cset "name='ADC Boost Capture Volume' 0"
+		# 55/63
+		cset "name='Mono ADC Capture Volume' 55"
+		# 0/3
+		cset "name='Mono ADC Boost Capture Volume' 0"
+		# 27/31
+		cset "name='IN Capture Volume' 27"
+		cset "name='I2S2 Func Switch' on"
+		# 3/12 the headphone mic tends to be quite loud
+		cset "name='IN1 Boost' 3"
+		# 8/8 the internal analog mic tends to be quite soft
+		cset "name='IN2 Boost' 8"
+	]
+
+	DisableSequence [
+		cdev "hw:chtrt5645"
+
+		# Disable audio output path
+		cset "name='codec_out1 mix 0 pcm0_in Switch' off"
+		cset "name='media0_out mix 0 media1_in Switch' off"
+
+		cset "name='media1_in Gain 0 Switch' off"
+		cset "name='pcm0_in Gain 0 Switch' off"
+		cset "name='codec_out1 Gain 0 Switch' off"
+
+		# Disable audio input path
+		cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
+		cset "name='media_loop2_out mix 0 codec_in0 Switch' off"
+
+		cset "name='media_loop2_out Gain 0 Switch' off"
+		cset "name='pcm1_out Gain 0 Switch' off"
+		cset "name='codec_in0 Gain 0 Switch' off"
+	]
+}
+
+SectionDevice."Speaker" {
+	Comment "Speaker"
+
+	Value {
+		PlaybackChannels "2"
+	}
+
+	ConflictingDevice [
+		"Headphones"
+	]
+
+	EnableSequence [
+		cdev "hw:chtrt5645"
+
+		# Monospeaker: Mix right to left
+		cset "name='Stereo DAC MIXL DAC R1 Switch' 1"
+		cset "name='Stereo DAC MIXR DAC R1 Switch' 0"
+
+		cset "name='Headphone Switch' off"
+		cset "name='Headphone Channel Switch' off"
+
+		cset "name='Ext Spk Switch' on"
+		cset "name='Speaker Channel Switch' on"
+		cset "name='Speaker Playback Volume' 31"
+	]
+
+	DisableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Ext Spk Switch' off"
+		cset "name='Speaker Channel Switch' off"
+	]
+}
+
+SectionDevice."Headphones" {
+	Comment "Headphones"
+
+	Value {
+		PlaybackChannels "2"
+		JackControl "Headphone Jack"
+		JackHWMute "Speaker"
+	}
+
+	ConflictingDevice [
+		"Speaker"
+	]
+
+	EnableSequence [
+		cdev "hw:chtrt5645"
+
+		# Undo monospeaker mixing
+		cset "name='Stereo DAC MIXL DAC R1 Switch' 0"
+		cset "name='Stereo DAC MIXR DAC R1 Switch' 1"
+
+		cset "name='Ext Spk Switch' off"
+		cset "name='Speaker Channel Switch' off"
+
+		cset "name='Headphone Switch' on"
+		cset "name='Headphone Channel Switch' on"
+		# 25/39 higher values cause crackling on some boards
+		cset "name='Headphone Playback Volume' 25"
+	]
+
+	DisableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Headphone Switch' off"
+		cset "name='Headphone Channel Switch' off"
+	]
+}
+
+SectionDevice."Mic".0 {
+	Comment "Internal Analog Microphone"
+
+	Value {
+		CaptureChannels "2"
+		CapturePriority "150"
+	}
+
+	EnableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Int Analog Mic Switch' on"
+
+		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
+		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
+		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
+		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
+
+		cset "name='Mono ADC MIXL ADC1 Switch' on"
+		cset "name='Mono ADC MIXR ADC1 Switch' on"
+		cset "name='Mono ADC MIXL ADC2 Switch' off"
+		cset "name='Mono ADC MIXR ADC2 Switch' off"
+
+		cset "name='RECMIXL BST2 Switch' on"
+		cset "name='RECMIXR BST2 Switch' on"
+
+	]
+
+	DisableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
+		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
+		cset "name='Mono ADC MIXL ADC1 Switch' off"
+		cset "name='Mono ADC MIXR ADC1 Switch' off"
+
+		cset "name='RECMIXL BST2 Switch' off"
+		cset "name='RECMIXR BST2 Switch' off"
+
+		cset "name='Int Analog Mic Switch' off"
+	]
+}
+
+
+SectionDevice."HSMic".0 {
+	Comment "Headset Microphone"
+
+	Value {
+		CaptureChannels "2"
+		JackControl "Headset Mic Jack"
+		JackHWMute "Mic"
+	}
+
+	EnableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Headset Mic Switch' on"
+
+		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
+		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
+		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
+		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
+
+		cset "name='Mono ADC MIXL ADC1 Switch' on"
+		cset "name='Mono ADC MIXR ADC1 Switch' on"
+		cset "name='Mono ADC MIXL ADC2 Switch' off"
+		cset "name='Mono ADC MIXR ADC2 Switch' off"
+
+		cset "name='RECMIXL BST1 Switch' on"
+		cset "name='RECMIXR BST1 Switch' on"
+
+	]
+
+	DisableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Headset Mic Switch' off"
+
+		cset "name='RECMIXL BST1 Switch' off"
+		cset "name='RECMIXR BST1 Switch' off"
+		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
+		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
+		cset "name='Mono ADC MIXL ADC1 Switch' on"
+		cset "name='Mono ADC MIXR ADC1 Switch' on"
+
+	]
+}
diff --git a/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/Makefile.am b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/Makefile.am
new file mode 100644
index 00000000..4c4d7cf4
--- /dev/null
+++ b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/chtrt5645-mono-speaker-analog-mic
+ucm_DATA = chtrt5645-mono-speaker-analog-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/chtrt5645-mono-speaker-analog-mic.conf b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/chtrt5645-mono-speaker-analog-mic.conf
new file mode 100644
index 00000000..b1a5206e
--- /dev/null
+++ b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/chtrt5645-mono-speaker-analog-mic.conf
@@ -0,0 +1,5 @@
+Comment "Intel SoC Audio Device"
+SectionUseCase."HiFi" {
+	File "../chtrt5645-mono-speaker-analog-mic/HiFi.conf"
+	Comment "Default"
+}
diff --git a/src/conf/ucm/gpd-win-pocket-rt5645/Makefile.am b/src/conf/ucm/gpd-win-pocket-rt5645/Makefile.am
new file mode 100644
index 00000000..62440926
--- /dev/null
+++ b/src/conf/ucm/gpd-win-pocket-rt5645/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/gpd-win-pocket-rt5645
+ucm_DATA = gpd-win-pocket-rt5645.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/gpd-win-pocket-rt5645/gpd-win-pocket-rt5645.conf b/src/conf/ucm/gpd-win-pocket-rt5645/gpd-win-pocket-rt5645.conf
new file mode 120000
index 00000000..1b1d4754
--- /dev/null
+++ b/src/conf/ucm/gpd-win-pocket-rt5645/gpd-win-pocket-rt5645.conf
@@ -0,0 +1 @@
+../chtrt5645-mono-speaker-analog-mic/chtrt5645-mono-speaker-analog-mic.conf
\ No newline at end of file
-- 
2.14.3
