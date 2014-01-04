From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/1] hdspmixer: Add support for RME AIO AEB
	boards
Date: Sat,  4 Jan 2014 21:38:23 +0100
Message-ID: <1388867903-25055-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

AIO allows to connect Analogue Extension Boards (4in/4out).

Provide those channels in hdspmixer, too.

The channel maps were copied from the driver, hence the changed casing
in the comments.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerCard.cxx b/hdspmixer/src/HDSPMixerCard.cxx
index 78b88b6..ce40ba7 100644
--- a/hdspmixer/src/HDSPMixerCard.cxx
+++ b/hdspmixer/src/HDSPMixerCard.cxx
@@ -348,9 +348,9 @@ void HDSPMixerCard::adjustSettings() {
 
         switch (speed_mode) {
         case 0: // SS
-            channels_input = 14;
-            channels_playback = 16;
-            channels_output = 16; /* SS 2xAnalog+2xAES+2xSPDIF+4xADAT+2xHeadphones */
+            channels_input = 18;
+            channels_playback = 20;
+            channels_output = 20; /* SS 2xAnalog+2xAES+2xSPDIF+8xADAT+2xHeadphones+4xAEB */
             channel_map_input = channel_map_aio_in_ss;
             channel_map_playback = channel_map_aio_out_ss;
             dest_map = dest_map_aio_ss;
@@ -358,9 +358,9 @@ void HDSPMixerCard::adjustSettings() {
             meter_map_playback = channel_map_aio_out_ss;
             break;
         case 1: // DS
-            channels_input = 10;
-            channels_playback = 12;
-            channels_output = 12; /* DS 2xAnalog+2xAES+2xSPDIF+4xADAT(SMUX)+2xHeadphones */
+            channels_input = 14;
+            channels_playback = 16;
+            channels_output = 16; /* DS 2xAnalog+2xAES+2xSPDIF+4xADAT(SMUX)+2xHeadphones+4xAEB */
             channel_map_input = channel_map_aio_in_ds;
             channel_map_playback = channel_map_aio_out_ds;
             dest_map = dest_map_aio_ds;
@@ -368,9 +368,9 @@ void HDSPMixerCard::adjustSettings() {
             meter_map_playback = channel_map_aio_out_ds;
             break;
         case 2: // QS
-            channels_input = 8;
-            channels_playback = 10;
-            channels_output = 10; /* QS 2xAnalog+2xAES+2xSPDIF+2xADAT(SMUX)+2xHeadphones */
+            channels_input = 12;
+            channels_playback = 14;
+            channels_output = 14; /* QS 2xAnalog+2xAES+2xSPDIF+2xADAT(SMUX)+2xHeadphones+4xAEB */
             channel_map_input = channel_map_aio_in_qs;
             channel_map_playback = channel_map_aio_out_qs;
             dest_map = dest_map_aio_qs;
diff --git a/hdspmixer/src/HDSPMixerOutput.cxx b/hdspmixer/src/HDSPMixerOutput.cxx
index 5a88f41..0053fe0 100644
--- a/hdspmixer/src/HDSPMixerOutput.cxx
+++ b/hdspmixer/src/HDSPMixerOutput.cxx
@@ -87,51 +87,57 @@ static char const *labels_rpm_input[5] = {
   "Mic"
 };
 
-static char const *labels_aio_ss_input[14] = {
+static char const *labels_aio_ss_input[18] = {
   "AN 1",  "AN 2",
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
   "A 1", "A 2", "A 3", "A 4",
-  "A 5", "A 6", "A 7", "A 8"
+  "A 5", "A 6", "A 7", "A 8",
+  "AEB 1", "AEB 2", "AEB 3," "AEB 4"
 };
 
-static char const *labels_aio_ss_playback[16] = {
+static char const *labels_aio_ss_playback[20] = {
   "AN 1",  "AN 2",
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
   "A 1", "A 2", "A 3", "A 4",
   "A 5", "A 6", "A 7", "A 8",
-  "PH.L", "PH.R"
+  "PH.L", "PH.R",
+  "AEB 1", "AEB 2", "AEB 3", "AEB 4"
 };
 
-static char const *labels_aio_ds_input[10] = {
+static char const *labels_aio_ds_input[14] = {
   "AN 1",  "AN 2",  
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
-  "A 1", "A 2", "A 3", "A 4"
+  "A 1", "A 2", "A 3", "A 4",
+  "AEB 1", "AEB 2", "AEB 3", "AEB 4"
 };
 
-static char const *labels_aio_ds_playback[12] = {
+static char const *labels_aio_ds_playback[16] = {
   "AN 1",  "AN 2",  
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
   "A 1", "A 2", "A 3", "A 4",
-  "PH.L", "PH.R"
+  "PH.L", "PH.R",
+  "AEB 1", "AEB 2", "AEB 3", "AEB 4"
  };
 
-static char const *labels_aio_qs_input[8] = {
+static char const *labels_aio_qs_input[12] = {
   "AN 1",  "AN 2",
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
-  "A 1", "A 2"
+  "A 1", "A 2",
+  "AEB 1", "AEB 2", "AEB 3", "AEB 4"
 };
 
-static char const *labels_aio_qs_playback[10] = {
+static char const *labels_aio_qs_playback[14] = {
   "AN 1",  "AN 2",
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
   "A 1", "A 2",
   "PH.L", "PH.R",
+  "AEB 1", "AEB 2", "AEB 3", "AEB 4"
 };
 
 
diff --git a/hdspmixer/src/HDSPMixerSelector.cxx b/hdspmixer/src/HDSPMixerSelector.cxx
index 084c80d..3dcbad3 100644
--- a/hdspmixer/src/HDSPMixerSelector.cxx
+++ b/hdspmixer/src/HDSPMixerSelector.cxx
@@ -81,28 +81,34 @@ static char const *destinations_raydat_qs[6] = {
 };
 
 
-static char const *destinations_aio_ss[8] = {
+static char const *destinations_aio_ss[10] = {
   "AN 1+2",
   "AES",
   "SPDIF",
   "A 1+2", "A 3+4", "A 5+6", "A 7+8",
-  "Phones"
+  "Phones",
+  "AEB 1+2",
+  "AEB 3+4"
 };
 
-static char const *destinations_aio_ds[6] = {
+static char const *destinations_aio_ds[8] = {
   "AN 1+2", 
   "AES",
   "SPDIF",
   "A 1+2", "A 3+4",
-  "Phones"
+  "Phones",
+  "AEB 1+2",
+  "AEB 3+4"
 };
 
-static char const *destinations_aio_qs[5] = {
+static char const *destinations_aio_qs[7] = {
   "AN 1+2",
   "AES",
   "SPDIF",
   "A 1+2",
-  "Phones"
+  "Phones",
+  "AEB 1+2",
+  "AEB 3+4"
 };
 
 static char const *destinations_mf_ss[10] = {
@@ -318,15 +324,15 @@ void HDSPMixerSelector::setLabels()
     } else if (HDSPeAIO == type) {
 	switch (sm) {
 	case 0:
-	  max_dest = 8;
+	  max_dest = 10;
 	  destinations = destinations_aio_ss;
 	  break;
 	case 1:
-	  max_dest = 6;
+	  max_dest = 8;
 	  destinations = destinations_aio_ds;
 	  break;
 	case 2:
-	  max_dest = 5;
+	  max_dest = 7;
 	  destinations = destinations_aio_qs;
 	  break;
 	}
diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index e1fe18c..342efb2 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -753,12 +753,12 @@ void HDSPMixerWindow::restoreDefaults(int card)
       num_modes = 3;
       break;
      case HDSPeAIO:
-      chnls[0] = 14;
-      chnls[1] = 10;
-      chnls[2] = 8;
-      maxdest[0] = 8;
-      maxdest[1] = 6;
-      maxdest[2] = 5;
+      chnls[0] = 18;
+      chnls[1] = 14;
+      chnls[2] = 12;
+      maxdest[0] = 10;
+      maxdest[1] = 8;
+      maxdest[2] = 7;
       num_modes = 3;
       break;
     case HDSPeRayDAT:
diff --git a/hdspmixer/src/channelmap.cxx b/hdspmixer/src/channelmap.cxx
index e3ca15c..b7bdded 100644
--- a/hdspmixer/src/channelmap.cxx
+++ b/hdspmixer/src/channelmap.cxx
@@ -247,38 +247,44 @@ char channel_map_raydat_qs[HDSPM_MAX_CHANNELS] = {
 
 // HDSPe AIO
 
-char dest_map_aio_ss[8] = {
+char dest_map_aio_ss[10] = {
    0, // Analogue
    8, // AES
   10, // SPDIF
   12, 14, 16, 18, // ADAT
-   6  // Phones
+   6,  // Phones
+   2,  // AEB 1+2
+   4   // AEB 3+4
 };
 
 
-char dest_map_aio_ds[6] = {
+char dest_map_aio_ds[8] = {
    0, // Analogue
    8, // AES
   10, // SPDIF
   12, 16, // ADAT
-   6  // Phones
+   6,  // Phones
+   2,  // AEB 1+2
+   4   // AEB 3+4
 };
 
-char dest_map_aio_qs[5] = {
+char dest_map_aio_qs[7] = {
    0, // Analogue
    8, // AES
   10, // SPDIF
   12, // ADAT
-   6  // Phone
+   6, // Phone
+   2, // AEB 1+2
+   4  // AEB 3+4
 };
 
 char channel_map_aio_in_ss[HDSPM_MAX_CHANNELS] = {
 	0, 1,			/* line in */
-	8, 9,			/* AES in, */
-	10, 11,			/* SPDIF in */
+	8, 9,			/* aes in, */
+	10, 11,			/* spdif in */
 	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT in */
-	-1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
+	2, 3, 4, 5,		/* AEB */
+	-1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -288,11 +294,12 @@ char channel_map_aio_in_ss[HDSPM_MAX_CHANNELS] = {
 
 char channel_map_aio_out_ss[HDSPM_MAX_CHANNELS] = {
 	0, 1,			/* line out */
-	8, 9,			/* AES out */
-	10, 11,			/* SPDIF out */
+	8, 9,			/* aes out */
+	10, 11,			/* spdif out */
 	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT out */
 	6, 7,			/* phone out */
-	-1, -1, -1, -1, -1, -1, -1, -1,
+	2, 3, 4, 5,		/* AEB */
+	-1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -302,10 +309,11 @@ char channel_map_aio_out_ss[HDSPM_MAX_CHANNELS] = {
 
 char channel_map_aio_in_ds[HDSPM_MAX_CHANNELS] = {
 	0, 1,			/* line in */
-	8, 9,			/* AES in */
-	10, 11,			/* SPDIF in */
-	12, 14, 16, 18,		/* ADAT in */
-	-1, -1, -1, -1, -1, -1,
+	8, 9,			/* aes in */
+	10, 11,			/* spdif in */
+	12, 14, 16, 18,		/* adat in */
+	2, 3, 4, 5,		/* AEB */
+	-1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -316,11 +324,11 @@ char channel_map_aio_in_ds[HDSPM_MAX_CHANNELS] = {
 
 char channel_map_aio_out_ds[HDSPM_MAX_CHANNELS] = {
 	0, 1,			/* line out */
-	8, 9,			/* AES out */
-	10, 11,			/* SPDIF out */
-	12, 14, 16, 18,		/* ADAT out */
+	8, 9,			/* aes out */
+	10, 11,			/* spdif out */
+	12, 14, 16, 18,		/* adat out */
 	6, 7,			/* phone out */
-	-1, -1, -1, -1,
+	2, 3, 4, 5,		/* AEB */
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -331,10 +339,11 @@ char channel_map_aio_out_ds[HDSPM_MAX_CHANNELS] = {
 
 char channel_map_aio_in_qs[HDSPM_MAX_CHANNELS] = {
 	0, 1,			/* line in */
-	8, 9,			/* AES in */
-	10, 11,			/* SPDIF in */
-	12, 16,			/* ADAT in */
-	-1, -1, -1, -1, -1, -1, -1, -1,
+	8, 9,			/* aes in */
+	10, 11,			/* spdif in */
+	12, 16,			/* adat in */
+	2, 3, 4, 5,		/* AEB */
+	-1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
@@ -345,11 +354,12 @@ char channel_map_aio_in_qs[HDSPM_MAX_CHANNELS] = {
 
 char channel_map_aio_out_qs[HDSPM_MAX_CHANNELS] = {
 	0, 1,			/* line out */
-	8, 9,			/* AES out */
-	10, 11,			/* SPDIF out */
-	12, 16,			/* ADAT out */
+	8, 9,			/* aes out */
+	10, 11,			/* spdif out */
+	12, 16,			/* adat out */
 	6, 7,			/* phone out */
-	-1, -1, -1, -1, -1, -1,
+	2, 3, 4, 5,		/* AEB */
+	-1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
 	-1, -1, -1, -1, -1, -1, -1, -1,
diff --git a/hdspmixer/src/channelmap.h b/hdspmixer/src/channelmap.h
index 51b69ce..854e5a1 100644
--- a/hdspmixer/src/channelmap.h
+++ b/hdspmixer/src/channelmap.h
@@ -112,12 +112,12 @@ extern char channel_map_raydat_qs[HDSPM_MAX_CHANNELS];
 
 // HDSPe AIO
 
-extern char dest_map_aio_ss[8];
+extern char dest_map_aio_ss[10];
 
 
-extern char dest_map_aio_ds[6];
+extern char dest_map_aio_ds[8];
 
-extern char dest_map_aio_qs[5];
+extern char dest_map_aio_qs[7];
 
 extern char channel_map_aio_in_ss[HDSPM_MAX_CHANNELS];
 
-- 
1.8.4.rc3
