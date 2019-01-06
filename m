From: russell.parker7@gmail.com
Subject: [PATCH ucm/conf: 1/5] Update chtrt5645 ucm variants to
	use bytcr/PlatformEnableSeq.conf component
Date: Sat,  5 Jan 2019 19:47:11 -0800
Message-ID: <20190106034715.21045-2-russell.parker7@gmail.com>
References: <20190106034715.21045-1-russell.parker7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190106034715.21045-1-russell.parker7@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Russell Parker <russell.parker7@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Russell Parker <russell.parker7@gmail.com>

The Lenovo Ideapad Miix 320, Asus T100HA, and chtrt5645 mono variant
UCM configurations have not been updated to make use of the shared
bytcr/PlatfromEnableSeq.conf sequence. This commit deletes those
command sequences and loads the shared component directly.

Signed-off-by: Russell Parker <russell.parker7@gmail.com>

diff --git a/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
index 78bf9823..61848358 100644
--- a/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
+++ b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
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
+		<platforms/bytcr/PlatformEnableSeq.conf>
 
 		# Output Configuration
 		cset "name='DAC1 L Mux' IF1 DAC"
diff --git a/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf b/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf
index 8cc9c7f2..d043f685 100644
--- a/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf
+++ b/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf
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
+		<platforms/bytcr/PlatformEnableSeq.conf>
 
 		# Output Configuration
 		cset "name='DAC1 L Mux' IF1 DAC"
diff --git a/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
index 7a0cd51c..c4452a4e 100644
--- a/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
+++ b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
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
+		<platforms/bytcr/PlatformEnableSeq.conf>
 
 		# Output Configuration
 		cset "name='DAC1 L Mux' IF1 DAC"
diff --git a/src/conf/ucm/platforms/bytcr/PlatformEnableSeq.conf b/src/conf/ucm/platforms/bytcr/PlatformEnableSeq.conf
index b5ee2b41..6f5e899c 100644
--- a/src/conf/ucm/platforms/bytcr/PlatformEnableSeq.conf
+++ b/src/conf/ucm/platforms/bytcr/PlatformEnableSeq.conf
@@ -29,7 +29,7 @@ cset "name='pcm0_in Gain 0 Volume' 0"
 cset "name='pcm1_in Gain 0 Switch' off"
 cset "name='pcm1_in Gain 0 Volume' 0%"
 
-# codec0_out settings (used if SSP2 is connected)
+# codec0_out settings (used if SSP2 is connected to aif1)
 cset "name='codec_out0 mix 0 codec_in0 Switch' off"
 cset "name='codec_out0 mix 0 codec_in1 Switch' off"
 cset "name='codec_out0 mix 0 media_loop1_in Switch' off"
@@ -40,7 +40,7 @@ cset "name='codec_out0 mix 0 sprot_loop_in Switch' off"
 cset "name='codec_out0 Gain 0 Switch' on"
 cset "name='codec_out0 Gain 0 Volume' 0"
 
-# modem_out settings (used if SSP0 is connected)
+# modem_out settings (used if SSP0 is connected to aif2)
 cset "name='modem_out mix 0 codec_in0 Switch' off"
 cset "name='modem_out mix 0 codec_in1 Switch' off"
 cset "name='modem_out mix 0 media_loop1_in Switch' off"
-- 
2.20.1
