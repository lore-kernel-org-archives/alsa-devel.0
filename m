From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] conf/ucm: cht-bsw-rt5672: Add board
	specific profile for Lenovo Thinkpad 8 tablet
Date: Sat, 31 Aug 2019 16:58:42 +0200
Message-ID: <20190831145842.32990-2-hdegoede@redhat.com>
References: <20190831145842.32990-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48C64F800EA
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2019 16:58:48 +0200 (CEST)
In-Reply-To: <20190831145842.32990-1-hdegoede@redhat.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The Lenovo Thinkpad 8 tablet has stereo speakers and its internal DMIC
on DMIC1, at a device specific profile for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                                  |  1 +
 .../HiFi.conf                                 | 23 +++++++++++++++++++
 ...ENOVO-20BN002QGE-ThinkPad8-20BN002QGE.conf |  4 ++++
 .../Makefile.am                               |  4 ++++
 src/conf/ucm/Makefile.am                      |  1 +
 5 files changed, 33 insertions(+)
 create mode 100644 src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/HiFi.conf
 create mode 100644 src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE.conf
 create mode 100644 src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/Makefile.am

diff --git a/configure.ac b/configure.ac
index 9ccca7aa..778bc64e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -756,6 +756,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile \
 	  src/conf/ucm/HDAudio-Lenovo-DualCodecs/Makefile \
 	  src/conf/ucm/kblrt5660/Makefile \
+	  src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/Makefile \
 	  src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/Makefile \
 	  src/conf/ucm/PandaBoard/Makefile \
 	  src/conf/ucm/PandaBoardES/Makefile \
diff --git a/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/HiFi.conf b/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/HiFi.conf
new file mode 100644
index 00000000..43c3c0dd
--- /dev/null
+++ b/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/HiFi.conf
@@ -0,0 +1,23 @@
+SectionVerb {
+	EnableSequence [
+		cdev "hw:chtbswrt5672"
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5672/EnableSeq.conf>
+	]
+
+	DisableSequence [
+		cdev "hw:chtbswrt5672"
+		<platforms/bytcr/PlatformDisableSeq.conf>
+	]
+
+	Value {
+		PlaybackPCM "hw:chtbswrt5672"
+		CapturePCM "hw:chtbswrt5672"
+	}
+}
+
+<codecs/rt5672/Speaker.conf>
+<codecs/rt5672/HeadPhones.conf>
+
+<codecs/rt5672/DMIC2.conf>
+<codecs/rt5672/HeadsetMic.conf>
diff --git a/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE.conf b/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE.conf
new file mode 100644
index 00000000..1c3a766b
--- /dev/null
+++ b/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE.conf
@@ -0,0 +1,4 @@
+SectionUseCase."HiFi" {
+	File "../LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/HiFi.conf"
+	Comment "Play HiFi quality Music"
+}
diff --git a/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/Makefile.am b/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/Makefile.am
new file mode 100644
index 00000000..842409e8
--- /dev/null
+++ b/src/conf/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/LENOVO-20BN002QGE-ThinkPad8-20BN002QGE
+ucm_DATA = LENOVO-20BN002QGE-ThinkPad8-20BN002QGE.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 2ed4e1a3..7bb8eb1d 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -40,6 +40,7 @@ gpd-win-pocket-rt5645 \
 HDAudio-Gigabyte-ALC1220DualCodecs \
 HDAudio-Lenovo-DualCodecs \
 kblrt5660 \
+LENOVO-20BN002QGE-ThinkPad8-20BN002QGE \
 LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216 \
 PandaBoard \
 PandaBoardES \
-- 
2.23.0
