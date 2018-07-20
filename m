From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 13/14] conf/ucm: bytcr-rt5651: Add
	bytcr-rt5651-mono-spk-in2-mic-hp-swapped config
Date: Fri, 20 Jul 2018 09:27:40 +0200
Message-ID: <20180720072741.4632-14-hdegoede@redhat.com>
References: <20180720072741.4632-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 4799E26777F
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 09:27:57 +0200 (CEST)
In-Reply-To: <20180720072741.4632-1-hdegoede@redhat.com>
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

Add a longname profile for devices with a mono speaker, the Internal Mic
hooked up to IN2 and the left and right channels of their headphones
output swapped.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                                  |  1 +
 src/conf/ucm/Makefile.am                      |  1 +
 .../HiFi.conf                                 | 27 ++++++++++++
 .../Makefile.am                               |  4 ++
 ...cr-rt5651-mono-spk-in2-mic-hp-swapped.conf | 10 +++++
 src/conf/ucm/rt5651/HeadPhones-swapped.conf   | 42 +++++++++++++++++++
 src/conf/ucm/rt5651/Makefile.am               |  6 +--
 7 files changed, 88 insertions(+), 3 deletions(-)
 create mode 100644 src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/bytcr-rt5651-mono-spk-in2-mic-hp-swapped.conf
 create mode 100644 src/conf/ucm/rt5651/HeadPhones-swapped.conf

diff --git a/configure.ac b/configure.ac
index 9fb7218c..97d61abd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -731,6 +731,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/bytcr-rt5651/Makefile \
 	  src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/Makefile \
+	  src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/Makefile \
 	  src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 1246e7ae..7cdc6176 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -13,6 +13,7 @@ bytcr-rt5640-stereo-spk-in3-mic \
 bytcr-rt5651 \
 bytcr-rt5651-mono-spk-in1-mic \
 bytcr-rt5651-mono-spk-in2-mic \
+bytcr-rt5651-mono-spk-in2-mic-hp-swapped \
 bytcr-rt5651-stereo-spk-in1-mic \
 bytcr-rt5651-stereo-spk-in2-mic \
 bytcr-rt5651-stereo-spk-in12-mic \
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf
new file mode 100644
index 00000000..777ed783
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf
@@ -0,0 +1,27 @@
+# Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
+
+<searchdir:ucm>
+
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytcrrt5651"
+		<bytcr/PlatformEnableSeq.conf>
+		<rt5651/EnableSeq.conf>
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5651"
+		<bytcr/PlatformDisableSeq.conf>
+	]
+
+	Value {
+		PlaybackPCM "hw:bytcrrt5651"
+		CapturePCM "hw:bytcrrt5651"
+	}
+}
+
+<rt5651/MonoSpeaker.conf>
+<rt5651/HeadPhones-swapped.conf>
+
+<rt5651/IN2-InternalMic.conf>
+<rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/Makefile.am b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/Makefile.am
new file mode 100644
index 00000000..862d38b9
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped
+ucm_DATA = bytcr-rt5651-mono-spk-in2-mic-hp-swapped.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/bytcr-rt5651-mono-spk-in2-mic-hp-swapped.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/bytcr-rt5651-mono-spk-in2-mic-hp-swapped.conf
new file mode 100644
index 00000000..916fbc19
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/bytcr-rt5651-mono-spk-in2-mic-hp-swapped.conf
@@ -0,0 +1,10 @@
+# Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
+
+SectionUseCase."HiFi" {
+	File "../bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5651"
+]
diff --git a/src/conf/ucm/rt5651/HeadPhones-swapped.conf b/src/conf/ucm/rt5651/HeadPhones-swapped.conf
new file mode 100644
index 00000000..e79b40a7
--- /dev/null
+++ b/src/conf/ucm/rt5651/HeadPhones-swapped.conf
@@ -0,0 +1,42 @@
+SectionDevice."Headphones" {
+	Comment "Headphones"
+
+	ConflictingDevice [
+		"Speaker"
+		"MonoSpeaker"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5651"
+
+		# Swap left and right
+		cset "name='Stereo DAC MIXL DAC R1 Switch' on"
+		cset "name='Stereo DAC MIXL DAC L1 Switch' off"
+		cset "name='Stereo DAC MIXR DAC L1 Switch' on"
+		cset "name='Stereo DAC MIXR DAC R1 Switch' off"
+
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
+		# Disabling the HP switches is done by the Speaker EnableSeq
+
+		# Unswap left and right
+		cset "name='Stereo DAC MIXL DAC L1 Switch' on"
+		cset "name='Stereo DAC MIXL DAC R1 Switch' off"
+		cset "name='Stereo DAC MIXR DAC R1 Switch' on"
+		cset "name='Stereo DAC MIXR DAC L1 Switch' off"
+	]
+
+	Value {
+		PlaybackChannels "2"
+		JackControl "Headphone Jack"
+	}
+}
diff --git a/src/conf/ucm/rt5651/Makefile.am b/src/conf/ucm/rt5651/Makefile.am
index a9600ed6..acc8ea49 100644
--- a/src/conf/ucm/rt5651/Makefile.am
+++ b/src/conf/ucm/rt5651/Makefile.am
@@ -1,6 +1,6 @@
 alsaconfigdir = @ALSA_CONFIG_DIR@
 ucmdir = $(alsaconfigdir)/ucm/rt5651
-ucm_DATA = EnableSeq.conf HeadPhones.conf IN1-InternalMic.conf \
-	   IN2-InternalMic.conf IN12-InternalMic.conf IN3-HeadsetMic.conf \
-	   Speaker.conf MonoSpeaker.conf
+ucm_DATA = EnableSeq.conf HeadPhones.conf HeadPhones-swapped.conf \
+	   IN1-InternalMic.conf IN2-InternalMic.conf IN12-InternalMic.conf \
+	   IN3-HeadsetMic.conf Speaker.conf MonoSpeaker.conf
 EXTRA_DIST = $(ucm_DATA)
-- 
2.17.1
