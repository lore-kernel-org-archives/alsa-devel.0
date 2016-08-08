From: Riku Voipio <riku.voipio@linaro.org>
Subject: [PATCH] ucm: Add ucm files for DB410c board.
Date: Mon,  8 Aug 2016 16:23:10 +0300
Message-ID: <1470662590-23434-1-git-send-email-riku.voipio@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 63B4D2674FC
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 15:23:14 +0200 (CEST)
Received: by mail-wm0-f47.google.com with SMTP id i5so139105996wmg.0
 for <alsa-devel@alsa-project.org>; Mon, 08 Aug 2016 06:23:14 -0700 (PDT)
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
Cc: nicolas.dechesne@linaro.org, Riku Voipio <riku.voipio@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

DB410c board has support for both Digital and Analog audio. Digital
audio is over HDMI and analog is over codec chip integrated inside the
APQ8016 SOC.

It can support:
 -  3 Microphones: Primary Mic(Handset mic), Headset Mic and Secondary
 - 2 Digital Microphones.
 - Earpiece.
 - Headset.
 - Loud Speaker.
 - HDMI.

[Riku: squashed Srinivas's patches together and converted spaces to tabs]
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
Cc: nicolas.dechesne@linaro.org
---
 configure.ac                    |   1 +
 src/conf/ucm/DB410c/DB410c.conf |   8 ++
 src/conf/ucm/DB410c/HDMI        |  31 +++++++
 src/conf/ucm/DB410c/HiFi        | 185 ++++++++++++++++++++++++++++++++++++++++
 src/conf/ucm/DB410c/Makefile.am |   4 +
 src/conf/ucm/Makefile.am        |   2 +-
 6 files changed, 230 insertions(+), 1 deletion(-)
 create mode 100644 src/conf/ucm/DB410c/DB410c.conf
 create mode 100644 src/conf/ucm/DB410c/HDMI
 create mode 100644 src/conf/ucm/DB410c/HiFi
 create mode 100644 src/conf/ucm/DB410c/Makefile.am

diff --git a/configure.ac b/configure.ac
index f592e8b..014af5f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -675,6 +675,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/broadwell-rt286/Makefile \
 	  src/conf/ucm/VEYRON-I2S/Makefile \
 	  src/conf/ucm/chtrt5645/Makefile \
+	  src/conf/ucm/DB410c/Makefile \
 	  src/conf/topology/Makefile \
 	  src/conf/topology/broadwell/Makefile \
 	  modules/Makefile modules/mixer/Makefile modules/mixer/simple/Makefile \
diff --git a/src/conf/ucm/DB410c/DB410c.conf b/src/conf/ucm/DB410c/DB410c.conf
new file mode 100644
index 0000000..590278f
--- /dev/null
+++ b/src/conf/ucm/DB410c/DB410c.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "HiFi"
+	Comment "Play HiFi quality Music."
+}
+SectionUseCase."HDMI" {
+	File "HDMI"
+	Comment "HDMI output."
+}
diff --git a/src/conf/ucm/DB410c/HDMI b/src/conf/ucm/DB410c/HDMI
new file mode 100644
index 0000000..8112bc0
--- /dev/null
+++ b/src/conf/ucm/DB410c/HDMI
@@ -0,0 +1,31 @@
+# Use case configuration for DB410c board.
+# Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+SectionVerb {
+	EnableSequence [
+	]
+
+	DisableSequence [
+	]
+	Value {
+		TQ "HiFi"
+		PlaybackPCM "plughw:0,0"
+	}
+}
+
+SectionDevice."HDMI-stereo" {
+	#Name "HDMI-stereo"
+	Comment "HDMI Digital Stereo Output"
+
+	EnableSequence [
+		cdev "hw:0"
+	]
+
+	DisableSequence [
+		cdev "hw:0"
+	]
+
+	Value {
+		PlaybackChannels "2"
+	}
+}
diff --git a/src/conf/ucm/DB410c/HiFi b/src/conf/ucm/DB410c/HiFi
new file mode 100644
index 0000000..f9cbcf0
--- /dev/null
+++ b/src/conf/ucm/DB410c/HiFi
@@ -0,0 +1,185 @@
+# Use case configuration for DB410c board.
+# Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
+		PlaybackPCM "plughw:0,1"
+		CapturePCM "plughw:0,2"
+	}
+}
+
+
+SectionDevice."Speaker" {
+	Comment "Speaker playback"
+
+	ConflictingDevice [
+		"Headphones"
+		"Earpiece"
+	]
+
+	EnableSequence [
+		cdev "hw:0"
+		cset "name='SPK DAC Switch' 1"
+		cset "name='RX3 MIX1 INP1' RX1"
+		## gain to  0dB
+		cset "name='RX3 Digital Volume' 128"
+	]
+
+	DisableSequence [
+		cdev "hw:0"
+		cset "name='SPK DAC Switch' 0"
+		cset "name='RX3 MIX1 INP1' ZERO"
+	]
+
+	Value {
+		PlaybackChannels "2"
+	}
+}
+
+
+SectionDevice."Headphones" {
+	Comment "Headphones playback"
+
+	ConflictingDevice [
+		"Speaker"
+		"Earpiece"
+	]
+	EnableSequence [
+		cdev "hw:0"
+		cset "name='RX1 MIX1 INP1' RX1"
+		cset "name='RX2 MIX1 INP1' RX2"
+		cset "name='RDAC2 MUX' RX2"
+		cset "name='HPHL' 1"
+		cset "name='HPHR' 1"
+		## gain to  0dB
+		cset "name='RX1 Digital Volume' 128"
+		## gain to  0dB
+		cset "name='RX2 Digital Volume' 128"
+	]
+
+	DisableSequence [
+		cdev "hw:0"
+		cset "name='RX1 Digital Volume' 0"
+		cset "name='RX2 Digital Volume' 0"
+		cset "name='HPHL' 0"
+		cset "name='HPHR' 0"
+		cset "name='RDAC2 MUX' ZERO"
+		cset "name='RX1 MIX1 INP1' ZERO"
+		cset "name='RX2 MIX1 INP1' ZERO"
+	]
+
+	Value {
+		PlaybackChannels "2"
+	}
+}
+
+SectionDevice."Earpiece" {
+	Comment "Earpiece playback"
+
+	ConflictingDevice [
+		"Speaker"
+		"Headphones"
+	]
+	EnableSequence [
+		cdev "hw:0"
+	]
+
+	DisableSequence [
+		cdev "hw:0"
+	]
+
+	Value {
+		PlaybackChannels "2"
+	}
+}
+
+SectionDevice."Handset" {
+	Comment "Headset Microphone"
+
+	EnableSequence [
+		cdev "hw:0"
+		cset "name='DEC1 MUX' ADC2"
+		cset "name='ADC2 Volume' 8"
+		cset "name='ADC2 MUX' INP2"
+	]
+
+	DisableSequence [
+		cdev "hw:0"
+		cset "name='ADC2 MUX' ZERO"
+		cset "name='ADC2 Volume' 0"
+		cset "name='DEC1 MUX' ZERO"
+	]
+
+	Value {
+		CaptureChannels "2"
+	}
+}
+
+SectionDevice."Primarymic" {
+	Comment "Primary Microphone"
+
+	EnableSequence [
+		cdev "hw:0"
+		cset "name='DEC1 MUX' ADC1"
+		cset "name='ADC1 Volume' 8"
+	]
+
+	DisableSequence [
+		cdev "hw:0"
+		cset "name='DEC1 MUX' ZERO"
+		cset "name='ADC1 Volume' 0"
+	]
+
+	Value {
+		CaptureChannels "2"
+	}
+}
+
+SectionDevice."Secondarymic" {
+	Comment "Secondary Microphone"
+
+	EnableSequence [
+		cdev "hw:0"
+		cset "name='DEC1 MUX' ADC2"
+		cset "name='ADC2 Volume' 8"
+		cset "name='ADC2 MUX' INP2"
+	]
+
+	DisableSequence [
+		cdev "hw:0"
+		cset "name='DEC1 MUX' ZERO"
+		cset "name='ADC2 Volume' 0"
+		cset "name='ADC2 MUX' ZERO"
+	]
+
+	Value {
+		CaptureChannels "2"
+	}
+}
+
+SectionDevice."DMIC" {
+	Comment "Digital Microphone"
+
+	EnableSequence [
+		cdev "hw:0"
+		cset "name='DEC1 MUX' DMIC1"
+	]
+
+	DisableSequence [
+		cdev "hw:0"
+		cset "name='DEC1 MUX' ZERO"
+	]
+
+	Value {
+		CaptureChannels "2"
+	}
+}
diff --git a/src/conf/ucm/DB410c/Makefile.am b/src/conf/ucm/DB410c/Makefile.am
new file mode 100644
index 0000000..e10a136
--- /dev/null
+++ b/src/conf/ucm/DB410c/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/DB410c
+ucm_DATA = DB410c.conf HDMI HiFi
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 8865770..7bf432e 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -1 +1 @@
-SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 VEYRON-I2S chtrt5645
+SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 VEYRON-I2S chtrt5645 DB410c
-- 
2.1.4
