From: Marcin Juszkiewicz <marcin@juszkiewicz.com.pl>
Subject: [PATCH 4/5] SDP4430: add UCM config from Ubuntu
Date: Fri, 10 May 2013 14:51:09 +0200
Message-ID: <1368190270-29647-5-git-send-email-marcin@juszkiewicz.com.pl>
References: <1368190270-29647-1-git-send-email-marcin@juszkiewicz.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tygrysek.juszkiewicz.com.pl (tygrysek.juszkiewicz.com.pl
 [178.33.81.99]) by alsa0.perex.cz (Postfix) with ESMTP id 0D7EB2615F7
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 14:51:24 +0200 (CEST)
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
 SDP4430/FMAnalog     | 46 +++++++++++++++++++++++++++++
 SDP4430/SDP4430.conf | 45 ++++++++++++++++++++++++++++
 SDP4430/hifi         | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 SDP4430/hifiLP       | 46 +++++++++++++++++++++++++++++
 SDP4430/record       | 45 ++++++++++++++++++++++++++++
 SDP4430/voice        | 46 +++++++++++++++++++++++++++++
 SDP4430/voiceCall    | 67 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 378 insertions(+)
 create mode 100644 SDP4430/FMAnalog
 create mode 100644 SDP4430/SDP4430.conf
 create mode 100644 SDP4430/hifi
 create mode 100644 SDP4430/hifiLP
 create mode 100644 SDP4430/record
 create mode 100644 SDP4430/voice
 create mode 100644 SDP4430/voiceCall

diff --git a/SDP4430/FMAnalog b/SDP4430/FMAnalog
new file mode 100644
index 0000000..876527a
--- /dev/null
+++ b/SDP4430/FMAnalog
@@ -0,0 +1,46 @@
+# Use case Configurationfor TI SDP4430 HiFi Music
+# By Liam Girdwood <lrg@slimlogic.co.uk>
+
+SectionVerb {
+  	EnableSequence [
+                cdev "hw:SDP4430"
+                cset "name='AMIC_UL PDM Switch' 1"
+                cset "name='MUX_UL00' 9"
+                cset "name='MUX_UL01' 10"
+                cset "name='Capture Volume' 4"
+	]
+
+
+	DisableSequence [
+                cdev "hw:SDP4430"
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
+	Comment "SDP4430 3.5mm Headset"
+	
+	EnableSequence [
+                cdev "hw:SDP4430"
+                cset "name='Analog Left Capture Route' 2"
+                cset "name='Analog Right Capture Route' 2"
+                cset "name='Capture Preamplifier Volume' 2"
+	]
+
+	DisableSequence [
+                cdev "hw:SDP4430"
+                cset "name='Analog Left Capture Route' 3"
+                cset "name='Analog Right Capture Route' 3"
+                cset "name='Capture Preamplifier Volume' 0"
+	]
+}
+
diff --git a/SDP4430/SDP4430.conf b/SDP4430/SDP4430.conf
new file mode 100644
index 0000000..2fa2ab8
--- /dev/null
+++ b/SDP4430/SDP4430.conf
@@ -0,0 +1,45 @@
+# UCM configuration for SDP4430
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
+                cdev "hw:SDP4430"
+		exec "echo Im setting defaults"
+]
diff --git a/SDP4430/hifi b/SDP4430/hifi
new file mode 100644
index 0000000..a3293c5
--- /dev/null
+++ b/SDP4430/hifi
@@ -0,0 +1,83 @@
+# Use case Configuration for TI SDP4430 HiFi Music
+# By Liam Girdwood <lrg@slimlogic.co.uk>
+
+SectionVerb {
+  	EnableSequence [
+                cdev "hw:SDP4430"
+		cset "name='DL1 Mixer Multimedia' 1"
+		cset "name='Sidetone Mixer Playback' 1"
+                cset "name='DL1 PDM Switch' 1"
+		cset "name='DL1 Media Playback Volume' 90,90"
+                cset "name='SDT DL Volume' 120"
+
+                cset "name='HS Left Playback' 1"
+                cset "name='HS Right Playback' 1"
+                cset "name='Headset Playback Volume' 13"
+	]
+
+	DisableSequence [
+                cdev "hw:SDP4430"
+		cset "name='DL1 Mixer Multimedia' 0"
+		cset "name='Sidetone Mixer Playback' 0"
+                cset "name='DL1 PDM Switch' 0"
+		cset "name='DL1 Media Playback Volume' 0,0"
+                cset "name='SDT DL Volume' 0"
+
+		cset "name='HS Right Playback' 0"
+		cset "name='HS Left Playback' 0"
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
+	Comment "SDP4430 3.5mm Headset"
+	
+	EnableSequence [
+                cdev "hw:SDP4430"
+                cset "name='HS Left Playback' 1"
+                cset "name='HS Right Playback' 1"
+                cset "name='Headset Playback Volume' 13"
+	]
+
+	DisableSequence [
+                cdev "hw:SDP4430"
+		cset "name='HS Right Playback' 0"
+		cset "name='HS Left Playback' 0"
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
diff --git a/SDP4430/hifiLP b/SDP4430/hifiLP
new file mode 100644
index 0000000..ccf3d87
--- /dev/null
+++ b/SDP4430/hifiLP
@@ -0,0 +1,46 @@
+# Use case Configuration for TI SDP4430 HiFi Music
+# By Liam Girdwood <lrg@slimlogic.co.uk>
+
+SectionVerb {
+  	EnableSequence [
+                cdev "hw:SDP4430"
+		cset "name='DL1 Mixer Multimedia' 1"
+		cset "name='Sidetone Mixer Playback' 1"
+                cset "name='DL1 PDM Switch' 1"
+		cset "name='DL1 Media Playback Volume' 90,90"
+                cset "name='SDT DL Volume' 120"
+	]
+
+	DisableSequence [
+                cdev "hw:SDP4430"
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
+	Comment "SDP4430 3.5mm Headset"
+	
+	EnableSequence [
+                cdev "hw:SDP4430"
+                cset "name='HS Left Playback' 1"
+                cset "name='HS Right Playback' 1"
+                cset "name='Headset Playback Volume' 13"
+	]
+
+	DisableSequence [
+                cdev "hw:SDP4430"
+		cset "name='HS Right Playback' 0"
+		cset "name='HS Left Playback' 0"
+                cset "name='Headset Playback Volume' 0"
+	]
+}
diff --git a/SDP4430/record b/SDP4430/record
new file mode 100644
index 0000000..d680f25
--- /dev/null
+++ b/SDP4430/record
@@ -0,0 +1,45 @@
+# Use case Configuration for TI SDP4430 HiFi Music
+# By Liam Girdwood <lrg@slimlogic.co.uk>
+
+SectionVerb {
+  	EnableSequence [
+                cdev "hw:SDP4430"
+                cset "name='AMIC_UL PDM Switch' 1"
+                cset "name='MUX_UL00' 9"
+                cset "name='MUX_UL01' 10"
+                cset "name='Capture Volume' 4"
+	]
+
+	DisableSequence [
+                cdev "hw:SDP4430"
+                cset "name='AMIC_UL PDM Switch' 0"
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
+	Comment "SDP4430 3.5mm Headset"
+	
+	EnableSequence [
+                cdev "hw:SDP4430"
+                cset "name='Analog Left Capture Route' 0"
+                cset "name='Analog Right Capture Route' 0"
+                cset "name='Capture Preamplifier Volume' 2"
+	]
+
+	DisableSequence [
+                cdev "hw:SDP4430"
+                cset "name='Analog Left Capture Route' 3"
+                cset "name='Analog Right Capture Route' 3"
+                cset "name='Capture Preamplifier Volume' 0"
+	]
+}
diff --git a/SDP4430/voice b/SDP4430/voice
new file mode 100644
index 0000000..8bea89c
--- /dev/null
+++ b/SDP4430/voice
@@ -0,0 +1,46 @@
+# Use case Configuration for TI SDP4430 HiFi Music
+# By Liam Girdwood <lrg@slimlogic.co.uk>
+
+SectionVerb {
+  	EnableSequence [
+                cdev "hw:SDP4430"
+		cset "name='DL1 Mixer Voice' 1"
+		cset "name='Sidetone Mixer Playback' 1"
+                cset "name='DL1 PDM Switch' 1"
+		cset "name='DL1 Voice Playback Volume' 90,90"
+                cset "name='SDT DL Volume' 120"
+	]
+
+	DisableSequence [
+                cdev "hw:SDP4430"
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
+	Comment "SDP4430 3.5mm Headset"
+	
+	EnableSequence [
+                cdev "hw:SDP4430"
+                cset "name='HS Left Playback' 1"
+                cset "name='HS Right Playback' 1"
+                cset "name='Headset Playback Volume' 13"
+	]
+
+	DisableSequence [
+                cdev "hw:SDP4430"
+		cset "name='HS Right Playback' 0"
+		cset "name='HS Left Playback' 0"
+                cset "name='Headset Playback Volume' 0"
+	]
+}
diff --git a/SDP4430/voiceCall b/SDP4430/voiceCall
new file mode 100644
index 0000000..4c06106
--- /dev/null
+++ b/SDP4430/voiceCall
@@ -0,0 +1,67 @@
+# Use case Configuration for TI SDP4430 HiFi Music
+# By Liam Girdwood <lrg@slimlogic.co.uk>
+
+SectionVerb {
+  	EnableSequence [
+                cdev "hw:SDP4430"
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
+                cdev "hw:SDP4430"
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
+	Comment "SDP4430 3.5mm Headset"
+	
+	EnableSequence [
+                cdev "hw:SDP4430"
+                cset "name='Analog Left Capture Route' 0"
+                cset "name='Analog Right Capture Route' 0"
+                cset "name='Capture Preamplifier Volume' 2"
+                cset "name='HS Left Playback' 1"
+                cset "name='HS Right Playback' 1"
+                cset "name='Headset Playback Volume' 13"
+	]
+
+	DisableSequence [
+                cdev "hw:SDP4430"
+                cset "name='Analog Left Capture Route' 3"
+                cset "name='Analog Right Capture Route' 3"
+                cset "name='Capture Preamplifier Volume' 0"
+		cset "name='HS Right Playback' 0"
+		cset "name='HS Left Playback' 0"
+                cset "name='Headset Playback Volume' 0"
+	]
+}
+
-- 
1.8.1.2
