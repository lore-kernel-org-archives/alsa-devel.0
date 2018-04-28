From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/5] conf/ucm: chtrt5645: Fix recording from
	internal analog microphone
Date: Sat, 28 Apr 2018 21:51:58 +0200
Message-ID: <20180428195200.11722-4-hdegoede@redhat.com>
References: <20180428195200.11722-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FD44266C1C
 for <alsa-devel@alsa-project.org>; Sat, 28 Apr 2018 21:52:06 +0200 (CEST)
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

The internal analog mic switch is called 'Int Analog Mic Switch'
(not 'Int Mic Switch') and is connected to BST2 not BST1.

Also change the analog mic volume levels so that we get better
audio / less noise.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/chtrt5645/HiFi.conf | 38 ++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/src/conf/ucm/chtrt5645/HiFi.conf b/src/conf/ucm/chtrt5645/HiFi.conf
index b97a9c00..e81866cf 100644
--- a/src/conf/ucm/chtrt5645/HiFi.conf
+++ b/src/conf/ucm/chtrt5645/HiFi.conf
@@ -160,15 +160,24 @@ SectionVerb {
 
 		# Input Configuration
 		cset "name='Stereo1 DMIC Mux' 0"
+		cset "name='Stereo1 ADC1 Mux' 1"
 		cset "name='Stereo1 ADC2 Mux' 1"
 		cset "name='ADC Capture Switch' on"
-		cset "name='ADC Capture Volume' 31"
-		cset "name='ADC Boost Capture Volume' 3"
-		cset "name='Mono ADC Capture Volume' 63"
-		cset "name='Mono ADC Boost Capture Volume' 2"
-		cset "name='IN Capture Volume' 63"
+		# 55/63
+		cset "name='ADC Capture Volume' 55"
+		# set ADC Boost to 0/3, higher vals cause a lot of white noise
+		cset "name='ADC Boost Capture Volume' 0"
+		# 55/63
+		cset "name='Mono ADC Capture Volume' 55"
+		# 0/3
+		cset "name='Mono ADC Boost Capture Volume' 0"
+		# 27/31
+		cset "name='IN Capture Volume' 27"
 		cset "name='I2S2 Func Switch' on"
-
+		# 3/12 the headphone mic tends to be quite loud
+		cset "name='IN1 Boost' 3"
+		# 8/8 the internal analog mic tends to be quite soft
+		cset "name='IN2 Boost' 8"
 	]
 
 	DisableSequence [
@@ -243,7 +252,8 @@ SectionDevice."Headphones" {
 
 		cset "name='Headphone Switch' on"
 		cset "name='Headphone Channel Switch' on"
-		cset "name='Headphone Playback Volume' 31"
+		# 25/39 higher values cause crackling on some boards
+		cset "name='Headphone Playback Volume' 25"
 	]
 
 	DisableSequence [
@@ -255,7 +265,7 @@ SectionDevice."Headphones" {
 }
 
 SectionDevice."Mic".0 {
-	Comment "Internal Analog Microphones"
+	Comment "Internal Analog Microphone"
 
 	Value {
 		CaptureChannels "2"
@@ -265,7 +275,7 @@ SectionDevice."Mic".0 {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Int Mic Switch' on"
+		cset "name='Int Analog Mic Switch' on"
 
 		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
 		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
@@ -277,8 +287,8 @@ SectionDevice."Mic".0 {
 		cset "name='Mono ADC MIXL ADC2 Switch' off"
 		cset "name='Mono ADC MIXR ADC2 Switch' off"
 
-		cset "name='RECMIXL BST1 Switch' on"
-		cset "name='RECMIXR BST1 Switch' on"
+		cset "name='RECMIXL BST2 Switch' on"
+		cset "name='RECMIXR BST2 Switch' on"
 
 	]
 
@@ -290,10 +300,10 @@ SectionDevice."Mic".0 {
 		cset "name='Mono ADC MIXL ADC1 Switch' off"
 		cset "name='Mono ADC MIXR ADC1 Switch' off"
 
-		cset "name='RECMIXL BST1 Switch' off"
-		cset "name='RECMIXR BST1 Switch' off"
+		cset "name='RECMIXL BST2 Switch' off"
+		cset "name='RECMIXR BST2 Switch' off"
 
-		cset "name='Int Mic Switch' off"
+		cset "name='Int Analog Mic Switch' off"
 	]
 }
 
-- 
2.17.0
