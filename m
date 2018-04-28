From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/5] conf/ucm: chtrt5645: Microphone recording
	fixes
Date: Sat, 28 Apr 2018 21:51:57 +0200
Message-ID: <20180428195200.11722-3-hdegoede@redhat.com>
References: <20180428195200.11722-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BA56267235
 for <alsa-devel@alsa-project.org>; Sat, 28 Apr 2018 21:52:05 +0200 (CEST)
In-Reply-To: <20180428195200.11722-1-hdegoede@redhat.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Apply microphone recording changes from:
https://github.com/plbossart/UCM.git

Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
[hdegoede@redhat.com: Drop non generic DMIC changes]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/chtrt5645/HiFi.conf | 50 ++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/src/conf/ucm/chtrt5645/HiFi.conf b/src/conf/ucm/chtrt5645/HiFi.conf
index f63392d4..b97a9c00 100644
--- a/src/conf/ucm/chtrt5645/HiFi.conf
+++ b/src/conf/ucm/chtrt5645/HiFi.conf
@@ -4,8 +4,8 @@ SectionVerb {
 		TQ "HiFi"
 
 		# ALSA PCM device for HiFi
-		PlaybackPCM "hw:chtrt5645,0"
-		CapturePCM "hw:chtrt5645,0"
+		PlaybackPCM "hw:chtrt5645"
+		CapturePCM "hw:chtrt5645"
 	}
 
 	EnableSequence [
@@ -255,7 +255,7 @@ SectionDevice."Headphones" {
 }
 
 SectionDevice."Mic".0 {
-	Comment "Internal Microphone"
+	Comment "Internal Analog Microphones"
 
 	Value {
 		CaptureChannels "2"
@@ -266,15 +266,33 @@ SectionDevice."Mic".0 {
 		cdev "hw:chtrt5645"
 
 		cset "name='Int Mic Switch' on"
-		cset "name='Sto1 ADC MIXL ADC2 Switch' on"
-		cset "name='Sto1 ADC MIXR ADC2 Switch' on"
+
+		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
+		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
+		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
+		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
+
+		cset "name='Mono ADC MIXL ADC1 Switch' on"
+		cset "name='Mono ADC MIXR ADC1 Switch' on"
+		cset "name='Mono ADC MIXL ADC2 Switch' off"
+		cset "name='Mono ADC MIXR ADC2 Switch' off"
+
+		cset "name='RECMIXL BST1 Switch' on"
+		cset "name='RECMIXR BST1 Switch' on"
+
 	]
 
 	DisableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
+		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
+		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
+		cset "name='Mono ADC MIXL ADC1 Switch' off"
+		cset "name='Mono ADC MIXR ADC1 Switch' off"
+
+		cset "name='RECMIXL BST1 Switch' off"
+		cset "name='RECMIXR BST1 Switch' off"
+
 		cset "name='Int Mic Switch' off"
 	]
 }
@@ -292,19 +310,33 @@ SectionDevice."HSMic".0 {
 		cdev "hw:chtrt5645"
 
 		cset "name='Headset Mic Switch' on"
-		cset "name='RECMIXL BST1 Switch' on"
-		cset "name='RECMIXR BST1 Switch' on"
+
 		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
 		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
+		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
+		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
+
+		cset "name='Mono ADC MIXL ADC1 Switch' on"
+		cset "name='Mono ADC MIXR ADC1 Switch' on"
+		cset "name='Mono ADC MIXL ADC2 Switch' off"
+		cset "name='Mono ADC MIXR ADC2 Switch' off"
+
+		cset "name='RECMIXL BST1 Switch' on"
+		cset "name='RECMIXR BST1 Switch' on"
+
 	]
 
 	DisableSequence [
 		cdev "hw:chtrt5645"
 
 		cset "name='Headset Mic Switch' off"
+
 		cset "name='RECMIXL BST1 Switch' off"
 		cset "name='RECMIXR BST1 Switch' off"
 		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
 		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
+		cset "name='Mono ADC MIXL ADC1 Switch' on"
+		cset "name='Mono ADC MIXR ADC1 Switch' on"
+
 	]
 }
-- 
2.17.0
