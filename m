From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 6/6] hdspmixer: Fix metering for non-MADI cards
Date: Thu, 24 Feb 2011 21:33:31 +0100
Message-ID: <1298579611-16573-7-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298579611-16573-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298579611-16573-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Currently, hdsp and hdspm use different ioctls. Consequently, the metering
is wrong. To avoid code duplication, use pointers to the corresponding
struct members.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index a2e3db8..27003a0 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -31,6 +31,9 @@ static void readregisters_cb(void *arg)
     snd_hwdep_t *hw;
     hdsp_peak_rms_t hdsp_peak_rms;
     struct hdspm_peak_rms hdspm_peak_rms;
+    bool isMADI = false;
+    uint32_t *input_peaks, *playback_peaks, *output_peaks;
+    uint64_t *input_rms, *playback_rms, *output_rms;
     
     HDSPMixerWindow *w = (HDSPMixerWindow *)arg;
 
@@ -48,6 +51,7 @@ static void readregisters_cb(void *arg)
 	(HDSPeAIO == w->cards[w->current_card]->type) ||
 	(HDSP_AES == w->cards[w->current_card]->type) ||
 	(HDSPeRayDAT == w->cards[w->current_card]->type)) {
+      isMADI = true;
       if ((err = snd_hwdep_ioctl(hw, SNDRV_HDSPM_IOCTL_GET_PEAK_RMS, (void *)&hdspm_peak_rms)) < 0) {
 	fprintf(stderr, "HwDep ioctl failed. Metering stopped\n");
 	snd_hwdep_close(hw);
@@ -62,33 +66,54 @@ static void readregisters_cb(void *arg)
     }
     snd_hwdep_close(hw);
 
-    // check for speed change
-    if (hdspm_peak_rms.speed != w->cards[w->current_card]->speed_mode) {
-      w->cards[w->current_card]->setMode(hdspm_peak_rms.speed);
+    if (isMADI) {
+        // check for speed change
+	    if (hdspm_peak_rms.speed != w->cards[w->current_card]->speed_mode) {
+		    w->cards[w->current_card]->setMode(hdspm_peak_rms.speed);
+	    }
+        input_peaks = hdspm_peak_rms.input_peaks;
+        playback_peaks = hdspm_peak_rms.playback_peaks;
+        output_peaks = hdspm_peak_rms.output_peaks;
+
+        input_rms = hdspm_peak_rms.input_rms;
+        playback_rms = hdspm_peak_rms.playback_rms;
+        output_rms = hdspm_peak_rms.output_rms;
+    } else {
+        /* speed changes on non-MADI are already handled via alsactl_cb and
+         * getSpeed(), but the metering structs differ.
+         */
+        input_peaks = hdsp_peak_rms.input_peaks;
+        playback_peaks = hdsp_peak_rms.playback_peaks;
+        output_peaks = hdsp_peak_rms.output_peaks;
+
+        input_rms = hdsp_peak_rms.input_rms;
+        playback_rms = hdsp_peak_rms.playback_rms;
+        output_rms = hdsp_peak_rms.output_rms;
     }
 
+    /* update the meter */
     if (w->inputs->buttons->input) {
-      for (int i = 0; i < w->cards[w->current_card]->channels_input; ++i) {
-	w->inputs->strips[i]->meter->update(hdspm_peak_rms.input_peaks[(w->cards[w->current_card]->meter_map_input[i])] & 0xffffff00,
-					    hdspm_peak_rms.input_peaks[(w->cards[w->current_card]->meter_map_input[i])] & 0xf,
-					    hdspm_peak_rms.input_rms[(w->cards[w->current_card]->meter_map_input[i])]);
-      }
+        for (int i = 0; i < w->cards[w->current_card]->channels_input; ++i) {
+            w->inputs->strips[i]->meter->update(input_peaks[(w->cards[w->current_card]->meter_map_input[i])] & 0xffffff00,
+                    input_peaks[(w->cards[w->current_card]->meter_map_input[i])] & 0xf,
+                    input_rms[(w->cards[w->current_card]->meter_map_input[i])]);
+        }
     }
-     
+
     if (w->inputs->buttons->playback) {
-      for (int i = 0; i < w->cards[w->current_card]->channels_playback; ++i) {
-	w->playbacks->strips[i]->meter->update(hdspm_peak_rms.playback_peaks[(w->cards[w->current_card]->meter_map_playback[i])] & 0xffffff00,
-					       hdspm_peak_rms.playback_peaks[(w->cards[w->current_card]->meter_map_playback[i])] & 0xf,
-					       hdspm_peak_rms.playback_rms[(w->cards[w->current_card]->meter_map_playback[i])]);
-      }
+        for (int i = 0; i < w->cards[w->current_card]->channels_playback; ++i) {
+            w->playbacks->strips[i]->meter->update(playback_peaks[(w->cards[w->current_card]->meter_map_playback[i])] & 0xffffff00,
+                    playback_peaks[(w->cards[w->current_card]->meter_map_playback[i])] & 0xf,
+                    playback_rms[(w->cards[w->current_card]->meter_map_playback[i])]);
+        }
     }
 
     if (w->inputs->buttons->output) {
-      for (int i = 0; i < w->cards[w->current_card]->channels_playback; ++i) {
-	w->outputs->strips[i]->meter->update(hdspm_peak_rms.output_peaks[(w->cards[w->current_card]->meter_map_playback[i])] & 0xffffff00,
-					     hdspm_peak_rms.output_peaks[(w->cards[w->current_card]->meter_map_playback[i])] & 0xf,
-					     hdspm_peak_rms.output_rms[(w->cards[w->current_card]->meter_map_playback[i])]);
-      }
+        for (int i = 0; i < w->cards[w->current_card]->channels_playback; ++i) {
+            w->outputs->strips[i]->meter->update(output_peaks[(w->cards[w->current_card]->meter_map_playback[i])] & 0xffffff00,
+                    output_peaks[(w->cards[w->current_card]->meter_map_playback[i])] & 0xf,
+                    output_rms[(w->cards[w->current_card]->meter_map_playback[i])]);
+        }
     }
 
     Fl::add_timeout(0.03, readregisters_cb, w);
-- 
1.7.2.3
