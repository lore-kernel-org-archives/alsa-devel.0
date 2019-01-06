From: russell.parker7@gmail.com
Subject: [PATCH ucm/conf: 5/5] Create device comoponent for
	rt5645 Internal Analog Mic UCM
Date: Sat,  5 Jan 2019 19:47:15 -0800
Message-ID: <20190106034715.21045-6-russell.parker7@gmail.com>
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

Since the Internal Analog Microphone device configuration is
identical for the rt5645 and rt5645 mono speaker UCMs, move
the entire definition to a component.

Signed-off-by: Russell Parker <russell.parker7@gmail.com>

diff --git a/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
index 489390d5..8497fa66 100644
--- a/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
+++ b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
@@ -89,49 +89,7 @@ SectionDevice."Headphones" {
 	]
 }
 
-SectionDevice."Mic".0 {
-	Comment "Internal Analog Microphone"
-
-	Value {
-		CaptureChannels "2"
-		CapturePriority "150"
-	}
-
-	EnableSequence [
-		cdev "hw:chtrt5645"
-
-		cset "name='Int Analog Mic Switch' on"
-
-		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
-		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
-
-		cset "name='Mono ADC MIXL ADC1 Switch' on"
-		cset "name='Mono ADC MIXR ADC1 Switch' on"
-		cset "name='Mono ADC MIXL ADC2 Switch' off"
-		cset "name='Mono ADC MIXR ADC2 Switch' off"
-
-		cset "name='RECMIXL BST2 Switch' on"
-		cset "name='RECMIXR BST2 Switch' on"
-
-	]
-
-	DisableSequence [
-		cdev "hw:chtrt5645"
-
-		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
-		cset "name='Mono ADC MIXL ADC1 Switch' off"
-		cset "name='Mono ADC MIXR ADC1 Switch' off"
-
-		cset "name='RECMIXL BST2 Switch' off"
-		cset "name='RECMIXR BST2 Switch' off"
-
-		cset "name='Int Analog Mic Switch' off"
-	]
-}
-
+<codecs/rt5645-common/AnalogMic.conf>
 
 SectionDevice."HSMic".0 {
 	Comment "Headset Microphone"
diff --git a/src/conf/ucm/chtrt5645/HiFi.conf b/src/conf/ucm/chtrt5645/HiFi.conf
index ac5f60e2..b98ae66f 100644
--- a/src/conf/ucm/chtrt5645/HiFi.conf
+++ b/src/conf/ucm/chtrt5645/HiFi.conf
@@ -81,48 +81,7 @@ SectionDevice."Headphones" {
 	]
 }
 
-SectionDevice."Mic".0 {
-	Comment "Internal Analog Microphone"
-
-	Value {
-		CaptureChannels "2"
-		CapturePriority "150"
-	}
-
-	EnableSequence [
-		cdev "hw:chtrt5645"
-
-		cset "name='Int Analog Mic Switch' on"
-
-		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
-		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
-
-		cset "name='Mono ADC MIXL ADC1 Switch' on"
-		cset "name='Mono ADC MIXR ADC1 Switch' on"
-		cset "name='Mono ADC MIXL ADC2 Switch' off"
-		cset "name='Mono ADC MIXR ADC2 Switch' off"
-
-		cset "name='RECMIXL BST2 Switch' on"
-		cset "name='RECMIXR BST2 Switch' on"
-
-	]
-
-	DisableSequence [
-		cdev "hw:chtrt5645"
-
-		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
-		cset "name='Mono ADC MIXL ADC1 Switch' off"
-		cset "name='Mono ADC MIXR ADC1 Switch' off"
-
-		cset "name='RECMIXL BST2 Switch' off"
-		cset "name='RECMIXR BST2 Switch' off"
-
-		cset "name='Int Analog Mic Switch' off"
-	]
-}
+<codecs/rt5645-common/AnalogMic.conf>
 
 SectionDevice."HSMic".0 {
 	Comment "Headset Microphone"
diff --git a/src/conf/ucm/codecs/rt5645-common/AnalogMic.conf b/src/conf/ucm/codecs/rt5645-common/AnalogMic.conf
new file mode 100644
index 00000000..cbcefa7a
--- /dev/null
+++ b/src/conf/ucm/codecs/rt5645-common/AnalogMic.conf
@@ -0,0 +1,41 @@
+SectionDevice."Mic".0 {
+	Comment "Internal Analog Microphone"
+
+	Value {
+		CaptureChannels "2"
+		CapturePriority "150"
+	}
+
+	EnableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Int Analog Mic Switch' on"
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
+		cset "name='RECMIXL BST2 Switch' on"
+		cset "name='RECMIXR BST2 Switch' on"
+	]
+
+	DisableSequence [
+		cdev "hw:chtrt5645"
+
+		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
+		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
+		cset "name='Mono ADC MIXL ADC1 Switch' off"
+		cset "name='Mono ADC MIXR ADC1 Switch' off"
+
+		cset "name='RECMIXL BST2 Switch' off"
+		cset "name='RECMIXR BST2 Switch' off"
+
+		cset "name='Int Analog Mic Switch' off"
+	]
+}
diff --git a/src/conf/ucm/codecs/rt5645-common/Makefile.am b/src/conf/ucm/codecs/rt5645-common/Makefile.am
index 06403d9b..75924b40 100644
--- a/src/conf/ucm/codecs/rt5645-common/Makefile.am
+++ b/src/conf/ucm/codecs/rt5645-common/Makefile.am
@@ -3,5 +3,5 @@ ucmdir = $(alsaconfigdir)/ucm/codecs/rt5645-common
 ucm_DATA = DisableSeq.conf EnableSeq.conf HeadphonesEnableSeq.conf \
 		   SpeakerEnableSeq.conf DigitalMicDisableSeq.conf \
 		   DigitalMicEnableSeq.conf HSMicDisableSeq.conf \
-		   HSMicEnableSeq.conf
+		   HSMicEnableSeq.conf AnalogMic.conf
 EXTRA_DIST = $(ucm_DATA)
-- 
2.20.1
