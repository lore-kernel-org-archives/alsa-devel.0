From: russell.parker7@gmail.com
Subject: [PATCH ucm/conf: 4/5] Factor out rt5645 variants
	Headset+Digital Mic UCM shared {en, dis}able sequences
Date: Sat,  5 Jan 2019 19:47:14 -0800
Message-ID: <20190106034715.21045-5-russell.parker7@gmail.com>
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

Signed-off-by: Russell Parker <russell.parker7@gmail.com>

diff --git a/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
index 9616be27..e080e383 100644
--- a/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
+++ b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
@@ -92,31 +92,18 @@ SectionDevice."DMic".0 {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Int Mic Switch' on"
+		<codecs/rt5645-common/DigitalMicEnableSeq.conf>
 
 		cset "name='Stereo1 DMIC Mux' DMIC1"
 		cset "name='Stereo1 ADC2 Mux' DMIC"
 		cset "name='Mono ADC L2 Mux' DMIC"
 		cset "name='Mono ADC R2 Mux' DMIC"
-
-		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
-		cset "name='Sto1 ADC MIXL ADC2 Switch' on"
-		cset "name='Sto1 ADC MIXR ADC2 Switch' on"
-		cset "name='Mono ADC MIXL ADC1 Switch' off"
-		cset "name='Mono ADC MIXR ADC1 Switch' off"
-		cset "name='Mono ADC MIXL ADC2 Switch' on"
-		cset "name='Mono ADC MIXR ADC2 Switch' on"
 	]
 
 	DisableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
-		cset "name='Mono ADC MIXL ADC2 Switch' off"
-		cset "name='Mono ADC MIXR ADC2 Switch' off"
-		cset "name='Int Mic Switch' off"
+		<codecs/rt5645-common/DigitalMicDisableSeq.conf>
 	]
 }
 
@@ -132,10 +119,8 @@ SectionDevice."HSMic".0 {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Headset Mic Switch' on"
+		<codecs/rt5645-common/HSMicEnableSeq.conf>
 
-		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
 		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
 		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
 
@@ -143,23 +128,14 @@ SectionDevice."HSMic".0 {
 		cset "name='Mono ADC MIXR ADC1 Switch' on"
 		cset "name='Mono ADC MIXL ADC2 Switch' off"
 		cset "name='Mono ADC MIXR ADC2 Switch' off"
-
-		cset "name='RECMIXL BST1 Switch' on"
-		cset "name='RECMIXR BST1 Switch' on"
-
 	]
 
 	DisableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Headset Mic Switch' off"
+		<codecs/rt5645-common/HSMicEnableSeq.conf>
 
-		cset "name='RECMIXL BST1 Switch' off"
-		cset "name='RECMIXR BST1 Switch' off"
-		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
 		cset "name='Mono ADC MIXL ADC1 Switch' on"
 		cset "name='Mono ADC MIXR ADC1 Switch' on"
-
 	]
 }
diff --git a/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf b/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf
index eda1272a..714f4597 100644
--- a/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf
+++ b/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf
@@ -92,7 +92,7 @@ SectionDevice."DMic".0 {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Int Mic Switch' on"
+		<codecs/rt5645-common/DigitalMicEnableSeq.conf>
 
 		cset "name='Stereo1 DMIC Mux' DMIC2"
 		cset "name='Stereo1 ADC2 Mux' DMIC"
@@ -100,25 +100,12 @@ SectionDevice."DMic".0 {
 		cset "name='Mono DMIC R Mux' DMIC2"
 		cset "name='Mono ADC L2 Mux' DMIC"
 		cset "name='Mono ADC R2 Mux' DMIC"
-
-		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
-		cset "name='Sto1 ADC MIXL ADC2 Switch' on"
-		cset "name='Sto1 ADC MIXR ADC2 Switch' on"
-		cset "name='Mono ADC MIXL ADC1 Switch' off"
-		cset "name='Mono ADC MIXR ADC1 Switch' off"
-		cset "name='Mono ADC MIXL ADC2 Switch' on"
-		cset "name='Mono ADC MIXR ADC2 Switch' on"
 	]
 
 	DisableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
-		cset "name='Mono ADC MIXL ADC2 Switch' off"
-		cset "name='Mono ADC MIXR ADC2 Switch' off"
-		cset "name='Int Mic Switch' off"
+		<codecs/rt5645-common/DigitalMicDisableSeq.conf>
 	]
 }
 
@@ -134,10 +121,8 @@ SectionDevice."HSMic".0 {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Headset Mic Switch' on"
+		<codecs/rt5645-common/HSMicEnableSeq.conf>
 
-		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
 		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
 		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
 
@@ -145,23 +130,14 @@ SectionDevice."HSMic".0 {
 		cset "name='Mono ADC MIXR ADC1 Switch' on"
 		cset "name='Mono ADC MIXL ADC2 Switch' off"
 		cset "name='Mono ADC MIXR ADC2 Switch' off"
-
-		cset "name='RECMIXL BST1 Switch' on"
-		cset "name='RECMIXR BST1 Switch' on"
-
 	]
 
 	DisableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Headset Mic Switch' off"
+		<codecs/rt5645-common/HSMicEnableSeq.conf>
 
-		cset "name='RECMIXL BST1 Switch' off"
-		cset "name='RECMIXR BST1 Switch' off"
-		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
 		cset "name='Mono ADC MIXL ADC1 Switch' on"
 		cset "name='Mono ADC MIXR ADC1 Switch' on"
-
 	]
 }
diff --git a/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
index 0e868e26..489390d5 100644
--- a/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
+++ b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
@@ -145,10 +145,8 @@ SectionDevice."HSMic".0 {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Headset Mic Switch' on"
+		<codecs/rt5645-common/HSMicEnableSeq.conf>
 
-		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
 		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
 		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
 
@@ -156,23 +154,14 @@ SectionDevice."HSMic".0 {
 		cset "name='Mono ADC MIXR ADC1 Switch' on"
 		cset "name='Mono ADC MIXL ADC2 Switch' off"
 		cset "name='Mono ADC MIXR ADC2 Switch' off"
-
-		cset "name='RECMIXL BST1 Switch' on"
-		cset "name='RECMIXR BST1 Switch' on"
-
 	]
 
 	DisableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Headset Mic Switch' off"
+		<codecs/rt5645-common/HSMicDisableSeq.conf>
 
-		cset "name='RECMIXL BST1 Switch' off"
-		cset "name='RECMIXR BST1 Switch' off"
-		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
 		cset "name='Mono ADC MIXL ADC1 Switch' on"
 		cset "name='Mono ADC MIXR ADC1 Switch' on"
-
 	]
 }
diff --git a/src/conf/ucm/chtrt5645/HiFi.conf b/src/conf/ucm/chtrt5645/HiFi.conf
index 1bb9830d..ac5f60e2 100644
--- a/src/conf/ucm/chtrt5645/HiFi.conf
+++ b/src/conf/ucm/chtrt5645/HiFi.conf
@@ -136,10 +136,8 @@ SectionDevice."HSMic".0 {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Headset Mic Switch' on"
+		<codecs/rt5645-common/HSMicEnableSeq.conf>
 
-		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
 		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
 		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
 
@@ -147,23 +145,14 @@ SectionDevice."HSMic".0 {
 		cset "name='Mono ADC MIXR ADC1 Switch' on"
 		cset "name='Mono ADC MIXL ADC2 Switch' off"
 		cset "name='Mono ADC MIXR ADC2 Switch' off"
-
-		cset "name='RECMIXL BST1 Switch' on"
-		cset "name='RECMIXR BST1 Switch' on"
-
 	]
 
 	DisableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Headset Mic Switch' off"
+		<codecs/rt5645-common/HSMicDisableSeq.conf>
 
-		cset "name='RECMIXL BST1 Switch' off"
-		cset "name='RECMIXR BST1 Switch' off"
-		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
 		cset "name='Mono ADC MIXL ADC1 Switch' on"
 		cset "name='Mono ADC MIXR ADC1 Switch' on"
-
 	]
 }
diff --git a/src/conf/ucm/chtrt5650/HiFi.conf b/src/conf/ucm/chtrt5650/HiFi.conf
index c8bd397a..641dbc34 100644
--- a/src/conf/ucm/chtrt5650/HiFi.conf
+++ b/src/conf/ucm/chtrt5650/HiFi.conf
@@ -118,22 +118,16 @@ SectionDevice."HSMic".0 {
 	EnableSequence [
 		cdev "hw:chtrt5650"
 
-		cset "name='Headset Mic Switch' on"
-		cset "name='RECMIXL BST1 Switch' on"
-		cset "name='RECMIXR BST1 Switch' on"
-		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
+		<codecs/rt5645-common/HSMicEnableSeq.conf>
+
 		cset "name='IN1 Boost' 1"
 	]
 
 	DisableSequence [
 		cdev "hw:chtrt5650"
 
-		cset "name='Headset Mic Switch' off"
-		cset "name='RECMIXL BST1 Switch' off"
-		cset "name='RECMIXR BST1 Switch' off"
-		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
-		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
+		<codecs/rt5645-common/HSMicDisableSeq.conf>
+
 		cset "name='IN1 Boost' 0"
 	]
 }
diff --git a/src/conf/ucm/codecs/rt5645-common/DigitalMicDisableSeq.conf b/src/conf/ucm/codecs/rt5645-common/DigitalMicDisableSeq.conf
new file mode 100644
index 00000000..751f38c0
--- /dev/null
+++ b/src/conf/ucm/codecs/rt5645-common/DigitalMicDisableSeq.conf
@@ -0,0 +1,5 @@
+cset "name='Sto1 ADC MIXL ADC2 Switch' off"
+cset "name='Sto1 ADC MIXR ADC2 Switch' off"
+cset "name='Mono ADC MIXL ADC2 Switch' off"
+cset "name='Mono ADC MIXR ADC2 Switch' off"
+cset "name='Int Mic Switch' off"
diff --git a/src/conf/ucm/codecs/rt5645-common/DigitalMicEnableSeq.conf b/src/conf/ucm/codecs/rt5645-common/DigitalMicEnableSeq.conf
new file mode 100644
index 00000000..cb243b33
--- /dev/null
+++ b/src/conf/ucm/codecs/rt5645-common/DigitalMicEnableSeq.conf
@@ -0,0 +1,10 @@
+cset "name='Int Mic Switch' on"
+
+cset "name='Sto1 ADC MIXL ADC1 Switch' off"
+cset "name='Sto1 ADC MIXR ADC1 Switch' off"
+cset "name='Sto1 ADC MIXL ADC2 Switch' on"
+cset "name='Sto1 ADC MIXR ADC2 Switch' on"
+cset "name='Mono ADC MIXL ADC1 Switch' off"
+cset "name='Mono ADC MIXR ADC1 Switch' off"
+cset "name='Mono ADC MIXL ADC2 Switch' on"
+cset "name='Mono ADC MIXR ADC2 Switch' on"
diff --git a/src/conf/ucm/codecs/rt5645-common/HSMicDisableSeq.conf b/src/conf/ucm/codecs/rt5645-common/HSMicDisableSeq.conf
new file mode 100644
index 00000000..ef42b176
--- /dev/null
+++ b/src/conf/ucm/codecs/rt5645-common/HSMicDisableSeq.conf
@@ -0,0 +1,6 @@
+cset "name='Headset Mic Switch' off"
+
+cset "name='RECMIXL BST1 Switch' off"
+cset "name='RECMIXR BST1 Switch' off"
+cset "name='Sto1 ADC MIXL ADC1 Switch' off"
+cset "name='Sto1 ADC MIXR ADC1 Switch' off"
diff --git a/src/conf/ucm/codecs/rt5645-common/HSMicEnableSeq.conf b/src/conf/ucm/codecs/rt5645-common/HSMicEnableSeq.conf
new file mode 100644
index 00000000..6c26d687
--- /dev/null
+++ b/src/conf/ucm/codecs/rt5645-common/HSMicEnableSeq.conf
@@ -0,0 +1,7 @@
+cset "name='Headset Mic Switch' on"
+
+cset "name='Sto1 ADC MIXL ADC1 Switch' on"
+cset "name='Sto1 ADC MIXR ADC1 Switch' on"
+
+cset "name='RECMIXL BST1 Switch' on"
+cset "name='RECMIXR BST1 Switch' on"
diff --git a/src/conf/ucm/codecs/rt5645-common/Makefile.am b/src/conf/ucm/codecs/rt5645-common/Makefile.am
index 7eff2e72..06403d9b 100644
--- a/src/conf/ucm/codecs/rt5645-common/Makefile.am
+++ b/src/conf/ucm/codecs/rt5645-common/Makefile.am
@@ -1,5 +1,7 @@
 alsaconfigdir = @ALSA_CONFIG_DIR@
 ucmdir = $(alsaconfigdir)/ucm/codecs/rt5645-common
 ucm_DATA = DisableSeq.conf EnableSeq.conf HeadphonesEnableSeq.conf \
-		   SpeakerEnableSeq.conf
+		   SpeakerEnableSeq.conf DigitalMicDisableSeq.conf \
+		   DigitalMicEnableSeq.conf HSMicDisableSeq.conf \
+		   HSMicEnableSeq.conf
 EXTRA_DIST = $(ucm_DATA)
-- 
2.20.1
