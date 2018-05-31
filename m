From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/5] conf/ucm: bytcr-rt5640: Add long-name UCM
	profiles
Date: Thu, 31 May 2018 17:10:23 +0200
Message-ID: <20180531151026.29521-3-hdegoede@redhat.com>
References: <20180531151026.29521-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 70CDD267910
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 17:10:31 +0200 (CEST)
In-Reply-To: <20180531151026.29521-1-hdegoede@redhat.com>
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

With a recently merged kernel commit, the kernel now sets a long-name for
bytcr-rt5640 boards which indicates if a single (mono) speaker or stereo
speakers are used and wether dmic1, in1 or in3 is used for the internal
mic (the headset mic sofar is always in2).

This commit adds UCM profiles for bytcr-rt5640 boards using these new
long-names, based on the generic bytcr-rt5640 profile.

The added profiles have the unnecessary input / output options from the
generic profile removed leaving only 2 input and 2 output options, which
are automatically switched between by e.g. pulse based on jack-detect.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                                  |  6 +++++
 src/conf/ucm/Makefile.am                      |  6 +++++
 .../bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf | 26 +++++++++++++++++++
 .../Makefile.am                               |  4 +++
 .../bytcr-rt5640-mono-spk-dmic1-mic.conf      |  8 ++++++
 .../bytcr-rt5640-mono-spk-in1-mic/HiFi.conf   | 26 +++++++++++++++++++
 .../bytcr-rt5640-mono-spk-in1-mic/Makefile.am |  4 +++
 .../bytcr-rt5640-mono-spk-in1-mic.conf        |  8 ++++++
 .../bytcr-rt5640-mono-spk-in3-mic/HiFi.conf   | 26 +++++++++++++++++++
 .../bytcr-rt5640-mono-spk-in3-mic/Makefile.am |  4 +++
 .../bytcr-rt5640-mono-spk-in3-mic.conf        |  8 ++++++
 .../HiFi.conf                                 | 26 +++++++++++++++++++
 .../Makefile.am                               |  4 +++
 .../bytcr-rt5640-stereo-spk-dmic1-mic.conf    |  8 ++++++
 .../bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf | 26 +++++++++++++++++++
 .../Makefile.am                               |  4 +++
 .../bytcr-rt5640-stereo-spk-in1-mic.conf      |  8 ++++++
 .../bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf | 26 +++++++++++++++++++
 .../Makefile.am                               |  4 +++
 .../bytcr-rt5640-stereo-spk-in3-mic.conf      |  8 ++++++
 20 files changed, 240 insertions(+)
 create mode 100644 src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/bytcr-rt5640-mono-spk-dmic1-mic.conf
 create mode 100644 src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/bytcr-rt5640-mono-spk-in1-mic.conf
 create mode 100644 src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/bytcr-rt5640-mono-spk-in3-mic.conf
 create mode 100644 src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/bytcr-rt5640-stereo-spk-dmic1-mic.conf
 create mode 100644 src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/bytcr-rt5640-stereo-spk-in1-mic.conf
 create mode 100644 src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/bytcr-rt5640-stereo-spk-in3-mic.conf

diff --git a/configure.ac b/configure.ac
index f6ee6ca8..57e0c354 100644
--- a/configure.ac
+++ b/configure.ac
@@ -722,6 +722,12 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/broxton-rt298/Makefile \
 	  src/conf/ucm/bytcr/Makefile \
 	  src/conf/ucm/bytcr-rt5640/Makefile \
+	  src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/Makefile \
+	  src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/Makefile \
+	  src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/Makefile \
+	  src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/Makefile \
+	  src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/Makefile \
+	  src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5651/Makefile \
 	  src/conf/ucm/chtrt5645/Makefile \
 	  src/conf/ucm/chtrt5645-mono-speaker-analog-mic/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index dc2d6857..a524921b 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -4,6 +4,12 @@ broadwell-rt286 \
 broxton-rt298 \
 bytcr \
 bytcr-rt5640 \
+bytcr-rt5640-mono-spk-dmic1-mic \
+bytcr-rt5640-mono-spk-in1-mic \
+bytcr-rt5640-mono-spk-in3-mic \
+bytcr-rt5640-stereo-spk-dmic1-mic \
+bytcr-rt5640-stereo-spk-in1-mic \
+bytcr-rt5640-stereo-spk-in3-mic \
 bytcr-rt5651 \
 chtrt5645 \
 chtrt5645-mono-speaker-analog-mic \
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
new file mode 100644
index 00000000..47ca04f0
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
@@ -0,0 +1,26 @@
+# Use case Configuration for bytcr-rt5640
+
+<searchdir:ucm>
+
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+		<bytcr/PlatformEnableSeq.conf>
+		<rt5640/EnableSeq.conf>
+	]
+
+	DisableSequence [
+	]
+
+	Value {
+		PlaybackPCM "hw:bytcrrt5640"
+		CapturePCM "hw:bytcrrt5640"
+	}
+}
+
+<rt5640/MonoSpeaker.conf>
+<rt5640/HeadPhones.conf>
+
+<rt5640/DigitalMics.conf>
+<rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/Makefile.am b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/Makefile.am
new file mode 100644
index 00000000..55ed3dbd
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5640-mono-spk-dmic1-mic
+ucm_DATA = bytcr-rt5640-mono-spk-dmic1-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/bytcr-rt5640-mono-spk-dmic1-mic.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/bytcr-rt5640-mono-spk-dmic1-mic.conf
new file mode 100644
index 00000000..f5297e9e
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/bytcr-rt5640-mono-spk-dmic1-mic.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "../bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5640"
+]
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
new file mode 100644
index 00000000..e280843d
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
@@ -0,0 +1,26 @@
+# Use case Configuration for bytcr-rt5640
+
+<searchdir:ucm>
+
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+		<bytcr/PlatformEnableSeq.conf>
+		<rt5640/EnableSeq.conf>
+	]
+
+	DisableSequence [
+	]
+
+	Value {
+		PlaybackPCM "hw:bytcrrt5640"
+		CapturePCM "hw:bytcrrt5640"
+	}
+}
+
+<rt5640/MonoSpeaker.conf>
+<rt5640/HeadPhones.conf>
+
+<rt5640/IN1-InternalMic.conf>
+<rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/Makefile.am b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/Makefile.am
new file mode 100644
index 00000000..d306cfcb
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5640-mono-spk-in1-mic
+ucm_DATA = bytcr-rt5640-mono-spk-in1-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/bytcr-rt5640-mono-spk-in1-mic.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/bytcr-rt5640-mono-spk-in1-mic.conf
new file mode 100644
index 00000000..cdac03a1
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/bytcr-rt5640-mono-spk-in1-mic.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "../bytcr-rt5640-mono-spk-in1-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5640"
+]
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
new file mode 100644
index 00000000..511b7c98
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
@@ -0,0 +1,26 @@
+# Use case Configuration for bytcr-rt5640
+
+<searchdir:ucm>
+
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+		<bytcr/PlatformEnableSeq.conf>
+		<rt5640/EnableSeq.conf>
+	]
+
+	DisableSequence [
+	]
+
+	Value {
+		PlaybackPCM "hw:bytcrrt5640"
+		CapturePCM "hw:bytcrrt5640"
+	}
+}
+
+<rt5640/MonoSpeaker.conf>
+<rt5640/HeadPhones.conf>
+
+<rt5640/IN3-InternalMic.conf>
+<rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/Makefile.am b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/Makefile.am
new file mode 100644
index 00000000..3f44a725
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5640-mono-spk-in3-mic
+ucm_DATA = bytcr-rt5640-mono-spk-in3-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/bytcr-rt5640-mono-spk-in3-mic.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/bytcr-rt5640-mono-spk-in3-mic.conf
new file mode 100644
index 00000000..15807363
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/bytcr-rt5640-mono-spk-in3-mic.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "../bytcr-rt5640-mono-spk-in3-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5640"
+]
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
new file mode 100644
index 00000000..8cf5cb7c
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
@@ -0,0 +1,26 @@
+# Use case Configuration for bytcr-rt5640
+
+<searchdir:ucm>
+
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+		<bytcr/PlatformEnableSeq.conf>
+		<rt5640/EnableSeq.conf>
+	]
+
+	DisableSequence [
+	]
+
+	Value {
+		PlaybackPCM "hw:bytcrrt5640"
+		CapturePCM "hw:bytcrrt5640"
+	}
+}
+
+<rt5640/Speaker.conf>
+<rt5640/HeadPhones.conf>
+
+<rt5640/DigitalMics.conf>
+<rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/Makefile.am b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/Makefile.am
new file mode 100644
index 00000000..acd1f0ef
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5640-stereo-spk-dmic1-mic
+ucm_DATA = bytcr-rt5640-stereo-spk-dmic1-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/bytcr-rt5640-stereo-spk-dmic1-mic.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/bytcr-rt5640-stereo-spk-dmic1-mic.conf
new file mode 100644
index 00000000..a84bf842
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/bytcr-rt5640-stereo-spk-dmic1-mic.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "../bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5640"
+]
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
new file mode 100644
index 00000000..a617ba19
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
@@ -0,0 +1,26 @@
+# Use case Configuration for bytcr-rt5640
+
+<searchdir:ucm>
+
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+		<bytcr/PlatformEnableSeq.conf>
+		<rt5640/EnableSeq.conf>
+	]
+
+	DisableSequence [
+	]
+
+	Value {
+		PlaybackPCM "hw:bytcrrt5640"
+		CapturePCM "hw:bytcrrt5640"
+	}
+}
+
+<rt5640/Speaker.conf>
+<rt5640/HeadPhones.conf>
+
+<rt5640/IN1-InternalMic.conf>
+<rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/Makefile.am b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/Makefile.am
new file mode 100644
index 00000000..f6f11fe8
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5640-stereo-spk-in1-mic
+ucm_DATA = bytcr-rt5640-stereo-spk-in1-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/bytcr-rt5640-stereo-spk-in1-mic.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/bytcr-rt5640-stereo-spk-in1-mic.conf
new file mode 100644
index 00000000..e8231c17
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/bytcr-rt5640-stereo-spk-in1-mic.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "../bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5640"
+]
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
new file mode 100644
index 00000000..83b31795
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
@@ -0,0 +1,26 @@
+# Use case Configuration for bytcr-rt5640
+
+<searchdir:ucm>
+
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytcrrt5640"
+
+		<bytcr/PlatformEnableSeq.conf>
+		<rt5640/EnableSeq.conf>
+	]
+
+	DisableSequence [
+	]
+
+	Value {
+		PlaybackPCM "hw:bytcrrt5640"
+		CapturePCM "hw:bytcrrt5640"
+	}
+}
+
+<rt5640/Speaker.conf>
+<rt5640/HeadPhones.conf>
+
+<rt5640/IN3-InternalMic.conf>
+<rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/Makefile.am b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/Makefile.am
new file mode 100644
index 00000000..bedd535d
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5640-stereo-spk-in3-mic
+ucm_DATA = bytcr-rt5640-stereo-spk-in3-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/bytcr-rt5640-stereo-spk-in3-mic.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/bytcr-rt5640-stereo-spk-in3-mic.conf
new file mode 100644
index 00000000..ba369dcf
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/bytcr-rt5640-stereo-spk-in3-mic.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "../bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5640"
+]
-- 
2.17.0
