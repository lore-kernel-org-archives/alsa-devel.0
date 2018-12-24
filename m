From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/4] conf/ucm: bytcr-rt5651: Add
	bytcr-rt5651-stereo-spk-dmic-mic config
Date: Mon, 24 Dec 2018 16:05:04 +0100
Message-ID: <20181224150504.20845-4-hdegoede@redhat.com>
References: <20181224150504.20845-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 6273C267ABE
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2018 16:05:11 +0100 (CET)
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

Add a config for boards which use a digital mic as internal mic,
combined with having the headset mic on in2.

An example of such a board is the Point of View TAB-P1006W-232 (v1.0) tablet.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                                  |  1 +
 src/conf/ucm/Makefile.am                      |  1 +
 .../HiFi.conf                                 | 26 +++++++++++++++++++
 .../Makefile.am                               |  4 +++
 .../bytcr-rt5651-stereo-spk-dmic-mic.conf     | 10 +++++++
 5 files changed, 42 insertions(+)
 create mode 100644 src/conf/ucm/bytcr-rt5651-stereo-spk-dmic-mic/HiFi.conf
 create mode 100644 src/conf/ucm/bytcr-rt5651-stereo-spk-dmic-mic/Makefile.am
 create mode 100644 src/conf/ucm/bytcr-rt5651-stereo-spk-dmic-mic/bytcr-rt5651-stereo-spk-dmic-mic.conf

diff --git a/configure.ac b/configure.ac
index d0cab2d6..5d7a5b3c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -731,6 +731,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/Makefile \
+	  src/conf/ucm/bytcr-rt5651-stereo-spk-dmic-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 85c15090..00f88425 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -15,6 +15,7 @@ bytcr-rt5651 \
 bytcr-rt5651-mono-spk-in1-mic \
 bytcr-rt5651-mono-spk-in2-mic \
 bytcr-rt5651-mono-spk-in2-mic-hp-swapped \
+bytcr-rt5651-stereo-spk-dmic-mic \
 bytcr-rt5651-stereo-spk-in1-mic \
 bytcr-rt5651-stereo-spk-in2-mic \
 bytcr-rt5651-stereo-spk-in12-mic \
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-dmic-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-dmic-mic/HiFi.conf
new file mode 100644
index 00000000..abf5fc75
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-dmic-mic/HiFi.conf
@@ -0,0 +1,26 @@
+# Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
+
+
+SectionVerb {
+	EnableSequence [
+		cdev "hw:bytcrrt5651"
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5651/EnableSeq.conf>
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5651"
+		<platforms/bytcr/PlatformDisableSeq.conf>
+	]
+
+	Value {
+		PlaybackPCM "hw:bytcrrt5651"
+		CapturePCM "hw:bytcrrt5651"
+	}
+}
+
+<codecs/rt5651/Speaker.conf>
+<codecs/rt5651/HeadPhones.conf>
+
+<codecs/rt5651/DigitalMic.conf>
+<codecs/rt5651/IN2-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-dmic-mic/Makefile.am b/src/conf/ucm/bytcr-rt5651-stereo-spk-dmic-mic/Makefile.am
new file mode 100644
index 00000000..07054501
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-dmic-mic/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/bytcr-rt5651-stereo-spk-dmic-mic
+ucm_DATA = bytcr-rt5651-stereo-spk-dmic-mic.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-dmic-mic/bytcr-rt5651-stereo-spk-dmic-mic.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-dmic-mic/bytcr-rt5651-stereo-spk-dmic-mic.conf
new file mode 100644
index 00000000..de8d954a
--- /dev/null
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-dmic-mic/bytcr-rt5651-stereo-spk-dmic-mic.conf
@@ -0,0 +1,10 @@
+# Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
+
+SectionUseCase."HiFi" {
+	File "../bytcr-rt5651-stereo-spk-dmic-mic/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
+
+SectionDefaults [
+	cdev "hw:bytcrrt5651"
+]
-- 
2.20.1
