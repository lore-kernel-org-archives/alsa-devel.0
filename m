From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 5/6] hdspmixer: Fix ALSA snd_ctl_open error
	when running with three cards.
Date: Thu, 24 Feb 2011 21:33:30 +0100
Message-ID: <1298579611-16573-6-git-send-email-adi@drcomp.erfurt.thur.de>
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

If three (or more) RME cards are installed in one box, hdspmixer will
try to open a non-existing 4th card, causing an error in snd_ctl_open
and finally terminates itself.

cards[] is a static array, and one must not read beyond the last
element. The solution is far from elegant, however, it's a rather
unintrusive change.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index 38e7b61..a2e3db8 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -219,7 +219,7 @@ static void restore_defaults_cb(Fl_Widget *widget, void *arg)
     snprintf(w->window_title, FL_PATH_MAX, "HDSPMixer");
     w->label(w->window_title);
     w->resetMixer();
-    while (w->cards[i] != NULL) {
+    while (i < MAX_CARDS && w->cards[i] != NULL) {
 	w->restoreDefaults(i++);
     }
     w->inputs->buttons->presets->preset_change(1);
@@ -408,7 +408,7 @@ void HDSPMixerWindow::load()
     if ((file = fopen(file_name, "r")) == NULL) {
 	int i = 0;
 	fl_alert("Error opening file %s for reading", file_name);
-	while (cards[i] != NULL) {
+	while (i < MAX_CARDS && cards[i] != NULL) {
 	    restoreDefaults(i++);
 	}
 	inputs->buttons->presets->preset_change(1);	
@@ -718,7 +718,7 @@ HDSPMixerWindow::HDSPMixerWindow(int x, int y, int w, int h, const char *label,
     setup = new HDSPMixerSetup(400, 260, "Level Meters Setup", this);
     about = new HDSPMixerAbout(360, 300, "About HDSPMixer", this);
     i = 0;
-    while (cards[i] != NULL) {
+    while (i < MAX_CARDS && cards[i] != NULL) {
 	cards[i++]->initializeCard(this);
     }
     size_range(MIN_WIDTH, MIN_HEIGHT, cards[current_card]->window_width, cards[current_card]->window_height);
@@ -729,7 +729,7 @@ HDSPMixerWindow::HDSPMixerWindow(int x, int y, int w, int h, const char *label,
     } else {
 	printf("Initializing default presets\n");
 	i = 0;
-	while (cards[i] != NULL) {
+	while (i < MAX_CARDS && cards[i] != NULL) {
 	    restoreDefaults(i++);
 	}
 	inputs->buttons->presets->preset_change(1);
@@ -738,7 +738,7 @@ HDSPMixerWindow::HDSPMixerWindow(int x, int y, int w, int h, const char *label,
     Fl::add_handler(handler_cb);
     Fl::add_timeout(0.030, readregisters_cb, this);
     i = 0;
-    while (cards[i] != NULL)
+    while (i < MAX_CARDS && cards[i] != NULL)
       inputs->buttons->cardselector->ActivateCard (i++);
 }
 
diff --git a/hdspmixer/src/HDSPMixerWindow.h b/hdspmixer/src/HDSPMixerWindow.h
index f10b729..0eb6f1a 100644
--- a/hdspmixer/src/HDSPMixerWindow.h
+++ b/hdspmixer/src/HDSPMixerWindow.h
@@ -73,8 +73,8 @@ public:
     Fl_Scroll *scroll;
     HDSPMixerSetup *setup;
     HDSPMixerAbout *about;
-    HDSPMixerPresetData *data[3][3][8]; /* data[card number][mode(ss/ds/qs)][preset number] */
-    HDSPMixerCard *cards[3];
+    HDSPMixerPresetData *data[MAX_CARDS][3][8]; /* data[card number][mode(ss/ds/qs)][preset number] */
+    HDSPMixerCard *cards[MAX_CARDS];
     HDSPMixerInputs *inputs;
     HDSPMixerPlaybacks *playbacks;
     HDSPMixerOutputs *outputs;
diff --git a/hdspmixer/src/defines.h b/hdspmixer/src/defines.h
index 2065620..d29c37c 100644
--- a/hdspmixer/src/defines.h
+++ b/hdspmixer/src/defines.h
@@ -47,6 +47,8 @@
 
 #define PAN_WIDTH 28
 
+#define MAX_CARDS	3
+
 typedef unsigned long long int int64;
 
 #endif
-- 
1.7.2.3
