From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/4] conf/ucm: bytcr-rt5651: Enable Stereo? ADC
	MIXL ADC? switches when enabling inputs
Date: Mon, 24 Dec 2018 16:05:01 +0100
Message-ID: <20181224150504.20845-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id E097C267A65
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2018 16:05:07 +0100 (CET)
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

Explicitly enable the right 'Stereo? ADC MIXL ADC?' when selecting an input,
rather then just enabling them all in ucm/codecs/rt5651/EnableSeq.conf .

This is a preparation patch for adding digital mic support.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/codecs/rt5651/EnableSeq.conf        | 16 ++++++++--------
 src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf  |  4 ++++
 src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf |  4 ++++
 src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf  |  4 ++++
 src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf   |  4 ++++
 5 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/src/conf/ucm/codecs/rt5651/EnableSeq.conf b/src/conf/ucm/codecs/rt5651/EnableSeq.conf
index 6fb3c1f2..db2fd328 100644
--- a/src/conf/ucm/codecs/rt5651/EnableSeq.conf
+++ b/src/conf/ucm/codecs/rt5651/EnableSeq.conf
@@ -14,12 +14,14 @@ cset "name='Stereo DAC MIXL DAC L1 Switch' on"
 cset "name='Stereo DAC MIXL DAC R1 Switch' off"
 cset "name='Stereo DAC MIXR DAC L1 Switch' off"
 cset "name='Stereo DAC MIXR DAC R1 Switch' on"
-cset "name='Stereo1 ADC MIXR ADC1 Switch' on"
-cset "name='Stereo1 ADC MIXR ADC2 Switch' on"
-cset "name='Stereo2 ADC MIXL ADC1 Switch' on"
-cset "name='Stereo2 ADC MIXL ADC2 Switch' on"
-cset "name='Stereo2 ADC MIXR ADC1 Switch' on"
-cset "name='Stereo2 ADC MIXR ADC2 Switch' on"
+cset "name='Stereo1 ADC MIXL ADC1 Switch' off"
+cset "name='Stereo1 ADC MIXR ADC1 Switch' off"
+cset "name='Stereo1 ADC MIXL ADC2 Switch' off"
+cset "name='Stereo1 ADC MIXR ADC2 Switch' off"
+cset "name='Stereo2 ADC MIXL ADC1 Switch' off"
+cset "name='Stereo2 ADC MIXR ADC1 Switch' off"
+cset "name='Stereo2 ADC MIXL ADC2 Switch' off"
+cset "name='Stereo2 ADC MIXR ADC2 Switch' off"
 cset "name='Headphone Switch' off"
 cset "name='Speaker Switch' off"
 
@@ -41,8 +43,6 @@ cset "name='IN3 Boost' 1"
 # input
 cset "name='Stereo1 ADC L1 Mux' ADC"
 cset "name='Stereo1 ADC R1 Mux' ADC"
-cset "name='Stereo1 ADC MIXL ADC1 Switch' on"
-cset "name='Stereo1 ADC MIXR ADC1 Switch' on"
 cset "name='RECMIXL BST1 Switch' off"
 cset "name='RECMIXR BST1 Switch' off"
 cset "name='RECMIXL BST3 Switch' off"
diff --git a/src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf b/src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf
index 85e25a5c..b2ce17b6 100644
--- a/src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf
@@ -12,10 +12,14 @@ SectionDevice."InternalMic-IN1" {
 		cset "name='Internal Mic Switch' on"
 		cset "name='RECMIXL BST1 Switch' on"
 		cset "name='RECMIXR BST1 Switch' on"
+		cset "name='Stereo1 ADC MIXL ADC1 Switch' on"
+		cset "name='Stereo1 ADC MIXR ADC1 Switch' on"
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
+		cset "name='Stereo1 ADC MIXL ADC1 Switch' off"
+		cset "name='Stereo1 ADC MIXR ADC1 Switch' off"
 		cset "name='Internal Mic Switch' off"
 		cset "name='RECMIXL BST1 Switch' off"
 		cset "name='RECMIXR BST1 Switch' off"
diff --git a/src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf b/src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf
index f1cc17fe..e8041912 100644
--- a/src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf
@@ -14,10 +14,14 @@ SectionDevice."InternalMic-IN12" {
 		cset "name='RECMIXR BST1 Switch' on"
 		cset "name='RECMIXL BST2 Switch' on"
 		cset "name='RECMIXR BST2 Switch' on"
+		cset "name='Stereo1 ADC MIXL ADC1 Switch' on"
+		cset "name='Stereo1 ADC MIXR ADC1 Switch' on"
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
+		cset "name='Stereo1 ADC MIXL ADC1 Switch' off"
+		cset "name='Stereo1 ADC MIXR ADC1 Switch' off"
 		cset "name='Internal Mic Switch' off"
 		cset "name='RECMIXL BST1 Switch' off"
 		cset "name='RECMIXR BST1 Switch' off"
diff --git a/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf b/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf
index 18f74e1a..048fcc95 100644
--- a/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf
@@ -12,10 +12,14 @@ SectionDevice."InternalMic-IN2" {
 		cset "name='Internal Mic Switch' on"
 		cset "name='RECMIXL BST2 Switch' on"
 		cset "name='RECMIXR BST2 Switch' on"
+		cset "name='Stereo1 ADC MIXL ADC1 Switch' on"
+		cset "name='Stereo1 ADC MIXR ADC1 Switch' on"
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
+		cset "name='Stereo1 ADC MIXL ADC1 Switch' off"
+		cset "name='Stereo1 ADC MIXR ADC1 Switch' off"
 		cset "name='Internal Mic Switch' off"
 		cset "name='RECMIXL BST2 Switch' off"
 		cset "name='RECMIXR BST2 Switch' off"
diff --git a/src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf b/src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf
index bfd0b009..712d14bb 100644
--- a/src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf
+++ b/src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf
@@ -12,10 +12,14 @@ SectionDevice."HeadsetMic-IN3" {
 		cset "name='Headset Mic Switch' on"
 		cset "name='RECMIXL BST3 Switch' on"
 		cset "name='RECMIXR BST3 Switch' on"
+		cset "name='Stereo1 ADC MIXL ADC1 Switch' on"
+		cset "name='Stereo1 ADC MIXR ADC1 Switch' on"
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
+		cset "name='Stereo1 ADC MIXL ADC1 Switch' off"
+		cset "name='Stereo1 ADC MIXR ADC1 Switch' off"
 		cset "name='Headset Mic Switch' off"
 		cset "name='RECMIXL BST3 Switch' off"
 		cset "name='RECMIXR BST3 Switch' off"
-- 
2.20.1
