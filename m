From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] conf/ucm: Add Gigabyte mobo UCM profile
	with dual HD-audio codecs
Date: Tue,  5 Dec 2017 17:46:20 +0100
Message-ID: <20171205164620.6257-3-tiwai@suse.de>
References: <20171205164620.6257-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 38364266DB1
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 17:46:27 +0100 (CET)
In-Reply-To: <20171205164620.6257-1-tiwai@suse.de>
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
Cc: Hui Wang <hui.wang@canonical.com>, Kailang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

Like the previous Lenovo laptops, some Gigabyte mobos have dual
HD-audio codecs and need to switch dynamically via UCM profile.
Reuse the same profile as Lenovo dual codecs, so far.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 configure.ac                                       |   1 +
 .../HDAudio-Gigabyte-ALC1220DualCodecs.conf        |   5 +
 .../HDAudio-Gigabyte-ALC1220DualCodecs/HiFi.conf   | 145 +++++++++++++++++++++
 .../HDAudio-Gigabyte-ALC1220DualCodecs/Makefile.am |   4 +
 src/conf/ucm/Makefile.am                           |   1 +
 5 files changed, 156 insertions(+)
 create mode 100644 src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/HDAudio-Gigabyte-ALC1220DualCodecs.conf
 create mode 100644 src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/HiFi.conf
 create mode 100644 src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile.am

diff --git a/configure.ac b/configure.ac
index 286f6bdd74cb..1d97946d843f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -698,6 +698,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/DAISY-I2S/Makefile \
 	  src/conf/ucm/DB410c/Makefile \
 	  src/conf/ucm/GoogleNyan/Makefile \
+	  src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile \
 	  src/conf/ucm/HDAudio-Lenovo-DualCodecs/Makefile \
 	  src/conf/ucm/PandaBoard/Makefile \
 	  src/conf/ucm/PandaBoardES/Makefile \
diff --git a/src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/HDAudio-Gigabyte-ALC1220DualCodecs.conf b/src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/HDAudio-Gigabyte-ALC1220DualCodecs.conf
new file mode 100644
index 000000000000..492eebf01aa9
--- /dev/null
+++ b/src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/HDAudio-Gigabyte-ALC1220DualCodecs.conf
@@ -0,0 +1,5 @@
+Comment "Gigabyte mobo with dual HD-audio codecs"
+SectionUseCase."HiFi" {
+	File "HiFi.conf"
+	Comment "Default"
+}
diff --git a/src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/HiFi.conf b/src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/HiFi.conf
new file mode 100644
index 000000000000..509678964f3f
--- /dev/null
+++ b/src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/HiFi.conf
@@ -0,0 +1,145 @@
+SectionVerb {
+	Value {
+		TQ "HiFi"
+	}
+
+	EnableSequence [
+		cdev "hw:PCH"
+		cset "name='Front Playback Volume' 100%"
+		cset "name='Front Playback Switch' on"
+		cset "name='Rear-Panel Capture Volume' 100%"
+		cset "name='Rear-Panel Capture Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:PCH"
+		cset "name='Front Playback Volume' 0"
+		cset "name='Front Playback Switch' off"
+		cset "name='Rear-Panel Capture Volume' 0"
+		cset "name='Rear-Panel Capture Switch' off"
+	]
+}
+
+SectionDevice."Speaker" {
+	Comment "Speaker"
+
+	Value {
+		PlaybackChannels "2"
+		PlaybackPCM "hw:PCH,4"
+	}
+
+	ConflictingDevice [
+		"Headphone"
+	]
+
+	EnableSequence [
+		cdev "hw:PCH"
+		cset "name='Speaker Playback Switch' on"
+		cset "name='Speaker Playback Volume' 100%"
+	]
+
+	DisableSequence [
+		cdev "hw:PCH"
+		cset "name='Speaker Playback Volume' 0"
+		cset "name='Speaker Playback Switch' off"
+	]
+}
+
+SectionDevice."LineOut" {
+	Comment "Line Out"
+
+	Value {
+		PlaybackChannels "2"
+		PlaybackPCM "hw:PCH,0"
+		JackControl "Line Out Jack"
+		JackHWMute "Speaker"
+	}
+}
+
+SectionDevice."Headphone" {
+	Comment "Headphone"
+
+	Value {
+		PlaybackChannels "2"
+		PlaybackPCM "hw:PCH,4"
+		JackControl "Front Headphone Jack"
+		JackHWMute "Speaker"
+	}
+
+	ConflictingDevice [
+		"Speaker"
+	]
+
+	EnableSequence [
+		cdev "hw:PCH"
+		cset "name='Headphone Playback Switch' on"
+		cset "name='Headphone Playback Volume' 100%"
+	]
+
+	DisableSequence [
+		cdev "hw:PCH"
+		cset "name='Headphone Playback Volume' 0"
+		cset "name='Headphone Playback Switch' off"
+	]
+}
+
+SectionDevice."LineIn" {
+	Comment "Rear Line In"
+
+	Value {
+		CaptureChannels "2"
+		CapturePCM "hw:PCH,0"
+		JackControl "Line Jack"
+	}
+
+	ConflictingDevice [
+		"RearMic"
+	]
+
+	EnableSequence [
+		cdev "hw:PCH"
+		cset "name='Input Source' Line"
+	]
+}
+
+SectionDevice."RearMic" {
+	Comment "Rear Microphone"
+
+	Value {
+		CaptureChannels "2"
+		CapturePCM "hw:PCH,0"
+		# CapturePriority "150"
+		JackHWMute "LineIn"
+	}
+
+	ConflictingDevice [
+		"LineIn"
+	]
+
+	EnableSequence [
+		cdev "hw:PCH"
+		cset "name='Input Source' Rear Mic"
+	]
+}
+
+SectionDevice."FrontMic" {
+	Comment "Front Microphone"
+
+	Value {
+		CaptureChannels "2"
+		CapturePCM "hw:PCH,4"
+		JackControl "Front Mic Jack"
+	}
+
+	EnableSequence [
+		cdev "hw:PCH"
+		cset "name='Front-Panel Capture Volume' 100%"
+		cset "name='Front-Panel Capture Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:PCH"
+		cset "name='Front-Panel Capture Volume' 0"
+		cset "name='Front-Panel Capture Switch' off"
+	]
+}
diff --git a/src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile.am b/src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile.am
new file mode 100644
index 000000000000..728fd19b9251
--- /dev/null
+++ b/src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/HDAudio-Gigabyte-ALC1220DualCodecs
+ucm_DATA = HDAudio-Gigabyte-ALC1220DualCodecs.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 1d81beeb4ddf..954e32b8f0c8 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -6,6 +6,7 @@ chtrt5645 \
 DAISY-I2S \
 DB410c \
 GoogleNyan \
+HDAudio-Gigabyte-ALC1220DualCodecs \
 HDAudio-Lenovo-DualCodecs \
 PandaBoard \
 PandaBoardES \
-- 
2.15.0
