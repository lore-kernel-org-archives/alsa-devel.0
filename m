From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/4] conf/ucm: bytcr-rt5651: Add digital mic
	support
Date: Mon, 24 Dec 2018 16:05:03 +0100
Message-ID: <20181224150504.20845-3-hdegoede@redhat.com>
References: <20181224150504.20845-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id CBA48267ABE
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2018 16:05:09 +0100 (CET)
In-Reply-To: <20181224150504.20845-1-hdegoede@redhat.com>
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

Add a new ucm/codecs/rt5651/DigitalMic.conf snippet for digital mic support
and include this in the default non board-specific bytcr-rt5651.conf.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/bytcr-rt5651/HiFi.conf           |  1 +
 src/conf/ucm/codecs/rt5651/DigitalMic.conf    | 29 +++++++++++++++++++
 src/conf/ucm/codecs/rt5651/EnableSeq.conf     |  2 ++
 .../ucm/codecs/rt5651/IN1-InternalMic.conf    |  1 +
 .../ucm/codecs/rt5651/IN12-InternalMic.conf   |  1 +
 .../ucm/codecs/rt5651/IN2-HeadsetMic.conf     |  1 +
 .../ucm/codecs/rt5651/IN2-InternalMic.conf    |  1 +
 .../ucm/codecs/rt5651/IN3-HeadsetMic.conf     |  1 +
 src/conf/ucm/codecs/rt5651/Makefile.am        |  3 +-
 9 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 src/conf/ucm/codecs/rt5651/DigitalMic.conf

diff --git a/src/conf/ucm/bytcr-rt5651/HiFi.conf b/src/conf/ucm/bytcr-rt5651/HiFi.conf
index 37bb1d40..8fcc5a8c 100644
--- a/src/conf/ucm/bytcr-rt5651/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651/HiFi.conf
@@ -23,6 +23,7 @@ SectionVerb {
 <codecs/rt5651/MonoSpeaker.conf>
 <codecs/rt5651/HeadPhones.conf>
 
+<codecs/rt5651/DigitalMic.conf>
 <codecs/rt5651/IN1-InternalMic.conf>
 <codecs/rt5651/IN2-InternalMic.conf>
 <codecs/rt5651/IN12-InternalMic.conf>
diff --git a/src/conf/ucm/codecs/rt5651/DigitalMic.conf b/src/conf/ucm/codecs/rt5651/DigitalMic.conf
new file mode 100644
index 00000000..63ffa9d5
--- /dev/null
+++ b/src/conf/ucm/codecs/rt5651/DigitalMic.conf
@@ -0,0 +1,29 @@
+SectionDevice."DigitalMic" {
+	Comment "Internal Digital Microphone"
+
+	ConflictingDevice [
+		"InternalMic-IN1"
+		"InternalMic-IN2"
+		"InternalMic-IN12"
+		"HeadsetMic-IN2"
+		"HeadsetMic-IN3"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5651"
+		cset "name='Stereo1 ADC MIXL ADC2 Switch' on"
+		cset "name='Stereo1 ADC MIXR ADC2 Switch' on"
+		cset "name='Internal Mic Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5651"
+		cset "name='Stereo1 ADC MIXL ADC2 Switch' off"
+		cset "name='Stereo1 ADC MIXR ADC2 Switch' off"
+		cset "name='Internal Mic Switch' off"
+	]
+
+	Value {
+		CaptureChannels 2
+	}
+}
diff --git a/src/conf/ucm/codecs/rt5651/EnableSeq.conf b/src/conf/ucm/codecs/rt5651/EnableSeq.conf
index db2fd328..9c1386fa 100644
--- a/src/conf/ucm/codecs/rt5651/EnableSeq.conf
+++ b/src/conf/ucm/codecs/rt5651/EnableSeq.conf
@@ -43,6 +43,8 @@ cset "name='IN3 Boost' 1"
 # input
 cset "name='Stereo1 ADC L1 Mux' ADC"
 cset "name='Stereo1 ADC R1 Mux' ADC"
+cset "name='Stereo1 ADC L2 Mux' DMIC"
+cset "name='Stereo1 ADC R2 Mux' DMIC"
 cset "name='RECMIXL BST1 Switch' off"
 cset "name='RECMIXR BST1 Switch' off"
 cset "name='RECMIXL BST3 Switch' off"
diff --git a/src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf b/src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf
index 5092809f..12ab5cbc 100644
--- a/src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf
@@ -2,6 +2,7 @@ SectionDevice."InternalMic-IN1" {
 	Comment "Internal Microphone on IN1"
 
 	ConflictingDevice [
+		"DigitalMic"
 		"InternalMic-IN2"
 		"InternalMic-IN12"
 		"HeadsetMic-IN2"
diff --git a/src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf b/src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf
index c917e85e..c4290b75 100644
--- a/src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf
@@ -2,6 +2,7 @@ SectionDevice."InternalMic-IN12" {
 	Comment "Internal Microphones on IN1 and IN2"
 
 	ConflictingDevice [
+		"DigitalMic"
 		"InternalMic-IN1"
 		"InternalMic-IN2"
 		"HeadsetMic-IN2"
diff --git a/src/conf/ucm/codecs/rt5651/IN2-HeadsetMic.conf b/src/conf/ucm/codecs/rt5651/IN2-HeadsetMic.conf
index b6dc0814..8759c274 100644
--- a/src/conf/ucm/codecs/rt5651/IN2-HeadsetMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN2-HeadsetMic.conf
@@ -2,6 +2,7 @@ SectionDevice."HeadsetMic-IN2" {
 	Comment "Headset Microphone on IN2"
 
 	ConflictingDevice [
+		"DigitalMic"
 		"InternalMic-IN1"
 		"InternalMic-IN2"
 		"InternalMic-IN12"
diff --git a/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf b/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf
index bbb713c0..c9c11c28 100644
--- a/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf
@@ -2,6 +2,7 @@ SectionDevice."InternalMic-IN2" {
 	Comment "Internal Microphone on IN2"
 
 	ConflictingDevice [
+		"DigitalMic"
 		"InternalMic-IN1"
 		"InternalMic-IN12"
 		"HeadsetMic-IN2"
diff --git a/src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf b/src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf
index 48f3e463..66af6b9b 100644
--- a/src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf
@@ -2,6 +2,7 @@ SectionDevice."HeadsetMic-IN3" {
 	Comment "Headset Microphone on IN3"
 
 	ConflictingDevice [
+		"DigitalMic"
 		"InternalMic-IN1"
 		"InternalMic-IN2"
 		"InternalMic-IN12"
diff --git a/src/conf/ucm/codecs/rt5651/Makefile.am b/src/conf/ucm/codecs/rt5651/Makefile.am
index 889b4fd4..29b68437 100644
--- a/src/conf/ucm/codecs/rt5651/Makefile.am
+++ b/src/conf/ucm/codecs/rt5651/Makefile.am
@@ -1,6 +1,7 @@
 alsaconfigdir = @ALSA_CONFIG_DIR@
 ucmdir = $(alsaconfigdir)/ucm/codecs/rt5651
-ucm_DATA = EnableSeq.conf HeadPhones.conf HeadPhones-swapped.conf \
+ucm_DATA = DigitalMic.conf EnableSeq.conf \
+	   HeadPhones.conf HeadPhones-swapped.conf \
 	   IN1-InternalMic.conf IN2-InternalMic.conf IN12-InternalMic.conf \
 	   IN2-HeadsetMic.conf IN3-HeadsetMic.conf Speaker.conf MonoSpeaker.conf
 EXTRA_DIST = $(ucm_DATA)
-- 
2.20.1
