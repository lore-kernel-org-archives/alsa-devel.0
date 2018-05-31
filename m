From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5/5] conf/ucm: chtnau8824: Add Cube iWork8 Air
	and Pipo W2S specific profiles
Date: Thu, 31 May 2018 17:10:26 +0200
Message-ID: <20180531151026.29521-6-hdegoede@redhat.com>
References: <20180531151026.29521-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 27CD8267910
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 17:10:34 +0200 (CEST)
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

The Cube iWork8 Air and Pipo W2S tablets both only have a single speaker.
Add long-name profiles for them which are identical to the default
chtnau8824 profile, except that they include the nau8824/MonoSpeaker.conf
snippet instead of the nau8824/Speaker.conf one.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                                  |  2 ++
 src/conf/ucm/Makefile.am                      |  2 ++
 .../HiFi.conf                                 | 28 +++++++++++++++++++
 .../Makefile.am                               |  4 +++
 .../PIPO-W2S-Defaultstring-CherryTrailCR.conf |  6 ++++
 .../HiFi.conf                                 | 28 +++++++++++++++++++
 .../Makefile.am                               |  4 +++
 ...ube-i1_TF-Defaultstring-CherryTrailCR.conf |  6 ++++
 8 files changed, 80 insertions(+)
 create mode 100644 src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf
 create mode 100644 src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/Makefile.am
 create mode 100644 src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/PIPO-W2S-Defaultstring-CherryTrailCR.conf
 create mode 100644 src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf
 create mode 100644 src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/Makefile.am
 create mode 100644 src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/cube-i1_TF-Defaultstring-CherryTrailCR.conf

diff --git a/configure.ac b/configure.ac
index ce21c7fb..adc654e2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -732,6 +732,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/chtnau8824/Makefile \
 	  src/conf/ucm/chtrt5645/Makefile \
 	  src/conf/ucm/chtrt5645-mono-speaker-analog-mic/Makefile \
+	  src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/Makefile \
 	  src/conf/ucm/DAISY-I2S/Makefile \
 	  src/conf/ucm/DB410c/Makefile \
 	  src/conf/ucm/Dell-WD15-Dock/Makefile \
@@ -744,6 +745,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/PandaBoard/Makefile \
 	  src/conf/ucm/PandaBoardES/Makefile \
 	  src/conf/ucm/PAZ00/Makefile \
+	  src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/Makefile \
 	  src/conf/ucm/rt5640/Makefile \
 	  src/conf/ucm/SDP4430/Makefile \
 	  src/conf/ucm/skylake-rt286/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index c350c526..1e51f73e 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -14,6 +14,7 @@ bytcr-rt5651 \
 chtnau8824 \
 chtrt5645 \
 chtrt5645-mono-speaker-analog-mic \
+cube-i1_TF-Defaultstring-CherryTrailCR \
 DAISY-I2S \
 DB410c \
 Dell-WD15-Dock \
@@ -26,6 +27,7 @@ nau8824 \
 PandaBoard \
 PandaBoardES \
 PAZ00 \
+PIPO-W2S-Defaultstring-CherryTrailCR \
 rt5640 \
 SDP4430 \
 skylake-rt286 \
diff --git a/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf b/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf
new file mode 100644
index 00000000..799163db
--- /dev/null
+++ b/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf
@@ -0,0 +1,28 @@
+<searchdir:ucm>
+
+SectionVerb {
+
+	Value {
+		TQ "HiFi"
+		# ALSA PCM device for HiFi
+		PlaybackPCM "hw:chtnau8824"
+		CapturePCM "hw:chtnau8824"
+	}
+
+	EnableSequence [
+		cdev "hw:chtnau8824"
+		<bytcr/PlatformEnableSeq.conf>
+		<nau8824/EnableSeq.conf>
+	]
+
+	DisableSequence [
+		cdev "hw:chtnau8824"
+		<bytcr/PlatformDisableSeq.conf>
+	]
+}
+
+<nau8824/MonoSpeaker.conf>
+<nau8824/HeadPhones.conf>
+
+<nau8824/InternalMic.conf>
+<nau8824/HeadsetMic.conf>
diff --git a/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/Makefile.am b/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/Makefile.am
new file mode 100644
index 00000000..5fc0f210
--- /dev/null
+++ b/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/PIPO-W2S-Defaultstring-CherryTrailCR
+ucm_DATA = PIPO-W2S-Defaultstring-CherryTrailCR.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/PIPO-W2S-Defaultstring-CherryTrailCR.conf b/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/PIPO-W2S-Defaultstring-CherryTrailCR.conf
new file mode 100644
index 00000000..37a8d04e
--- /dev/null
+++ b/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/PIPO-W2S-Defaultstring-CherryTrailCR.conf
@@ -0,0 +1,6 @@
+Comment "chtnau8824 internal card"
+
+SectionUseCase."HiFi" {
+	File "../PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf"
+	Comment "Default"
+}
diff --git a/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf b/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf
new file mode 100644
index 00000000..799163db
--- /dev/null
+++ b/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf
@@ -0,0 +1,28 @@
+<searchdir:ucm>
+
+SectionVerb {
+
+	Value {
+		TQ "HiFi"
+		# ALSA PCM device for HiFi
+		PlaybackPCM "hw:chtnau8824"
+		CapturePCM "hw:chtnau8824"
+	}
+
+	EnableSequence [
+		cdev "hw:chtnau8824"
+		<bytcr/PlatformEnableSeq.conf>
+		<nau8824/EnableSeq.conf>
+	]
+
+	DisableSequence [
+		cdev "hw:chtnau8824"
+		<bytcr/PlatformDisableSeq.conf>
+	]
+}
+
+<nau8824/MonoSpeaker.conf>
+<nau8824/HeadPhones.conf>
+
+<nau8824/InternalMic.conf>
+<nau8824/HeadsetMic.conf>
diff --git a/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/Makefile.am b/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/Makefile.am
new file mode 100644
index 00000000..92df54fd
--- /dev/null
+++ b/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/cube-i1_TF-Defaultstring-CherryTrailCR
+ucm_DATA = cube-i1_TF-Defaultstring-CherryTrailCR.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/cube-i1_TF-Defaultstring-CherryTrailCR.conf b/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/cube-i1_TF-Defaultstring-CherryTrailCR.conf
new file mode 100644
index 00000000..3775ed4c
--- /dev/null
+++ b/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/cube-i1_TF-Defaultstring-CherryTrailCR.conf
@@ -0,0 +1,6 @@
+Comment "chtnau8824 internal card"
+
+SectionUseCase."HiFi" {
+	File "../cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf"
+	Comment "Default"
+}
-- 
2.17.0
