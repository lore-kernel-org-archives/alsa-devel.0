From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/5] conf/ucm: chtrt5645: Cleanup and playback
	fixes
Date: Sat, 28 Apr 2018 21:51:56 +0200
Message-ID: <20180428195200.11722-2-hdegoede@redhat.com>
References: <20180428195200.11722-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id A21532671EA
 for <alsa-devel@alsa-project.org>; Sat, 28 Apr 2018 21:52:04 +0200 (CEST)
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

Apply cleanup and playback fixes changes from:
https://github.com/plbossart/UCM.git

Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
[hdegoede@redhat.com: Modify commit msg and paths for merging into alsa-lib]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/chtrt5645/HiFi.conf | 157 +++++++++++++++++++++++++------
 1 file changed, 129 insertions(+), 28 deletions(-)

diff --git a/src/conf/ucm/chtrt5645/HiFi.conf b/src/conf/ucm/chtrt5645/HiFi.conf
index 0c2c83cc..f63392d4 100644
--- a/src/conf/ucm/chtrt5645/HiFi.conf
+++ b/src/conf/ucm/chtrt5645/HiFi.conf
@@ -11,51 +11,146 @@ SectionVerb {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		# Enable audio output path
-		cset "name='codec_out1 mix 0 pcm0_in Switch' on"
-		cset "name='media0_out mix 0 media1_in Switch' on"
+		# media mixer settings
+		#   compress
+		cset "name='media0_in Gain 0 Switch' on"
+		cset "name='media0_in Gain 0 Volume' 0"
 
-		cset "name='media1_in Gain 0 Ramp Delay' 50"
+		#   normal
 		cset "name='media1_in Gain 0 Switch' on"
-		cset "name='media1_in Gain 0 Volume' 80% 80%"
+		cset "name='media1_in Gain 0 Volume' 0"
+		#   swm loopback
+		cset "name='media2_in Gain 0 Switch' off"
+		cset "name='media2_in Gain 0 Volume' 0%"
+		#   deep buffer
+		cset "name='media3_in Gain 0 Switch' on"
+		cset "name='media3_in Gain 0 Volume' 0"
+
+		cset "name='media0_out mix 0 media0_in Switch' on"
+		cset "name='media0_out mix 0 media1_in Switch' on"
+		cset "name='media0_out mix 0 media2_in Switch' off"
+		cset "name='media0_out mix 0 media3_in Switch' on"
+
+		cset "name='media1_out mix 0 media0_in Switch' off"
+		cset "name='media1_out mix 0 media1_in Switch' off"
+		cset "name='media1_out mix 0 media2_in Switch' off"
+		cset "name='media1_out mix 0 media3_in Switch' off"
 
-		cset "name='pcm0_in Gain 0 Ramp Delay' 50"
 		cset "name='pcm0_in Gain 0 Switch' on"
-		cset "name='pcm0_in Gain 0 Volume' 80% 80%"
+		cset "name='pcm0_in Gain 0 Volume' 0"
+
+		cset "name='pcm1_in Gain 0 Switch' off"
+		cset "name='pcm1_in Gain 0 Volume' 0%"
+
+		# codec0_out settings (used if ssp2 is connected to aif1)
+		cset "name='codec_out0 mix 0 codec_in0 Switch' off"
+		cset "name='codec_out0 mix 0 codec_in1 Switch' off"
+		cset "name='codec_out0 mix 0 media_loop1_in Switch' off"
+		cset "name='codec_out0 mix 0 media_loop2_in Switch' off"
+		cset "name='codec_out0 mix 0 pcm0_in Switch' on"
+		cset "name='codec_out0 mix 0 pcm1_in Switch' off"
+		cset "name='codec_out0 mix 0 sprot_loop_in Switch' off"
+		cset "name='codec_out0 Gain 0 Switch' on"
+		cset "name='codec_out0 Gain 0 Volume' 0"
+
+		# modem_out settings (used if ssp0 is connected to aif2)
+		cset "name='modem_out mix 0 codec_in0 Switch' off"
+		cset "name='modem_out mix 0 codec_in1 Switch' off"
+		cset "name='modem_out mix 0 media_loop1_in Switch' off"
+		cset "name='modem_out mix 0 media_loop2_in Switch' off"
+		cset "name='modem_out mix 0 pcm0_in Switch' on"
+		cset "name='modem_out mix 0 pcm1_in Switch' off"
+		cset "name='modem_out mix 0 sprot_loop_in Switch' off"
+		cset "name='modem_out Gain 0 Switch' on"
+		cset "name='modem_out Gain 0 Volume' 0"
+
+		# input settings
+		# pcm1_out settings
+
+		# input used when SSP2 is connected
+		cset "name='codec_in0 Gain 0 Switch' on"
+		cset "name='codec_in0 Gain 0 Volume' 0"
 
-		cset "name='codec_out1 Gain 0 Ramp Delay' 50"
-		cset "name='codec_out1 Gain 0 Switch' on"
-		cset "name='codec_out1 Gain 0 Volume' 70% 70%"
+		# input used when SSP0 is connected
+		cset "name='modem_in Gain 0 Switch' on"
+		cset "name='modem_in Gain 0 Volume' 0"
 
-		# Enable audio input path
-		cset "name='pcm1_out mix 0 media_loop2_in Switch' on"
-		cset "name='media_loop2_out mix 0 codec_in0 Switch' on"
+		cset "name='pcm1_out mix 0 codec_in0 Switch' on"
+		cset "name='pcm1_out mix 0 modem_in Switch' on"
+		cset "name='pcm1_out mix 0 codec_in1 Switch' off"
+		cset "name='pcm1_out mix 0 media_loop1_in Switch' off"
+		cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
+		cset "name='pcm1_out mix 0 pcm0_in Switch' off"
+		cset "name='pcm1_out mix 0 pcm1_in Switch' off"
+		cset "name='pcm1_out mix 0 sprot_loop_in Switch' off"
 
-		cset "name='codec_in0 Gain 0 Ramp Delay' 50"
-		cset "name='codec_in0 Gain 0 Switch' on"
-		cset "name='codec_in0 Gain 0 Volume' 80% 80%"
+		cset "name='pcm1_out Gain 0 Switch' on"
+		cset "name='pcm1_out Gain 0 Volume' 0"
 
-		cset "name='media_loop2_out Gain 0 Ramp Delay' 50"
-		cset "name='media_loop2_out Gain 0 Switch' on"
-		cset "name='media_loop2_out Gain 0 Volume' 80% 80%"
+		# disable codec_out1
+		cset "name='codec_out1 mix 0 codec_in0 Switch' off"
+		cset "name='codec_out1 mix 0 codec_in1 Switch' off"
+		cset "name='codec_out1 mix 0 media_loop1_in Switch' off"
+		cset "name='codec_out1 mix 0 media_loop2_in Switch' off"
+		cset "name='codec_out1 mix 0 pcm0_in Switch' off"
+		cset "name='codec_out1 mix 0 pcm1_in Switch' off"
+		cset "name='codec_out1 mix 0 sprot_loop_in Switch' off"
+		cset "name='codec_out1 Gain 0 Switch' off"
+		cset "name='codec_out1 Gain 0 Volume' 0%"
 
-		cset "name='pcm1_out Gain 0 Ramp Delay' 50"
-		cset "name='pcm1_out Gain 0 Switch' on"
-		cset "name='pcm1_out Gain 0 Volume' 80% 80%"
+		# disable codec_in1
+		cset "name='codec_in1 Gain 0 Switch' off"
+		cset "name='codec_in1 Gain 0 Volume' 0%"
+
+		# disable all loops
+		cset "name='media_loop1_out mix 0 codec_in0 Switch' off"
+		cset "name='media_loop1_out mix 0 codec_in1 Switch' off"
+		cset "name='media_loop1_out mix 0 media_loop1_in Switch' off"
+		cset "name='media_loop1_out mix 0 media_loop2_in Switch' off"
+		cset "name='media_loop1_out mix 0 pcm0_in Switch' off"
+		cset "name='media_loop1_out mix 0 pcm1_in Switch' off"
+		cset "name='media_loop1_out mix 0 sprot_loop_in Switch' off"
+
+		cset "name='media_loop2_out mix 0 codec_in0 Switch' off"
+		cset "name='media_loop2_out mix 0 codec_in1 Switch' off"
+		cset "name='media_loop2_out mix 0 media_loop1_in Switch' off"
+		cset "name='media_loop2_out mix 0 media_loop2_in Switch' off"
+		cset "name='media_loop2_out mix 0 pcm0_in Switch' off"
+		cset "name='media_loop2_out mix 0 pcm1_in Switch' off"
+		cset "name='media_loop2_out mix 0 sprot_loop_in Switch' off"
+
+		cset "name='sprot_loop_out mix 0 codec_in0 Switch' off"
+		cset "name='sprot_loop_out mix 0 codec_in1 Switch' off"
+		cset "name='sprot_loop_out mix 0 media_loop1_in Switch' off"
+		cset "name='sprot_loop_out mix 0 media_loop2_in Switch' off"
+		cset "name='sprot_loop_out mix 0 pcm0_in Switch' off"
+		cset "name='sprot_loop_out mix 0 pcm1_in Switch' off"
+		cset "name='sprot_loop_out mix 0 sprot_loop_in Switch' off"
 
 		# Output Configuration
-		cset "name='DAC L2 Mux' 'IF1 DAC'"
-		cset "name='DAC R2 Mux' 'IF1 DAC'"
+		cset "name='DAC1 L Mux' IF1 DAC"
+		cset "name='DAC1 R Mux' IF1 DAC"
+		cset "name='DAC1 MIXL DAC1 Switch' 1"
+		cset "name='DAC1 MIXR DAC1 Switch' 1"
+		cset "name='Stereo DAC MIXL DAC L1 Switch' 1"
+		cset "name='Stereo DAC MIXR DAC R1 Switch' 1"
+
+		cset "name='DAC L2 Mux' IF2 DAC"
+		cset "name='DAC R2 Mux' IF2 DAC"
 		cset "name='Mono DAC MIXL DAC L2 Switch' on"
 		cset "name='Mono DAC MIXR DAC R2 Switch' on"
 		cset "name='DAC2 Playback Switch' on"
 
+		cset "name='HPOVOL MIXL DAC1 Switch' on"
+		cset "name='HPOVOL MIXR DAC1 Switch' on"
 		cset "name='HPOVOL MIXL DAC2 Switch' on"
 		cset "name='HPOVOL MIXR DAC2 Switch' on"
 		cset "name='HPO MIX HPVOL Switch' on"
 		cset "name='HPOVOL L Switch' on"
 		cset "name='HPOVOL R Switch' on"
 
+		cset "name='SPK MIXL DAC L1 Switch' on"
+		cset "name='SPK MIXR DAC R1 Switch' on"
 		cset "name='SPK MIXL DAC L2 Switch' on"
 		cset "name='SPK MIXR DAC R2 Switch' on"
 		cset "name='SPOL MIX SPKVOL L Switch' on"
@@ -105,15 +200,18 @@ SectionDevice."Speaker" {
 	}
 
 	ConflictingDevice [
-		"Headphone"
+		"Headphones"
 	]
 
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
+		cset "name='Headphone Switch' off"
+		cset "name='Headphone Channel Switch' off"
+
 		cset "name='Ext Spk Switch' on"
 		cset "name='Speaker Channel Switch' on"
-		cset "name='Speaker Playback Volume' 39"
+		cset "name='Speaker Playback Volume' 31"
 	]
 
 	DisableSequence [
@@ -124,7 +222,7 @@ SectionDevice."Speaker" {
 	]
 }
 
-SectionDevice."Headphone".0 {
+SectionDevice."Headphones" {
 	Comment "Headphones"
 
 	Value {
@@ -140,9 +238,12 @@ SectionDevice."Headphone".0 {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
+		cset "name='Ext Spk Switch' off"
+		cset "name='Speaker Channel Switch' off"
+
 		cset "name='Headphone Switch' on"
 		cset "name='Headphone Channel Switch' on"
-		cset "name='Headphone Playback Volume' 39"
+		cset "name='Headphone Playback Volume' 31"
 	]
 
 	DisableSequence [
-- 
2.17.0
