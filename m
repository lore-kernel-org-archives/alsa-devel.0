From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2] conf: Move UCM profile snippets into
	components subdirectory
Date: Wed, 28 Nov 2018 10:56:54 +0100
Message-ID: <20181128095654.22915-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BBB51267AF4
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 10:56:58 +0100 (CET)
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
Cc: Hans de Goede <hdegoede@redhat.com>, youling 257 <youling257@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

We have placed UCM profile snippets to be included by the main config
files also in the same directory, src/conf/ucm, it confuses alsaucm
program that scans over all subdirectories.  It thinks such a file is
also the main config file, and spews errors like:
  % alsaucm
  ALSA lib utils.c:67:(uc_mgr_config_load) could not open configuration file /usr/share/alsa/ucm/bytcr/bytcr.conf
  ALSA lib parser.c:1427:(load_master_config) error: could not parse configuration for card bytcr
  alsaucm: unable to obtain card list: No such file or directory

Actually we already defined the subdirectory for such components, and
they are skipped at parsing the main configs.  So we just need to move
the files there -- this is what's done here.

One more thing done here is to add a new component subdirectory,
platforms, for definitions bytcr/* that don't match with neither the
existing ones (codecs nor dsps).

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 configure.ac                                  | 10 ++++++----
 src/conf/ucm/Makefile.am                      |  6 ++----
 .../HiFi.conf                                 | 14 ++++++-------
 .../bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf | 14 ++++++-------
 .../bytcr-rt5640-mono-spk-in1-mic/HiFi.conf   | 14 ++++++-------
 .../bytcr-rt5640-mono-spk-in3-mic/HiFi.conf   | 14 ++++++-------
 .../HiFi.conf                                 | 14 ++++++-------
 .../bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf | 14 ++++++-------
 .../bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf | 14 ++++++-------
 src/conf/ucm/bytcr-rt5640/HiFi.conf           | 20 +++++++++----------
 .../bytcr-rt5651-mono-spk-in1-mic/HiFi.conf   | 14 ++++++-------
 .../HiFi.conf                                 | 14 ++++++-------
 .../bytcr-rt5651-mono-spk-in2-mic/HiFi.conf   | 14 ++++++-------
 .../bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf | 14 ++++++-------
 .../HiFi.conf                                 | 14 ++++++-------
 .../bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf | 14 ++++++-------
 src/conf/ucm/bytcr-rt5651/HiFi.conf           | 20 +++++++++----------
 src/conf/ucm/chtnau8824/HiFi.conf             | 14 ++++++-------
 src/conf/ucm/chtrt5645/HiFi.conf              |  2 +-
 src/conf/ucm/codecs/Makefile.am               |  4 ++++
 .../ucm/{ => codecs}/nau8824/EnableSeq.conf   |  0
 .../ucm/{ => codecs}/nau8824/HeadPhones.conf  |  0
 .../ucm/{ => codecs}/nau8824/HeadsetMic.conf  |  0
 .../ucm/{ => codecs}/nau8824/InternalMic.conf |  0
 src/conf/ucm/{ => codecs}/nau8824/Makefile.am |  2 +-
 .../ucm/{ => codecs}/nau8824/MonoSpeaker.conf |  0
 .../ucm/{ => codecs}/nau8824/Speaker.conf     |  0
 .../ucm/{ => codecs}/rt5640/DigitalMics.conf  |  0
 .../ucm/{ => codecs}/rt5640/EnableSeq.conf    |  0
 .../ucm/{ => codecs}/rt5640/HeadPhones.conf   |  0
 .../ucm/{ => codecs}/rt5640/HeadsetMic.conf   |  0
 .../{ => codecs}/rt5640/IN1-InternalMic.conf  |  0
 .../{ => codecs}/rt5640/IN3-InternalMic.conf  |  0
 src/conf/ucm/{ => codecs}/rt5640/Makefile.am  |  2 +-
 .../ucm/{ => codecs}/rt5640/MonoSpeaker.conf  |  0
 src/conf/ucm/{ => codecs}/rt5640/Speaker.conf |  0
 .../ucm/{ => codecs}/rt5651/EnableSeq.conf    |  0
 .../rt5651/HeadPhones-swapped.conf            |  0
 .../ucm/{ => codecs}/rt5651/HeadPhones.conf   |  0
 .../{ => codecs}/rt5651/IN1-InternalMic.conf  |  0
 .../{ => codecs}/rt5651/IN12-InternalMic.conf |  0
 .../{ => codecs}/rt5651/IN2-InternalMic.conf  |  0
 .../{ => codecs}/rt5651/IN3-HeadsetMic.conf   |  0
 src/conf/ucm/{ => codecs}/rt5651/Makefile.am  |  2 +-
 .../ucm/{ => codecs}/rt5651/MonoSpeaker.conf  |  0
 src/conf/ucm/{ => codecs}/rt5651/Speaker.conf |  0
 .../HiFi.conf                                 | 14 ++++++-------
 src/conf/ucm/platforms/Makefile.am            |  2 ++
 .../ucm/{ => platforms}/bytcr/Makefile.am     |  2 +-
 .../bytcr/PlatformDisableSeq.conf             |  0
 .../bytcr/PlatformEnableSeq.conf              |  0
 src/ucm/parser.c                              |  1 +
 52 files changed, 145 insertions(+), 138 deletions(-)
 create mode 100644 src/conf/ucm/codecs/Makefile.am
 rename src/conf/ucm/{ => codecs}/nau8824/EnableSeq.conf (100%)
 rename src/conf/ucm/{ => codecs}/nau8824/HeadPhones.conf (100%)
 rename src/conf/ucm/{ => codecs}/nau8824/HeadsetMic.conf (100%)
 rename src/conf/ucm/{ => codecs}/nau8824/InternalMic.conf (100%)
 rename src/conf/ucm/{ => codecs}/nau8824/Makefile.am (79%)
 rename src/conf/ucm/{ => codecs}/nau8824/MonoSpeaker.conf (100%)
 rename src/conf/ucm/{ => codecs}/nau8824/Speaker.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5640/DigitalMics.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5640/EnableSeq.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5640/HeadPhones.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5640/HeadsetMic.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5640/IN1-InternalMic.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5640/IN3-InternalMic.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5640/Makefile.am (82%)
 rename src/conf/ucm/{ => codecs}/rt5640/MonoSpeaker.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5640/Speaker.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5651/EnableSeq.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5651/HeadPhones-swapped.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5651/HeadPhones.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5651/IN1-InternalMic.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5651/IN12-InternalMic.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5651/IN2-InternalMic.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5651/IN3-HeadsetMic.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5651/Makefile.am (85%)
 rename src/conf/ucm/{ => codecs}/rt5651/MonoSpeaker.conf (100%)
 rename src/conf/ucm/{ => codecs}/rt5651/Speaker.conf (100%)
 create mode 100644 src/conf/ucm/platforms/Makefile.am
 rename src/conf/ucm/{ => platforms}/bytcr/Makefile.am (71%)
 rename src/conf/ucm/{ => platforms}/bytcr/PlatformDisableSeq.conf (100%)
 rename src/conf/ucm/{ => platforms}/bytcr/PlatformEnableSeq.conf (100%)

diff --git a/configure.ac b/configure.ac
index 4c9d860fd0e5..d0cab2d6cf78 100644
--- a/configure.ac
+++ b/configure.ac
@@ -720,7 +720,6 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/Makefile \
 	  src/conf/ucm/broadwell-rt286/Makefile \
 	  src/conf/ucm/broxton-rt298/Makefile \
-	  src/conf/ucm/bytcr/Makefile \
 	  src/conf/ucm/bytcr-rt5640/Makefile \
 	  src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/Makefile \
 	  src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/Makefile \
@@ -747,18 +746,21 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile \
 	  src/conf/ucm/HDAudio-Lenovo-DualCodecs/Makefile \
 	  src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/Makefile \
-	  src/conf/ucm/nau8824/Makefile \
 	  src/conf/ucm/PandaBoard/Makefile \
 	  src/conf/ucm/PandaBoardES/Makefile \
 	  src/conf/ucm/PAZ00/Makefile \
 	  src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/Makefile \
-	  src/conf/ucm/rt5640/Makefile \
-	  src/conf/ucm/rt5651/Makefile \
 	  src/conf/ucm/SDP4430/Makefile \
 	  src/conf/ucm/skylake-rt286/Makefile \
 	  src/conf/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR/Makefile \
 	  src/conf/ucm/tegraalc5632/Makefile \
 	  src/conf/ucm/VEYRON-I2S/Makefile \
+	  src/conf/ucm/codecs/Makefile \
+	  src/conf/ucm/codecs/nau8824/Makefile \
+	  src/conf/ucm/codecs/rt5640/Makefile \
+	  src/conf/ucm/codecs/rt5651/Makefile \
+	  src/conf/ucm/platforms/Makefile \
+	  src/conf/ucm/platforms/bytcr/Makefile \
 	  src/conf/topology/Makefile \
 	  src/conf/topology/broadwell/Makefile \
 	  modules/Makefile modules/mixer/Makefile modules/mixer/simple/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 7cdc6176584a..85c15090951d 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -1,8 +1,9 @@
 SUBDIRS=\
+codecs \
+platforms \
 ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN \
 broadwell-rt286 \
 broxton-rt298 \
-bytcr \
 bytcr-rt5640 \
 bytcr-rt5640-mono-spk-dmic1-mic \
 bytcr-rt5640-mono-spk-in1-mic \
@@ -29,13 +30,10 @@ gpd-win-pocket-rt5645 \
 HDAudio-Gigabyte-ALC1220DualCodecs \
 HDAudio-Lenovo-DualCodecs \
 LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216 \
-nau8824 \
 PandaBoard \
 PandaBoardES \
 PAZ00 \
 PIPO-W2S-Defaultstring-CherryTrailCR \
-rt5640 \
-rt5651 \
 SDP4430 \
 skylake-rt286 \
 TECLAST-X80Pro-Defaultstring-CherryTrailCR \
diff --git a/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf b/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf
index 799163dbe481..facc73ac3b2b 100644
--- a/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf
+++ b/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf
@@ -11,18 +11,18 @@ SectionVerb {
 
 	EnableSequence [
 		cdev "hw:chtnau8824"
-		<bytcr/PlatformEnableSeq.conf>
-		<nau8824/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/nau8824/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:chtnau8824"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 }
 
-<nau8824/MonoSpeaker.conf>
-<nau8824/HeadPhones.conf>
+<codecs/nau8824/MonoSpeaker.conf>
+<codecs/nau8824/HeadPhones.conf>
 
-<nau8824/InternalMic.conf>
-<nau8824/HeadsetMic.conf>
+<codecs/nau8824/InternalMic.conf>
+<codecs/nau8824/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
index 938b359290d4..c78cdfb80a44 100644
--- a/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
@@ -6,13 +6,13 @@ SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5640"
 
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5640/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5640/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5640"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -21,8 +21,8 @@ SectionVerb {
 	}
 }
 
-<rt5640/MonoSpeaker.conf>
-<rt5640/HeadPhones.conf>
+<codecs/rt5640/MonoSpeaker.conf>
+<codecs/rt5640/HeadPhones.conf>
 
-<rt5640/DigitalMics.conf>
-<rt5640/HeadsetMic.conf>
+<codecs/rt5640/DigitalMics.conf>
+<codecs/rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
index f36b245e5092..34a5d53d363c 100644
--- a/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
@@ -6,13 +6,13 @@ SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5640"
 
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5640/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5640/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5640"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -21,8 +21,8 @@ SectionVerb {
 	}
 }
 
-<rt5640/MonoSpeaker.conf>
-<rt5640/HeadPhones.conf>
+<codecs/rt5640/MonoSpeaker.conf>
+<codecs/rt5640/HeadPhones.conf>
 
-<rt5640/IN1-InternalMic.conf>
-<rt5640/HeadsetMic.conf>
+<codecs/rt5640/IN1-InternalMic.conf>
+<codecs/rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
index 1a08ededc40c..0aa0c0266412 100644
--- a/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
@@ -6,13 +6,13 @@ SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5640"
 
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5640/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5640/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5640"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -21,8 +21,8 @@ SectionVerb {
 	}
 }
 
-<rt5640/MonoSpeaker.conf>
-<rt5640/HeadPhones.conf>
+<codecs/rt5640/MonoSpeaker.conf>
+<codecs/rt5640/HeadPhones.conf>
 
-<rt5640/IN3-InternalMic.conf>
-<rt5640/HeadsetMic.conf>
+<codecs/rt5640/IN3-InternalMic.conf>
+<codecs/rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
index 4587b2e1294e..e358d4f23f12 100644
--- a/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
@@ -6,13 +6,13 @@ SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5640"
 
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5640/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5640/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5640"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -21,8 +21,8 @@ SectionVerb {
 	}
 }
 
-<rt5640/Speaker.conf>
-<rt5640/HeadPhones.conf>
+<codecs/rt5640/Speaker.conf>
+<codecs/rt5640/HeadPhones.conf>
 
-<rt5640/DigitalMics.conf>
-<rt5640/HeadsetMic.conf>
+<codecs/rt5640/DigitalMics.conf>
+<codecs/rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
index decd396047aa..097560d02d12 100644
--- a/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
@@ -6,13 +6,13 @@ SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5640"
 
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5640/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5640/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5640"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -21,8 +21,8 @@ SectionVerb {
 	}
 }
 
-<rt5640/Speaker.conf>
-<rt5640/HeadPhones.conf>
+<codecs/rt5640/Speaker.conf>
+<codecs/rt5640/HeadPhones.conf>
 
-<rt5640/IN1-InternalMic.conf>
-<rt5640/HeadsetMic.conf>
+<codecs/rt5640/IN1-InternalMic.conf>
+<codecs/rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
index d243bf823511..8a018f63c9c6 100644
--- a/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
@@ -6,13 +6,13 @@ SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5640"
 
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5640/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5640/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5640"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -21,8 +21,8 @@ SectionVerb {
 	}
 }
 
-<rt5640/Speaker.conf>
-<rt5640/HeadPhones.conf>
+<codecs/rt5640/Speaker.conf>
+<codecs/rt5640/HeadPhones.conf>
 
-<rt5640/IN3-InternalMic.conf>
-<rt5640/HeadsetMic.conf>
+<codecs/rt5640/IN3-InternalMic.conf>
+<codecs/rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5640/HiFi.conf b/src/conf/ucm/bytcr-rt5640/HiFi.conf
index c833fe74845b..20ebe2dd36e2 100644
--- a/src/conf/ucm/bytcr-rt5640/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5640/HiFi.conf
@@ -6,13 +6,13 @@ SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5640"
 
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5640/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5640/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5640"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -21,11 +21,11 @@ SectionVerb {
 	}
 }
 
-<rt5640/Speaker.conf>
-<rt5640/MonoSpeaker.conf>
-<rt5640/HeadPhones.conf>
+<codecs/rt5640/Speaker.conf>
+<codecs/rt5640/MonoSpeaker.conf>
+<codecs/rt5640/HeadPhones.conf>
 
-<rt5640/DigitalMics.conf>
-<rt5640/IN1-InternalMic.conf>
-<rt5640/IN3-InternalMic.conf>
-<rt5640/HeadsetMic.conf>
+<codecs/rt5640/DigitalMics.conf>
+<codecs/rt5640/IN1-InternalMic.conf>
+<codecs/rt5640/IN3-InternalMic.conf>
+<codecs/rt5640/HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf
index dd5b35fc02cb..ca8a7d9078fb 100644
--- a/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf
@@ -5,13 +5,13 @@
 SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5651/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5651/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -20,8 +20,8 @@ SectionVerb {
 	}
 }
 
-<rt5651/MonoSpeaker.conf>
-<rt5651/HeadPhones.conf>
+<codecs/rt5651/MonoSpeaker.conf>
+<codecs/rt5651/HeadPhones.conf>
 
-<rt5651/IN1-InternalMic.conf>
-<rt5651/IN3-HeadsetMic.conf>
+<codecs/rt5651/IN1-InternalMic.conf>
+<codecs/rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf
index 777ed7836ee5..60ef6b332ea2 100644
--- a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf
@@ -5,13 +5,13 @@
 SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5651/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5651/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -20,8 +20,8 @@ SectionVerb {
 	}
 }
 
-<rt5651/MonoSpeaker.conf>
-<rt5651/HeadPhones-swapped.conf>
+<codecs/rt5651/MonoSpeaker.conf>
+<codecs/rt5651/HeadPhones-swapped.conf>
 
-<rt5651/IN2-InternalMic.conf>
-<rt5651/IN3-HeadsetMic.conf>
+<codecs/rt5651/IN2-InternalMic.conf>
+<codecs/rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf
index 9f56c077b65a..e75210d4aa7e 100644
--- a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf
@@ -5,13 +5,13 @@
 SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5651/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5651/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -20,8 +20,8 @@ SectionVerb {
 	}
 }
 
-<rt5651/MonoSpeaker.conf>
-<rt5651/HeadPhones.conf>
+<codecs/rt5651/MonoSpeaker.conf>
+<codecs/rt5651/HeadPhones.conf>
 
-<rt5651/IN2-InternalMic.conf>
-<rt5651/IN3-HeadsetMic.conf>
+<codecs/rt5651/IN2-InternalMic.conf>
+<codecs/rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf
index e2a579ab2261..2b7675bce831 100644
--- a/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf
@@ -5,13 +5,13 @@
 SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5651/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5651/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -20,8 +20,8 @@ SectionVerb {
 	}
 }
 
-<rt5651/Speaker.conf>
-<rt5651/HeadPhones.conf>
+<codecs/rt5651/Speaker.conf>
+<codecs/rt5651/HeadPhones.conf>
 
-<rt5651/IN1-InternalMic.conf>
-<rt5651/IN3-HeadsetMic.conf>
+<codecs/rt5651/IN1-InternalMic.conf>
+<codecs/rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf
index ae52e7196110..7a8c94bc5d6b 100644
--- a/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf
@@ -5,13 +5,13 @@
 SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5651/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5651/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -20,8 +20,8 @@ SectionVerb {
 	}
 }
 
-<rt5651/Speaker.conf>
-<rt5651/HeadPhones.conf>
+<codecs/rt5651/Speaker.conf>
+<codecs/rt5651/HeadPhones.conf>
 
-<rt5651/IN12-InternalMic.conf>
-<rt5651/IN3-HeadsetMic.conf>
+<codecs/rt5651/IN12-InternalMic.conf>
+<codecs/rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf
index a73ff5f86b8f..45c7837c6fb9 100644
--- a/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf
@@ -5,13 +5,13 @@
 SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5651/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5651/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -20,8 +20,8 @@ SectionVerb {
 	}
 }
 
-<rt5651/Speaker.conf>
-<rt5651/HeadPhones.conf>
+<codecs/rt5651/Speaker.conf>
+<codecs/rt5651/HeadPhones.conf>
 
-<rt5651/IN2-InternalMic.conf>
-<rt5651/IN3-HeadsetMic.conf>
+<codecs/rt5651/IN2-InternalMic.conf>
+<codecs/rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/bytcr-rt5651/HiFi.conf b/src/conf/ucm/bytcr-rt5651/HiFi.conf
index 8733403cf28d..d3928e9b9976 100644
--- a/src/conf/ucm/bytcr-rt5651/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651/HiFi.conf
@@ -5,13 +5,13 @@
 SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformEnableSeq.conf>
-		<rt5651/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5651/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
@@ -20,11 +20,11 @@ SectionVerb {
 	}
 }
 
-<rt5651/Speaker.conf>
-<rt5651/MonoSpeaker.conf>
-<rt5651/HeadPhones.conf>
+<codecs/rt5651/Speaker.conf>
+<codecs/rt5651/MonoSpeaker.conf>
+<codecs/rt5651/HeadPhones.conf>
 
-<rt5651/IN1-InternalMic.conf>
-<rt5651/IN2-InternalMic.conf>
-<rt5651/IN12-InternalMic.conf>
-<rt5651/IN3-HeadsetMic.conf>
+<codecs/rt5651/IN1-InternalMic.conf>
+<codecs/rt5651/IN2-InternalMic.conf>
+<codecs/rt5651/IN12-InternalMic.conf>
+<codecs/rt5651/IN3-HeadsetMic.conf>
diff --git a/src/conf/ucm/chtnau8824/HiFi.conf b/src/conf/ucm/chtnau8824/HiFi.conf
index dc52800e5eaa..97a7ac7ba366 100644
--- a/src/conf/ucm/chtnau8824/HiFi.conf
+++ b/src/conf/ucm/chtnau8824/HiFi.conf
@@ -11,18 +11,18 @@ SectionVerb {
 
 	EnableSequence [
 		cdev "hw:chtnau8824"
-		<bytcr/PlatformEnableSeq.conf>
-		<nau8824/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/nau8824/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:chtnau8824"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 }
 
-<nau8824/Speaker.conf>
-<nau8824/HeadPhones.conf>
+<codecs/nau8824/Speaker.conf>
+<codecs/nau8824/HeadPhones.conf>
 
-<nau8824/InternalMic.conf>
-<nau8824/HeadsetMic.conf>
+<codecs/nau8824/InternalMic.conf>
+<codecs/nau8824/HeadsetMic.conf>
diff --git a/src/conf/ucm/chtrt5645/HiFi.conf b/src/conf/ucm/chtrt5645/HiFi.conf
index d993f6ae9929..9a72dab9343c 100644
--- a/src/conf/ucm/chtrt5645/HiFi.conf
+++ b/src/conf/ucm/chtrt5645/HiFi.conf
@@ -11,7 +11,7 @@ SectionVerb {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		<bytcr/PlatformEnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
 
 		# Output Configuration
 		cset "name='DAC1 L Mux' IF1 DAC"
diff --git a/src/conf/ucm/codecs/Makefile.am b/src/conf/ucm/codecs/Makefile.am
new file mode 100644
index 000000000000..2b374acb09fd
--- /dev/null
+++ b/src/conf/ucm/codecs/Makefile.am
@@ -0,0 +1,4 @@
+SUBDIRS=\
+rt5640 \
+rt5651 \
+nau8824
diff --git a/src/conf/ucm/nau8824/EnableSeq.conf b/src/conf/ucm/codecs/nau8824/EnableSeq.conf
similarity index 100%
rename from src/conf/ucm/nau8824/EnableSeq.conf
rename to src/conf/ucm/codecs/nau8824/EnableSeq.conf
diff --git a/src/conf/ucm/nau8824/HeadPhones.conf b/src/conf/ucm/codecs/nau8824/HeadPhones.conf
similarity index 100%
rename from src/conf/ucm/nau8824/HeadPhones.conf
rename to src/conf/ucm/codecs/nau8824/HeadPhones.conf
diff --git a/src/conf/ucm/nau8824/HeadsetMic.conf b/src/conf/ucm/codecs/nau8824/HeadsetMic.conf
similarity index 100%
rename from src/conf/ucm/nau8824/HeadsetMic.conf
rename to src/conf/ucm/codecs/nau8824/HeadsetMic.conf
diff --git a/src/conf/ucm/nau8824/InternalMic.conf b/src/conf/ucm/codecs/nau8824/InternalMic.conf
similarity index 100%
rename from src/conf/ucm/nau8824/InternalMic.conf
rename to src/conf/ucm/codecs/nau8824/InternalMic.conf
diff --git a/src/conf/ucm/nau8824/Makefile.am b/src/conf/ucm/codecs/nau8824/Makefile.am
similarity index 79%
rename from src/conf/ucm/nau8824/Makefile.am
rename to src/conf/ucm/codecs/nau8824/Makefile.am
index b39b8bb4c934..fd3bafe135b7 100644
--- a/src/conf/ucm/nau8824/Makefile.am
+++ b/src/conf/ucm/codecs/nau8824/Makefile.am
@@ -1,5 +1,5 @@
 alsaconfigdir = @ALSA_CONFIG_DIR@
-ucmdir = $(alsaconfigdir)/ucm/nau8824
+ucmdir = $(alsaconfigdir)/ucm/codecs/nau8824
 ucm_DATA = EnableSeq.conf HeadPhones.conf HeadsetMic.conf InternalMic.conf \
 	   MonoSpeaker.conf Speaker.conf
 EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/nau8824/MonoSpeaker.conf b/src/conf/ucm/codecs/nau8824/MonoSpeaker.conf
similarity index 100%
rename from src/conf/ucm/nau8824/MonoSpeaker.conf
rename to src/conf/ucm/codecs/nau8824/MonoSpeaker.conf
diff --git a/src/conf/ucm/nau8824/Speaker.conf b/src/conf/ucm/codecs/nau8824/Speaker.conf
similarity index 100%
rename from src/conf/ucm/nau8824/Speaker.conf
rename to src/conf/ucm/codecs/nau8824/Speaker.conf
diff --git a/src/conf/ucm/rt5640/DigitalMics.conf b/src/conf/ucm/codecs/rt5640/DigitalMics.conf
similarity index 100%
rename from src/conf/ucm/rt5640/DigitalMics.conf
rename to src/conf/ucm/codecs/rt5640/DigitalMics.conf
diff --git a/src/conf/ucm/rt5640/EnableSeq.conf b/src/conf/ucm/codecs/rt5640/EnableSeq.conf
similarity index 100%
rename from src/conf/ucm/rt5640/EnableSeq.conf
rename to src/conf/ucm/codecs/rt5640/EnableSeq.conf
diff --git a/src/conf/ucm/rt5640/HeadPhones.conf b/src/conf/ucm/codecs/rt5640/HeadPhones.conf
similarity index 100%
rename from src/conf/ucm/rt5640/HeadPhones.conf
rename to src/conf/ucm/codecs/rt5640/HeadPhones.conf
diff --git a/src/conf/ucm/rt5640/HeadsetMic.conf b/src/conf/ucm/codecs/rt5640/HeadsetMic.conf
similarity index 100%
rename from src/conf/ucm/rt5640/HeadsetMic.conf
rename to src/conf/ucm/codecs/rt5640/HeadsetMic.conf
diff --git a/src/conf/ucm/rt5640/IN1-InternalMic.conf b/src/conf/ucm/codecs/rt5640/IN1-InternalMic.conf
similarity index 100%
rename from src/conf/ucm/rt5640/IN1-InternalMic.conf
rename to src/conf/ucm/codecs/rt5640/IN1-InternalMic.conf
diff --git a/src/conf/ucm/rt5640/IN3-InternalMic.conf b/src/conf/ucm/codecs/rt5640/IN3-InternalMic.conf
similarity index 100%
rename from src/conf/ucm/rt5640/IN3-InternalMic.conf
rename to src/conf/ucm/codecs/rt5640/IN3-InternalMic.conf
diff --git a/src/conf/ucm/rt5640/Makefile.am b/src/conf/ucm/codecs/rt5640/Makefile.am
similarity index 82%
rename from src/conf/ucm/rt5640/Makefile.am
rename to src/conf/ucm/codecs/rt5640/Makefile.am
index a6fbdc572529..80fa8cfc758c 100644
--- a/src/conf/ucm/rt5640/Makefile.am
+++ b/src/conf/ucm/codecs/rt5640/Makefile.am
@@ -1,5 +1,5 @@
 alsaconfigdir = @ALSA_CONFIG_DIR@
-ucmdir = $(alsaconfigdir)/ucm/rt5640
+ucmdir = $(alsaconfigdir)/ucm/codecs/rt5640
 ucm_DATA = DigitalMics.conf EnableSeq.conf HeadPhones.conf HeadsetMic.conf \
 	IN1-InternalMic.conf IN3-InternalMic.conf MonoSpeaker.conf Speaker.conf
 EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/rt5640/MonoSpeaker.conf b/src/conf/ucm/codecs/rt5640/MonoSpeaker.conf
similarity index 100%
rename from src/conf/ucm/rt5640/MonoSpeaker.conf
rename to src/conf/ucm/codecs/rt5640/MonoSpeaker.conf
diff --git a/src/conf/ucm/rt5640/Speaker.conf b/src/conf/ucm/codecs/rt5640/Speaker.conf
similarity index 100%
rename from src/conf/ucm/rt5640/Speaker.conf
rename to src/conf/ucm/codecs/rt5640/Speaker.conf
diff --git a/src/conf/ucm/rt5651/EnableSeq.conf b/src/conf/ucm/codecs/rt5651/EnableSeq.conf
similarity index 100%
rename from src/conf/ucm/rt5651/EnableSeq.conf
rename to src/conf/ucm/codecs/rt5651/EnableSeq.conf
diff --git a/src/conf/ucm/rt5651/HeadPhones-swapped.conf b/src/conf/ucm/codecs/rt5651/HeadPhones-swapped.conf
similarity index 100%
rename from src/conf/ucm/rt5651/HeadPhones-swapped.conf
rename to src/conf/ucm/codecs/rt5651/HeadPhones-swapped.conf
diff --git a/src/conf/ucm/rt5651/HeadPhones.conf b/src/conf/ucm/codecs/rt5651/HeadPhones.conf
similarity index 100%
rename from src/conf/ucm/rt5651/HeadPhones.conf
rename to src/conf/ucm/codecs/rt5651/HeadPhones.conf
diff --git a/src/conf/ucm/rt5651/IN1-InternalMic.conf b/src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf
similarity index 100%
rename from src/conf/ucm/rt5651/IN1-InternalMic.conf
rename to src/conf/ucm/codecs/rt5651/IN1-InternalMic.conf
diff --git a/src/conf/ucm/rt5651/IN12-InternalMic.conf b/src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf
similarity index 100%
rename from src/conf/ucm/rt5651/IN12-InternalMic.conf
rename to src/conf/ucm/codecs/rt5651/IN12-InternalMic.conf
diff --git a/src/conf/ucm/rt5651/IN2-InternalMic.conf b/src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf
similarity index 100%
rename from src/conf/ucm/rt5651/IN2-InternalMic.conf
rename to src/conf/ucm/codecs/rt5651/IN2-InternalMic.conf
diff --git a/src/conf/ucm/rt5651/IN3-HeadsetMic.conf b/src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf
similarity index 100%
rename from src/conf/ucm/rt5651/IN3-HeadsetMic.conf
rename to src/conf/ucm/codecs/rt5651/IN3-HeadsetMic.conf
diff --git a/src/conf/ucm/rt5651/Makefile.am b/src/conf/ucm/codecs/rt5651/Makefile.am
similarity index 85%
rename from src/conf/ucm/rt5651/Makefile.am
rename to src/conf/ucm/codecs/rt5651/Makefile.am
index acc8ea491043..a68bd7bb9fcf 100644
--- a/src/conf/ucm/rt5651/Makefile.am
+++ b/src/conf/ucm/codecs/rt5651/Makefile.am
@@ -1,5 +1,5 @@
 alsaconfigdir = @ALSA_CONFIG_DIR@
-ucmdir = $(alsaconfigdir)/ucm/rt5651
+ucmdir = $(alsaconfigdir)/ucm/codecs/rt5651
 ucm_DATA = EnableSeq.conf HeadPhones.conf HeadPhones-swapped.conf \
 	   IN1-InternalMic.conf IN2-InternalMic.conf IN12-InternalMic.conf \
 	   IN3-HeadsetMic.conf Speaker.conf MonoSpeaker.conf
diff --git a/src/conf/ucm/rt5651/MonoSpeaker.conf b/src/conf/ucm/codecs/rt5651/MonoSpeaker.conf
similarity index 100%
rename from src/conf/ucm/rt5651/MonoSpeaker.conf
rename to src/conf/ucm/codecs/rt5651/MonoSpeaker.conf
diff --git a/src/conf/ucm/rt5651/Speaker.conf b/src/conf/ucm/codecs/rt5651/Speaker.conf
similarity index 100%
rename from src/conf/ucm/rt5651/Speaker.conf
rename to src/conf/ucm/codecs/rt5651/Speaker.conf
diff --git a/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf b/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf
index 799163dbe481..facc73ac3b2b 100644
--- a/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf
+++ b/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf
@@ -11,18 +11,18 @@ SectionVerb {
 
 	EnableSequence [
 		cdev "hw:chtnau8824"
-		<bytcr/PlatformEnableSeq.conf>
-		<nau8824/EnableSeq.conf>
+		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/nau8824/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:chtnau8824"
-		<bytcr/PlatformDisableSeq.conf>
+		<platforms/bytcr/PlatformDisableSeq.conf>
 	]
 }
 
-<nau8824/MonoSpeaker.conf>
-<nau8824/HeadPhones.conf>
+<codecs/nau8824/MonoSpeaker.conf>
+<codecs/nau8824/HeadPhones.conf>
 
-<nau8824/InternalMic.conf>
-<nau8824/HeadsetMic.conf>
+<codecs/nau8824/InternalMic.conf>
+<codecs/nau8824/HeadsetMic.conf>
diff --git a/src/conf/ucm/platforms/Makefile.am b/src/conf/ucm/platforms/Makefile.am
new file mode 100644
index 000000000000..1bf252f0e0e3
--- /dev/null
+++ b/src/conf/ucm/platforms/Makefile.am
@@ -0,0 +1,2 @@
+SUBDIRS=\
+bytcr
diff --git a/src/conf/ucm/bytcr/Makefile.am b/src/conf/ucm/platforms/bytcr/Makefile.am
similarity index 71%
rename from src/conf/ucm/bytcr/Makefile.am
rename to src/conf/ucm/platforms/bytcr/Makefile.am
index f7a54cbdedcd..c53b21438ad2 100644
--- a/src/conf/ucm/bytcr/Makefile.am
+++ b/src/conf/ucm/platforms/bytcr/Makefile.am
@@ -1,4 +1,4 @@
 alsaconfigdir = @ALSA_CONFIG_DIR@
-ucmdir = $(alsaconfigdir)/ucm/bytcr
+ucmdir = $(alsaconfigdir)/ucm/platforms/bytcr
 ucm_DATA = PlatformEnableSeq.conf PlatformDisableSeq.conf
 EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/bytcr/PlatformDisableSeq.conf b/src/conf/ucm/platforms/bytcr/PlatformDisableSeq.conf
similarity index 100%
rename from src/conf/ucm/bytcr/PlatformDisableSeq.conf
rename to src/conf/ucm/platforms/bytcr/PlatformDisableSeq.conf
diff --git a/src/conf/ucm/bytcr/PlatformEnableSeq.conf b/src/conf/ucm/platforms/bytcr/PlatformEnableSeq.conf
similarity index 100%
rename from src/conf/ucm/bytcr/PlatformEnableSeq.conf
rename to src/conf/ucm/platforms/bytcr/PlatformEnableSeq.conf
diff --git a/src/ucm/parser.c b/src/ucm/parser.c
index 219edb9691a6..2b6f1159aa7d 100644
--- a/src/ucm/parser.c
+++ b/src/ucm/parser.c
@@ -53,6 +53,7 @@
 static const char * const component_dir[] = {
 	"codecs",	/* for off-soc codecs */
 	"dsps",		/* for DSPs embedded in SoC */
+	"platforms",	/* for common platform implementations */
 	NULL,		/* terminator */
 };
 
-- 
2.19.1
