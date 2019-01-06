From: russell.parker7@gmail.com
Subject: [PATCH ucm/conf: 2/5] Create shared {En,
	Dis}ableSeq.conf components for rt5645 variants
Date: Sat,  5 Jan 2019 19:47:12 -0800
Message-ID: <20190106034715.21045-3-russell.parker7@gmail.com>
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

Factor out the common enable and disable sequences used
in rt5645 variants, including the rt5650. Move the sequences
into a new compoent directory codecs/rt5645-common/ along with
a Makefile.

Some lines like
    cset "name='Stereo1 ADC1 Mux' 1"
and
    cset "name='I2S2 Func Switch' on"
are not set set in the chtrt5650 UCM sequences and thus are not present
in the new component, in order to maximize reuse.

Signed-off-by: Russell Parker <russell.parker7@gmail.com>

diff --git a/configure.ac b/configure.ac
index a0392bfe..307e7fc7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -761,6 +761,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/codecs/Makefile \
 	  src/conf/ucm/codecs/nau8824/Makefile \
 	  src/conf/ucm/codecs/rt5640/Makefile \
+	  src/conf/ucm/codecs/rt5645-common/Makefile \
 	  src/conf/ucm/codecs/rt5651/Makefile \
 	  src/conf/ucm/platforms/Makefile \
 	  src/conf/ucm/platforms/bytcr/Makefile \
diff --git a/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
index 61848358..46508766 100644
--- a/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
+++ b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
@@ -12,53 +12,9 @@ SectionVerb {
 		cdev "hw:chtrt5645"
 
 		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5645-common/EnableSeq.conf>
 
-		# Output Configuration
-		cset "name='DAC1 L Mux' IF1 DAC"
-		cset "name='DAC1 R Mux' IF1 DAC"
-		cset "name='DAC1 MIXL DAC1 Switch' 1"
-		cset "name='DAC1 MIXR DAC1 Switch' 1"
-		cset "name='Stereo DAC MIXL DAC L1 Switch' 1"
-		cset "name='Stereo DAC MIXR DAC R1 Switch' 1"
-
-		cset "name='DAC L2 Mux' IF2 DAC"
-		cset "name='DAC R2 Mux' IF2 DAC"
-		cset "name='Mono DAC MIXL DAC L2 Switch' on"
-		cset "name='Mono DAC MIXR DAC R2 Switch' on"
-		cset "name='DAC2 Playback Switch' on"
-
-		cset "name='HPOVOL MIXL DAC1 Switch' on"
-		cset "name='HPOVOL MIXR DAC1 Switch' on"
-		cset "name='HPOVOL MIXL DAC2 Switch' on"
-		cset "name='HPOVOL MIXR DAC2 Switch' on"
-		cset "name='HPO MIX HPVOL Switch' on"
-		cset "name='HPOVOL L Switch' on"
-		cset "name='HPOVOL R Switch' on"
-
-		cset "name='SPK MIXL DAC L1 Switch' on"
-		cset "name='SPK MIXR DAC R1 Switch' on"
-		cset "name='SPK MIXL DAC L2 Switch' on"
-		cset "name='SPK MIXR DAC R2 Switch' on"
-		cset "name='SPOL MIX SPKVOL L Switch' on"
-		cset "name='SPOR MIX SPKVOL R Switch' on"
-		cset "name='SPKVOL L Switch' on"
-		cset "name='SPKVOL R Switch' on"
-
-		# Input Configuration
-		cset "name='Stereo1 DMIC Mux' 0"
 		cset "name='Stereo1 ADC1 Mux' 1"
-		cset "name='Stereo1 ADC2 Mux' 1"
-		cset "name='ADC Capture Switch' on"
-		# 55/63
-		cset "name='ADC Capture Volume' 55"
-		# set ADC Boost to 0/3, higher vals cause a lot of white noise
-		cset "name='ADC Boost Capture Volume' 0"
-		# 55/63
-		cset "name='Mono ADC Capture Volume' 55"
-		# 0/3
-		cset "name='Mono ADC Boost Capture Volume' 0"
-		# 27/31
-		cset "name='IN Capture Volume' 27"
 		cset "name='I2S2 Func Switch' on"
 		# 3/12 the headphone mic tends to be quite loud
 		cset "name='IN1 Boost' 3"
@@ -69,21 +25,7 @@ SectionVerb {
 	DisableSequence [
 		cdev "hw:chtrt5645"
 
-		# Disable audio output path
-		cset "name='codec_out1 mix 0 pcm0_in Switch' off"
-		cset "name='media0_out mix 0 media1_in Switch' off"
-
-		cset "name='media1_in Gain 0 Switch' off"
-		cset "name='pcm0_in Gain 0 Switch' off"
-		cset "name='codec_out1 Gain 0 Switch' off"
-
-		# Disable audio input path
-		cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
-		cset "name='media_loop2_out mix 0 codec_in0 Switch' off"
-
-		cset "name='media_loop2_out Gain 0 Switch' off"
-		cset "name='pcm1_out Gain 0 Switch' off"
-		cset "name='codec_in0 Gain 0 Switch' off"
+		<codecs/rt5645-common/DisableSeq.conf>
 	]
 }
 
diff --git a/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf b/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf
index d043f685..c16cceac 100644
--- a/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf
+++ b/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf
@@ -12,53 +12,9 @@ SectionVerb {
 		cdev "hw:chtrt5645"
 
 		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5645-common/EnableSeq.conf>
 
-		# Output Configuration
-		cset "name='DAC1 L Mux' IF1 DAC"
-		cset "name='DAC1 R Mux' IF1 DAC"
-		cset "name='DAC1 MIXL DAC1 Switch' 1"
-		cset "name='DAC1 MIXR DAC1 Switch' 1"
-		cset "name='Stereo DAC MIXL DAC L1 Switch' 1"
-		cset "name='Stereo DAC MIXR DAC R1 Switch' 1"
-
-		cset "name='DAC L2 Mux' IF2 DAC"
-		cset "name='DAC R2 Mux' IF2 DAC"
-		cset "name='Mono DAC MIXL DAC L2 Switch' on"
-		cset "name='Mono DAC MIXR DAC R2 Switch' on"
-		cset "name='DAC2 Playback Switch' on"
-
-		cset "name='HPOVOL MIXL DAC1 Switch' on"
-		cset "name='HPOVOL MIXR DAC1 Switch' on"
-		cset "name='HPOVOL MIXL DAC2 Switch' on"
-		cset "name='HPOVOL MIXR DAC2 Switch' on"
-		cset "name='HPO MIX HPVOL Switch' on"
-		cset "name='HPOVOL L Switch' on"
-		cset "name='HPOVOL R Switch' on"
-
-		cset "name='SPK MIXL DAC L1 Switch' on"
-		cset "name='SPK MIXR DAC R1 Switch' on"
-		cset "name='SPK MIXL DAC L2 Switch' on"
-		cset "name='SPK MIXR DAC R2 Switch' on"
-		cset "name='SPOL MIX SPKVOL L Switch' on"
-		cset "name='SPOR MIX SPKVOL R Switch' on"
-		cset "name='SPKVOL L Switch' on"
-		cset "name='SPKVOL R Switch' on"
-
-		# Input Configuration
-		cset "name='Stereo1 DMIC Mux' 0"
 		cset "name='Stereo1 ADC1 Mux' 1"
-		cset "name='Stereo1 ADC2 Mux' 1"
-		cset "name='ADC Capture Switch' on"
-		# 55/63
-		cset "name='ADC Capture Volume' 55"
-		# set ADC Boost to 0/3, higher vals cause a lot of white noise
-		cset "name='ADC Boost Capture Volume' 0"
-		# 55/63
-		cset "name='Mono ADC Capture Volume' 55"
-		# 0/3
-		cset "name='Mono ADC Boost Capture Volume' 0"
-		# 27/31
-		cset "name='IN Capture Volume' 27"
 		cset "name='I2S2 Func Switch' on"
 		# 3/12 the headphone mic tends to be quite loud
 		cset "name='IN1 Boost' 3"
@@ -69,21 +25,7 @@ SectionVerb {
 	DisableSequence [
 		cdev "hw:chtrt5645"
 
-		# Disable audio output path
-		cset "name='codec_out1 mix 0 pcm0_in Switch' off"
-		cset "name='media0_out mix 0 media1_in Switch' off"
-
-		cset "name='media1_in Gain 0 Switch' off"
-		cset "name='pcm0_in Gain 0 Switch' off"
-		cset "name='codec_out1 Gain 0 Switch' off"
-
-		# Disable audio input path
-		cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
-		cset "name='media_loop2_out mix 0 codec_in0 Switch' off"
-
-		cset "name='media_loop2_out Gain 0 Switch' off"
-		cset "name='pcm1_out Gain 0 Switch' off"
-		cset "name='codec_in0 Gain 0 Switch' off"
+		<codecs/rt5645-common/DisableSeq.conf>
 	]
 }
 
diff --git a/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
index c4452a4e..45cc5186 100644
--- a/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
+++ b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
@@ -12,53 +12,9 @@ SectionVerb {
 		cdev "hw:chtrt5645"
 
 		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5645-common/EnableSeq.conf>
 
-		# Output Configuration
-		cset "name='DAC1 L Mux' IF1 DAC"
-		cset "name='DAC1 R Mux' IF1 DAC"
-		cset "name='DAC1 MIXL DAC1 Switch' 1"
-		cset "name='DAC1 MIXR DAC1 Switch' 1"
-		cset "name='Stereo DAC MIXL DAC L1 Switch' 1"
-		cset "name='Stereo DAC MIXR DAC R1 Switch' 1"
-
-		cset "name='DAC L2 Mux' IF2 DAC"
-		cset "name='DAC R2 Mux' IF2 DAC"
-		cset "name='Mono DAC MIXL DAC L2 Switch' on"
-		cset "name='Mono DAC MIXR DAC R2 Switch' on"
-		cset "name='DAC2 Playback Switch' on"
-
-		cset "name='HPOVOL MIXL DAC1 Switch' on"
-		cset "name='HPOVOL MIXR DAC1 Switch' on"
-		cset "name='HPOVOL MIXL DAC2 Switch' on"
-		cset "name='HPOVOL MIXR DAC2 Switch' on"
-		cset "name='HPO MIX HPVOL Switch' on"
-		cset "name='HPOVOL L Switch' on"
-		cset "name='HPOVOL R Switch' on"
-
-		cset "name='SPK MIXL DAC L1 Switch' on"
-		cset "name='SPK MIXR DAC R1 Switch' on"
-		cset "name='SPK MIXL DAC L2 Switch' on"
-		cset "name='SPK MIXR DAC R2 Switch' on"
-		cset "name='SPOL MIX SPKVOL L Switch' on"
-		cset "name='SPOR MIX SPKVOL R Switch' on"
-		cset "name='SPKVOL L Switch' on"
-		cset "name='SPKVOL R Switch' on"
-
-		# Input Configuration
-		cset "name='Stereo1 DMIC Mux' 0"
 		cset "name='Stereo1 ADC1 Mux' 1"
-		cset "name='Stereo1 ADC2 Mux' 1"
-		cset "name='ADC Capture Switch' on"
-		# 55/63
-		cset "name='ADC Capture Volume' 55"
-		# set ADC Boost to 0/3, higher vals cause a lot of white noise
-		cset "name='ADC Boost Capture Volume' 0"
-		# 55/63
-		cset "name='Mono ADC Capture Volume' 55"
-		# 0/3
-		cset "name='Mono ADC Boost Capture Volume' 0"
-		# 27/31
-		cset "name='IN Capture Volume' 27"
 		cset "name='I2S2 Func Switch' on"
 		# 3/12 the headphone mic tends to be quite loud
 		cset "name='IN1 Boost' 3"
@@ -69,21 +25,7 @@ SectionVerb {
 	DisableSequence [
 		cdev "hw:chtrt5645"
 
-		# Disable audio output path
-		cset "name='codec_out1 mix 0 pcm0_in Switch' off"
-		cset "name='media0_out mix 0 media1_in Switch' off"
-
-		cset "name='media1_in Gain 0 Switch' off"
-		cset "name='pcm0_in Gain 0 Switch' off"
-		cset "name='codec_out1 Gain 0 Switch' off"
-
-		# Disable audio input path
-		cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
-		cset "name='media_loop2_out mix 0 codec_in0 Switch' off"
-
-		cset "name='media_loop2_out Gain 0 Switch' off"
-		cset "name='pcm1_out Gain 0 Switch' off"
-		cset "name='codec_in0 Gain 0 Switch' off"
+		<codecs/rt5645-common/DisableSeq.conf>
 	]
 }
 
diff --git a/src/conf/ucm/chtrt5645/HiFi.conf b/src/conf/ucm/chtrt5645/HiFi.conf
index 422f3b7e..bc4801d8 100644
--- a/src/conf/ucm/chtrt5645/HiFi.conf
+++ b/src/conf/ucm/chtrt5645/HiFi.conf
@@ -1,4 +1,3 @@
-
 SectionVerb {
 	# ALSA PCM
 	Value {
@@ -13,53 +12,9 @@ SectionVerb {
 		cdev "hw:chtrt5645"
 
 		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5645-common/EnableSeq.conf>
 
-		# Output Configuration
-		cset "name='DAC1 L Mux' IF1 DAC"
-		cset "name='DAC1 R Mux' IF1 DAC"
-		cset "name='DAC1 MIXL DAC1 Switch' 1"
-		cset "name='DAC1 MIXR DAC1 Switch' 1"
-		cset "name='Stereo DAC MIXL DAC L1 Switch' 1"
-		cset "name='Stereo DAC MIXR DAC R1 Switch' 1"
-
-		cset "name='DAC L2 Mux' IF2 DAC"
-		cset "name='DAC R2 Mux' IF2 DAC"
-		cset "name='Mono DAC MIXL DAC L2 Switch' on"
-		cset "name='Mono DAC MIXR DAC R2 Switch' on"
-		cset "name='DAC2 Playback Switch' on"
-
-		cset "name='HPOVOL MIXL DAC1 Switch' on"
-		cset "name='HPOVOL MIXR DAC1 Switch' on"
-		cset "name='HPOVOL MIXL DAC2 Switch' on"
-		cset "name='HPOVOL MIXR DAC2 Switch' on"
-		cset "name='HPO MIX HPVOL Switch' on"
-		cset "name='HPOVOL L Switch' on"
-		cset "name='HPOVOL R Switch' on"
-
-		cset "name='SPK MIXL DAC L1 Switch' on"
-		cset "name='SPK MIXR DAC R1 Switch' on"
-		cset "name='SPK MIXL DAC L2 Switch' on"
-		cset "name='SPK MIXR DAC R2 Switch' on"
-		cset "name='SPOL MIX SPKVOL L Switch' on"
-		cset "name='SPOR MIX SPKVOL R Switch' on"
-		cset "name='SPKVOL L Switch' on"
-		cset "name='SPKVOL R Switch' on"
-
-		# Input Configuration
-		cset "name='Stereo1 DMIC Mux' 0"
 		cset "name='Stereo1 ADC1 Mux' 1"
-		cset "name='Stereo1 ADC2 Mux' 1"
-		cset "name='ADC Capture Switch' on"
-		# 55/63
-		cset "name='ADC Capture Volume' 55"
-		# set ADC Boost to 0/3, higher vals cause a lot of white noise
-		cset "name='ADC Boost Capture Volume' 0"
-		# 55/63
-		cset "name='Mono ADC Capture Volume' 55"
-		# 0/3
-		cset "name='Mono ADC Boost Capture Volume' 0"
-		# 27/31
-		cset "name='IN Capture Volume' 27"
 		cset "name='I2S2 Func Switch' on"
 		# 3/12 the headphone mic tends to be quite loud
 		cset "name='IN1 Boost' 3"
@@ -70,21 +25,7 @@ SectionVerb {
 	DisableSequence [
 		cdev "hw:chtrt5645"
 
-		# Disable audio output path
-		cset "name='codec_out1 mix 0 pcm0_in Switch' off"
-		cset "name='media0_out mix 0 media1_in Switch' off"
-
-		cset "name='media1_in Gain 0 Switch' off"
-		cset "name='pcm0_in Gain 0 Switch' off"
-		cset "name='codec_out1 Gain 0 Switch' off"
-
-		# Disable audio input path
-		cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
-		cset "name='media_loop2_out mix 0 codec_in0 Switch' off"
-
-		cset "name='media_loop2_out Gain 0 Switch' off"
-		cset "name='pcm1_out Gain 0 Switch' off"
-		cset "name='codec_in0 Gain 0 Switch' off"
+		<codecs/rt5645-common/DisableSeq.conf>
 	]
 }
 
diff --git a/src/conf/ucm/chtrt5650/HiFi.conf b/src/conf/ucm/chtrt5650/HiFi.conf
index cc3d64bf..7142dece 100644
--- a/src/conf/ucm/chtrt5650/HiFi.conf
+++ b/src/conf/ucm/chtrt5650/HiFi.conf
@@ -13,73 +13,19 @@ SectionVerb {
 		cdev "hw:chtrt5650"
 
 		<platforms/bytcr/PlatformEnableSeq.conf>
+		<codecs/rt5645-common/EnableSeq.conf>
 
-		# Output Configuration
-		cset "name='DAC1 L Mux' IF1 DAC"
-		cset "name='DAC1 R Mux' IF1 DAC"
-		cset "name='DAC1 MIXL DAC1 Switch' 1"
-		cset "name='DAC1 MIXR DAC1 Switch' 1"
-		cset "name='Stereo DAC MIXL DAC L1 Switch' 1"
-		cset "name='Stereo DAC MIXR DAC R1 Switch' 1"
 		cset "name='Speaker HWEQ' 1,164,237,135,1,165,0,0,1,166,237,135,1,167,0,0,1,192,30,196,1,193,0,0,1,194,30,196,1,195,0,0,1,196,31,180,1,197,0,75,1,198,31,180,1,199,31,180,1,200,0,75,1,201,31,180,0,177,51,224"
 		cset "name='DAC1 Playback Volume' 77,77"
-
 		cset "name='Speaker ClassD Playback Volume' 4"
-
-		cset "name='DAC L2 Mux' IF2 DAC"
-		cset "name='DAC R2 Mux' IF2 DAC"
-		cset "name='Mono DAC MIXL DAC L2 Switch' on"
-		cset "name='Mono DAC MIXR DAC R2 Switch' on"
-		cset "name='DAC2 Playback Switch' on"
-
-		cset "name='HPOVOL MIXL DAC1 Switch' on"
-		cset "name='HPOVOL MIXR DAC1 Switch' on"
-		cset "name='HPOVOL MIXL DAC2 Switch' on"
-		cset "name='HPOVOL MIXR DAC2 Switch' on"
-		cset "name='HPO MIX HPVOL Switch' on"
-		cset "name='HPOVOL L Switch' on"
-		cset "name='HPOVOL R Switch' on"
-
-		cset "name='SPK MIXL DAC L1 Switch' on"
-		cset "name='SPK MIXR DAC R1 Switch' on"
-		cset "name='SPK MIXL DAC L2 Switch' on"
-		cset "name='SPK MIXR DAC R2 Switch' on"
-		cset "name='SPOL MIX SPKVOL L Switch' on"
-		cset "name='SPOR MIX SPKVOL R Switch' on"
-		cset "name='SPKVOL L Switch' on"
-		cset "name='SPKVOL R Switch' on"
-
-		# Input Configuration
-		cset "name='Stereo1 DMIC Mux' 0"
-		cset "name='Stereo1 ADC2 Mux' 1"
-		cset "name='ADC Capture Switch' on"
-		cset "name='ADC Capture Volume' 74"
-		cset "name='ADC Boost Capture Volume' 3"
-		cset "name='Mono ADC Capture Volume' 74"
-		cset "name='Mono ADC Boost Capture Volume' 2"
-		cset "name='IN Capture Volume' 63"
-		cset "name='RT5650 IF1 ADC Mux' 0"
 		cset "name='I2S2 Func Switch' off"
+		cset "name='RT5650 IF1 ADC Mux' 0"
 	]
 
 	DisableSequence [
 		cdev "hw:chtrt5650"
 
-		# Disable audio output path
-		cset "name='codec_out1 mix 0 pcm0_in Switch' off"
-		cset "name='media0_out mix 0 media1_in Switch' off"
-
-		cset "name='media1_in Gain 0 Switch' off"
-		cset "name='pcm0_in Gain 0 Switch' off"
-		cset "name='codec_out1 Gain 0 Switch' off"
-
-		# Disable audio input path
-		cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
-		cset "name='media_loop2_out mix 0 codec_in0 Switch' off"
-
-		cset "name='media_loop2_out Gain 0 Switch' off"
-		cset "name='pcm1_out Gain 0 Switch' off"
-		cset "name='codec_in0 Gain 0 Switch' off"
+		<codecs/rt5645-common/DisableSeq.conf>
 	]
 }
 
diff --git a/src/conf/ucm/codecs/Makefile.am b/src/conf/ucm/codecs/Makefile.am
index 2b374acb..ac1a56dc 100644
--- a/src/conf/ucm/codecs/Makefile.am
+++ b/src/conf/ucm/codecs/Makefile.am
@@ -1,4 +1,5 @@
 SUBDIRS=\
 rt5640 \
+rt5645-common \
 rt5651 \
 nau8824
diff --git a/src/conf/ucm/codecs/rt5645-common/DisableSeq.conf b/src/conf/ucm/codecs/rt5645-common/DisableSeq.conf
new file mode 100644
index 00000000..5127d1ae
--- /dev/null
+++ b/src/conf/ucm/codecs/rt5645-common/DisableSeq.conf
@@ -0,0 +1,15 @@
+# Disable audio output path
+cset "name='codec_out1 mix 0 pcm0_in Switch' off"
+cset "name='media0_out mix 0 media1_in Switch' off"
+
+cset "name='media1_in Gain 0 Switch' off"
+cset "name='pcm0_in Gain 0 Switch' off"
+cset "name='codec_out1 Gain 0 Switch' off"
+
+# Disable audio input path
+cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
+cset "name='media_loop2_out mix 0 codec_in0 Switch' off"
+
+cset "name='media_loop2_out Gain 0 Switch' off"
+cset "name='pcm1_out Gain 0 Switch' off"
+cset "name='codec_in0 Gain 0 Switch' off"
diff --git a/src/conf/ucm/codecs/rt5645-common/EnableSeq.conf b/src/conf/ucm/codecs/rt5645-common/EnableSeq.conf
new file mode 100644
index 00000000..d3ad4cf9
--- /dev/null
+++ b/src/conf/ucm/codecs/rt5645-common/EnableSeq.conf
@@ -0,0 +1,46 @@
+# Output Configuration
+cset "name='DAC1 L Mux' IF1 DAC"
+cset "name='DAC1 R Mux' IF1 DAC"
+cset "name='DAC1 MIXL DAC1 Switch' 1"
+cset "name='DAC1 MIXR DAC1 Switch' 1"
+cset "name='Stereo DAC MIXL DAC L1 Switch' 1"
+cset "name='Stereo DAC MIXR DAC R1 Switch' 1"
+
+cset "name='DAC L2 Mux' IF2 DAC"
+cset "name='DAC R2 Mux' IF2 DAC"
+cset "name='Mono DAC MIXL DAC L2 Switch' on"
+cset "name='Mono DAC MIXR DAC R2 Switch' on"
+cset "name='DAC2 Playback Switch' on"
+
+cset "name='HPOVOL MIXL DAC1 Switch' on"
+cset "name='HPOVOL MIXR DAC1 Switch' on"
+cset "name='HPOVOL MIXL DAC2 Switch' on"
+cset "name='HPOVOL MIXR DAC2 Switch' on"
+cset "name='HPO MIX HPVOL Switch' on"
+cset "name='HPOVOL L Switch' on"
+cset "name='HPOVOL R Switch' on"
+
+cset "name='SPK MIXL DAC L1 Switch' on"
+cset "name='SPK MIXR DAC R1 Switch' on"
+cset "name='SPK MIXL DAC L2 Switch' on"
+cset "name='SPK MIXR DAC R2 Switch' on"
+cset "name='SPOL MIX SPKVOL L Switch' on"
+cset "name='SPOR MIX SPKVOL R Switch' on"
+cset "name='SPKVOL L Switch' on"
+cset "name='SPKVOL R Switch' on"
+
+# Input Configuration
+cset "name='Stereo1 DMIC Mux' 0"
+cset "name='Stereo1 ADC2 Mux' 1"
+cset "name='ADC Capture Switch' on"
+
+# 55/63
+cset "name='ADC Capture Volume' 55"
+# set ADC Boost to 0/3, higher vals cause a lot of white noise
+cset "name='ADC Boost Capture Volume' 0"
+# 55/63
+cset "name='Mono ADC Capture Volume' 55"
+# 0/3
+cset "name='Mono ADC Boost Capture Volume' 0"
+# 27/31
+cset "name='IN Capture Volume' 27"
diff --git a/src/conf/ucm/codecs/rt5645-common/Makefile.am b/src/conf/ucm/codecs/rt5645-common/Makefile.am
new file mode 100644
index 00000000..f351fa37
--- /dev/null
+++ b/src/conf/ucm/codecs/rt5645-common/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/codecs/rt5645-common
+ucm_DATA = DisableSeq.conf EnableSeq.conf
+EXTRA_DIST = $(ucm_DATA)
-- 
2.20.1
