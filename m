From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ucm: Add ucm files for DB820c board
Date: Tue, 29 Jan 2019 10:48:28 +0000
Message-ID: <20190129104828.24728-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by alsa0.perex.cz (Postfix) with ESMTP id D5B1826749A
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 11:48:39 +0100 (CET)
Received: by mail-wr1-f68.google.com with SMTP id t6so21437203wrr.12
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 02:48:39 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

DB820c board is based of MSM8996 Qualcomm SoC, which has support for both
Digital and Analog audio. Digital audio is over HDMI and analog is over
WCD9335 codec via SLIMbus.

Board itself has HDMI port, a 3.5mm audio Jack and an Audio expansion
connector.
This patch adds support for HDMI port and 3.5mm jack.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 configure.ac                    |   1 +
 src/conf/ucm/DB820c/DB820c.conf |   9 +++
 src/conf/ucm/DB820c/HDMI        |  37 +++++++++++
 src/conf/ucm/DB820c/HiFi        | 110 ++++++++++++++++++++++++++++++++
 src/conf/ucm/DB820c/Makefile.am |   4 ++
 src/conf/ucm/Makefile.am        |   1 +
 6 files changed, 162 insertions(+)
 create mode 100644 src/conf/ucm/DB820c/DB820c.conf
 create mode 100644 src/conf/ucm/DB820c/HDMI
 create mode 100644 src/conf/ucm/DB820c/HiFi
 create mode 100644 src/conf/ucm/DB820c/Makefile.am

diff --git a/configure.ac b/configure.ac
index a0c346ef..e9e1a369 100644
--- a/configure.ac
+++ b/configure.ac
@@ -747,6 +747,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/Makefile \
 	  src/conf/ucm/DAISY-I2S/Makefile \
 	  src/conf/ucm/DB410c/Makefile \
+	  src/conf/ucm/DB820c/Makefile \
 	  src/conf/ucm/Dell-WD15-Dock/Makefile \
 	  src/conf/ucm/GoogleNyan/Makefile \
 	  src/conf/ucm/gpd-win-pocket-rt5645/Makefile \
diff --git a/src/conf/ucm/DB820c/DB820c.conf b/src/conf/ucm/DB820c/DB820c.conf
new file mode 100644
index 00000000..58b7ff4e
--- /dev/null
+++ b/src/conf/ucm/DB820c/DB820c.conf
@@ -0,0 +1,9 @@
+SectionUseCase."HiFi" {
+	File "HiFi"
+	Comment "HiFi quality Music."
+}
+
+SectionUseCase."HDMI" {
+	File "HDMI"
+	Comment "HDMI output."
+}
diff --git a/src/conf/ucm/DB820c/HDMI b/src/conf/ucm/DB820c/HDMI
new file mode 100644
index 00000000..39b28692
--- /dev/null
+++ b/src/conf/ucm/DB820c/HDMI
@@ -0,0 +1,37 @@
+# Use case configuration for DB820c board.
+# Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+SectionVerb {
+        EnableSequence [
+			cdev "hw:0"
+			cset "name='HDMI Mixer MultiMedia1' 1"
+        ]
+
+        DisableSequence [
+			cdev "hw:0"
+			cset "name='HDMI Mixer MultiMedia1' 0"
+		]
+        Value {
+                TQ "HiFi"
+                PlaybackPCM "plughw:0,0"
+        }
+}
+
+SectionDevice."HDMI-stereo" {
+        #Name "HDMI-stereo"
+        Comment "HDMI Digital Stereo Output"
+
+        EnableSequence [
+			cdev "hw:0"
+			cset "name='HDMI Mixer MultiMedia1' 1"
+        ]
+
+        DisableSequence [
+			cdev "hw:0"
+			cset "name='HDMI Mixer MultiMedia1' 0"
+        ]
+
+        Value {
+                PlaybackChannels "2"
+        }
+}
diff --git a/src/conf/ucm/DB820c/HiFi b/src/conf/ucm/DB820c/HiFi
new file mode 100644
index 00000000..4457329f
--- /dev/null
+++ b/src/conf/ucm/DB820c/HiFi
@@ -0,0 +1,110 @@
+# Use case configuration for DB820c board.
+# Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+SectionVerb {
+
+	EnableSequence [
+		cdev "hw:0"
+		cset "name='SLIM RX0 MUX' ZERO"
+		cset "name='SLIM RX1 MUX' ZERO"
+		cset "name='SLIM RX2 MUX' ZERO"
+		cset "name='SLIM RX3 MUX' ZERO"
+		cset "name='SLIM RX4 MUX' ZERO"
+		cset "name='SLIM RX5 MUX' AIF4_PB"
+		cset "name='SLIM RX6 MUX' AIF4_PB"
+		cset "name='SLIM RX7 MUX' ZERO"
+		cset "name='RX INT1_2 MUX' RX5"
+		cset "name='RX INT2_2 MUX' RX6"
+		## gain to  0dB
+		cset "name='RX5 Digital Volume' 68"
+		## gain to  0dB
+		cset "name='RX6 Digital Volume' 68"
+		cset "name='SLIMBUS_6_RX Audio Mixer MultiMedia2' 1"
+		cset "name='MultiMedia3 Mixer SLIMBUS_0_TX' 1"
+		cset "name='RX INT1 DEM MUX' CLSH_DSM_OUT"
+		cset "name='RX INT2 DEM MUX' CLSH_DSM_OUT"
+		cset "name='AIF1_CAP Mixer SLIM TX0' 1"
+		cset "name='SLIM TX0 MUX' DEC0"
+		cset "name='ADC2 Volume' 12"
+		cset "name='ADC MUX0' AMIC"
+		cset "name='AMIC MUX0' ADC2"
+	]
+
+	DisableSequence [
+                cdev "hw:0"
+		cset "name='SLIMBUS_6_RX Audio Mixer MultiMedia2' 0"
+		cset "name='MultiMedia3 Mixer SLIMBUS_0_TX' 0"
+	]
+
+	# ALSA PCM
+	Value {
+		# ALSA PCM device for HiFi
+		PlaybackPCM "plughw:0,1"
+		CapturePCM "plughw:0,2"
+	}
+}
+
+SectionDevice."Headphones" {
+	Comment "Headphones playback"
+
+	EnableSequence [
+		cdev "hw:0"
+		cset "name='SLIM RX0 MUX' ZERO"
+		cset "name='SLIM RX1 MUX' ZERO"
+		cset "name='SLIM RX2 MUX' ZERO"
+		cset "name='SLIM RX3 MUX' ZERO"
+		cset "name='SLIM RX4 MUX' ZERO"
+		cset "name='SLIM RX5 MUX' AIF4_PB"
+		cset "name='SLIM RX6 MUX' AIF4_PB"
+		cset "name='SLIM RX7 MUX' ZERO"
+		cset "name='RX INT1_2 MUX' RX5"
+		cset "name='RX INT2_2 MUX' RX6"
+		## gain to  0dB
+		cset "name='RX5 Digital Volume' 68"
+		## gain to  0dB
+		cset "name='RX6 Digital Volume' 68"
+		cset "name='SLIMBUS_6_RX Audio Mixer MultiMedia2' 1"
+		cset "name='RX INT1 DEM MUX' CLSH_DSM_OUT"
+		cset "name='RX INT2 DEM MUX' CLSH_DSM_OUT"
+	]
+
+	DisableSequence [
+		cdev "hw:0"
+		cset "name='RX5 Digital Volume' 0"
+		cset "name='RX6 Digital Volume' 0"
+		cset "name='SLIM RX5 MUX' ZERO"
+		cset "name='SLIM RX6 MUX' ZERO"
+		cset "name='SLIMBUS_6_RX Audio Mixer MultiMedia2' 0"
+	]
+
+	Value {
+		PlaybackChannels "2"
+	}
+}
+
+SectionDevice."Handset" {
+	Comment "Headset Microphone"
+
+	EnableSequence [
+		cdev "hw:0"
+		cset "name='MultiMedia3 Mixer SLIMBUS_0_TX' 1"
+		cset "name='AIF1_CAP Mixer SLIM TX0' 1"
+		cset "name='SLIM TX0 MUX' DEC0"
+		cset "name='ADC2 Volume' 12"
+		cset "name='ADC MUX0' AMIC"
+		cset "name='AMIC MUX0' ADC2"
+	]
+
+	DisableSequence [
+		cdev "hw:0"
+		cset "name='MultiMedia3 Mixer SLIMBUS_0_TX' 0"
+		cset "name='AIF1_CAP Mixer SLIM TX0' 0"
+		cset "name='AMIC MUX0' ZERO"
+		cset "name='SLIM TX0 MUX' ZERO"
+		cset "name='ADC2 Volume' 0"
+	]
+
+	Value {
+		CaptureChannels "1"
+	}
+}
diff --git a/src/conf/ucm/DB820c/Makefile.am b/src/conf/ucm/DB820c/Makefile.am
new file mode 100644
index 00000000..16e985e5
--- /dev/null
+++ b/src/conf/ucm/DB820c/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/DB820c
+ucm_DATA = DB820c.conf HDMI HiFi
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index ee850ee6..e9f88ed6 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -31,6 +31,7 @@ chtrt5650 \
 cube-i1_TF-Defaultstring-CherryTrailCR \
 DAISY-I2S \
 DB410c \
+DB820c \
 Dell-WD15-Dock \
 GoogleNyan \
 gpd-win-pocket-rt5645 \
-- 
2.20.1
