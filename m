From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 01/13] conf/ucm: bytcr-rt5645: Use the
	generic bytcr/PlatformEnableSeq.conf
Date: Wed,  8 Aug 2018 11:05:31 +0200
Message-ID: <20180808090543.15181-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 49D0826786A
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 11:05:46 +0200 (CEST)
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

Use the generic Intel SSP bytcr/PlatformEnableSeq.conf file, it is
identical to all the cset statements this commit removes.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 src/conf/ucm/chtrt5645/HiFi.conf | 116 +------------------------------
 1 file changed, 1 insertion(+), 115 deletions(-)

diff --git a/src/conf/ucm/chtrt5645/HiFi.conf b/src/conf/ucm/chtrt5645/HiFi.conf
index e81866cf..d993f6ae 100644
--- a/src/conf/ucm/chtrt5645/HiFi.conf
+++ b/src/conf/ucm/chtrt5645/HiFi.conf
@@ -11,121 +11,7 @@ SectionVerb {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		# media mixer settings
-		#   compress
-		cset "name='media0_in Gain 0 Switch' on"
-		cset "name='media0_in Gain 0 Volume' 0"
-
-		#   normal
-		cset "name='media1_in Gain 0 Switch' on"
-		cset "name='media1_in Gain 0 Volume' 0"
-		#   swm loopback
-		cset "name='media2_in Gain 0 Switch' off"
-		cset "name='media2_in Gain 0 Volume' 0%"
-		#   deep buffer
-		cset "name='media3_in Gain 0 Switch' on"
-		cset "name='media3_in Gain 0 Volume' 0"
-
-		cset "name='media0_out mix 0 media0_in Switch' on"
-		cset "name='media0_out mix 0 media1_in Switch' on"
-		cset "name='media0_out mix 0 media2_in Switch' off"
-		cset "name='media0_out mix 0 media3_in Switch' on"
-
-		cset "name='media1_out mix 0 media0_in Switch' off"
-		cset "name='media1_out mix 0 media1_in Switch' off"
-		cset "name='media1_out mix 0 media2_in Switch' off"
-		cset "name='media1_out mix 0 media3_in Switch' off"
-
-		cset "name='pcm0_in Gain 0 Switch' on"
-		cset "name='pcm0_in Gain 0 Volume' 0"
-
-		cset "name='pcm1_in Gain 0 Switch' off"
-		cset "name='pcm1_in Gain 0 Volume' 0%"
-
-		# codec0_out settings (used if ssp2 is connected to aif1)
-		cset "name='codec_out0 mix 0 codec_in0 Switch' off"
-		cset "name='codec_out0 mix 0 codec_in1 Switch' off"
-		cset "name='codec_out0 mix 0 media_loop1_in Switch' off"
-		cset "name='codec_out0 mix 0 media_loop2_in Switch' off"
-		cset "name='codec_out0 mix 0 pcm0_in Switch' on"
-		cset "name='codec_out0 mix 0 pcm1_in Switch' off"
-		cset "name='codec_out0 mix 0 sprot_loop_in Switch' off"
-		cset "name='codec_out0 Gain 0 Switch' on"
-		cset "name='codec_out0 Gain 0 Volume' 0"
-
-		# modem_out settings (used if ssp0 is connected to aif2)
-		cset "name='modem_out mix 0 codec_in0 Switch' off"
-		cset "name='modem_out mix 0 codec_in1 Switch' off"
-		cset "name='modem_out mix 0 media_loop1_in Switch' off"
-		cset "name='modem_out mix 0 media_loop2_in Switch' off"
-		cset "name='modem_out mix 0 pcm0_in Switch' on"
-		cset "name='modem_out mix 0 pcm1_in Switch' off"
-		cset "name='modem_out mix 0 sprot_loop_in Switch' off"
-		cset "name='modem_out Gain 0 Switch' on"
-		cset "name='modem_out Gain 0 Volume' 0"
-
-		# input settings
-		# pcm1_out settings
-
-		# input used when SSP2 is connected
-		cset "name='codec_in0 Gain 0 Switch' on"
-		cset "name='codec_in0 Gain 0 Volume' 0"
-
-		# input used when SSP0 is connected
-		cset "name='modem_in Gain 0 Switch' on"
-		cset "name='modem_in Gain 0 Volume' 0"
-
-		cset "name='pcm1_out mix 0 codec_in0 Switch' on"
-		cset "name='pcm1_out mix 0 modem_in Switch' on"
-		cset "name='pcm1_out mix 0 codec_in1 Switch' off"
-		cset "name='pcm1_out mix 0 media_loop1_in Switch' off"
-		cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
-		cset "name='pcm1_out mix 0 pcm0_in Switch' off"
-		cset "name='pcm1_out mix 0 pcm1_in Switch' off"
-		cset "name='pcm1_out mix 0 sprot_loop_in Switch' off"
-
-		cset "name='pcm1_out Gain 0 Switch' on"
-		cset "name='pcm1_out Gain 0 Volume' 0"
-
-		# disable codec_out1
-		cset "name='codec_out1 mix 0 codec_in0 Switch' off"
-		cset "name='codec_out1 mix 0 codec_in1 Switch' off"
-		cset "name='codec_out1 mix 0 media_loop1_in Switch' off"
-		cset "name='codec_out1 mix 0 media_loop2_in Switch' off"
-		cset "name='codec_out1 mix 0 pcm0_in Switch' off"
-		cset "name='codec_out1 mix 0 pcm1_in Switch' off"
-		cset "name='codec_out1 mix 0 sprot_loop_in Switch' off"
-		cset "name='codec_out1 Gain 0 Switch' off"
-		cset "name='codec_out1 Gain 0 Volume' 0%"
-
-		# disable codec_in1
-		cset "name='codec_in1 Gain 0 Switch' off"
-		cset "name='codec_in1 Gain 0 Volume' 0%"
-
-		# disable all loops
-		cset "name='media_loop1_out mix 0 codec_in0 Switch' off"
-		cset "name='media_loop1_out mix 0 codec_in1 Switch' off"
-		cset "name='media_loop1_out mix 0 media_loop1_in Switch' off"
-		cset "name='media_loop1_out mix 0 media_loop2_in Switch' off"
-		cset "name='media_loop1_out mix 0 pcm0_in Switch' off"
-		cset "name='media_loop1_out mix 0 pcm1_in Switch' off"
-		cset "name='media_loop1_out mix 0 sprot_loop_in Switch' off"
-
-		cset "name='media_loop2_out mix 0 codec_in0 Switch' off"
-		cset "name='media_loop2_out mix 0 codec_in1 Switch' off"
-		cset "name='media_loop2_out mix 0 media_loop1_in Switch' off"
-		cset "name='media_loop2_out mix 0 media_loop2_in Switch' off"
-		cset "name='media_loop2_out mix 0 pcm0_in Switch' off"
-		cset "name='media_loop2_out mix 0 pcm1_in Switch' off"
-		cset "name='media_loop2_out mix 0 sprot_loop_in Switch' off"
-
-		cset "name='sprot_loop_out mix 0 codec_in0 Switch' off"
-		cset "name='sprot_loop_out mix 0 codec_in1 Switch' off"
-		cset "name='sprot_loop_out mix 0 media_loop1_in Switch' off"
-		cset "name='sprot_loop_out mix 0 media_loop2_in Switch' off"
-		cset "name='sprot_loop_out mix 0 pcm0_in Switch' off"
-		cset "name='sprot_loop_out mix 0 pcm1_in Switch' off"
-		cset "name='sprot_loop_out mix 0 sprot_loop_in Switch' off"
+		<bytcr/PlatformEnableSeq.conf>
 
 		# Output Configuration
 		cset "name='DAC1 L Mux' IF1 DAC"
-- 
2.18.0
