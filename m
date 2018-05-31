From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/5] conf/ucm: chtnau8824: Add UCM profile for
	chtnau8824 boards
Date: Thu, 31 May 2018 17:10:25 +0200
Message-ID: <20180531151026.29521-5-hdegoede@redhat.com>
References: <20180531151026.29521-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 337EB267932
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 17:10:33 +0200 (CEST)
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

Add UCM profile for chtnau8824 boards based on:
https://github.com/plbossart/UCM/blob/master/chtnau8824

Split into multiple files in the same way as this was done for the
bytcr-rt5640 support, re-using the existing ucm/PlatformEnableSeq.conf
and ucm/PlatformDisableSeq.conf files for the SST mixer settings.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                            |  2 ++
 src/conf/ucm/Makefile.am                |  2 ++
 src/conf/ucm/chtnau8824/HiFi.conf       | 28 ++++++++++++++++++++++
 src/conf/ucm/chtnau8824/Makefile.am     |  4 ++++
 src/conf/ucm/chtnau8824/chtnau8824.conf |  6 +++++
 src/conf/ucm/nau8824/EnableSeq.conf     | 15 ++++++++++++
 src/conf/ucm/nau8824/HeadPhones.conf    | 25 ++++++++++++++++++++
 src/conf/ucm/nau8824/HeadsetMic.conf    | 31 +++++++++++++++++++++++++
 src/conf/ucm/nau8824/InternalMic.conf   | 31 +++++++++++++++++++++++++
 src/conf/ucm/nau8824/Makefile.am        |  5 ++++
 src/conf/ucm/nau8824/MonoSpeaker.conf   | 29 +++++++++++++++++++++++
 src/conf/ucm/nau8824/Speaker.conf       | 28 ++++++++++++++++++++++
 12 files changed, 206 insertions(+)
 create mode 100644 src/conf/ucm/chtnau8824/HiFi.conf
 create mode 100644 src/conf/ucm/chtnau8824/Makefile.am
 create mode 100644 src/conf/ucm/chtnau8824/chtnau8824.conf
 create mode 100644 src/conf/ucm/nau8824/EnableSeq.conf
 create mode 100644 src/conf/ucm/nau8824/HeadPhones.conf
 create mode 100644 src/conf/ucm/nau8824/HeadsetMic.conf
 create mode 100644 src/conf/ucm/nau8824/InternalMic.conf
 create mode 100644 src/conf/ucm/nau8824/Makefile.am
 create mode 100644 src/conf/ucm/nau8824/MonoSpeaker.conf
 create mode 100644 src/conf/ucm/nau8824/Speaker.conf

diff --git a/configure.ac b/configure.ac
index 57e0c354..ce21c7fb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -729,6 +729,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5651/Makefile \
+	  src/conf/ucm/chtnau8824/Makefile \
 	  src/conf/ucm/chtrt5645/Makefile \
 	  src/conf/ucm/chtrt5645-mono-speaker-analog-mic/Makefile \
 	  src/conf/ucm/DAISY-I2S/Makefile \
@@ -739,6 +740,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile \
 	  src/conf/ucm/HDAudio-Lenovo-DualCodecs/Makefile \
 	  src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/Makefile \
+	  src/conf/ucm/nau8824/Makefile \
 	  src/conf/ucm/PandaBoard/Makefile \
 	  src/conf/ucm/PandaBoardES/Makefile \
 	  src/conf/ucm/PAZ00/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index a524921b..c350c526 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -11,6 +11,7 @@ bytcr-rt5640-stereo-spk-dmic1-mic \
 bytcr-rt5640-stereo-spk-in1-mic \
 bytcr-rt5640-stereo-spk-in3-mic \
 bytcr-rt5651 \
+chtnau8824 \
 chtrt5645 \
 chtrt5645-mono-speaker-analog-mic \
 DAISY-I2S \
@@ -21,6 +22,7 @@ gpd-win-pocket-rt5645 \
 HDAudio-Gigabyte-ALC1220DualCodecs \
 HDAudio-Lenovo-DualCodecs \
 LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216 \
+nau8824 \
 PandaBoard \
 PandaBoardES \
 PAZ00 \
diff --git a/src/conf/ucm/chtnau8824/HiFi.conf b/src/conf/ucm/chtnau8824/HiFi.conf
new file mode 100644
index 00000000..dc52800e
--- /dev/null
+++ b/src/conf/ucm/chtnau8824/HiFi.conf
@@ -0,0 +1,28 @@
+<searchdir:ucm>
+
+SectionVerb {
+
+	Value {
+		TQ "HiFi"
+		# ALSA PCM device for HiFi
+		PlaybackPCM "hw:chtnau8824"
+		CapturePCM "hw:chtnau8824"
+	}
+
+	EnableSequence [
+		cdev "hw:chtnau8824"
+		<bytcr/PlatformEnableSeq.conf>
+		<nau8824/EnableSeq.conf>
+	]
+
+	DisableSequence [
+		cdev "hw:chtnau8824"
+		<bytcr/PlatformDisableSeq.conf>
+	]
+}
+
+<nau8824/Speaker.conf>
+<nau8824/HeadPhones.conf>
+
+<nau8824/InternalMic.conf>
+<nau8824/HeadsetMic.conf>
diff --git a/src/conf/ucm/chtnau8824/Makefile.am b/src/conf/ucm/chtnau8824/Makefile.am
new file mode 100644
index 00000000..e197d3e6
--- /dev/null
+++ b/src/conf/ucm/chtnau8824/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/chtnau8824
+ucm_DATA = chtnau8824.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/chtnau8824/chtnau8824.conf b/src/conf/ucm/chtnau8824/chtnau8824.conf
new file mode 100644
index 00000000..189b0dbe
--- /dev/null
+++ b/src/conf/ucm/chtnau8824/chtnau8824.conf
@@ -0,0 +1,6 @@
+Comment "chtnau8824 internal card"
+
+SectionUseCase."HiFi" {
+	File "HiFi.conf"
+	Comment "Default"
+}
diff --git a/src/conf/ucm/nau8824/EnableSeq.conf b/src/conf/ucm/nau8824/EnableSeq.conf
new file mode 100644
index 00000000..05f5f0b4
--- /dev/null
+++ b/src/conf/ucm/nau8824/EnableSeq.conf
@@ -0,0 +1,15 @@
+# Playback TDM configuration
+cset "name='DACL Channel Source' 0"
+cset "name='DACR Channel Source' 1"
+# Input Configuration
+cset "name='DMIC1 Enable Switch' off"
+cset "name='DMIC2 Enable Switch' off"
+cset "name='DMIC3 Enable Switch' off"
+cset "name='DMIC4 Enable Switch' off"
+cset "name='MIC1 Volume' 10"
+cset "name='MIC2 Volume' 10"
+# Button Configuration
+cset "name='THD for key media' 10"
+cset "name='THD for key voice command' 16"
+cset "name='THD for key volume up' 38"
+cset "name='THD for key volume down' 115"
diff --git a/src/conf/ucm/nau8824/HeadPhones.conf b/src/conf/ucm/nau8824/HeadPhones.conf
new file mode 100644
index 00000000..8ed6f194
--- /dev/null
+++ b/src/conf/ucm/nau8824/HeadPhones.conf
@@ -0,0 +1,25 @@
+SectionDevice."Headphones" {
+	Comment "Headphones"
+
+	Value {
+		PlaybackChannels "2"
+		JackControl "Headphone Jack"
+	}
+
+	ConflictingDevice [
+		"MonoSpeaker"
+		"Speaker"
+	]
+
+	EnableSequence [
+		cdev "hw:chtnau8824"
+
+		cset "name='Headphone Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:chtnau8824"
+
+		cset "name='Headphone Switch' off"
+	]
+}
diff --git a/src/conf/ucm/nau8824/HeadsetMic.conf b/src/conf/ucm/nau8824/HeadsetMic.conf
new file mode 100644
index 00000000..11b0b52a
--- /dev/null
+++ b/src/conf/ucm/nau8824/HeadsetMic.conf
@@ -0,0 +1,31 @@
+SectionDevice."HeadsetMic" {
+	Comment "Headset Microphone"
+
+	Value {
+		CaptureChannels "2"
+		JackControl "Headset Mic Jack"
+	}
+
+	ConflictingDevice [
+		"InternalMic"
+	]
+
+	EnableSequence [
+		cdev "hw:chtnau8824"
+
+		cset "name='ADC CH0 Select' 1"
+		cset "name='ADC CH1 Select' 1"
+
+		cset "name='Headset Mic Switch' on"
+		cset "name='Right ADC HSMIC Switch' on"
+		cset "name='Left ADC HSMIC Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:chtnau8824"
+
+		cset "name='Headset Mic Switch' off"
+		cset "name='Right ADC HSMIC Switch' off"
+		cset "name='Left ADC HSMIC Switch' off"
+	]
+}
diff --git a/src/conf/ucm/nau8824/InternalMic.conf b/src/conf/ucm/nau8824/InternalMic.conf
new file mode 100644
index 00000000..c6a741cc
--- /dev/null
+++ b/src/conf/ucm/nau8824/InternalMic.conf
@@ -0,0 +1,31 @@
+SectionDevice."InternalMic" {
+	Comment "Internal Microphone"
+
+	Value {
+		CaptureChannels "2"
+		CapturePriority "150"
+	}
+
+	ConflictingDevice [
+		"HeadsetMic"
+	]
+
+	EnableSequence [
+		cdev "hw:chtnau8824"
+
+		cset "name='ADC CH0 Select' 0"
+		cset "name='ADC CH1 Select' 0"
+
+		cset "name='Int Mic Switch' on"
+		cset "name='Right ADC MIC Switch' on"
+		cset "name='Left ADC MIC Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:chtnau8824"
+
+		cset "name='Int Mic Switch' off"
+		cset "name='Right ADC MIC Switch' off"
+		cset "name='Left ADC MIC Switch' off"
+	]
+}
diff --git a/src/conf/ucm/nau8824/Makefile.am b/src/conf/ucm/nau8824/Makefile.am
new file mode 100644
index 00000000..b39b8bb4
--- /dev/null
+++ b/src/conf/ucm/nau8824/Makefile.am
@@ -0,0 +1,5 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/nau8824
+ucm_DATA = EnableSeq.conf HeadPhones.conf HeadsetMic.conf InternalMic.conf \
+	   MonoSpeaker.conf Speaker.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/nau8824/MonoSpeaker.conf b/src/conf/ucm/nau8824/MonoSpeaker.conf
new file mode 100644
index 00000000..86735181
--- /dev/null
+++ b/src/conf/ucm/nau8824/MonoSpeaker.conf
@@ -0,0 +1,29 @@
+SectionDevice."MonoSpeaker" {
+	Comment "Mono Speaker"
+
+	Value {
+		PlaybackChannels "2"
+	}
+
+	ConflictingDevice [
+		"Speaker"
+		"Headphones"
+	]
+
+	EnableSequence [
+		cdev "hw:chtnau8824"
+
+		# nau8824 mono speaker boards have the speaker on the right chan
+		cset "name='Speaker Left DACL Volume' 0"
+		cset "name='Speaker Left DACR Volume' 0"
+		cset "name='Speaker Right DACL Volume' 1"
+		cset "name='Speaker Right DACR Volume' 1"
+		cset "name='Ext Spk Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:chtnau8824"
+
+		cset "name='Ext Spk Switch' off"
+	]
+}
diff --git a/src/conf/ucm/nau8824/Speaker.conf b/src/conf/ucm/nau8824/Speaker.conf
new file mode 100644
index 00000000..e4d25b08
--- /dev/null
+++ b/src/conf/ucm/nau8824/Speaker.conf
@@ -0,0 +1,28 @@
+SectionDevice."Speaker" {
+	Comment "Speaker"
+
+	Value {
+		PlaybackChannels "2"
+	}
+
+	ConflictingDevice [
+		"MonoSpeaker"
+		"Headphones"
+	]
+
+	EnableSequence [
+		cdev "hw:chtnau8824"
+
+		cset "name='Speaker Left DACL Volume' 1"
+		cset "name='Speaker Left DACR Volume' 0"
+		cset "name='Speaker Right DACL Volume' 0"
+		cset "name='Speaker Right DACR Volume' 1"
+		cset "name='Ext Spk Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:chtnau8824"
+
+		cset "name='Ext Spk Switch' off"
+	]
+}
-- 
2.17.0
