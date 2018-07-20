From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 12/14] conf/ucm: bytcr-rt5651: Add long-name
	UCM profiles
Date: Fri, 20 Jul 2018 09:27:39 +0200
Message-ID: <20180720072741.4632-13-hdegoede@redhat.com>
References: <20180720072741.4632-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 59A4126772E
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 09:27:56 +0200 (CEST)
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

After recent kernel work, the kernel now sets a long-name for bytcr-rt5651
boards which indicates if a single (mono) speaker or stereo speakers are
used and if in1, in2, or in1 and 2 are used for the internal mic(s) (the
headset mic sofar is always on in3).

This commit adds UCM profiles for bytcr-rt5651 boards using these new
long-names, based on the generic bytcr-rt5651 profile.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                                  |  5 ++++
 src/conf/ucm/Makefile.am                      |  5 ++++
 .../bytcr-rt5651-mono-spk-in1-mic/HiFi.conf   | 27 +++++++++++++++++++
 .../bytcr-rt5651-mono-spk-in1-mic/Makefile.am |  4 +++
 .../bytcr-rt5651-mono-spk-in1-mic.conf        | 10 +++++++
 .../bytcr-rt5651-mono-spk-in2-mic/HiFi.conf   | 27 +++++++++++++++++++
 .../bytcr-rt5651-mono-spk-in2-mic/Makefile.am |  4 +++
 .../bytcr-rt5651-mono-spk-in2-mic.conf        | 10 +++++++
 .../bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf | 27 +++++++++++++++++++
 .../Makefile.am                               |  4 +++
 .../bytcr-rt5651-stereo-spk-in1-mic.conf      | 10 +++++++
 .../HiFi.conf                                 | 27 +++++++++++++++++++
 .../Makefile.am                               |  4 +++
 .../bytcr-rt5651-stereo-spk-in12-mic.conf     | 10 +++++++
 .../bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf | 27 +++++++++++++++++++
 .../Makefile.am                               |  4 +++
 .../bytcr-rt5651-stereo-spk-in2-mic.conf      | 10 +++++++
 17 files changed, 215 insertions(+)
 create mode 100644 src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/bytcr-rt5651-mono-spk-in1-mic.conf
 create mode 100644 src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/bytcr-rt5651-mono-spk-in2-mic.conf
 create mode 100644 src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/bytcr-rt5651-stereo-spk-in1-mic.conf
 create mode 100644 src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/bytcr-rt5651-stereo-spk-in12-mic.conf
 create mode 100644 src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/bytcr-rt5651-stereo-spk-in2-mic.conf

diff --git a/configure.ac b/configure.ac
index 85a6be80..9fb7218c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -729,6 +729,11 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5651/Makefile \
+	  src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/Makefile \
+	  src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/Makefile \
+	  src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/Makefile \
+	  src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/Makefile \
+	  src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/Makefile \
 	  src/conf/ucm/chtnau8824/Makefile \
 	  src/conf/ucm/chtrt5645/Makefile \
 	  src/conf/ucm/chtrt5645-mono-speaker-analog-mic/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 669e98d5..1246e7ae 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -11,6 +11,11 @@ bytcr-rt5640-stereo-spk-dmic1-mic \
 bytcr-rt5640-stereo-spk-in1-mic \
 bytcr-rt5640-stereo-spk-in3-mic \
 bytcr-rt5651 \
+bytcr-rt5651-mono-spk-in1-mic \
+bytcr-rt5651-mono-spk-in2-mic \
+bytcr-rt5651-stereo-spk-in1-mic \
+bytcr-rt5651-stereo-spk-in2-mic \
+bytcr-rt5651-stereo-spk-in12-mic \
 chtnau8824 \
 chtrt5645 \
 chtrt5645-mono-speaker-analog-mic \
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf
new file mode 100644
index 00000000..dd5b35fc
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf
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
+<rt5651/HeadPhones.conf>
+
+<rt5651/IN1-InternalMic.conf>
+<rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/Makefile.am b/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/Makefile.am
new file mode 100644
index 00000000..3c5ad289
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5651-mono-spk-in1-mic
+ucm_DATA = bytcr-rt5651-mono-spk-in1-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/bytcr-rt5651-mono-spk-in1-mic.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/bytcr-rt5651-mono-spk-in1-mic.conf
new file mode 100644
index 00000000..a2f584e8
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/bytcr-rt5651-mono-spk-in1-mic.conf
@@ -0,0 +1,10 @@
+# Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
+
+SectionUseCase."HiFi" {
+	File "../bytcr-rt5651-mono-spk-in1-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5651"
+]
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf
new file mode 100644
index 00000000..9f56c077
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf
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
+<rt5651/HeadPhones.conf>
+
+<rt5651/IN2-InternalMic.conf>
+<rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/Makefile.am b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/Makefile.am
new file mode 100644
index 00000000..38ee13b9
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5651-mono-spk-in2-mic
+ucm_DATA = bytcr-rt5651-mono-spk-in2-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/bytcr-rt5651-mono-spk-in2-mic.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/bytcr-rt5651-mono-spk-in2-mic.conf
new file mode 100644
index 00000000..4ad36ec3
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/bytcr-rt5651-mono-spk-in2-mic.conf
@@ -0,0 +1,10 @@
+# Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
+
+SectionUseCase."HiFi" {
+	File "../bytcr-rt5651-mono-spk-in2-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5651"
+]
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf
new file mode 100644
index 00000000..e2a579ab
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf
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
+<rt5651/Speaker.conf>
+<rt5651/HeadPhones.conf>
+
+<rt5651/IN1-InternalMic.conf>
+<rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/Makefile.am b/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/Makefile.am
new file mode 100644
index 00000000..40691994
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5651-stereo-spk-in1-mic
+ucm_DATA = bytcr-rt5651-stereo-spk-in1-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/bytcr-rt5651-stereo-spk-in1-mic.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/bytcr-rt5651-stereo-spk-in1-mic.conf
new file mode 100644
index 00000000..40d871be
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/bytcr-rt5651-stereo-spk-in1-mic.conf
@@ -0,0 +1,10 @@
+# Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
+
+SectionUseCase."HiFi" {
+	File "../bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5651"
+]
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf
new file mode 100644
index 00000000..ae52e719
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf
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
+<rt5651/Speaker.conf>
+<rt5651/HeadPhones.conf>
+
+<rt5651/IN12-InternalMic.conf>
+<rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/Makefile.am b/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/Makefile.am
new file mode 100644
index 00000000..12514945
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5651-stereo-spk-in12-mic
+ucm_DATA = bytcr-rt5651-stereo-spk-in12-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/bytcr-rt5651-stereo-spk-in12-mic.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/bytcr-rt5651-stereo-spk-in12-mic.conf
new file mode 100644
index 00000000..56bf3f07
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/bytcr-rt5651-stereo-spk-in12-mic.conf
@@ -0,0 +1,10 @@
+# Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
+
+SectionUseCase."HiFi" {
+	File "../bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5651"
+]
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf
new file mode 100644
index 00000000..a73ff5f8
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf
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
+<rt5651/Speaker.conf>
+<rt5651/HeadPhones.conf>
+
+<rt5651/IN2-InternalMic.conf>
+<rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/Makefile.am b/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/Makefile.am
new file mode 100644
index 00000000..9b06afd1
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5651-stereo-spk-in2-mic
+ucm_DATA = bytcr-rt5651-stereo-spk-in2-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/bytcr-rt5651-stereo-spk-in2-mic.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/bytcr-rt5651-stereo-spk-in2-mic.conf
new file mode 100644
index 00000000..84e86e42
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/bytcr-rt5651-stereo-spk-in2-mic.conf
@@ -0,0 +1,10 @@
+# Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
+
+SectionUseCase."HiFi" {
+	File "../bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5651"
+]
-- 
2.17.1
