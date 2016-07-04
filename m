From: Stephen Just <stephenjust@gmail.com>
Subject: [PATCH] [alsa-lib] conf/ucm: chtrt5645: Add UCM config
	for chtrt5645
Date: Mon,  4 Jul 2016 10:51:55 -0600
Message-ID: <20160704165155.2372-1-stephenjust@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Stephen Just <stephenjust@gmail.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Add a UCM configuration for the rt5645 codec on Intel's Cherry-Trail
platform. Tested on the Microsoft Surface 3.

Signed-off-by: Stephen Just <stephenjust@gmail.com>
---
 configure.ac                          |   1 +
 src/conf/ucm/Makefile.am              |   2 +-
 src/conf/ucm/chtrt5645/HiFi.conf      | 209 ++++++++++++++++++++++++++++++++++
 src/conf/ucm/chtrt5645/Makefile.am    |   4 +
 src/conf/ucm/chtrt5645/chtrt5645.conf |   5 +
 5 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 src/conf/ucm/chtrt5645/HiFi.conf
 create mode 100644 src/conf/ucm/chtrt5645/Makefile.am
 create mode 100644 src/conf/ucm/chtrt5645/chtrt5645.conf

diff --git a/configure.ac b/configure.ac
index 53fca33..9eebd0a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -659,6 +659,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/GoogleNyan/Makefile \
 	  src/conf/ucm/broadwell-rt286/Makefile \
 	  src/conf/ucm/VEYRON-I2S/Makefile \
+	  src/conf/ucm/chtrt5645/Makefile \
 	  src/conf/topology/Makefile \
 	  src/conf/topology/broadwell/Makefile \
 	  modules/Makefile modules/mixer/Makefile modules/mixer/simple/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 3cce36a..8865770 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -1 +1 @@
-SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 VEYRON-I2S
+SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 VEYRON-I2S chtrt5645
diff --git a/src/conf/ucm/chtrt5645/HiFi.conf b/src/conf/ucm/chtrt5645/HiFi.conf
new file mode 100644
index 0000000..0c2c83c
--- /dev/null
+++ b/src/conf/ucm/chtrt5645/HiFi.conf
@@ -0,0 +1,209 @@
+SectionVerb {
+	# ALSA PCM
+	Value {
+		TQ "HiFi"
+
+		# ALSA PCM device for HiFi
+		PlaybackPCM "hw:chtrt5645,0"
+		CapturePCM "hw:chtrt5645,0"
+	}
+
+	EnableSequence [
+		cdev "hw:chtrt5645"
+
+		# Enable audio output path
+		cset "name='codec_out1 mix 0 pcm0_in Switch' on"
+		cset "name='media0_out mix 0 media1_in Switch' on"
+
+		cset "name='media1_in Gain 0 Ramp Delay' 50"
+		cset "name='media1_in Gain 0 Switch' on"
+		cset "name='media1_in Gain 0 Volume' 80% 80%"
+
+		cset "name='pcm0_in Gain 0 Ramp Delay' 50"
+		cset "name='pcm0_in Gain 0 Switch' on"
+		cset "name='pcm0_in Gain 0 Volume' 80% 80%"
+
+		cset "name='codec_out1 Gain 0 Ramp Delay' 50"
+		cset "name='codec_out1 Gain 0 Switch' on"
+		cset "name='codec_out1 Gain 0 Volume' 70% 70%"
+
+		# Enable audio input path
+		cset "name='pcm1_out mix 0 media_loop2_in Switch' on"
+		cset "name='media_loop2_out mix 0 codec_in0 Switch' on"
+
+		cset "name='codec_in0 Gain 0 Ramp Delay' 50"
+		cset "name='codec_in0 Gain 0 Switch' on"
+		cset "name='codec_in0 Gain 0 Volume' 80% 80%"
+
+		cset "name='media_loop2_out Gain 0 Ramp Delay' 50"
+		cset "name='media_loop2_out Gain 0 Switch' on"
+		cset "name='media_loop2_out Gain 0 Volume' 80% 80%"
+
+		cset "name='pcm1_out Gain 0 Ramp Delay' 50"
+		cset "name='pcm1_out Gain 0 Switch' on"
+		cset "name='pcm1_out Gain 0 Volume' 80% 80%"
+
+		# Output Configuration
+		cset "name='DAC L2 Mux' 'IF1 DAC'"
+		cset "name='DAC R2 Mux' 'IF1 DAC'"
+		cset "name='Mono DAC MIXL DAC L2 Switch' on"
+		cset "name='Mono DAC MIXR DAC R2 Switch' on"
+		cset "name='DAC2 Playback Switch' on"
+
+		cset "name='HPOVOL MIXL DAC2 Switch' on"
+		cset "name='HPOVOL MIXR DAC2 Switch' on"
+		cset "name='HPO MIX HPVOL Switch' on"
+		cset "name='HPOVOL L Switch' on"
+		cset "name='HPOVOL R Switch' on"
+
+		cset "name='SPK MIXL DAC L2 Switch' on"
+		cset "name='SPK MIXR DAC R2 Switch' on"
+		cset "name='SPOL MIX SPKVOL L Switch' on"
+		cset "name='SPOR MIX SPKVOL R Switch' on"
+		cset "name='SPKVOL L Switch' on"
+		cset "name='SPKVOL R Switch' on"
+
+		# Input Configuration
+		cset "name='Stereo1 DMIC Mux' 0"
+		cset "name='Stereo1 ADC2 Mux' 1"
+		cset "name='ADC Capture Switch' on"
+		cset "name='ADC Capture Volume' 31"
+		cset "name='ADC Boost Capture Volume' 3"
+		cset "name='Mono ADC Capture Volume' 63"
+		cset "name='Mono ADC Boost Capture Volume' 2"
+		cset "name='IN Capture Volume' 63"
+		cset "name='I2S2 Func Switch' on"
+
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
+		"Headphone"
+	]
+
+	EnableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Ext Spk Switch' on"
+		cset "name='Speaker Channel Switch' on"
+		cset "name='Speaker Playback Volume' 39"
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
+SectionDevice."Headphone".0 {
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
+		cset "name='Headphone Switch' on"
+		cset "name='Headphone Channel Switch' on"
+		cset "name='Headphone Playback Volume' 39"
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
+		cset "name='Sto1 ADC MIXL ADC2 Switch' on"
+		cset "name='Sto1 ADC MIXR ADC2 Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
+		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
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
+		JackHWMute "Mic"
+	}
+
+	EnableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Headset Mic Switch' on"
+		cset "name='RECMIXL BST1 Switch' on"
+		cset "name='RECMIXR BST1 Switch' on"
+		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
+		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Headset Mic Switch' off"
+		cset "name='RECMIXL BST1 Switch' off"
+		cset "name='RECMIXR BST1 Switch' off"
+		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
+		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
+	]
+}
diff --git a/src/conf/ucm/chtrt5645/Makefile.am b/src/conf/ucm/chtrt5645/Makefile.am
new file mode 100644
index 0000000..b3a82f5
--- /dev/null
+++ b/src/conf/ucm/chtrt5645/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/chtrt5645
+ucm_DATA = chtrt5645.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/chtrt5645/chtrt5645.conf b/src/conf/ucm/chtrt5645/chtrt5645.conf
new file mode 100644
index 0000000..dfc36c8
--- /dev/null
+++ b/src/conf/ucm/chtrt5645/chtrt5645.conf
@@ -0,0 +1,5 @@
+Comment "Intel SoC Audio Device"
+SectionUseCase."HiFi" {
+	File "HiFi.conf"
+	Comment "Default"
+}
-- 
2.9.0
