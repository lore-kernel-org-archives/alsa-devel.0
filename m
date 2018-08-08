From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 08/13] conf/ucm: bytcr-rt5651: Add support
	for mic input on various pins
Date: Wed,  8 Aug 2018 11:05:38 +0200
Message-ID: <20180808090543.15181-8-hdegoede@redhat.com>
References: <20180808090543.15181-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id BD5A426786A
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 11:05:52 +0200 (CEST)
In-Reply-To: <20180808090543.15181-1-hdegoede@redhat.com>
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

Note this commit replaces the pre-existing "Handset Microphone" and
"Main Microphone" options, these come from the first commit of the
bytcr-rt5651 UCM profile and were based on wrong assumptions about the
input mappings. None of the existing devices has the Hand/Headset mic
on IN1 as these options assumed.

The rt5651 is used in various configurations with the Internal Mic(s)
hooked up to IN1, IN2, or to IN1 and IN2 and the Headset Mic hooked up
to IN3.

Add support for all these to the generic bytcr-rt5651 profile and name
them accotding to their input + functions.

A follow up commit will add specialized longname configs which
will only expose the inputs actually used on the board with that
longname.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/bytcr-rt5651/HiFi.conf | 93 +++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 11 deletions(-)

diff --git a/src/conf/ucm/bytcr-rt5651/HiFi.conf b/src/conf/ucm/bytcr-rt5651/HiFi.conf
index fd878f4a..54c365d9 100644
--- a/src/conf/ucm/bytcr-rt5651/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651/HiFi.conf
@@ -85,51 +85,91 @@ SectionDevice."Speaker" {
 	}
 }
 
-SectionDevice."Handset" {
-	Comment "Handset Microphone"
+SectionDevice."InternalMic-IN1" {
+	Comment "Internal Microphone on IN1"
 
 	ConflictingDevice [
-		"Mainmic"
+		"InternalMic-IN2"
+		"InternalMic-IN12"
+		"HeadsetMic-IN3"
 	]
 
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
-		exec "echo Handset Microphone enable sequence"
+		exec "echo Internal Mic IN1 Microphone enable sequence"
+		cset "name='Internal Mic Switch' on"
 		cset "name='RECMIXL BST1 Switch' on"
 		cset "name='RECMIXR BST1 Switch' on"
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
-		exec "echo Handset Microphone disable sequence"
+		exec "echo Internal Mic IN1 Microphone disable sequence"
+		cset "name='Internal Mic Switch' off"
 		cset "name='RECMIXL BST1 Switch' off"
 		cset "name='RECMIXR BST1 Switch' off"
 	]
 
 	Value {
 		CaptureChannels "2"
-		JackControl "Headset Mic Jack"
 	}
 }
 
+SectionDevice."InternalMic-IN2" {
+	Comment "Internal Microphone on IN2"
+
+	ConflictingDevice [
+		"InternalMic-IN1"
+		"InternalMic-IN12"
+		"HeadsetMic-IN3"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5651"
+		exec "echo Internal Mic IN2 Microphone enable sequence"
+		cset "name='Internal Mic Switch' on"
+		cset "name='RECMIXL BST2 Switch' on"
+		cset "name='RECMIXR BST2 Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5651"
+		exec "echo Internal Mic IN2 Microphone disable sequence"
+		cset "name='Internal Mic Switch' off"
+		cset "name='RECMIXL BST2 Switch' off"
+		cset "name='RECMIXR BST2 Switch' off"
+	]
 
-SectionDevice."Mainmic" {
-	Comment "Main Microphone"
+	Value {
+		CaptureChannels "2"
+	}
+}
+
+SectionDevice."InternalMic-IN12" {
+	Comment "Internal Microphones on IN1 and IN2"
 
 	ConflictingDevice [
-		"Handset"
+		"InternalMic-IN1"
+		"InternalMic-IN2"
+		"HeadsetMic-IN3"
 	]
 
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
-		exec "echo Main Microphone enable sequence"
+		exec "echo Internal Mic IN12 Microphone enable sequence"
+		cset "name='Internal Mic Switch' on"
+		cset "name='RECMIXL BST1 Switch' on"
+		cset "name='RECMIXR BST1 Switch' on"
 		cset "name='RECMIXL BST2 Switch' on"
 		cset "name='RECMIXR BST2 Switch' on"
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
-		exec "echo Main Microphone disable sequence"
+		exec "echo Internal Mic IN12 Microphone disable sequence"
+		cset "name='Internal Mic Switch' off"
+		cset "name='RECMIXL BST1 Switch' off"
+		cset "name='RECMIXR BST1 Switch' off"
 		cset "name='RECMIXL BST2 Switch' off"
 		cset "name='RECMIXR BST2 Switch' off"
 	]
@@ -138,3 +178,34 @@ SectionDevice."Mainmic" {
 		CaptureChannels "2"
 	}
 }
+
+SectionDevice."HeadsetMic-IN3" {
+	Comment "Headset Microphone"
+
+	ConflictingDevice [
+		"InternalMic-IN1"
+		"InternalMic-IN2"
+		"InternalMic-IN12"
+	]
+
+	EnableSequence [
+		cdev "hw:bytcrrt5651"
+		exec "echo HeadsetMic-IN3 Microphone enable sequence"
+		cset "name='Headset Mic Switch' on"
+		cset "name='RECMIXL BST3 Switch' on"
+		cset "name='RECMIXR BST3 Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:bytcrrt5651"
+		exec "echo HeadsetMic-IN3 Microphone disable sequence"
+		cset "name='Headset Mic Switch' off"
+		cset "name='RECMIXL BST3 Switch' off"
+		cset "name='RECMIXR BST3 Switch' off"
+	]
+
+	Value {
+		CaptureChannels "2"
+		JackControl "Headset Mic Jack"
+	}
+}
-- 
2.18.0
