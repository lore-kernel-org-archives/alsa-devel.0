From: zombah <zombah@gmail.com>
Subject: [PATCH/alsa-lib] conf/ucm: PAZ00: add Toshiba
	AC100/Dynabook AZ new config
Date: Tue, 23 Sep 2014 19:53:43 +0400
Message-ID: <1411487623-9380-1-git-send-email-zombah@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C7F1265141
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 17:54:49 +0200 (CEST)
Received: by mail-lb0-f181.google.com with SMTP id b6so3731738lbj.40
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 08:54:49 -0700 (PDT)
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
Cc: zombah <zombah@gmail.com>
List-Id: alsa-devel@alsa-project.org

Recent mainline kernels threat Toshiba AC100 audio hardware as hw:PAZ00
vs old hw:tegraalc5632.

This patch adds config files for new hw name and include them to
makefiles.

Signed-off-by: zombah <zombah@gmail.com>
---
 configure.ac                   |  1 +
 src/conf/ucm/Makefile.am       |  2 +-
 src/conf/ucm/PAZ00/HiFi.conf   | 45 +++++++++++++++++++++++++++++
 src/conf/ucm/PAZ00/Makefile.am |  4 +++
 src/conf/ucm/PAZ00/PAZ00.conf  | 39 +++++++++++++++++++++++++
 src/conf/ucm/PAZ00/Record.conf | 65 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 src/conf/ucm/PAZ00/HiFi.conf
 create mode 100644 src/conf/ucm/PAZ00/Makefile.am
 create mode 100644 src/conf/ucm/PAZ00/PAZ00.conf
 create mode 100644 src/conf/ucm/PAZ00/Record.conf

diff --git a/configure.ac b/configure.ac
index b8353a0..734163c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -653,6 +653,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/PandaBoardES/Makefile \
 	  src/conf/ucm/SDP4430/Makefile \
 	  src/conf/ucm/tegraalc5632/Makefile \
+	  src/conf/ucm/PAZ00/Makefile \
 	  modules/Makefile modules/mixer/Makefile modules/mixer/simple/Makefile \
 	  alsalisp/Makefile aserver/Makefile \
 	  test/Makefile test/lsb/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index e089dde..bde89df 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -1 +1 @@
-SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632
+SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00
diff --git a/src/conf/ucm/PAZ00/HiFi.conf b/src/conf/ucm/PAZ00/HiFi.conf
new file mode 100644
index 0000000..275516d
--- /dev/null
+++ b/src/conf/ucm/PAZ00/HiFi.conf
@@ -0,0 +1,45 @@
+SectionVerb {
+    EnableSequence [
+        cdev "hw:PAZ00"
+ 
+        cset "name='Speaker Playback Switch' on"
+        cset "name='Int Spk Switch' on"
+        cset "name='Speaker Mix DAC2SPK Playback Switch' on"
+    ]
+    DisableSequence [
+        cset "name='Speaker Playback Switch' off"
+        cset "name='Int Spk Switch' off"
+        cset "name='Speaker Mix DAC2SPK Playback Switch' off"
+    ]
+}
+ 
+SectionDevice."Headset".0 {
+    Comment "3.5mm Headset"
+ 
+    Value {
+        JackName "Paz00 Headset Jack"
+    }
+ 
+    EnableSequence [
+        cdev "hw:PAZ00"
+ 
+        # Internal speaker
+        cset "name='Int Spk Switch' off"
+ 
+        # Headphones
+        cset "name='Headphone Playback Switch' on"
+        cset "name='HPL Mix DACL2HP Playback Switch' on"
+        cset "name='HPR Mix DACR2HP Playback Switch' on"
+    ]
+    DisableSequence [
+        cdev "hw:PAZ00"
+ 
+        # Headphones
+        cset "name='Headphone Playback Switch' off"
+        cset "name='HPL Mix DACL2HP Playback Switch' off"
+        cset "name='HPR Mix DACR2HP Playback Switch' off"
+ 
+        # Internal speaker
+        cset "name='Int Spk Switch' on"
+    ]
+}
diff --git a/src/conf/ucm/PAZ00/Makefile.am b/src/conf/ucm/PAZ00/Makefile.am
new file mode 100644
index 0000000..1bf98a6
--- /dev/null
+++ b/src/conf/ucm/PAZ00/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/PAZ00
+ucm_DATA = PAZ00.conf HiFi.conf Record.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/PAZ00/PAZ00.conf b/src/conf/ucm/PAZ00/PAZ00.conf
new file mode 100644
index 0000000..8b9d904
--- /dev/null
+++ b/src/conf/ucm/PAZ00/PAZ00.conf
@@ -0,0 +1,39 @@
+Comment "PAZ00 alc5632"
+ 
+ValueDefaults {
+  PlaybackCTL "hw:0"
+  CaptureCTL "hw:0"
+}
+ 
+SectionDefaults [
+        cdev "hw:PAZ00"
+ 
+        cset "name='Master Playback Switch' on"
+        cset "name='Master Playback Volume' 44,44"
+        cset "name='Headphone Playback Volume' 21,21"
+        cset "name='Speaker Playback Volume' 21,21"
+        cset "name='SpeakerOut Mux' 2"
+        cset "name='SpeakerOut N Mux' LN/-R"
+        cset "name='AB-D Amp Mux' 0"
+        cset "name='Left Headphone Mux' 1"
+        cset "name='Right Headphone Mux' 1"
+        cset "name='DMIC Boost Capture Volume' 4"
+        cset "name='Rec Capture Volume' 24"
+ 
+        # Fix external mic record volumes
+        cset "name='Mic 1 Boost Volume' 0"
+        cset "name='Mic 2 Boost Volume' 0"
+        cset "name='Mic1 Playback Volume' 0"
+        cset "name='Mic2 Playback Volume' 0"
+        cset "name='Rec Capture Volume' 0"
+]
+ 
+SectionUseCase."HiFi" {
+    File "HiFi.conf"
+    Comment "Music playback"
+}
+ 
+SectionUseCase."Record" {
+    File "Record.conf"
+    Comment "Playback and capture"
+}
diff --git a/src/conf/ucm/PAZ00/Record.conf b/src/conf/ucm/PAZ00/Record.conf
new file mode 100644
index 0000000..568e2fb
--- /dev/null
+++ b/src/conf/ucm/PAZ00/Record.conf
@@ -0,0 +1,65 @@
+SectionVerb {
+    EnableSequence [
+        cdev "hw:PAZ00"
+ 
+        cset "name='Speaker Playback Switch' on"
+        cset "name='Int Spk Switch' on"
+        cset "name='Speaker Mix DAC2SPK Playback Switch' on"
+ 
+        cset "name='DMICL Mix DMICL2ADC Capture Switch' on"
+        cset "name='DMIC En Capture Switch' on"
+        cset "name='DMIC PreFilter Capture Switch' on"
+    ]
+    DisableSequence [
+        cset "name='Speaker Playback Switch' off"
+        cset "name='Int Spk Switch' off"
+        cset "name='Speaker Mix DAC2SPK Playback Switch' off"
+ 
+        cset "name='DMICL Mix DMICL2ADC Capture Switch' off"
+        cset "name='DMIC En Capture Switch' off"
+        cset "name='DMIC PreFilter Capture Switch' off"
+    ]
+}
+ 
+SectionDevice."Headset".0 {
+    Comment "3.5mm Headset"
+ 
+    Value {
+        JackName "Paz00 Headset Jack"
+    }
+ 
+    EnableSequence [
+        cdev "hw:PAZ00"
+ 
+        # Internal speaker
+        cset "name='Int Spk Switch' off"
+ 
+        # Internal mic
+        cset "name='DMIC En Capture Switch' off"
+ 
+        # Headphones
+        cset "name='Headphone Playback Switch' on"
+        cset "name='HPL Mix DACL2HP Playback Switch' on"
+        cset "name='HPR Mix DACR2HP Playback Switch' on"
+ 
+        # External min
+        cset "name='Left Capture Mix MIC12REC_L Capture Switch' on"
+    ]
+    DisableSequence [
+        cdev "hw:PAZ00"
+ 
+        # Headphones
+        cset "name='Headphone Playback Switch' off"
+        cset "name='HPL Mix DACL2HP Playback Switch' off"
+        cset "name='HPR Mix DACR2HP Playback Switch' off"
+ 
+        # External mic
+        cset "name='Left Capture Mix MIC12REC_L Capture Switch' on"
+ 
+        # Internal speaker
+        cset "name='Int Spk Switch' on"
+ 
+        # Internal mic
+        cset "name='DMIC En Capture Switch' on"
+    ]
+}
-- 
2.0.1
