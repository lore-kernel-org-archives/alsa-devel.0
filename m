From: Hans de Goede <hdegoede@redhat.com>
Subject: [RFC 2/2] conf/ucm: bytcht-es8316: Add long-name UCM
	profiles
Date: Thu,  3 Jan 2019 14:50:15 +0100
Message-ID: <20190103135015.14669-3-hdegoede@redhat.com>
References: <20190103135015.14669-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CEC3267BFB
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 14:50:21 +0100 (CET)
In-Reply-To: <20190103135015.14669-1-hdegoede@redhat.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, linux@endlessm.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org

After recent kernel work, the kernel now sets a long-name for bytcht-es8316
boards which indicates if a single (mono) speaker or stereo speakers are
used and if in1 or in2 is used for the internal mic (the headset mic will
be on the other input).

This commit adds UCM profiles for bytcht-es8316 boards using these new
long-names, based on the generic bytcht-es8316 profile.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                                  |  4 ++++
 src/conf/ucm/Makefile.am                      |  4 ++++
 .../bytcht-es8316-mono-spk-in1-mic/HiFi.conf  | 23 +++++++++++++++++++
 .../Makefile.am                               |  4 ++++
 .../bytcht-es8316-mono-spk-in1-mic.conf       |  8 +++++++
 .../bytcht-es8316-mono-spk-in2-mic/HiFi.conf  | 23 +++++++++++++++++++
 .../Makefile.am                               |  4 ++++
 .../bytcht-es8316-mono-spk-in2-mic.conf       |  8 +++++++
 .../HiFi.conf                                 | 23 +++++++++++++++++++
 .../Makefile.am                               |  4 ++++
 .../bytcht-es8316-stereo-spk-in1-mic.conf     |  8 +++++++
 .../HiFi.conf                                 | 23 +++++++++++++++++++
 .../Makefile.am                               |  4 ++++
 .../bytcht-es8316-stereo-spk-in2-mic.conf     |  8 +++++++
 14 files changed, 148 insertions(+)
 create mode 100644 src/conf/ucm/bytcht-es8316-mono-spk-in1-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcht-es8316-mono-spk-in1-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcht-es8316-mono-spk-in1-mic/bytcht-es8316-mono-spk-in1-mic.conf
 create mode 100644 src/conf/ucm/bytcht-es8316-mono-spk-in2-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcht-es8316-mono-spk-in2-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcht-es8316-mono-spk-in2-mic/bytcht-es8316-mono-spk-in2-mic.conf
 create mode 100644 src/conf/ucm/bytcht-es8316-stereo-spk-in1-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcht-es8316-stereo-spk-in1-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcht-es8316-stereo-spk-in1-mic/bytcht-es8316-stereo-spk-in1-mic.conf
 create mode 100644 src/conf/ucm/bytcht-es8316-stereo-spk-in2-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcht-es8316-stereo-spk-in2-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcht-es8316-stereo-spk-in2-mic/bytcht-es8316-stereo-spk-in2-mic.conf

diff --git a/configure.ac b/configure.ac
index ff2e2799..9b099b7f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -721,6 +721,10 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/broadwell-rt286/Makefile \
 	  src/conf/ucm/broxton-rt298/Makefile \
 	  src/conf/ucm/bytcht-es8316/Makefile \
+	  src/conf/ucm/bytcht-es8316-mono-spk-in1-mic/Makefile \
+	  src/conf/ucm/bytcht-es8316-mono-spk-in2-mic/Makefile \
+	  src/conf/ucm/bytcht-es8316-stereo-spk-in1-mic/Makefile \
+	  src/conf/ucm/bytcht-es8316-stereo-spk-in2-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5640/Makefile \
 	  src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index b252f258..ee850ee6 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -5,6 +5,10 @@ ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN \
 broadwell-rt286 \
 broxton-rt298 \
 bytcht-es8316 \
+bytcht-es8316-mono-spk-in1-mic \
+bytcht-es8316-mono-spk-in2-mic \
+bytcht-es8316-stereo-spk-in1-mic \
+bytcht-es8316-stereo-spk-in2-mic \
 bytcr-rt5640 \
 bytcr-rt5640-mono-spk-dmic1-mic \
 bytcr-rt5640-mono-spk-in1-mic \
diff --git a/src/conf/ucm/bytcht-es8316-mono-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcht-es8316-mono-spk-in1-mic/HiFi.conf
new file mode 100644
index 00000000..97899495
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316-mono-spk-in1-mic/HiFi.conf
@@ -0,0 +1,23 @@
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytchtes8316"
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/es8316/EnableSeq.conf>
+	]
+
+	DisableSequence [
+		cdev "hw:bytchtes8316"
+		<platforms/bytcr/PlatformDisableSeq.conf>
+	]
+
+	Value {
+		PlaybackPCM "hw:bytchtes8316"
+		CapturePCM "hw:bytchtes8316"
+	}
+}
+
+<codecs/es8316/MonoSpeaker.conf>
+<codecs/es8316/HeadPhones.conf>
+
+<codecs/es8316/IN1-InternalMic.conf>
+<codecs/es8316/IN2-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcht-es8316-mono-spk-in1-mic/Makefile.am b/src/conf/ucm/bytcht-es8316-mono-spk-in1-mic/Makefile.am
new file mode 100644
index 00000000..420592fc
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316-mono-spk-in1-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcht-es8316-mono-spk-in1-mic
+ucm_DATA = bytcht-es8316-mono-spk-in1-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcht-es8316-mono-spk-in1-mic/bytcht-es8316-mono-spk-in1-mic.conf b/src/conf/ucm/bytcht-es8316-mono-spk-in1-mic/bytcht-es8316-mono-spk-in1-mic.conf
new file mode 100644
index 00000000..26d82ead
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316-mono-spk-in1-mic/bytcht-es8316-mono-spk-in1-mic.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "../bytcht-es8316-mono-spk-in1-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytchtes8316"
+]
diff --git a/src/conf/ucm/bytcht-es8316-mono-spk-in2-mic/HiFi.conf b/src/conf/ucm/bytcht-es8316-mono-spk-in2-mic/HiFi.conf
new file mode 100644
index 00000000..2821eb51
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316-mono-spk-in2-mic/HiFi.conf
@@ -0,0 +1,23 @@
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytchtes8316"
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/es8316/EnableSeq.conf>
+	]
+
+	DisableSequence [
+		cdev "hw:bytchtes8316"
+		<platforms/bytcr/PlatformDisableSeq.conf>
+	]
+
+	Value {
+		PlaybackPCM "hw:bytchtes8316"
+		CapturePCM "hw:bytchtes8316"
+	}
+}
+
+<codecs/es8316/MonoSpeaker.conf>
+<codecs/es8316/HeadPhones.conf>
+
+<codecs/es8316/IN1-HeadsetMic.conf>
+<codecs/es8316/IN2-InternalMic.conf>
diff --git a/src/conf/ucm/bytcht-es8316-mono-spk-in2-mic/Makefile.am b/src/conf/ucm/bytcht-es8316-mono-spk-in2-mic/Makefile.am
new file mode 100644
index 00000000..939c8b7d
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316-mono-spk-in2-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcht-es8316-mono-spk-in2-mic
+ucm_DATA = bytcht-es8316-mono-spk-in2-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcht-es8316-mono-spk-in2-mic/bytcht-es8316-mono-spk-in2-mic.conf b/src/conf/ucm/bytcht-es8316-mono-spk-in2-mic/bytcht-es8316-mono-spk-in2-mic.conf
new file mode 100644
index 00000000..b9885c2d
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316-mono-spk-in2-mic/bytcht-es8316-mono-spk-in2-mic.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "../bytcht-es8316-mono-spk-in2-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytchtes8316"
+]
diff --git a/src/conf/ucm/bytcht-es8316-stereo-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcht-es8316-stereo-spk-in1-mic/HiFi.conf
new file mode 100644
index 00000000..9f1801c9
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316-stereo-spk-in1-mic/HiFi.conf
@@ -0,0 +1,23 @@
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytchtes8316"
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/es8316/EnableSeq.conf>
+	]
+
+	DisableSequence [
+		cdev "hw:bytchtes8316"
+		<platforms/bytcr/PlatformDisableSeq.conf>
+	]
+
+	Value {
+		PlaybackPCM "hw:bytchtes8316"
+		CapturePCM "hw:bytchtes8316"
+	}
+}
+
+<codecs/es8316/Speaker.conf>
+<codecs/es8316/HeadPhones.conf>
+
+<codecs/es8316/IN1-InternalMic.conf>
+<codecs/es8316/IN2-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcht-es8316-stereo-spk-in1-mic/Makefile.am b/src/conf/ucm/bytcht-es8316-stereo-spk-in1-mic/Makefile.am
new file mode 100644
index 00000000..d3fbb9e9
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316-stereo-spk-in1-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcht-es8316-stereo-spk-in1-mic
+ucm_DATA = bytcht-es8316-stereo-spk-in1-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcht-es8316-stereo-spk-in1-mic/bytcht-es8316-stereo-spk-in1-mic.conf b/src/conf/ucm/bytcht-es8316-stereo-spk-in1-mic/bytcht-es8316-stereo-spk-in1-mic.conf
new file mode 100644
index 00000000..9bd32664
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316-stereo-spk-in1-mic/bytcht-es8316-stereo-spk-in1-mic.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "../bytcht-es8316-stereo-spk-in1-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytchtes8316"
+]
diff --git a/src/conf/ucm/bytcht-es8316-stereo-spk-in2-mic/HiFi.conf b/src/conf/ucm/bytcht-es8316-stereo-spk-in2-mic/HiFi.conf
new file mode 100644
index 00000000..00d4b7fe
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316-stereo-spk-in2-mic/HiFi.conf
@@ -0,0 +1,23 @@
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytchtes8316"
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/es8316/EnableSeq.conf>
+	]
+
+	DisableSequence [
+		cdev "hw:bytchtes8316"
+		<platforms/bytcr/PlatformDisableSeq.conf>
+	]
+
+	Value {
+		PlaybackPCM "hw:bytchtes8316"
+		CapturePCM "hw:bytchtes8316"
+	}
+}
+
+<codecs/es8316/Speaker.conf>
+<codecs/es8316/HeadPhones.conf>
+
+<codecs/es8316/IN1-HeadsetMic.conf>
+<codecs/es8316/IN2-InternalMic.conf>
diff --git a/src/conf/ucm/bytcht-es8316-stereo-spk-in2-mic/Makefile.am b/src/conf/ucm/bytcht-es8316-stereo-spk-in2-mic/Makefile.am
new file mode 100644
index 00000000..f92fab48
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316-stereo-spk-in2-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcht-es8316-stereo-spk-in2-mic
+ucm_DATA = bytcht-es8316-stereo-spk-in2-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcht-es8316-stereo-spk-in2-mic/bytcht-es8316-stereo-spk-in2-mic.conf b/src/conf/ucm/bytcht-es8316-stereo-spk-in2-mic/bytcht-es8316-stereo-spk-in2-mic.conf
new file mode 100644
index 00000000..a94f0f70
--- /dev/null
+++ b/src/conf/ucm/bytcht-es8316-stereo-spk-in2-mic/bytcht-es8316-stereo-spk-in2-mic.conf
@@ -0,0 +1,8 @@
+SectionUseCase."HiFi" {
+	File "../bytcht-es8316-stereo-spk-in2-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytchtes8316"
+]
-- 
2.20.1
