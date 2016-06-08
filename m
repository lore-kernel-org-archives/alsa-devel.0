From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH] conf/ucm: ROCKCHIP-I2S: rename to VEYRON-I2S
Date: Thu, 09 Jun 2016 01:17:15 +0200
Message-ID: <2171222.JpkBRpngRM@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gloria.sntech.de (gloria.sntech.de [95.129.55.99])
 by alsa0.perex.cz (Postfix) with ESMTP id D9B182654D0
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2016 01:17:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit a192f52fc63a introduced an ucm profile for Rockchip Veyron-
Chromebooks by taking the ucm profile from the ChromeOS userspace.

But similarly to DAISY-I2S, PAZ00 and most other profiles, the audio
setup is pretty specific to a board type, so hogging the Rockchip name
will make it harder for future Rockchip based boards to fit in nicely.

And while Veyron also is a family of boards, all of them share the
same audio setup. The ucm profile was not released with any official
alsa release and the audio setup also isn't in the mainline kernel yet,
so such a rename should be easily possible.

Fixes: a192f52fc63a ("conf/ucm: ROCKCHIP-I2S: add Rockchip I2S UCM config.")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 src/conf/ucm/Makefile.am                                   |  2 +-
 src/conf/ucm/ROCKCHIP-I2S/Makefile.am                      |  4 ----
 src/conf/ucm/{ROCKCHIP-I2S => VEYRON-I2S}/HiFi.conf        | 14 +++++++-------
 src/conf/ucm/VEYRON-I2S/Makefile.am                        |  4 ++++
 .../ROCKCHIP-I2S.conf => VEYRON-I2S/VEYRON-I2S.conf}       |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)
 delete mode 100644 src/conf/ucm/ROCKCHIP-I2S/Makefile.am
 rename src/conf/ucm/{ROCKCHIP-I2S => VEYRON-I2S}/HiFi.conf (91%)
 create mode 100644 src/conf/ucm/VEYRON-I2S/Makefile.am
 rename src/conf/ucm/{ROCKCHIP-I2S/ROCKCHIP-I2S.conf => VEYRON-I2S/VEYRON-I2S.conf} (67%)

diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index d1d51e5..3cce36a 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -1 +1 @@
-SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 ROCKCHIP-I2S
+SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 VEYRON-I2S
diff --git a/src/conf/ucm/ROCKCHIP-I2S/Makefile.am b/src/conf/ucm/ROCKCHIP-I2S/Makefile.am
deleted file mode 100644
index 485a740..0000000
--- a/src/conf/ucm/ROCKCHIP-I2S/Makefile.am
+++ /dev/null
@@ -1,4 +0,0 @@
-alsaconfigdir = @ALSA_CONFIG_DIR@
-ucmdir = $(alsaconfigdir)/ucm/ROCKCHIP-I2S
-ucm_DATA = ROCKCHIP-I2S.conf HiFi.conf
-EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/ROCKCHIP-I2S/HiFi.conf b/src/conf/ucm/VEYRON-I2S/HiFi.conf
similarity index 91%
rename from src/conf/ucm/ROCKCHIP-I2S/HiFi.conf
rename to src/conf/ucm/VEYRON-I2S/HiFi.conf
index 7bfe995..292b8fc 100644
--- a/src/conf/ucm/ROCKCHIP-I2S/HiFi.conf
+++ b/src/conf/ucm/VEYRON-I2S/HiFi.conf
@@ -5,7 +5,7 @@ SectionVerb {
 	}
 
 	EnableSequence [
-		cdev "hw:ROCKCHIPI2S"
+		cdev "hw:VEYRONI2S"
 
 		cset "name='Left Speaker Mixer Left DAC Switch' on"
 		cset "name='Right Speaker Mixer Right DAC Switch' on"
@@ -49,19 +49,19 @@ SectionVerb {
 
 SectionDevice."Headphone".0 {
 	Value {
-		JackName "ROCKCHIP-I2S Headset Jack"
+		JackName "VEYRON-I2S Headset Jack"
 		OutputDspName ""
 	}
 
 	EnableSequence [
-		cdev "hw:ROCKCHIPI2S"
+		cdev "hw:VEYRONI2S"
 
 		cset "name='Speaker Switch' off"
 		cset "name='Headphone Left Switch' on"
 		cset "name='Headphone Right Switch' on"
 	]
 	DisableSequence [
-		cdev "hw:ROCKCHIPI2S"
+		cdev "hw:VEYRONI2S"
 
 		cset "name='Headphone Left Switch' off"
 		cset "name='Headphone Right Switch' off"
@@ -71,11 +71,11 @@ SectionDevice."Headphone".0 {
 
 SectionDevice."Mic".0 {
 	Value {
-		JackName "ROCKCHIP-I2S Headset Jack"
+		JackName "VEYRON-I2S Headset Jack"
 	}
 
 	EnableSequence [
-		cdev "hw:ROCKCHIPI2S"
+		cdev "hw:VEYRONI2S"
 
 		cset "name='Int Mic Switch' off"
 		cset "name='DMIC Mux' ADC"
@@ -84,7 +84,7 @@ SectionDevice."Mic".0 {
 	]
 
 	DisableSequence [
-		cdev "hw:ROCKCHIPI2S"
+		cdev "hw:VEYRONI2S"
 
 		cset "name='Headset Mic Switch' off"
 		cset "name='DMIC Mux' DMIC"
diff --git a/src/conf/ucm/VEYRON-I2S/Makefile.am b/src/conf/ucm/VEYRON-I2S/Makefile.am
new file mode 100644
index 0000000..2bb628e
--- /dev/null
+++ b/src/conf/ucm/VEYRON-I2S/Makefile.am
@@ -0,0 +1,4 @@
+alsaconfigdir = @ALSA_CONFIG_DIR@
+ucmdir = $(alsaconfigdir)/ucm/VEYRON-I2S
+ucm_DATA = VEYRON-I2S.conf HiFi.conf
+EXTRA_DIST = $(ucm_DATA)
diff --git a/src/conf/ucm/ROCKCHIP-I2S/ROCKCHIP-I2S.conf b/src/conf/ucm/VEYRON-I2S/VEYRON-I2S.conf
similarity index 67%
rename from src/conf/ucm/ROCKCHIP-I2S/ROCKCHIP-I2S.conf
rename to src/conf/ucm/VEYRON-I2S/VEYRON-I2S.conf
index 0c399b0..2a92b6f 100644
--- a/src/conf/ucm/ROCKCHIP-I2S/ROCKCHIP-I2S.conf
+++ b/src/conf/ucm/VEYRON-I2S/VEYRON-I2S.conf
@@ -1,4 +1,4 @@
-Comment "Rockchip card"
+Comment "Rockchip Veyron card"
 
 SectionUseCase."HiFi" {
 	File "HiFi.conf"
-- 
2.8.0.rc3
