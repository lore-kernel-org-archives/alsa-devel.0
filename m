From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/4] conf/ucm: bytcr-rt5651: Add support for a
	headset-mic on IN2
Date: Mon, 24 Dec 2018 16:05:02 +0100
Message-ID: <20181224150504.20845-2-hdegoede@redhat.com>
References: <20181224150504.20845-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 70A5F267A65
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

The first design with the headset-mic on IN2 rather then the
default / reference-design IN3 has shown up.

Add a new ucm/codecs/rt5651/IN2-HeadsetMic.conf snippet to deal with this
and include this in the default non board-specific bytcr-rt5651.conf.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/bytcr-rt5651/HiFi.conf                    |  1 +
 src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf        |  1 +
 src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf       |  1 +
 .../{IN2-InternalMic.conf => IN2-HeadsetMic.conf}      | 10 ++++++----
 src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf        |  1 +
 src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf         |  3 ++-
 src/conf/ucm/codecs/rt5651/Makefile.am                 |  2 +-
 7 files changed, 13 insertions(+), 6 deletions(-)
 copy src/conf/ucm/codecs/rt5651/{IN2-InternalMic.conf => IN2-HeadsetMic.conf} (73%)

diff --git a/src/conf/ucm/bytcr-rt5651/HiFi.conf b/src/conf/ucm/bytcr-rt5651/HiFi.conf
index fddd8a3c..37bb1d40 100644
--- a/src/conf/ucm/bytcr-rt5651/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651/HiFi.conf
@@ -26,4 +26,5 @@ SectionVerb {
 <codecs/rt5651/IN1-InternalMic.conf>
 <codecs/rt5651/IN2-InternalMic.conf>
 <codecs/rt5651/IN12-InternalMic.conf>
+<codecs/rt5651/IN2-HeadsetMic.conf>
 <codecs/rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf b/src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf
index b2ce17b6..5092809f 100644
--- a/src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf
@@ -4,6 +4,7 @@ SectionDevice."InternalMic-IN1" {
 	ConflictingDevice [
 		"InternalMic-IN2"
 		"InternalMic-IN12"
+		"HeadsetMic-IN2"
 		"HeadsetMic-IN3"
 	]
 
diff --git a/src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf b/src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf
index e8041912..c917e85e 100644
--- a/src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf
@@ -4,6 +4,7 @@ SectionDevice."InternalMic-IN12" {
 	ConflictingDevice [
 		"InternalMic-IN1"
 		"InternalMic-IN2"
+		"HeadsetMic-IN2"
 		"HeadsetMic-IN3"
 	]
 
diff --git a/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf b/src/conf/ucm/codecs/rt5651/IN2-HeadsetMic.conf
similarity index 73%
copy from src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf
copy to src/conf/ucm/codecs/rt5651/IN2-HeadsetMic.conf
index 048fcc95..b6dc0814 100644
--- a/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN2-HeadsetMic.conf
@@ -1,15 +1,16 @@
-SectionDevice."InternalMic-IN2" {
-	Comment "Internal Microphone on IN2"
+SectionDevice."HeadsetMic-IN2" {
+	Comment "Headset Microphone on IN2"
 
 	ConflictingDevice [
 		"InternalMic-IN1"
+		"InternalMic-IN2"
 		"InternalMic-IN12"
 		"HeadsetMic-IN3"
 	]
 
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
-		cset "name='Internal Mic Switch' on"
+		cset "name='Headset Mic Switch' on"
 		cset "name='RECMIXL BST2 Switch' on"
 		cset "name='RECMIXR BST2 Switch' on"
 		cset "name='Stereo1 ADC MIXL ADC1 Switch' on"
@@ -20,12 +21,13 @@ SectionDevice."InternalMic-IN2" {
 		cdev "hw:bytcrrt5651"
 		cset "name='Stereo1 ADC MIXL ADC1 Switch' off"
 		cset "name='Stereo1 ADC MIXR ADC1 Switch' off"
-		cset "name='Internal Mic Switch' off"
+		cset "name='Headset Mic Switch' off"
 		cset "name='RECMIXL BST2 Switch' off"
 		cset "name='RECMIXR BST2 Switch' off"
 	]
 
 	Value {
 		CaptureChannels "2"
+		JackControl "Headset Mic Jack"
 	}
 }
diff --git a/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf b/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf
index 048fcc95..bbb713c0 100644
--- a/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf
@@ -4,6 +4,7 @@ SectionDevice."InternalMic-IN2" {
 	ConflictingDevice [
 		"InternalMic-IN1"
 		"InternalMic-IN12"
+		"HeadsetMic-IN2"
 		"HeadsetMic-IN3"
 	]
 
diff --git a/src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf b/src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf
index 712d14bb..48f3e463 100644
--- a/src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf
@@ -1,10 +1,11 @@
 SectionDevice."HeadsetMic-IN3" {
-	Comment "Headset Microphone"
+	Comment "Headset Microphone on IN3"
 
 	ConflictingDevice [
 		"InternalMic-IN1"
 		"InternalMic-IN2"
 		"InternalMic-IN12"
+		"HeadsetMic-IN2"
 	]
 
 	EnableSequence [
diff --git a/src/conf/ucm/codecs/rt5651/Makefile.am b/src/conf/ucm/codecs/rt5651/Makefile.am
index a68bd7bb..889b4fd4 100644
--- a/src/conf/ucm/codecs/rt5651/Makefile.am
+++ b/src/conf/ucm/codecs/rt5651/Makefile.am
@@ -2,5 +2,5 @@ alsaconfigdir = @ALSA_CONFIG_DIR@
 ucmdir = $(alsaconfigdir)/ucm/codecs/rt5651
 ucm_DATA = EnableSeq.conf HeadPhones.conf HeadPhones-swapped.conf \
 	   IN1-InternalMic.conf IN2-InternalMic.conf IN12-InternalMic.conf \
-	   IN3-HeadsetMic.conf Speaker.conf MonoSpeaker.conf
+	   IN2-HeadsetMic.conf IN3-HeadsetMic.conf Speaker.conf MonoSpeaker.conf
 EXTRA_DIST = $(ucm_DATA)
-- 
2.20.1
