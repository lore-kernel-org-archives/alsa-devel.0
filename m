From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/3] hdspmixer: Add support for RME RPM
Date: Thu, 28 Jul 2011 23:45:46 +0200
Message-ID: <1311889548-28617-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1311889548-28617-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1311889548-28617-1-git-send-email-adi@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch adds support for the RME RPM devices. It's mostly based on
Florian Faber's previous patch against hdspmixer 1.0.23,
forwarded-ported to the current hdspmixer code.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerCard.cxx b/hdspmixer/src/HDSPMixerCard.cxx
index fbd5de5..78b88b6 100644
--- a/hdspmixer/src/HDSPMixerCard.cxx
+++ b/hdspmixer/src/HDSPMixerCard.cxx
@@ -255,6 +255,17 @@ void HDSPMixerCard::adjustSettings() {
         }
     }
 
+    if (type == RPM) {
+        /* RPM has no digital audio connectors, hence channel mappings don't
+         * depend on speedmode */
+        channels_input = 5;
+        channels_playback = channels_output = 6; /* 2xMain,2xMon,2xPH */
+        channel_map_input = channel_map_playback = channel_map_rpm;
+        dest_map = dest_map_rpm;
+        meter_map_input = meter_map_playback = channel_map_rpm;
+    }
+
+
     if (type == H9652) {
         switch (speed_mode) {
         case 0:
diff --git a/hdspmixer/src/HDSPMixerCard.h b/hdspmixer/src/HDSPMixerCard.h
index d2ef8a6..656702b 100644
--- a/hdspmixer/src/HDSPMixerCard.h
+++ b/hdspmixer/src/HDSPMixerCard.h
@@ -32,6 +32,11 @@
 #include "channelmap.h"
 #include "HDSPMixerWindow.h"
 
+/* temporary workaround until hdsp.h (HDSP_IO_Type gets fixed */
+#ifndef RPM
+# define RPM	5
+#endif
+
 class HDSPMixerWindow;
 
 class HDSPMixerCard
diff --git a/hdspmixer/src/HDSPMixerOutput.cxx b/hdspmixer/src/HDSPMixerOutput.cxx
index 17ab25d..5a88f41 100644
--- a/hdspmixer/src/HDSPMixerOutput.cxx
+++ b/hdspmixer/src/HDSPMixerOutput.cxx
@@ -77,6 +77,15 @@ static char const *labels_raydat_qs[12] = {
   "SP.L", "SP.R"
 };
 
+static char const *labels_rpm_output[6] = {
+  "Main L", "Main R", "Mon L", "Mon R", "PH L", "PH R"
+};
+
+static char const *labels_rpm_input[5] = {
+  "Phono 1.L", "Phono 1.R",
+  "Phono 2.L", "Phono 2.R",
+  "Mic"
+};
 
 static char const *labels_aio_ss_input[14] = {
   "AN 1",  "AN 2",
@@ -219,6 +228,12 @@ void HDSPMixerOutput::setLabels()
             labels_input = labels_playback = labels_mf_ss;
         return;
     };
+
+    if (type == RPM) {
+        labels_input = labels_rpm_input;
+        labels_playback = labels_rpm_output;
+        return;
+    };
     
     if (type == Digiface || type == H9652) {
         if (sm)
diff --git a/hdspmixer/src/HDSPMixerSelector.cxx b/hdspmixer/src/HDSPMixerSelector.cxx
index 32d91db..084c80d 100644
--- a/hdspmixer/src/HDSPMixerSelector.cxx
+++ b/hdspmixer/src/HDSPMixerSelector.cxx
@@ -131,6 +131,10 @@ static char const *destinations_df_ds[8] = {
   "SPDIF", "Analog"
 };
 
+static char const *destinations_rpm[3] = {
+  "Main", "Mon", "Phones"
+};
+
 static char const *destinations_h9652_ss[13] = {
   "A1 1+2", "A1 3+4", "A1 5+6", "A1 7+8",
   "A2 1+2", "A2 3+4", "A2 5+6", "A2 7+8",
@@ -261,6 +265,9 @@ void HDSPMixerSelector::setLabels()
 	    /* should never happen */
 	    break;
 	}
+    } else if (type == RPM) {
+        max_dest = 3;
+        destinations = destinations_rpm;
     } else if (type == H9652) {
 	switch (sm) {
 	case 0:
diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index 74b5630..e1fe18c 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -709,6 +709,10 @@ void HDSPMixerWindow::restoreDefaults(int card)
 	maxdest[0] = 14;
 	maxdest[1] = 8;
 	break;
+    case RPM:
+    chnls[0] = chnls[1] = 6;
+    maxdest[0] = maxdest[1] = 3;
+    break;
     case H9652:
 	chnls[0] = 26;
 	chnls[1] = 14;
diff --git a/hdspmixer/src/channelmap.cxx b/hdspmixer/src/channelmap.cxx
index 598be56..e3ca15c 100644
--- a/hdspmixer/src/channelmap.cxx
+++ b/hdspmixer/src/channelmap.cxx
@@ -78,6 +78,18 @@ char dest_map_ds[8] = {
 	0, 2, 8, 10, 16, 18, 24, 26
 };
 
+/* RPM */
+char dest_map_rpm[3] = {
+    0, 2, 4
+};
+
+char channel_map_rpm[26] = {
+     0,  1,  2,  3,  4,  5, -1, -1,
+    -1, -1, -1, -1, -1, -1, -1, -1,
+    -1, -1, -1, -1, -1, -1, -1, -1,
+    -1, -1
+};
+
 // HDSP 9652
 
 char dest_map_h9652_ss[13] = {
diff --git a/hdspmixer/src/channelmap.h b/hdspmixer/src/channelmap.h
index 6b151a0..51b69ce 100644
--- a/hdspmixer/src/channelmap.h
+++ b/hdspmixer/src/channelmap.h
@@ -54,6 +54,11 @@ extern char channel_map_ds[26];
 
 extern char dest_map_ds[8];
 
+// RPM
+
+extern char dest_map_rpm[3];
+extern char channel_map_rpm[26];
+
 // HDSP 9652
 
 extern char dest_map_h9652_ss[13];
diff --git a/hdspmixer/src/hdspmixer.cxx b/hdspmixer/src/hdspmixer.cxx
index 4929863..9c0a3c4 100644
--- a/hdspmixer/src/hdspmixer.cxx
+++ b/hdspmixer/src/hdspmixer.cxx
@@ -65,6 +65,10 @@ int main(int argc, char **argv)
             printf("Digiface found!\n");
             hdsp_cards[cards] = new HDSPMixerCard(Digiface, card, shortname);
             cards++;
+        } else if (!strncmp(name, "RME Hammerfall DSP + RPM", 24)) {
+            printf("RPM found!\n");
+            hdsp_cards[cards] = new HDSPMixerCard(RPM, card, shortname);
+            cards++;
         } else if (!strncmp(name, "RME Hammerfall HDSP 9652", 24)) {
             printf("HDSP 9652 found!\n");
             hdsp_cards[cards] = new HDSPMixerCard(H9652, card, shortname);
-- 
1.7.5.4
