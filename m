From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/2] hdspmixer: Add RME HDSPe AES and AES32
	support.
Date: Mon,  7 Feb 2011 18:55:25 +0100
Message-ID: <1297101326-10509-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1297101326-10509-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1297101326-10509-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Code provided by  Fredrik Lingvall <fredrik.lingvall@gmail.com>

It seems the PCIe (AES) and PCI (AES32) versions behave the same, so we
can kill two birds with one stone.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
---
 hdspmixer/src/HDSPMixerCard.cxx     |   22 ++++++++++++++++++++++
 hdspmixer/src/HDSPMixerOutput.cxx   |    7 +++++++
 hdspmixer/src/HDSPMixerSelector.cxx |    8 ++++++++
 hdspmixer/src/HDSPMixerWindow.cxx   |   10 ++++++++++
 hdspmixer/src/defines.h             |    1 +
 hdspmixer/src/hdspmixer.cxx         |    4 ++++
 6 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/hdspmixer/src/HDSPMixerCard.cxx b/hdspmixer/src/HDSPMixerCard.cxx
index 5f923ac..c0d38b8 100644
--- a/hdspmixer/src/HDSPMixerCard.cxx
+++ b/hdspmixer/src/HDSPMixerCard.cxx
@@ -52,6 +52,16 @@ static char dest_map_madi_ss[32] = {
  48, 50, 52, 54, 56, 58, 60, 62
 };
 
+static char channel_map_aes[16] = {
+    0, 1, 2, 3, 4, 5, 6, 7,
+    9, 10, 11, 12, 13, 14, 15
+};
+
+
+static char dest_map_aes[8] = {
+  0,  2,  4,  6,  8, 10, 12, 14
+};
+
 
 static char dest_map_raydat_ss[18] = {
    4,  6,  8, 10, 
@@ -466,6 +476,18 @@ void HDSPMixerCard::adjustSettings() {
 	break;
       }
 
+    } else if (HDSP_AES == type) {
+      playbacks_offset = 64; /* FL not sure about this one? */
+
+      /* 16 channels for all modes */
+      channels_input = 16;
+      channels_playback = 16;
+      channel_map_input = channel_map_aes;
+      channel_map_playback = channel_map_aes;
+      dest_map = dest_map_aes;
+      meter_map_input = channel_map_aes;
+      meter_map_playback = channel_map_aes;
+
     } else if (HDSPeRayDAT == type) {
       playbacks_offset = 64;
 
diff --git a/hdspmixer/src/HDSPMixerOutput.cxx b/hdspmixer/src/HDSPMixerOutput.cxx
index 9dc5457..cd9122f 100644
--- a/hdspmixer/src/HDSPMixerOutput.cxx
+++ b/hdspmixer/src/HDSPMixerOutput.cxx
@@ -45,6 +45,11 @@ static char *labels_madi_qs[16] = {
 };
 
 
+static char *labels_aes[16] = {
+  "AES 1", "AES 2", "AES 3", "AES 4", "AES 5", "AES 6", "AES 7", "AES 8",
+  "AES 9", "AES 10", "AES 11", "AES 12", "AES 13", "AES 14", "AES 15", "AES 16"
+};
+
 static char *labels_raydat_ss[36] = {
   "A1.1", "A1.2", "A1.3", "A1.4", "A1.5", "A1.6", "A1.7", "A1.8",
   "A2.1", "A2.2", "A2.3", "A2.4", "A2.5", "A2.6", "A2.7", "A2.8",
@@ -226,6 +231,8 @@ void HDSPMixerOutput::setLabels()
 	    labels_input = labels_playback = labels_madi_qs;
 	    break;
 	}
+    } else if (HDSP_AES == type) {
+      labels_input = labels_playback = labels_aes;
     } else if (HDSPeAIO == type) {
       	switch (sm) {
 	case 0:
diff --git a/hdspmixer/src/HDSPMixerSelector.cxx b/hdspmixer/src/HDSPMixerSelector.cxx
index 8ac0ad3..23cb744 100644
--- a/hdspmixer/src/HDSPMixerSelector.cxx
+++ b/hdspmixer/src/HDSPMixerSelector.cxx
@@ -45,6 +45,11 @@ static char *destinations_madi_qs[8] = {
 };
 
 
+static char *destinations_aes[8] = {
+  "AES 1+2", "AES 3+4", "AES 5+6", "AES 7+8",
+  "AES 9+10", "AES 11+12", "AES 13+14", "AES 15+16",
+};
+
 static char *destinations_raydat_ss[18] = {
 
   "A1 1+2", "A1 3+4", "A1 5+6", "A1 7+8",
@@ -291,6 +296,9 @@ void HDSPMixerSelector::setLabels()
 	  destinations = destinations_madi_qs;
 	  break;
 	}
+    } else if (HDSP_AES == type) {
+      max_dest = 8;
+      destinations = destinations_aes;
     } else if (HDSPeAIO == type) {
 	switch (sm) {
 	case 0:
diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index e7d4e85..5ac3794 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -46,6 +46,7 @@ static void readregisters_cb(void *arg)
 
     if ((HDSPeMADI == w->cards[w->current_card]->type) ||
 	(HDSPeAIO == w->cards[w->current_card]->type) ||
+	(HDSP_AES == w->cards[w->current_card]->type) ||
 	(HDSPeRayDAT == w->cards[w->current_card]->type)) {
       if ((err = snd_hwdep_ioctl(hw, SNDRV_HDSPM_IOCTL_GET_PEAK_RMS, (void *)&hdspm_peak_rms)) < 0) {
 	fprintf(stderr, "HwDep ioctl failed. Metering stopped\n");
@@ -552,6 +553,15 @@ void HDSPMixerWindow::restoreDefaults(int card)
       maxdest[2] = 8;
       num_modes = 3;
       break;
+    case HDSP_AES: /* these cards support full channel count at all modes */
+      chnls[0] = 16;
+      chnls[1] = 16;
+      chnls[2] = 16;
+      maxdest[0] = 16;
+      maxdest[1] = 16;
+      maxdest[2] = 16;
+      num_modes = 3;
+      break;
      case HDSPeAIO:
       chnls[0] = 14;
       chnls[1] = 10;
diff --git a/hdspmixer/src/defines.h b/hdspmixer/src/defines.h
index 33559ab..7fcb4d3 100644
--- a/hdspmixer/src/defines.h
+++ b/hdspmixer/src/defines.h
@@ -27,6 +27,7 @@
 #define HDSPeMADI 10
 #define HDSPeRayDAT 11
 #define HDSPeAIO 12
+#define HDSP_AES 13 /* both AES32 and HDSPeAES? */
 
 #define HDSP_MAX_CHANNELS 64
 #define HDSP_MAX_DEST	  32
diff --git a/hdspmixer/src/hdspmixer.cxx b/hdspmixer/src/hdspmixer.cxx
index 866afda..a020b93 100644
--- a/hdspmixer/src/hdspmixer.cxx
+++ b/hdspmixer/src/hdspmixer.cxx
@@ -77,6 +77,10 @@ int main(int argc, char **argv)
             printf("RME MADI found!\n");
             hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card);
             cards++;
+        } else if (!strncmp(name, "RME AES32", 8)) {
+            printf("RME AES32 or HDSPe AES found!\n");
+            hdsp_cards[cards] = new HDSPMixerCard(HDSP_AES, card);
+            cards++;
         } else if (!strncmp(name, "RME RayDAT", 10)) {
             printf("RME RayDAT found!\n");
             hdsp_cards[cards] = new HDSPMixerCard(HDSPeRayDAT, card);
-- 
1.7.2.3
