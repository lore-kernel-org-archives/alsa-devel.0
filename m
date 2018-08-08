From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 09/13] conf/ucm: bytcr-rt5651: Split into 1
	.conf file per input / output
Date: Wed,  8 Aug 2018 11:05:39 +0200
Message-ID: <20180808090543.15181-9-hdegoede@redhat.com>
References: <20180808090543.15181-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id AD29126786A
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 11:05:53 +0200 (CEST)
In-Reply-To: <20180808090543.15181-1-hdegoede@redhat.com>
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

Split the bytcr-rt5651 config into 1 .conf file per input / output as
has already been done for the bytcr-rt5640 and the chtnau8824 profiles.

This allows easy creation of long-name profiles with the specific input /
output combinations found on a board without needing to copy and paste
things.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/bytcr-rt5651/HiFi.conf       | 197 +---------------------
 src/conf/ucm/rt5651/HeadPhones.conf       |  31 ++++
 src/conf/ucm/rt5651/IN1-InternalMic.conf  |  27 +++
 src/conf/ucm/rt5651/IN12-InternalMic.conf |  31 ++++
 src/conf/ucm/rt5651/IN2-InternalMic.conf  |  27 +++
 src/conf/ucm/rt5651/IN3-HeadsetMic.conf   |  28 +++
 src/conf/ucm/rt5651/Makefile.am           |   4 +-
 src/conf/ucm/rt5651/Speaker.conf          |  30 ++++
 8 files changed, 185 insertions(+), 190 deletions(-)
 create mode 100644 src/conf/ucm/rt5651/HeadPhones.conf
 create mode 100644 src/conf/ucm/rt5651/IN1-InternalMic.conf
 create mode 100644 src/conf/ucm/rt5651/IN12-InternalMic.conf
 create mode 100644 src/conf/ucm/rt5651/IN2-InternalMic.conf
 create mode 100644 src/conf/ucm/rt5651/IN3-HeadsetMic.conf
 create mode 100644 src/conf/ucm/rt5651/Speaker.conf

diff --git a/src/conf/ucm/bytcr-rt5651/HiFi.conf b/src/conf/ucm/bytcr-rt5651/HiFi.conf
index 54c365d9..961b2604 100644
--- a/src/conf/ucm/bytcr-rt5651/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651/HiFi.conf
@@ -1,5 +1,7 @@
 # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
 
+<searchdir:ucm>
+
 SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
@@ -18,194 +20,11 @@ SectionVerb {
 	}
 }
 
-SectionDevice."Headphones" {
-	Comment "Headphones playback"
-
-	ConflictingDevice [
-		"Speaker"
-	]
-
-	EnableSequence [
-		cdev "hw:bytcrrt5651"
-		exec "echo Headphones playback enable sequence"
-		cset "name='Headphone Switch' on"
-		cset "name='HPO L Playback Switch' on"
-		cset "name='HPO R Playback Switch' on"
-		# Done after turning the HP on to keep the bias and clk on
-		cset "name='Speaker Switch' off"
-		cset "name='LOUT L Playback Switch' off"
-		cset "name='LOUT R Playback Switch' off"
-	]
-
-	DisableSequence [
-		cdev "hw:bytcrrt5651"
-		exec "echo Headphones playback disable sequence"
-		# This is done by the Speaker EnableSequence, so that the
-		# Platform Clock and BIAS do not temporarily get turned off
-		# as that breaks audio-streams which are playing when
-		# switching between Speaker/Headphone
-	]
-
-	Value {
-		PlaybackChannels "2"
-		JackControl "Headphone Jack"
-	}
-}
-
-SectionDevice."Speaker" {
-	Comment "Speaker playback"
-
-	ConflictingDevice [
-		"Headphones"
-	]
-
-	EnableSequence [
-		cdev "hw:bytcrrt5651"
-		exec "echo Speaker enable sequence"
-		cset "name='Speaker Switch' on"
-		cset "name='LOUT L Playback Switch' on"
-		cset "name='LOUT R Playback Switch' on"
-		# Done after turning the speaker on to keep the bias and clk on
-		cset "name='Headphone Switch' off"
-		cset "name='HPO L Playback Switch' off"
-		cset "name='HPO R Playback Switch' off"
-	]
-
-	DisableSequence [
-		cdev "hw:bytcrrt5651"
-		exec "echo Speaker disable sequence"
-		# This is done by the Headphones EnableSequence, so that the
-		# Platform Clock and BIAS do not temporarily get turned off
-		# as that breaks audio-streams which are playing when
-		# switching between Speaker/Headphone
-	]
-
-	Value {
-		PlaybackChannels "2"
-	}
-}
-
-SectionDevice."InternalMic-IN1" {
-	Comment "Internal Microphone on IN1"
-
-	ConflictingDevice [
-		"InternalMic-IN2"
-		"InternalMic-IN12"
-		"HeadsetMic-IN3"
-	]
-
-	EnableSequence [
-		cdev "hw:bytcrrt5651"
-		exec "echo Internal Mic IN1 Microphone enable sequence"
-		cset "name='Internal Mic Switch' on"
-		cset "name='RECMIXL BST1 Switch' on"
-		cset "name='RECMIXR BST1 Switch' on"
-	]
-
-	DisableSequence [
-		cdev "hw:bytcrrt5651"
-		exec "echo Internal Mic IN1 Microphone disable sequence"
-		cset "name='Internal Mic Switch' off"
-		cset "name='RECMIXL BST1 Switch' off"
-		cset "name='RECMIXR BST1 Switch' off"
-	]
-
-	Value {
-		CaptureChannels "2"
-	}
-}
-
-SectionDevice."InternalMic-IN2" {
-	Comment "Internal Microphone on IN2"
-
-	ConflictingDevice [
-		"InternalMic-IN1"
-		"InternalMic-IN12"
-		"HeadsetMic-IN3"
-	]
-
-	EnableSequence [
-		cdev "hw:bytcrrt5651"
-		exec "echo Internal Mic IN2 Microphone enable sequence"
-		cset "name='Internal Mic Switch' on"
-		cset "name='RECMIXL BST2 Switch' on"
-		cset "name='RECMIXR BST2 Switch' on"
-	]
-
-	DisableSequence [
-		cdev "hw:bytcrrt5651"
-		exec "echo Internal Mic IN2 Microphone disable sequence"
-		cset "name='Internal Mic Switch' off"
-		cset "name='RECMIXL BST2 Switch' off"
-		cset "name='RECMIXR BST2 Switch' off"
-	]
-
-	Value {
-		CaptureChannels "2"
-	}
-}
-
-SectionDevice."InternalMic-IN12" {
-	Comment "Internal Microphones on IN1 and IN2"
-
-	ConflictingDevice [
-		"InternalMic-IN1"
-		"InternalMic-IN2"
-		"HeadsetMic-IN3"
-	]
-
-	EnableSequence [
-		cdev "hw:bytcrrt5651"
-		exec "echo Internal Mic IN12 Microphone enable sequence"
-		cset "name='Internal Mic Switch' on"
-		cset "name='RECMIXL BST1 Switch' on"
-		cset "name='RECMIXR BST1 Switch' on"
-		cset "name='RECMIXL BST2 Switch' on"
-		cset "name='RECMIXR BST2 Switch' on"
-	]
-
-	DisableSequence [
-		cdev "hw:bytcrrt5651"
-		exec "echo Internal Mic IN12 Microphone disable sequence"
-		cset "name='Internal Mic Switch' off"
-		cset "name='RECMIXL BST1 Switch' off"
-		cset "name='RECMIXR BST1 Switch' off"
-		cset "name='RECMIXL BST2 Switch' off"
-		cset "name='RECMIXR BST2 Switch' off"
-	]
-
-	Value {
-		CaptureChannels "2"
-	}
-}
-
-SectionDevice."HeadsetMic-IN3" {
-	Comment "Headset Microphone"
-
-	ConflictingDevice [
-		"InternalMic-IN1"
-		"InternalMic-IN2"
-		"InternalMic-IN12"
-	]
+<rt5651/Speaker.conf>
+<rt5651/HeadPhones.conf>
 
-	EnableSequence [
-		cdev "hw:bytcrrt5651"
-		exec "echo HeadsetMic-IN3 Microphone enable sequence"
-		cset "name='Headset Mic Switch' on"
-		cset "name='RECMIXL BST3 Switch' on"
-		cset "name='RECMIXR BST3 Switch' on"
-	]
 
-	DisableSequence [
-		cdev "hw:bytcrrt5651"
-		exec "echo HeadsetMic-IN3 Microphone disable sequence"
-		cset "name='Headset Mic Switch' off"
-		cset "name='RECMIXL BST3 Switch' off"
-		cset "name='RECMIXR BST3 Switch' off"
-	]
-
-	Value {
-		CaptureChannels "2"
-		JackControl "Headset Mic Jack"
-	}
-}
+<rt5651/IN1-InternalMic.conf>
+<rt5651/IN2-InternalMic.conf>
+<rt5651/IN12-InternalMic.conf>
+<rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/rt5651/HeadPhones.conf b/src/conf/ucm/rt5651/HeadPhones.conf
new file mode 100644
index 00000000..b9323a36
--- /dev/null
+++ b/src/conf/ucm/rt5651/HeadPhones.conf
@@ -0,0 +1,31 @@
+SectionDevice."Headphones" {
+	Comment "Headphones"
+
+	ConflictingDevice [
+		"Speaker"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5651"
+		cset "name='Headphone Switch' on"
+		cset "name='HPO L Playback Switch' on"
+		cset "name='HPO R Playback Switch' on"
+		# Done after turning the HP on to keep the bias and clk on
+		cset "name='Speaker Switch' off"
+		cset "name='LOUT L Playback Switch' off"
+		cset "name='LOUT R Playback Switch' off"
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5651"
+		# This is done by the Speaker EnableSequence, so that the
+		# Platform Clock and BIAS do not temporarily get turned off
+		# as that breaks audio-streams which are playing when
+		# switching between Speaker/Headphone
+	]
+
+	Value {
+		PlaybackChannels "2"
+		JackControl "Headphone Jack"
+	}
+}
diff --git a/src/conf/ucm/rt5651/IN1-InternalMic.conf b/src/conf/ucm/rt5651/IN1-InternalMic.conf
new file mode 100644
index 00000000..85e25a5c
--- /dev/null
+++ b/src/conf/ucm/rt5651/IN1-InternalMic.conf
@@ -0,0 +1,27 @@
+SectionDevice."InternalMic-IN1" {
+	Comment "Internal Microphone on IN1"
+
+	ConflictingDevice [
+		"InternalMic-IN2"
+		"InternalMic-IN12"
+		"HeadsetMic-IN3"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5651"
+		cset "name='Internal Mic Switch' on"
+		cset "name='RECMIXL BST1 Switch' on"
+		cset "name='RECMIXR BST1 Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5651"
+		cset "name='Internal Mic Switch' off"
+		cset "name='RECMIXL BST1 Switch' off"
+		cset "name='RECMIXR BST1 Switch' off"
+	]
+
+	Value {
+		CaptureChannels "2"
+	}
+}
diff --git a/src/conf/ucm/rt5651/IN12-InternalMic.conf b/src/conf/ucm/rt5651/IN12-InternalMic.conf
new file mode 100644
index 00000000..f1cc17fe
--- /dev/null
+++ b/src/conf/ucm/rt5651/IN12-InternalMic.conf
@@ -0,0 +1,31 @@
+SectionDevice."InternalMic-IN12" {
+	Comment "Internal Microphones on IN1 and IN2"
+
+	ConflictingDevice [
+		"InternalMic-IN1"
+		"InternalMic-IN2"
+		"HeadsetMic-IN3"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5651"
+		cset "name='Internal Mic Switch' on"
+		cset "name='RECMIXL BST1 Switch' on"
+		cset "name='RECMIXR BST1 Switch' on"
+		cset "name='RECMIXL BST2 Switch' on"
+		cset "name='RECMIXR BST2 Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5651"
+		cset "name='Internal Mic Switch' off"
+		cset "name='RECMIXL BST1 Switch' off"
+		cset "name='RECMIXR BST1 Switch' off"
+		cset "name='RECMIXL BST2 Switch' off"
+		cset "name='RECMIXR BST2 Switch' off"
+	]
+
+	Value {
+		CaptureChannels "2"
+	}
+}
diff --git a/src/conf/ucm/rt5651/IN2-InternalMic.conf b/src/conf/ucm/rt5651/IN2-InternalMic.conf
new file mode 100644
index 00000000..18f74e1a
--- /dev/null
+++ b/src/conf/ucm/rt5651/IN2-InternalMic.conf
@@ -0,0 +1,27 @@
+SectionDevice."InternalMic-IN2" {
+	Comment "Internal Microphone on IN2"
+
+	ConflictingDevice [
+		"InternalMic-IN1"
+		"InternalMic-IN12"
+		"HeadsetMic-IN3"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5651"
+		cset "name='Internal Mic Switch' on"
+		cset "name='RECMIXL BST2 Switch' on"
+		cset "name='RECMIXR BST2 Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5651"
+		cset "name='Internal Mic Switch' off"
+		cset "name='RECMIXL BST2 Switch' off"
+		cset "name='RECMIXR BST2 Switch' off"
+	]
+
+	Value {
+		CaptureChannels "2"
+	}
+}
diff --git a/src/conf/ucm/rt5651/IN3-HeadsetMic.conf b/src/conf/ucm/rt5651/IN3-HeadsetMic.conf
new file mode 100644
index 00000000..bfd0b009
--- /dev/null
+++ b/src/conf/ucm/rt5651/IN3-HeadsetMic.conf
@@ -0,0 +1,28 @@
+SectionDevice."HeadsetMic-IN3" {
+	Comment "Headset Microphone"
+
+	ConflictingDevice [
+		"InternalMic-IN1"
+		"InternalMic-IN2"
+		"InternalMic-IN12"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5651"
+		cset "name='Headset Mic Switch' on"
+		cset "name='RECMIXL BST3 Switch' on"
+		cset "name='RECMIXR BST3 Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5651"
+		cset "name='Headset Mic Switch' off"
+		cset "name='RECMIXL BST3 Switch' off"
+		cset "name='RECMIXR BST3 Switch' off"
+	]
+
+	Value {
+		CaptureChannels "2"
+		JackControl "Headset Mic Jack"
+	}
+}
diff --git a/src/conf/ucm/rt5651/Makefile.am b/src/conf/ucm/rt5651/Makefile.am
index 8a22159c..abd45ad7 100644
--- a/src/conf/ucm/rt5651/Makefile.am
+++ b/src/conf/ucm/rt5651/Makefile.am
@@ -1,4 +1,6 @@
 alsaconfigdir = @ALSA_CONFIG_DIR@
 ucmdir = $(alsaconfigdir)/ucm/rt5651
-ucm_DATA = EnableSeq.conf
+ucm_DATA = EnableSeq.conf HeadPhones.conf IN1-InternalMic.conf \
+	   IN2-InternalMic.conf IN12-InternalMic.conf IN3-HeadsetMic.conf \
+	   Speaker.conf
 EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/rt5651/Speaker.conf b/src/conf/ucm/rt5651/Speaker.conf
new file mode 100644
index 00000000..44168cc5
--- /dev/null
+++ b/src/conf/ucm/rt5651/Speaker.conf
@@ -0,0 +1,30 @@
+SectionDevice."Speaker" {
+	Comment "Speakers"
+
+	ConflictingDevice [
+		"Headphones"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5651"
+		cset "name='Speaker Switch' on"
+		cset "name='LOUT L Playback Switch' on"
+		cset "name='LOUT R Playback Switch' on"
+		# Done after turning the speaker on to keep the bias and clk on
+		cset "name='Headphone Switch' off"
+		cset "name='HPO L Playback Switch' off"
+		cset "name='HPO R Playback Switch' off"
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5651"
+		# This is done by the Headphones EnableSequence, so that the
+		# Platform Clock and BIAS do not temporarily get turned off
+		# as that breaks audio-streams which are playing when
+		# switching between Speaker/Headphone
+	]
+
+	Value {
+		PlaybackChannels "2"
+	}
+}
-- 
2.18.0
