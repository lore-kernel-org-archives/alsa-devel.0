From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Subject: [PATCH 3/5] PandaBoardES: add UCM config from Ubuntu
Date: Fri, 10 May 2013 14:51:08 +0200
Message-ID: <1368190270-29647-4-git-send-email-marcin@juszkiewicz.com.pl>
References: <1368190270-29647-1-git-send-email-marcin@juszkiewicz.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tygrysek.juszkiewicz.com.pl (tygrysek.juszkiewicz.com.pl
 [178.33.81.99]) by alsa0.perex.cz (Postfix) with ESMTP id 5EFE02615F3
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 14:51:23 +0200 (CEST)
In-Reply-To: <1368190270-29647-1-git-send-email-marcin@juszkiewicz.com.pl>
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
Cc: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>, Liam Girgwood <liam.r.girdwood@linux.intel.com>, Luke Yelavich <themuso@ubuntu.com>, Mark Brown <broonie@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
---
 PandaBoardES/FMAnalog          | 46 +++++++++++++++++++++++
 PandaBoardES/PandaBoardES.conf | 45 +++++++++++++++++++++++
 PandaBoardES/hifi              | 83 ++++++++++++++++++++++++++++++++++++++++++
 PandaBoardES/hifiLP            | 46 +++++++++++++++++++++++
 PandaBoardES/record            | 47 ++++++++++++++++++++++++
 PandaBoardES/voice             | 46 +++++++++++++++++++++++
 PandaBoardES/voiceCall         | 67 ++++++++++++++++++++++++++++++++++
 7 files changed, 380 insertions(+)
 create mode 100644 PandaBoardES/FMAnalog
 create mode 100644 PandaBoardES/PandaBoardES.conf
 create mode 100644 PandaBoardES/hifi
 create mode 100644 PandaBoardES/hifiLP
 create mode 100644 PandaBoardES/record
 create mode 100644 PandaBoardES/voice
 create mode 100644 PandaBoardES/voiceCall

diff --git a/PandaBoardES/FMAnalog b/PandaBoardES/FMAnalog
new file mode 100644
index 0000000..6885cc8
--- /dev/null
+++ b/PandaBoardES/FMAnalog
@@ -0,0 +1,46 @@
+# Use case Configurationfor TI PandaBoardES HiFi Music
+# By Liam Girdwood <lrg@slimlogic.co.uk>
+
+SectionVerb {
+  	EnableSequence [
+                cdev "hw:PandaBoardES"
+                cset "name='AMIC_UL PDM Switch' 1"
+                cset "name='MUX_UL00' 9"
+                cset "name='MUX_UL01' 10"
+                cset "name='Capture Volume' 4"
+	]
+
+
+	DisableSequence [
+                cdev "hw:PandaBoardES"
+                cset "name='AMIC_UL PDM Switch' 0"
+                cset "name='MUX_UL00' 0"
+                cset "name='MUX_UL01' 0"
+                cset "name='Capture Volume' 0"
+	]
+
+	# Optional TQ and ALSA PCMs
+	Value {
+		TQ "Music"
+                CapturePCM "hw:0,0"
+	}
+}
+
+SectionDevice."Headset".0 {
+	Comment "PandaBoardES 3.5mm Headset"
+	
+	EnableSequence [
+                cdev "hw:PandaBoardES"
+                cset "name='Analog Left Capture Route' 2"
+                cset "name='Analog Right Capture Route' 2"
+                cset "name='Capture Preamplifier Volume' 2"
+	]
+
+	DisableSequence [
+                cdev "hw:PandaBoardES"
+                cset "name='Analog Left Capture Route' 3"
+                cset "name='Analog Right Capture Route' 3"
+                cset "name='Capture Preamplifier Volume' 0"
+	]
+}
+
diff --git a/PandaBoardES/PandaBoardES.conf b/PandaBoardES/PandaBoardES.conf
new file mode 100644
index 0000000..4fe6d0b
--- /dev/null
+++ b/PandaBoardES/PandaBoardES.conf
@@ -0,0 +1,45 @@
+# UCM configuration for PandaBoardES
+SectionUseCase."Record" {
+ 		File "record"
+ 		Comment "Record."
+}
+
+SectionUseCase."HiFi" {
+ 		File "hifi"
+ 		Comment "Play HiFi quality Music."
+}
+
+SectionUseCase."HiFi_Low_Power" {
+ 		File "hifiLP"
+ 		Comment "Play HiFi quality Music in Low Power Mode."
+}
+
+SectionUseCase."Voice" {
+ 		File "voice"
+ 		Comment "Playback Voice quality."
+}
+
+SectionUseCase."Voice_Low_Power" {
+ 		File "voice"
+ 		Comment "Playback Voice quality in Low Power Mode."
+}
+
+SectionUseCase."Voice_Call" {
+ 		File "voiceCall"
+ 		Comment "Capture and Playback in Voice quality."
+}
+
+SectionUseCase."Voice_Call_IP" {
+ 		File "voiceCall"
+ 		Comment "Capture and Playback in Voice quality."
+}
+
+SectionUseCase."FM_Analog_Radio" {
+ 		File "FMAnalog"
+ 		Comment "Capture FM Analog Radio."
+}
+
+SectionDefaults [
+                cdev "hw:PandaBoardES"
+		exec "echo Im setting PandaBoardES defaults"
+]
diff --git a/PandaBoardES/hifi b/PandaBoardES/hifi
new file mode 100644
index 0000000..be00e60
--- /dev/null
+++ b/PandaBoardES/hifi
@@ -0,0 +1,83 @@
+# Use case Configuration for TI PandaBoardES HiFi Music
+# By Liam Girdwood <lrg@slimlogic.co.uk>
+
+SectionVerb {
+  	EnableSequence [
+                cdev "hw:PandaBoardES"
+		cset "name='DL1 Mixer Multimedia' 1"
+		cset "name='Sidetone Mixer Playback' 1"
+                cset "name='DL1 PDM Switch' 1"
+		cset "name='DL1 Media Playback Volume' 90,90"
+                cset "name='SDT DL Volume' 120"
+
+                cset "name='Headset Left Playback' 1"
+                cset "name='Headset Right Playback' 1"
+                cset "name='Headset Playback Volume' 13"
+	]
+
+	DisableSequence [
+                cdev "hw:PandaBoardES"
+		cset "name='DL1 Mixer Multimedia' 0"
+		cset "name='Sidetone Mixer Playback' 0"
+                cset "name='DL1 PDM Switch' 0"
+		cset "name='DL1 Media Playback Volume' 0,0"
+                cset "name='SDT DL Volume' 0"
+
+		cset "name='Headset Right Playback' 0"
+		cset "name='Headset Left Playback' 0"
+                cset "name='Headset Playback Volume' 0"
+	]
+
+ 	# Optional TQ and ALSA PCMs
+#	Value {
+#		TQ "Music"
+#		PlaybackPCM "hw:0,0"
+#                PlaybackVolume "name='DL1 Media Playback Volume' 90,90"
+#                PlaybackSwitch "name='DL1 PDM Switch' 1"
+#	}
+}
+
+SectionDevice."Headset".0 {
+	Comment "PandaBoardES 3.5mm Headset"
+	
+	EnableSequence [
+                cdev "hw:PandaBoardES"
+                cset "name='Headset Left Playback' 1"
+                cset "name='Headset Right Playback' 1"
+                cset "name='Headset Playback Volume' 13"
+	]
+
+	DisableSequence [
+                cdev "hw:PandaBoardES"
+		cset "name='Headset Right Playback' 0"
+		cset "name='Headset Left Playback' 0"
+                cset "name='Headset Playback Volume' 0"
+	]
+}
+
+#SectionModifier."RecordMedia".0 {
+#	SupportedDevice [
+#		"Headset"
+#	]
+ #       EnableSequence [
+ #         ....
+ #       ]
+ #
+ #       DisableSequence [
+ #         ...
+ #       ]
+ #
+ #       TransitionSequence."ToModifierName" [
+ #         ...
+ #       ]
+ #
+ #       # Optional TQ and ALSA PCMs
+ #       Value {
+ #               TQ Voice
+ #               CapturePCM "hw:1"
+ #               PlaybackVolume "name='Master Playback Volume',index=2"
+ #               PlaybackSwitch "name='Master Playback Switch',index=2"
+ #       }
+#
+#}
+
diff --git a/PandaBoardES/hifiLP b/PandaBoardES/hifiLP
new file mode 100644
index 0000000..c817a58
--- /dev/null
+++ b/PandaBoardES/hifiLP
@@ -0,0 +1,46 @@
+# Use case Configuration for TI PandaBoardES HiFi Music
+# By Liam Girdwood <lrg@slimlogic.co.uk>
+
+SectionVerb {
+  	EnableSequence [
+                cdev "hw:PandaBoardES"
+		cset "name='DL1 Mixer Multimedia' 1"
+		cset "name='Sidetone Mixer Playback' 1"
+                cset "name='DL1 PDM Switch' 1"
+		cset "name='DL1 Media Playback Volume' 90,90"
+                cset "name='SDT DL Volume' 120"
+	]
+
+	DisableSequence [
+                cdev "hw:PandaBoardES"
+		cset "name='DL1 Mixer Multimedia' 0"
+		cset "name='Sidetone Mixer Playback' 0"
+                cset "name='DL1 PDM Switch' 0"
+		cset "name='DL1 Media Playback Volume' 0,0"
+                cset "name='SDT DL Volume' 0"
+	]
+
+	# Optional TQ and ALSA PCMs
+	Value {
+		TQ "Music"
+		PlaybackPCM "hw:0,6"
+	}
+}
+
+SectionDevice."Headset".0 {
+	Comment "PandaBoardES 3.5mm Headset"
+	
+	EnableSequence [
+                cdev "hw:PandaBoardES"
+                cset "name='Headset Left Playback' 1"
+                cset "name='Headset Right Playback' 1"
+                cset "name='Headset Playback Volume' 13"
+	]
+
+	DisableSequence [
+                cdev "hw:PandaBoardES"
+		cset "name='Headset Right Playback' 0"
+		cset "name='Headset Left Playback' 0"
+                cset "name='Headset Playback Volume' 0"
+	]
+}
diff --git a/PandaBoardES/record b/PandaBoardES/record
new file mode 100644
index 0000000..4f272a9
--- /dev/null
+++ b/PandaBoardES/record
@@ -0,0 +1,47 @@
+# Use case Configuration for TI PandaBoardES HiFi Music
+# By Liam Girdwood <lrg@slimlogic.co.uk>
+
+SectionVerb {
+  	EnableSequence [
+                cdev "hw:PandaBoardES"
+                # No more AMIC PDM Switch in current kernels
+                #cset "name='AMIC_UL PDM Switch' 1"
+                cset "name='MUX_UL00' 9"
+                cset "name='MUX_UL01' 10"
+                cset "name='Capture Volume' 4"
+	]
+
+	DisableSequence [
+                cdev "hw:PandaBoardES"
+                # No more AMIC PDM Switch in current kernels
+                #cset "name='AMIC_UL PDM Switch' 0"
+                cset "name='MUX_UL00' 0"
+                cset "name='MUX_UL01' 0"
+                cset "name='Capture Volume' 0"
+	]
+
+	# Optional TQ and ALSA PCMs
+	Value {
+		TQ "Music"
+		CapturePCM "hw:0,0"
+	}
+
+}
+
+SectionDevice."Headset".0 {
+	Comment "PandaBoardES 3.5mm Headset"
+	
+	EnableSequence [
+                cdev "hw:PandaBoardES"
+                cset "name='Analog Left Capture Route' 0"
+                cset "name='Analog Right Capture Route' 0"
+                cset "name='Capture Preamplifier Volume' 2"
+	]
+
+	DisableSequence [
+                cdev "hw:PandaBoardES"
+                cset "name='Analog Left Capture Route' 3"
+                cset "name='Analog Right Capture Route' 3"
+                cset "name='Capture Preamplifier Volume' 0"
+	]
+}
diff --git a/PandaBoardES/voice b/PandaBoardES/voice
new file mode 100644
index 0000000..e2b3f79
--- /dev/null
+++ b/PandaBoardES/voice
@@ -0,0 +1,46 @@
+# Use case Configuration for TI PandaBoardES HiFi Music
+# By Liam Girdwood <lrg@slimlogic.co.uk>
+
+SectionVerb {
+  	EnableSequence [
+                cdev "hw:PandaBoardES"
+		cset "name='DL1 Mixer Voice' 1"
+		cset "name='Sidetone Mixer Playback' 1"
+                cset "name='DL1 PDM Switch' 1"
+		cset "name='DL1 Voice Playback Volume' 90,90"
+                cset "name='SDT DL Volume' 120"
+	]
+
+	DisableSequence [
+                cdev "hw:PandaBoardES"
+		cset "name='DL1 Mixer Voice' 0"
+		cset "name='Sidetone Mixer Playback' 0"
+                cset "name='DL1 PDM Switch' 0"
+		cset "name='DL1 Voice Playback Volume' 0,0"
+                cset "name='SDT DL Volume' 0"
+	]
+
+	# Optional TQ and ALSA PCMs
+	Value {
+		TQ "Voice"
+		PlaybackPCM "hw:0,2"
+	}
+}
+
+SectionDevice."Headset".0 {
+	Comment "PandaBoardES 3.5mm Headset"
+	
+	EnableSequence [
+                cdev "hw:PandaBoardES"
+                cset "name='Headset Left Playback' 1"
+                cset "name='Headset Right Playback' 1"
+                cset "name='Headset Playback Volume' 13"
+	]
+
+	DisableSequence [
+                cdev "hw:PandaBoardES"
+		cset "name='Headset Right Playback' 0"
+		cset "name='Headset Left Playback' 0"
+                cset "name='Headset Playback Volume' 0"
+	]
+}
diff --git a/PandaBoardES/voiceCall b/PandaBoardES/voiceCall
new file mode 100644
index 0000000..57b1c80
--- /dev/null
+++ b/PandaBoardES/voiceCall
@@ -0,0 +1,67 @@
+# Use case Configuration for TI PandaBoardES HiFi Music
+# By Liam Girdwood <lrg@slimlogic.co.uk>
+
+SectionVerb {
+  	EnableSequence [
+                cdev "hw:PandaBoardES"
+                cset "name='AMIC_UL PDM Switch' 1"
+                cset "name='Sidetone Mixer Capture' 1"
+                cset "name='MUX_VX0' 9"
+                cset "name='MUX_VX1' 10"
+		cset "name='DL1 Mixer Voice' 1"
+		cset "name='Sidetone Mixer Playback' 1"
+                cset "name='DL1 PDM Switch' 1"
+		cset "name='DL1 Voice Playback Volume' 90,90"
+                cset "name='Capture Volume' 4"
+                cset "name='Capture Mixer Voice Capture' 90,90"
+                cset "name='SDT DL Volume' 120"
+	]
+
+
+	DisableSequence [
+                cdev "hw:PandaBoardES"
+                cset "name='AMIC_UL PDM Switch' 0"
+                cset "name='Sidetone Mixer Capture' 0"
+                cset "name='MUX_VX0' 0"
+                cset "name='MUX_VX1' 0"
+		cset "name='DL1 Mixer Voice' 0"
+		cset "name='Sidetone Mixer Playback' 0"
+                cset "name='DL1 PDM Switch' 0"
+		cset "name='DL1 Voice Playback Volume' 0,0"
+                cset "name='Capture Volume' 0"
+		cset "name='DL1 Voice Playback Volume' 0,0"
+                cset "name='SDT DL Volume' 0"
+	]
+
+	# Optional TQ and ALSA PCMs
+	Value {
+		TQ "Voice"
+                CapturePCM "hw:0,2"
+		PlaybackPCM "hw:0,2"
+	}
+}
+
+SectionDevice."Headset".0 {
+	Comment "PandaBoardES 3.5mm Headset"
+	
+	EnableSequence [
+                cdev "hw:PandaBoardES"
+                cset "name='Analog Left Capture Route' 0"
+                cset "name='Analog Right Capture Route' 0"
+                cset "name='Capture Preamplifier Volume' 2"
+                cset "name='Headset Left Playback' 1"
+                cset "name='Headset Right Playback' 1"
+                cset "name='Headset Playback Volume' 13"
+	]
+
+	DisableSequence [
+                cdev "hw:PandaBoardES"
+                cset "name='Analog Left Capture Route' 3"
+                cset "name='Analog Right Capture Route' 3"
+                cset "name='Capture Preamplifier Volume' 0"
+		cset "name='Headset Right Playback' 0"
+		cset "name='Headset Left Playback' 0"
+                cset "name='Headset Playback Volume' 0"
+	]
+}
+
-- 
1.8.1.2
