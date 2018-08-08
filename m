From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 06/13] conf/ucm: bytcr-rt5651: Use generic
	SSP enable + disable sequence, support SSP0
Date: Wed,  8 Aug 2018 11:05:36 +0200
Message-ID: <20180808090543.15181-6-hdegoede@redhat.com>
References: <20180808090543.15181-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id E7B9426786A
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2018 11:05:50 +0200 (CEST)
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

Use the generic SSP enable sequence from bytcr/PlatformEnableSeq.conf,
for boards using SSP2 this is identical the code it replaces and this
adds support for boards using SSP0.

This fixes sound not working on Bay Trail CR tablets with a rt5651 codec.

This commit also calls the generic disable sequence on shutdown
(this is new).

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 configure.ac                                |   1 +
 src/conf/ucm/Makefile.am                    |   1 +
 src/conf/ucm/bytcr-rt5651/HiFi.conf         |   5 +-
 src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf | 136 --------------------
 src/conf/ucm/rt5651/EnableSeq.conf          |  46 +++++++
 src/conf/ucm/rt5651/Makefile.am             |   4 +
 6 files changed, 55 insertions(+), 138 deletions(-)
 create mode 100644 src/conf/ucm/rt5651/EnableSeq.conf
 create mode 100644 src/conf/ucm/rt5651/Makefile.am

diff --git a/configure.ac b/configure.ac
index adc654e2..85a6be80 100644
--- a/configure.ac
+++ b/configure.ac
@@ -747,6 +747,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/PAZ00/Makefile \
 	  src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/Makefile \
 	  src/conf/ucm/rt5640/Makefile \
+	  src/conf/ucm/rt5651/Makefile \
 	  src/conf/ucm/SDP4430/Makefile \
 	  src/conf/ucm/skylake-rt286/Makefile \
 	  src/conf/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR/Makefile \
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 1e51f73e..669e98d5 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -29,6 +29,7 @@ PandaBoardES \
 PAZ00 \
 PIPO-W2S-Defaultstring-CherryTrailCR \
 rt5640 \
+rt5651 \
 SDP4430 \
 skylake-rt286 \
 TECLAST-X80Pro-Defaultstring-CherryTrailCR \
diff --git a/src/conf/ucm/bytcr-rt5651/HiFi.conf b/src/conf/ucm/bytcr-rt5651/HiFi.conf
index 42fa2c9a..fd878f4a 100644
--- a/src/conf/ucm/bytcr-rt5651/HiFi.conf
+++ b/src/conf/ucm/bytcr-rt5651/HiFi.conf
@@ -3,12 +3,13 @@
 SectionVerb {
 	EnableSequence [
 		cdev "hw:bytcrrt5651"
-		exec "echo HiFi enable sequence"
+		<bytcr/PlatformEnableSeq.conf>
+		<rt5651/EnableSeq.conf>
 	]
 
 	DisableSequence [
 		cdev "hw:bytcrrt5651"
-		exec "echo HiFi disable sequence"
+		<bytcr/PlatformDisableSeq.conf>
 	]
 
 	Value {
diff --git a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
index d3148b3d..45889d82 100644
--- a/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
+++ b/src/conf/ucm/bytcr-rt5651/bytcr-rt5651.conf
@@ -7,140 +7,4 @@ SectionUseCase."HiFi" {
 
 SectionDefaults [
 	cdev "hw:bytcrrt5651"
-
-	# media mixer settings
-	#   compress
-	cset "name='media0_in Gain 0 Switch' on"
-	cset "name='media0_in Gain 0 Volume' 0"
-	#   normal
-	cset "name='media1_in Gain 0 Switch' on"
-	cset "name='media1_in Gain 0 Volume' 0"
-	#   swm loopback
-	cset "name='media2_in Gain 0 Switch' off"
-	cset "name='media2_in Gain 0 Volume' 0%"
-	#   deep buffer
-	cset "name='media3_in Gain 0 Switch' on"
-	cset "name='media3_in Gain 0 Volume' 0"
-	cset "name='media0_out mix 0 media0_in Switch' on"
-	cset "name='media0_out mix 0 media1_in Switch' on"
-	cset "name='media0_out mix 0 media2_in Switch' off"
-	cset "name='media0_out mix 0 media3_in Switch' on"
-	cset "name='media1_out mix 0 media0_in Switch' off"
-	cset "name='media1_out mix 0 media1_in Switch' off"
-	cset "name='media1_out mix 0 media2_in Switch' off"
-	cset "name='media1_out mix 0 media3_in Switch' off"
-	cset "name='pcm0_in Gain 0 Switch' on"
-	cset "name='pcm0_in Gain 0 Volume' 0"
-	cset "name='pcm1_in Gain 0 Switch' off"
-	cset "name='pcm1_in Gain 0 Volume' 0%"
-
-	# codec0_out settings
-	cset "name='codec_out0 mix 0 codec_in0 Switch' off"
-	cset "name='codec_out0 mix 0 codec_in1 Switch' off"
-	cset "name='codec_out0 mix 0 media_loop1_in Switch' off"
-	cset "name='codec_out0 mix 0 media_loop2_in Switch' off"
-	cset "name='codec_out0 mix 0 pcm0_in Switch' on"
-	cset "name='codec_out0 mix 0 pcm1_in Switch' off"
-	cset "name='codec_out0 mix 0 sprot_loop_in Switch' off"
-	cset "name='codec_out0 Gain 0 Switch' on"
-	cset "name='codec_out0 Gain 0 Volume' 0"
-
-	# input settings
-	# pcm1_out settings
-	cset "name='codec_in0 Gain 0 Switch' on"
-	cset "name='codec_in0 Gain 0 Volume' 0"
-	cset "name='pcm1_out mix 0 codec_in0 Switch' on"
-	cset "name='pcm1_out mix 0 codec_in1 Switch' off"
-	cset "name='pcm1_out mix 0 media_loop1_in Switch' off"
-	cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
-	cset "name='pcm1_out mix 0 pcm0_in Switch' off"
-	cset "name='pcm1_out mix 0 pcm1_in Switch' off"
-	cset "name='pcm1_out mix 0 sprot_loop_in Switch' off"
-	cset "name='pcm1_out Gain 0 Switch' on"
-	cset "name='pcm1_out Gain 0 Volume' 0"
-
-	# disable codec_out1
-	cset "name='codec_out1 mix 0 codec_in0 Switch' off"
-	cset "name='codec_out1 mix 0 codec_in1 Switch' off"
-	cset "name='codec_out1 mix 0 media_loop1_in Switch' off"
-	cset "name='codec_out1 mix 0 media_loop2_in Switch' off"
-	cset "name='codec_out1 mix 0 pcm0_in Switch' off"
-	cset "name='codec_out1 mix 0 pcm1_in Switch' off"
-	cset "name='codec_out1 mix 0 sprot_loop_in Switch' off"
-	cset "name='codec_out1 Gain 0 Switch' off"
-	cset "name='codec_out1 Gain 0 Volume' 0%"
-
-	# disable codec_in1
-	cset "name='codec_in1 Gain 0 Switch' off"
-	cset "name='codec_in1 Gain 0 Volume' 0%"
-
-	# disable all loops
-	cset "name='media_loop1_out mix 0 codec_in0 Switch' off"
-	cset "name='media_loop1_out mix 0 codec_in1 Switch' off"
-	cset "name='media_loop1_out mix 0 media_loop1_in Switch' off"
-	cset "name='media_loop1_out mix 0 media_loop2_in Switch' off"
-	cset "name='media_loop1_out mix 0 pcm0_in Switch' off"
-	cset "name='media_loop1_out mix 0 pcm1_in Switch' off"
-	cset "name='media_loop1_out mix 0 sprot_loop_in Switch' off"
-	cset "name='media_loop2_out mix 0 codec_in0 Switch' off"
-	cset "name='media_loop2_out mix 0 codec_in1 Switch' off"
-	cset "name='media_loop2_out mix 0 media_loop1_in Switch' off"
-	cset "name='media_loop2_out mix 0 media_loop2_in Switch' off"
-	cset "name='media_loop2_out mix 0 pcm0_in Switch' off"
-	cset "name='media_loop2_out mix 0 pcm1_in Switch' off"
-	cset "name='media_loop2_out mix 0 sprot_loop_in Switch' off"
-	cset "name='sprot_loop_out mix 0 codec_in0 Switch' off"
-	cset "name='sprot_loop_out mix 0 codec_in1 Switch' off"
-	cset "name='sprot_loop_out mix 0 media_loop1_in Switch' off"
-	cset "name='sprot_loop_out mix 0 media_loop2_in Switch' off"
-	cset "name='sprot_loop_out mix 0 pcm0_in Switch' off"
-	cset "name='sprot_loop_out mix 0 pcm1_in Switch' off"
-	cset "name='sprot_loop_out mix 0 sprot_loop_in Switch' off"
-
-	# default state
-	cset "name='HPO MIX DAC1 Switch' on"
-	cset "name='HPO MIX HPVOL Switch' off"
-	cset "name='HPO L Playback Switch' off"
-	cset "name='HPO R Playback Switch' off"
-	cset "name='HPOVOL L Switch' on"
-	cset "name='HPOVOL R Switch' on"
-	cset "name='LOUT MIX DAC L1 Switch' on"
-	cset "name='LOUT MIX DAC R1 Switch' on"
-	cset "name='IN1 Boost' 1"
-	cset "name='IN2 Boost' 1"
-	cset "name='IF1 ASRC Switch' on"
-	cset "name='LOUT L Playback Switch' off"
-	cset "name='LOUT R Playback Switch' off"
-	cset "name='Stereo DAC MIXL DAC L1 Switch' on"
-	cset "name='Stereo DAC MIXR DAC R1 Switch' on"
-	cset "name='Stereo1 ADC MIXR ADC1 Switch' on"
-	cset "name='Stereo1 ADC MIXR ADC2 Switch' on"
-	cset "name='Stereo2 ADC MIXL ADC1 Switch' on"
-	cset "name='Stereo2 ADC MIXL ADC2 Switch' on"
-	cset "name='Stereo2 ADC MIXR ADC1 Switch' on"
-	cset "name='Stereo2 ADC MIXR ADC2 Switch' on"
-	cset "name='Headphone Switch' off"
-	cset "name='Speaker Switch' off"
-
-	# volumes for 0dB
-	cset "name='OUT Playback Volume' 31"
-	cset "name='HP Playback Volume' 31"
-	cset "name='IN Capture Volume' 23"
-	cset "name='ADC Capture Volume' 47"
-	cset "name='DAC1 Playback Volume' 175"
-
-	# input
-	cset "name='Stereo1 ADC L1 Mux' ADC"
-	cset "name='Stereo1 ADC R1 Mux' ADC"
-	cset "name='Stereo1 ADC MIXL ADC1 Switch' on"
-	cset "name='Stereo1 ADC MIXR ADC1 Switch' on"
-	cset "name='RECMIXL BST1 Switch' off"
-	cset "name='RECMIXR BST1 Switch' off"
-	cset "name='RECMIXL BST3 Switch' off"
-	cset "name='RECMIXR BST3 Switch' off"
-	cset "name='RECMIXL BST2 Switch' off"
-	cset "name='RECMIXR BST2 Switch' off"
-	cset "name='Headset Mic Switch' off"
-	cset "name='Internal Mic Switch' off"
-	cset "name='Line In Switch' off"
 ]
diff --git a/src/conf/ucm/rt5651/EnableSeq.conf b/src/conf/ucm/rt5651/EnableSeq.conf
new file mode 100644
index 00000000..3ef9afc0
--- /dev/null
+++ b/src/conf/ucm/rt5651/EnableSeq.conf
@@ -0,0 +1,46 @@
+# default state
+cset "name='HPO MIX DAC1 Switch' on"
+cset "name='HPO MIX HPVOL Switch' off"
+cset "name='HPO L Playback Switch' off"
+cset "name='HPO R Playback Switch' off"
+cset "name='HPOVOL L Switch' on"
+cset "name='HPOVOL R Switch' on"
+cset "name='LOUT MIX DAC L1 Switch' on"
+cset "name='LOUT MIX DAC R1 Switch' on"
+cset "name='IN1 Boost' 1"
+cset "name='IN2 Boost' 1"
+cset "name='IF1 ASRC Switch' on"
+cset "name='LOUT L Playback Switch' off"
+cset "name='LOUT R Playback Switch' off"
+cset "name='Stereo DAC MIXL DAC L1 Switch' on"
+cset "name='Stereo DAC MIXR DAC R1 Switch' on"
+cset "name='Stereo1 ADC MIXR ADC1 Switch' on"
+cset "name='Stereo1 ADC MIXR ADC2 Switch' on"
+cset "name='Stereo2 ADC MIXL ADC1 Switch' on"
+cset "name='Stereo2 ADC MIXL ADC2 Switch' on"
+cset "name='Stereo2 ADC MIXR ADC1 Switch' on"
+cset "name='Stereo2 ADC MIXR ADC2 Switch' on"
+cset "name='Headphone Switch' off"
+cset "name='Speaker Switch' off"
+
+# volumes for 0dB
+cset "name='OUT Playback Volume' 31"
+cset "name='HP Playback Volume' 31"
+cset "name='IN Capture Volume' 23"
+cset "name='ADC Capture Volume' 47"
+cset "name='DAC1 Playback Volume' 175"
+
+# input
+cset "name='Stereo1 ADC L1 Mux' ADC"
+cset "name='Stereo1 ADC R1 Mux' ADC"
+cset "name='Stereo1 ADC MIXL ADC1 Switch' on"
+cset "name='Stereo1 ADC MIXR ADC1 Switch' on"
+cset "name='RECMIXL BST1 Switch' off"
+cset "name='RECMIXR BST1 Switch' off"
+cset "name='RECMIXL BST3 Switch' off"
+cset "name='RECMIXR BST3 Switch' off"
+cset "name='RECMIXL BST2 Switch' off"
+cset "name='RECMIXR BST2 Switch' off"
+cset "name='Headset Mic Switch' off"
+cset "name='Internal Mic Switch' off"
+cset "name='Line In Switch' off"
diff --git a/src/conf/ucm/rt5651/Makefile.am b/src/conf/ucm/rt5651/Makefile.am
new file mode 100644
index 00000000..8a22159c
--- /dev/null
+++ b/src/conf/ucm/rt5651/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/rt5651
+ucm_DATA = EnableSeq.conf
+EXTRA_DIST = $(ucm_DATA)
-- 
2.18.0
