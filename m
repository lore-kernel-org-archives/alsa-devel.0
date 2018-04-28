From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/5] conf/ucm: chtrt5645: At config for the
	Asus T100HA
Date: Sat, 28 Apr 2018 21:51:59 +0200
Message-ID: <20180428195200.11722-5-hdegoede@redhat.com>
References: <20180428195200.11722-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 53146266C1C
 for <alsa-devel@alsa-project.org>; Sat, 28 Apr 2018 21:52:07 +0200 (CEST)
In-Reply-To: <20180428195200.11722-1-hdegoede@redhat.com>
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

The Asus T100HA uses a digital mic rather then an analog one, add
long-name config specific for the T100HA, which is a copy of the standard
chtrt5645 config with the internal analog mic section replaced with one
for the digital mic found on the Asus T100HA.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                                  |   1 +
 ...USTeKCOMPUTERINC.-T100HAN-1.0-T100HAN.conf |   5 +
 .../HiFi.conf                                 | 348 ++++++++++++++++++
 .../Makefile.am                               |   4 +
 src/conf/ucm/Makefile.am                      |   1 +
 5 files changed, 359 insertions(+)
 create mode 100644 src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN.conf
 create mode 100644 src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
 create mode 100644 src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/Makefile.am

diff --git a/configure.ac b/configure.ac
index 5bc1994f..94baf055 100644
--- a/configure.ac
+++ b/configure.ac
@@ -717,6 +717,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/cards/Makefile \
 	  src/conf/pcm/Makefile \
 	  src/conf/ucm/Makefile \
+	  src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/Makefile \
 	  src/conf/ucm/broadwell-rt286/Makefile \
 	  src/conf/ucm/broxton-rt298/Makefile \
 	  src/conf/ucm/bytcr-rt5651/Makefile \
diff --git a/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN.conf b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN.conf
new file mode 100644
index 00000000..5afe5f0b
--- /dev/null
+++ b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN.conf
@@ -0,0 +1,5 @@
+Comment "Intel SoC Audio Device"
+SectionUseCase."HiFi" {
+	File "../ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf"
+	Comment "Default"
+}
diff --git a/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
new file mode 100644
index 00000000..78bf9823
--- /dev/null
+++ b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
@@ -0,0 +1,348 @@
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
+SectionDevice."DMic".0 {
+	Comment "Internal Microphone"
+
+	Value {
+		CaptureChannels "2"
+		CapturePriority "150"
+	}
+
+	EnableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Int Mic Switch' on"
+
+		cset "name='Stereo1 DMIC Mux' DMIC1"
+		cset "name='Stereo1 ADC2 Mux' DMIC"
+		cset "name='Mono ADC L2 Mux' DMIC"
+		cset "name='Mono ADC R2 Mux' DMIC"
+
+		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
+		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
+		cset "name='Sto1 ADC MIXL ADC2 Switch' on"
+		cset "name='Sto1 ADC MIXR ADC2 Switch' on"
+		cset "name='Mono ADC MIXL ADC1 Switch' off"
+		cset "name='Mono ADC MIXR ADC1 Switch' off"
+		cset "name='Mono ADC MIXL ADC2 Switch' on"
+		cset "name='Mono ADC MIXR ADC2 Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
+		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
+		cset "name='Mono ADC MIXL ADC2 Switch' off"
+		cset "name='Mono ADC MIXR ADC2 Switch' off"
+		cset "name='Int Mic Switch' off"
+	]
+}
+
+SectionDevice."HSMic".0 {
+	Comment "Headset Microphone"
+
+	Value {
+		CaptureChannels "2"
+		JackControl "Headset Mic Jack"
+		JackHWMute "DMic"
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
diff --git a/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/Makefile.am b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/Makefile.am
new file mode 100644
index 00000000..dd8b372a
--- /dev/null
+++ b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN
+ucm_DATA = ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 3b4f13a8..e496ca89 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -1,4 +1,5 @@
 SUBDIRS=\
+ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN \
 broadwell-rt286 \
 broxton-rt298 \
 bytcr-rt5651 \
-- 
2.17.0
