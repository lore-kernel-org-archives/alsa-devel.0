From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 10/13] conf/ucm: bytcr-rt5651: Add mono
	speaker output profile
Date: Wed,  8 Aug 2018 11:05:40 +0200
Message-ID: <20180808090543.15181-10-hdegoede@redhat.com>
References: <20180808090543.15181-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id A72BC2678D3
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 11:05:54 +0200 (CEST)
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

Many rt5651 devices only have a single speaker and even though there is
some external mixing done on the PCB, the quality of that mixing is quite
poor and various sounds come out garbled when relying on the on PCB mixing.

Using the codecs builtin mixer to mix left + right to the left output works
much better. This commits adds a new MonoSpeaker.conf output profile which
allows this.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/bytcr-rt5651/HiFi.conf           |  2 +-
 src/conf/ucm/rt5651/EnableSeq.conf            |  2 ++
 src/conf/ucm/rt5651/HeadPhones.conf           |  1 +
 src/conf/ucm/rt5651/Makefile.am               |  2 +-
 .../rt5651/{Speaker.conf => MonoSpeaker.conf} | 20 ++++++++++++-------
 src/conf/ucm/rt5651/Speaker.conf              |  1 +
 6 files changed, 19 insertions(+), 9 deletions(-)
 copy src/conf/ucm/rt5651/{Speaker.conf => MonoSpeaker.conf} (52%)

diff --git a/src/conf/ucm/bytcr-rt5651/HiFi.conf b/src/conf/ucm/bytcr-rt5651/HiFi.conf
index 961b2604..8733403c 100644
--- a/src/conf/ucm/bytcr-rt5651/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651/HiFi.conf
@@ -21,9 +21,9 @@ SectionVerb {
 }
 
 <rt5651/Speaker.conf>
+<rt5651/MonoSpeaker.conf>
 <rt5651/HeadPhones.conf>
 
-
 <rt5651/IN1-InternalMic.conf>
 <rt5651/IN2-InternalMic.conf>
 <rt5651/IN12-InternalMic.conf>
diff --git a/src/conf/ucm/rt5651/EnableSeq.conf b/src/conf/ucm/rt5651/EnableSeq.conf
index 37bffecb..6fb3c1f2 100644
--- a/src/conf/ucm/rt5651/EnableSeq.conf
+++ b/src/conf/ucm/rt5651/EnableSeq.conf
@@ -11,6 +11,8 @@ cset "name='IF1 ASRC Switch' on"
 cset "name='LOUT L Playback Switch' off"
 cset "name='LOUT R Playback Switch' off"
 cset "name='Stereo DAC MIXL DAC L1 Switch' on"
+cset "name='Stereo DAC MIXL DAC R1 Switch' off"
+cset "name='Stereo DAC MIXR DAC L1 Switch' off"
 cset "name='Stereo DAC MIXR DAC R1 Switch' on"
 cset "name='Stereo1 ADC MIXR ADC1 Switch' on"
 cset "name='Stereo1 ADC MIXR ADC2 Switch' on"
diff --git a/src/conf/ucm/rt5651/HeadPhones.conf b/src/conf/ucm/rt5651/HeadPhones.conf
index b9323a36..eaf5fdfc 100644
--- a/src/conf/ucm/rt5651/HeadPhones.conf
+++ b/src/conf/ucm/rt5651/HeadPhones.conf
@@ -3,6 +3,7 @@ SectionDevice."Headphones" {
 
 	ConflictingDevice [
 		"Speaker"
+		"MonoSpeaker"
 	]
 
 	EnableSequence [
diff --git a/src/conf/ucm/rt5651/Makefile.am b/src/conf/ucm/rt5651/Makefile.am
index abd45ad7..a9600ed6 100644
--- a/src/conf/ucm/rt5651/Makefile.am
+++ b/src/conf/ucm/rt5651/Makefile.am
@@ -2,5 +2,5 @@ alsaconfigdir = @ALSA_CONFIG_DIR@
 ucmdir = $(alsaconfigdir)/ucm/rt5651
 ucm_DATA = EnableSeq.conf HeadPhones.conf IN1-InternalMic.conf \
 	   IN2-InternalMic.conf IN12-InternalMic.conf IN3-HeadsetMic.conf \
-	   Speaker.conf
+	   Speaker.conf MonoSpeaker.conf
 EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/rt5651/Speaker.conf b/src/conf/ucm/rt5651/MonoSpeaker.conf
similarity index 52%
copy from src/conf/ucm/rt5651/Speaker.conf
copy to src/conf/ucm/rt5651/MonoSpeaker.conf
index 44168cc5..0c3492fb 100644
--- a/src/conf/ucm/rt5651/Speaker.conf
+++ b/src/conf/ucm/rt5651/MonoSpeaker.conf
@@ -1,15 +1,20 @@
-SectionDevice."Speaker" {
-	Comment "Speakers"
+SectionDevice."MonoSpeaker" {
+	Comment "Mono Speaker"
 
 	ConflictingDevice [
+		"Speaker"
 		"Headphones"
 	]
 
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
+
+		# Map left and right input on left
+		cset "name='Stereo DAC MIXR DAC R1 Switch' off"
+		cset "name='Stereo DAC MIXL DAC R1 Switch' on"
+
 		cset "name='Speaker Switch' on"
 		cset "name='LOUT L Playback Switch' on"
-		cset "name='LOUT R Playback Switch' on"
 		# Done after turning the speaker on to keep the bias and clk on
 		cset "name='Headphone Switch' off"
 		cset "name='HPO L Playback Switch' off"
@@ -18,10 +23,11 @@ SectionDevice."Speaker" {
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
-		# This is done by the Headphones EnableSequence, so that the
-		# Platform Clock and BIAS do not temporarily get turned off
-		# as that breaks audio-streams which are playing when
-		# switching between Speaker/Headphone
+		# Disabling the  switches is done by the Speaker EnableSeq
+
+		# Undo mono mapping
+		cset "name='Stereo DAC MIXL DAC R1 Switch' off"
+		cset "name='Stereo DAC MIXR DAC R1 Switch' on"
 	]
 
 	Value {
diff --git a/src/conf/ucm/rt5651/Speaker.conf b/src/conf/ucm/rt5651/Speaker.conf
index 44168cc5..c1091523 100644
--- a/src/conf/ucm/rt5651/Speaker.conf
+++ b/src/conf/ucm/rt5651/Speaker.conf
@@ -2,6 +2,7 @@ SectionDevice."Speaker" {
 	Comment "Speakers"
 
 	ConflictingDevice [
+		"MonoSpeaker"
 		"Headphones"
 	]
 
-- 
2.18.0
