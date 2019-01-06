From: russell.parker7@gmail.com
Subject: [PATCH ucm/conf: 3/5] Factor out rt5645 variants
	Speaker+Headphones shared UCM enable sequences
Date: Sat,  5 Jan 2019 19:47:13 -0800
Message-ID: <20190106034715.21045-4-russell.parker7@gmail.com>
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

Move common enable sequences for rt5645 variants and rt5650
UCM configuratons into a shared component. The corresponding
disable sequences are only two lines each and do not seem worth
creating components for.

Signed-off-by: Russell Parker <russell.parker7@gmail.com>

diff --git a/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
index 46508766..9616be27 100644
--- a/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
+++ b/src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/HiFi.conf
@@ -43,12 +43,7 @@ SectionDevice."Speaker" {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Headphone Switch' off"
-		cset "name='Headphone Channel Switch' off"
-
-		cset "name='Ext Spk Switch' on"
-		cset "name='Speaker Channel Switch' on"
-		cset "name='Speaker Playback Volume' 31"
+		<codecs/rt5645-common/SpeakerEnableSeq.conf>
 	]
 
 	DisableSequence [
@@ -75,13 +70,7 @@ SectionDevice."Headphones" {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Ext Spk Switch' off"
-		cset "name='Speaker Channel Switch' off"
-
-		cset "name='Headphone Switch' on"
-		cset "name='Headphone Channel Switch' on"
-		# 25/39 higher values cause crackling on some boards
-		cset "name='Headphone Playback Volume' 25"
+		<codecs/rt5645-common/HeadphonesEnableSeq.conf>
 	]
 
 	DisableSequence [
diff --git a/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf b/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf
index c16cceac..eda1272a 100644
--- a/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf
+++ b/src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/HiFi.conf
@@ -43,12 +43,7 @@ SectionDevice."Speaker" {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Headphone Switch' off"
-		cset "name='Headphone Channel Switch' off"
-
-		cset "name='Ext Spk Switch' on"
-		cset "name='Speaker Channel Switch' on"
-		cset "name='Speaker Playback Volume' 31"
+		<codecs/rt5645-common/SpeakerEnableSeq.conf>
 	]
 
 	DisableSequence [
@@ -75,13 +70,7 @@ SectionDevice."Headphones" {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Ext Spk Switch' off"
-		cset "name='Speaker Channel Switch' off"
-
-		cset "name='Headphone Switch' on"
-		cset "name='Headphone Channel Switch' on"
-		# 25/39 higher values cause crackling on some boards
-		cset "name='Headphone Playback Volume' 25"
+		<codecs/rt5645-common/HeadphonesEnableSeq.conf>
 	]
 
 	DisableSequence [
diff --git a/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
index 45cc5186..0e868e26 100644
--- a/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
+++ b/src/conf/ucm/chtrt5645-mono-speaker-analog-mic/HiFi.conf
@@ -47,12 +47,7 @@ SectionDevice."Speaker" {
 		cset "name='Stereo DAC MIXL DAC R1 Switch' 1"
 		cset "name='Stereo DAC MIXR DAC R1 Switch' 0"
 
-		cset "name='Headphone Switch' off"
-		cset "name='Headphone Channel Switch' off"
-
-		cset "name='Ext Spk Switch' on"
-		cset "name='Speaker Channel Switch' on"
-		cset "name='Speaker Playback Volume' 31"
+		<codecs/rt5645-common/SpeakerEnableSeq.conf>
 	]
 
 	DisableSequence [
@@ -83,13 +78,7 @@ SectionDevice."Headphones" {
 		cset "name='Stereo DAC MIXL DAC R1 Switch' 0"
 		cset "name='Stereo DAC MIXR DAC R1 Switch' 1"
 
-		cset "name='Ext Spk Switch' off"
-		cset "name='Speaker Channel Switch' off"
-
-		cset "name='Headphone Switch' on"
-		cset "name='Headphone Channel Switch' on"
-		# 25/39 higher values cause crackling on some boards
-		cset "name='Headphone Playback Volume' 25"
+		<codecs/rt5645-common/HeadphonesEnableSeq.conf>
 	]
 
 	DisableSequence [
diff --git a/src/conf/ucm/chtrt5645/HiFi.conf b/src/conf/ucm/chtrt5645/HiFi.conf
index bc4801d8..1bb9830d 100644
--- a/src/conf/ucm/chtrt5645/HiFi.conf
+++ b/src/conf/ucm/chtrt5645/HiFi.conf
@@ -43,12 +43,7 @@ SectionDevice."Speaker" {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Headphone Switch' off"
-		cset "name='Headphone Channel Switch' off"
-
-		cset "name='Ext Spk Switch' on"
-		cset "name='Speaker Channel Switch' on"
-		cset "name='Speaker Playback Volume' 31"
+		<codecs/rt5645-common/SpeakerEnableSeq.conf>
 	]
 
 	DisableSequence [
@@ -75,13 +70,7 @@ SectionDevice."Headphones" {
 	EnableSequence [
 		cdev "hw:chtrt5645"
 
-		cset "name='Ext Spk Switch' off"
-		cset "name='Speaker Channel Switch' off"
-
-		cset "name='Headphone Switch' on"
-		cset "name='Headphone Channel Switch' on"
-		# 25/39 higher values cause crackling on some boards
-		cset "name='Headphone Playback Volume' 25"
+		<codecs/rt5645-common/HeadphonesEnableSeq.conf>
 	]
 
 	DisableSequence [
diff --git a/src/conf/ucm/chtrt5650/HiFi.conf b/src/conf/ucm/chtrt5650/HiFi.conf
index 7142dece..c8bd397a 100644
--- a/src/conf/ucm/chtrt5650/HiFi.conf
+++ b/src/conf/ucm/chtrt5650/HiFi.conf
@@ -43,12 +43,7 @@ SectionDevice."Speaker" {
 	EnableSequence [
 		cdev "hw:chtrt5650"
 
-		cset "name='Headphone Switch' off"
-		cset "name='Headphone Channel Switch' off"
-
-		cset "name='Ext Spk Switch' on"
-		cset "name='Speaker Channel Switch' on"
-		cset "name='Speaker Playback Volume' 31"
+		<codecs/rt5645-common/SpeakerEnableSeq.conf>
 	]
 
 	DisableSequence [
@@ -75,12 +70,7 @@ SectionDevice."Headphones" {
 	EnableSequence [
 		cdev "hw:chtrt5650"
 
-		cset "name='Ext Spk Switch' off"
-		cset "name='Speaker Channel Switch' off"
-
-		cset "name='Headphone Switch' on"
-		cset "name='Headphone Channel Switch' on"
-		cset "name='Headphone Playback Volume' 31"
+		<codecs/rt5645-common/HeadphonesEnableSeq.conf>
 	]
 
 	DisableSequence [
diff --git a/src/conf/ucm/codecs/rt5645-common/HeadphonesEnableSeq.conf b/src/conf/ucm/codecs/rt5645-common/HeadphonesEnableSeq.conf
new file mode 100644
index 00000000..6c231da7
--- /dev/null
+++ b/src/conf/ucm/codecs/rt5645-common/HeadphonesEnableSeq.conf
@@ -0,0 +1,7 @@
+cset "name='Ext Spk Switch' off"
+cset "name='Speaker Channel Switch' off"
+
+cset "name='Headphone Switch' on"
+cset "name='Headphone Channel Switch' on"
+# 25/39 higher values cause crackling on some boards
+cset "name='Headphone Playback Volume' 25"
diff --git a/src/conf/ucm/codecs/rt5645-common/Makefile.am b/src/conf/ucm/codecs/rt5645-common/Makefile.am
index f351fa37..7eff2e72 100644
--- a/src/conf/ucm/codecs/rt5645-common/Makefile.am
+++ b/src/conf/ucm/codecs/rt5645-common/Makefile.am
@@ -1,4 +1,5 @@
 alsaconfigdir = @ALSA_CONFIG_DIR@
 ucmdir = $(alsaconfigdir)/ucm/codecs/rt5645-common
-ucm_DATA = DisableSeq.conf EnableSeq.conf
+ucm_DATA = DisableSeq.conf EnableSeq.conf HeadphonesEnableSeq.conf \
+		   SpeakerEnableSeq.conf
 EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/codecs/rt5645-common/SpeakerEnableSeq.conf b/src/conf/ucm/codecs/rt5645-common/SpeakerEnableSeq.conf
new file mode 100644
index 00000000..2cc62fc5
--- /dev/null
+++ b/src/conf/ucm/codecs/rt5645-common/SpeakerEnableSeq.conf
@@ -0,0 +1,6 @@
+cset "name='Headphone Switch' off"
+cset "name='Headphone Channel Switch' off"
+
+cset "name='Ext Spk Switch' on"
+cset "name='Speaker Channel Switch' on"
+cset "name='Speaker Playback Volume' 31"
-- 
2.20.1
