From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 1/2] conf/ucm: Add UCM profile for bytcht-es8316
	boards
Date: Thu,  3 Jan 2019 14:50:14 +0100
Message-ID: <20190103135015.14669-2-hdegoede@redhat.com>
References: <20190103135015.14669-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id F3F33267BD4
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 14:50:19 +0100 (CET)
In-Reply-To: <20190103135015.14669-1-hdegoede@redhat.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, linux@endlessm.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Add an UCM profile for Bay Trail and Cherry Trail boards with an
ES8316 codec.

Re-use the existing platform enable and disable sequences for BYT/CHT SST
support and add a codecs/es8316 dir with codec specific enable / disable
sequences for the various inputs and outputs.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                                  |  2 +
 src/conf/ucm/Makefile.am                      |  1 +
 src/conf/ucm/bytcht-es8316/HiFi.conf          | 26 ++++++++++++
 src/conf/ucm/bytcht-es8316/Makefile.am        |  4 ++
 src/conf/ucm/bytcht-es8316/bytcht-es8316.conf |  8 ++++
 src/conf/ucm/codecs/Makefile.am               |  1 +
 src/conf/ucm/codecs/es8316/EnableSeq.conf     | 19 +++++++++
 src/conf/ucm/codecs/es8316/HeadPhones.conf    | 24 +++++++++++
 .../ucm/codecs/es8316/IN1-HeadsetMic.conf     | 25 ++++++++++++
 .../ucm/codecs/es8316/IN1-InternalMic.conf    | 24 +++++++++++
 .../ucm/codecs/es8316/IN2-HeadsetMic.conf     | 25 ++++++++++++
 .../ucm/codecs/es8316/IN2-InternalMic.conf    | 24 +++++++++++
 src/conf/ucm/codecs/es8316/Makefile.am        |  7 ++++
 src/conf/ucm/codecs/es8316/MonoSpeaker.conf   | 40 +++++++++++++++++++
 src/conf/ucm/codecs/es8316/Speaker.conf       | 22 ++++++++++
 15 files changed, 252 insertions(+)
 create mode 100644 src/conf/ucm/bytcht-es8316/HiFi.conf
 create mode 100644 src/conf/ucm/bytcht-es8316/Makefile.am
 create mode 100644 src/conf/ucm/bytcht-es8316/bytcht-es8316.conf
 create mode 100644 src/conf/ucm/codecs/es8316/EnableSeq.conf
 create mode 100644 src/conf/ucm/codecs/es8316/HeadPhones.conf
 create mode 100644 src/conf/ucm/codecs/es8316/IN1-HeadsetMic.conf
 create mode 100644 src/conf/ucm/codecs/es8316/IN1-InternalMic.conf
 create mode 100644 src/conf/ucm/codecs/es8316/IN2-HeadsetMic.conf
 create mode 100644 src/conf/ucm/codecs/es8316/IN2-InternalMic.conf
 create mode 100644 src/conf/ucm/codecs/es8316/Makefile.am
 create mode 100644 src/conf/ucm/codecs/es8316/MonoSpeaker.conf
 create mode 100644 src/conf/ucm/codecs/es8316/Speaker.conf

diff --git a/configure.ac b/configure.ac
index a0392bfe..ff2e2799 100644
--- a/configure.ac
+++ b/configure.ac
@@ -720,6 +720,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/Makefile \
 	  src/conf/ucm/broadwell-rt286/Makefile \
 	  src/conf/ucm/broxton-rt298/Makefile \
+	  src/conf/ucm/bytcht-es8316/Makefile \
 	  src/conf/ucm/bytcr-rt5640/Makefile \
 	  src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/Makefile \
@@ -759,6 +760,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/tegraalc5632/Makefile \
 	  src/conf/ucm/VEYRON-I2S/Makefile \
 	  src/conf/ucm/codecs/Makefile \
+	  src/conf/ucm/codecs/es8316/Makefile \
 	  src/conf/ucm/codecs/nau8824/Makefile \
 	  src/conf/ucm/codecs/rt5640/Makefile \
 	  src/conf/ucm/codecs/rt5651/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index c82637fa..b252f258 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -4,6 +4,7 @@ platforms \
 ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN \
 broadwell-rt286 \
 broxton-rt298 \
+bytcht-es8316 \
 bytcr-rt5640 \
 bytcr-rt5640-mono-spk-dmic1-mic \
 bytcr-rt5640-mono-spk-in1-mic \
diff --git a/src/conf/ucm/bytcht-es8316/HiFi.conf b/src/conf/ucm/bytcht-es8316/HiFi.conf
new file mode 100644
index 00000000..7af3daaf
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316/HiFi.conf
@@ -0,0 +1,26 @@
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytchtes8316"
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/es8316/EnableSeq.conf>
+	]
+
+	DisableSequence [
+		cdev "hw:bytchtes8316"
+		<platforms/bytcr/PlatformDisableSeq.conf>
+	]
+
+	Value {
+		PlaybackPCM "hw:bytchtes8316"
+		CapturePCM "hw:bytchtes8316"
+	}
+}
+
+<codecs/es8316/Speaker.conf>
+<codecs/es8316/MonoSpeaker.conf>
+<codecs/es8316/HeadPhones.conf>
+
+<codecs/es8316/IN1-InternalMic.conf>
+<codecs/es8316/IN2-InternalMic.conf>
+<codecs/es8316/IN1-HeadsetMic.conf>
+<codecs/es8316/IN2-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcht-es8316/Makefile.am b/src/conf/ucm/bytcht-es8316/Makefile.am
new file mode 100644
index 00000000..bc8fa669
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcht-es8316
+ucm_DATA = bytcht-es8316.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcht-es8316/bytcht-es8316.conf b/src/conf/ucm/bytcht-es8316/bytcht-es8316.conf
new file mode 100644
index 00000000..e77e2977
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316/bytcht-es8316.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytchtes8316"
+]
diff --git a/src/conf/ucm/codecs/Makefile.am b/src/conf/ucm/codecs/Makefile.am
index 2b374acb..0ea5399d 100644
--- a/src/conf/ucm/codecs/Makefile.am
+++ b/src/conf/ucm/codecs/Makefile.am
@@ -1,4 +1,5 @@
 SUBDIRS=\
+es8316 \
 rt5640 \
 rt5651 \
 nau8824
diff --git a/src/conf/ucm/codecs/es8316/EnableSeq.conf b/src/conf/ucm/codecs/es8316/EnableSeq.conf
new file mode 100644
index 00000000..551b79b7
--- /dev/null
+++ b/src/conf/ucm/codecs/es8316/EnableSeq.conf
@@ -0,0 +1,19 @@
+# Disable all inputs / outputs
+cset "name='Speaker Switch' off"
+cset "name='Headphone Switch' off"
+cset "name='Headset Mic Switch' off"
+cset "name='Internal Mic Switch' off"
+
+# Set HP vol to 0 dB (3/3)
+cset "name='Headphone Playback Volume' 3"
+# Set HP mixer vol to -6 dB (4/7) louder does not work
+cset "name='Headphone Mixer Volume' 4"
+# Set DAC vol to 0 dB (192/192)
+cset "name='DAC Playback Volume' 192"
+# Set ADC vold to 0 dB (10/10)
+cset "name='ADC PGA Gain Volume' 10"
+
+# Setup muxes / switches
+cset "name='Left Headphone Mixer Left DAC Switch' on"
+cset "name='Right Headphone Mixer Right DAC Switch' on"	
+cset "name='ALC Capture Switch' on"
diff --git a/src/conf/ucm/codecs/es8316/HeadPhones.conf b/src/conf/ucm/codecs/es8316/HeadPhones.conf
new file mode 100644
index 00000000..ff13ef1b
--- /dev/null
+++ b/src/conf/ucm/codecs/es8316/HeadPhones.conf
@@ -0,0 +1,24 @@
+SectionDevice."Headphones" {
+	Comment "Headphones"
+
+	ConflictingDevice [
+		"Speaker"
+		"MonoSpeaker"
+	]
+
+	EnableSequence [
+		cdev "hw:bytchtes8316"
+		cset "name='Headphone Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytchtes8316"
+		cset "name='Headphone Switch' off"
+	]
+
+	Value {
+		PlaybackChannels "2"
+		JackControl "Headphone Jack"
+		JackHWMute "Speaker MonoSpeaker"
+	}
+}
diff --git a/src/conf/ucm/codecs/es8316/IN1-HeadsetMic.conf b/src/conf/ucm/codecs/es8316/IN1-HeadsetMic.conf
new file mode 100644
index 00000000..05016468
--- /dev/null
+++ b/src/conf/ucm/codecs/es8316/IN1-HeadsetMic.conf
@@ -0,0 +1,25 @@
+SectionDevice."HeadsetMic-IN1" {
+	Comment "Headset Microphone on IN1"
+
+	ConflictingDevice [
+		"InternalMic-IN1"
+		"InternalMic-IN2"
+		"HeadsetMic-IN2"
+	]
+
+	EnableSequence [
+		cdev "hw:bytchtes8316"
+		cset "name='Differential Mux' lin1-rin1"
+		cset "name='Headset Mic Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytchtes8316"
+		cset "name='Headset Mic Switch' off"
+	]
+
+	Value {
+		CaptureChannels "2"
+		JackControl "Headset Mic Jack"
+	}
+}
diff --git a/src/conf/ucm/codecs/es8316/IN1-InternalMic.conf b/src/conf/ucm/codecs/es8316/IN1-InternalMic.conf
new file mode 100644
index 00000000..5386fda7
--- /dev/null
+++ b/src/conf/ucm/codecs/es8316/IN1-InternalMic.conf
@@ -0,0 +1,24 @@
+SectionDevice."InternalMic-IN1" {
+	Comment "Internal Microphone on IN1"
+
+	ConflictingDevice [
+		"InternalMic-IN2"
+		"HeadsetMic-IN1"
+		"HeadsetMic-IN2"
+	]
+
+	EnableSequence [
+		cdev "hw:bytchtes8316"
+		cset "name='Differential Mux' lin1-rin1"
+		cset "name='Internal Mic Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytchtes8316"
+		cset "name='Internal Mic Switch' off"
+	]
+
+	Value {
+		CaptureChannels "2"
+	}
+}
diff --git a/src/conf/ucm/codecs/es8316/IN2-HeadsetMic.conf b/src/conf/ucm/codecs/es8316/IN2-HeadsetMic.conf
new file mode 100644
index 00000000..229e7e7b
--- /dev/null
+++ b/src/conf/ucm/codecs/es8316/IN2-HeadsetMic.conf
@@ -0,0 +1,25 @@
+SectionDevice."HeadsetMic-IN2" {
+	Comment "Headset Microphone on IN2"
+
+	ConflictingDevice [
+		"InternalMic-IN1"
+		"InternalMic-IN2"
+		"HeadsetMic-IN1"
+	]
+
+	EnableSequence [
+		cdev "hw:bytchtes8316"
+		cset "name='Differential Mux' lin2-rin2"
+		cset "name='Headset Mic Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytchtes8316"
+		cset "name='Headset Mic Switch' off"
+	]
+
+	Value {
+		CaptureChannels "2"
+		JackControl "Headset Mic Jack"
+	}
+}
diff --git a/src/conf/ucm/codecs/es8316/IN2-InternalMic.conf b/src/conf/ucm/codecs/es8316/IN2-InternalMic.conf
new file mode 100644
index 00000000..59892fdc
--- /dev/null
+++ b/src/conf/ucm/codecs/es8316/IN2-InternalMic.conf
@@ -0,0 +1,24 @@
+SectionDevice."InternalMic-IN2" {
+	Comment "Internal Microphone on IN2"
+
+	ConflictingDevice [
+		"InternalMic-IN1"
+		"HeadsetMic-IN1"
+		"HeadsetMic-IN2"
+	]
+
+	EnableSequence [
+		cdev "hw:bytchtes8316"
+		cset "name='Differential Mux' lin2-rin2"
+		cset "name='Internal Mic Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytchtes8316"
+		cset "name='Internal Mic Switch' off"
+	]
+
+	Value {
+		CaptureChannels "2"
+	}
+}
diff --git a/src/conf/ucm/codecs/es8316/Makefile.am b/src/conf/ucm/codecs/es8316/Makefile.am
new file mode 100644
index 00000000..36eeebce
--- /dev/null
+++ b/src/conf/ucm/codecs/es8316/Makefile.am
@@ -0,0 +1,7 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/codecs/es8316
+ucm_DATA = EnableSeq.conf HeadPhones.conf \
+	   IN1-InternalMic.conf IN2-InternalMic.conf \
+	   IN1-HeadsetMic.conf IN2-HeadsetMic.conf \
+	   Speaker.conf MonoSpeaker.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/codecs/es8316/MonoSpeaker.conf b/src/conf/ucm/codecs/es8316/MonoSpeaker.conf
new file mode 100644
index 00000000..b1a95a5b
--- /dev/null
+++ b/src/conf/ucm/codecs/es8316/MonoSpeaker.conf
@@ -0,0 +1,40 @@
+SectionDevice."MonoSpeaker" {
+	Comment "Mono Speaker"
+
+	ConflictingDevice [
+		"Speaker"
+		"Headphones"
+	]
+
+	EnableSequence [
+		cdev "hw:bytchtes8316"
+
+		# BYT/CHT devices with an ES8316 codec use a single speaker
+		# connected between the headhpone LOUT and ROUT pins, expecting
+		# the output to be in a mono differential mode. Presumably this
+		# is done to use the power of both the left and right headphone
+		# amplifier channels to allow the speaker to be louder.
+		#
+		# The ES8316 codec does not have a differential output mode, but
+		# we can emulate one by making both channels output the exact
+		# same signal by setting the "DAC Mono Mix Switch", combined
+		# with setting the "Playback Polarity" control to "R Invert",
+		# which applies a 180 degrees phase inversion to the right chan.
+		cset "name='DAC Mono Mix Switch' on"
+		cset "name='Playback Polarity' 1"
+
+		cset "name='Speaker Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytchtes8316"
+		cset "name='Speaker Switch' off"
+		# DAC settings back to normal for stereo headphones output
+		cset "name='Playback Polarity' 0"
+		cset "name='DAC Mono Mix Switch' off"
+	]
+
+	Value {
+		PlaybackChannels "2"
+	}
+}
diff --git a/src/conf/ucm/codecs/es8316/Speaker.conf b/src/conf/ucm/codecs/es8316/Speaker.conf
new file mode 100644
index 00000000..f0894c74
--- /dev/null
+++ b/src/conf/ucm/codecs/es8316/Speaker.conf
@@ -0,0 +1,22 @@
+SectionDevice."Speaker" {
+	Comment "Speakers"
+
+	ConflictingDevice [
+		"MonoSpeaker"
+		"Headphones"
+	]
+
+	EnableSequence [
+		cdev "hw:bytchtes8316"
+		cset "name='Speaker Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytchtes8316"
+		cset "name='Speaker Switch' off"
+	]
+
+	Value {
+		PlaybackChannels "2"
+	}
+}
-- 
2.20.1
