From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 8/8] hdspmixer: Show cardname in window title
Date: Mon,  7 Mar 2011 19:03:09 +0100
Message-ID: <1299520989-14273-9-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1299520989-14273-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1299520989-14273-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

When running with more than one card, it isn't obvious which card is
shown.

Store the ALSA cardname in the corresponding class and show it in the
window title upon switching cards.

Also, don't show "(null)" but "(unsaved)" in case the user hasn't
selected a preset file.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerCard.cxx b/hdspmixer/src/HDSPMixerCard.cxx
index b754b20..f3205b9 100644
--- a/hdspmixer/src/HDSPMixerCard.cxx
+++ b/hdspmixer/src/HDSPMixerCard.cxx
@@ -163,11 +163,12 @@ int HDSPMixerCard::getSpeed()
     return 0;    
 }
 
-HDSPMixerCard::HDSPMixerCard(int cardtype, int id)
+HDSPMixerCard::HDSPMixerCard(int cardtype, int id, char *shortname)
 {
     type = cardtype;
     card_id = id;
     snprintf(name, 6, "hw:%i", card_id);
+    cardname = shortname;
     h9632_aeb.aebi = 0;
     h9632_aeb.aebo = 0;
     if (type == H9632) {
diff --git a/hdspmixer/src/HDSPMixerCard.h b/hdspmixer/src/HDSPMixerCard.h
index b721bd9..032c61f 100644
--- a/hdspmixer/src/HDSPMixerCard.h
+++ b/hdspmixer/src/HDSPMixerCard.h
@@ -24,6 +24,7 @@
 
 #include <stdlib.h>
 #include <stdio.h>
+#include <string>
 #include <alsa/asoundlib.h>
 #include <alsa/sound/hdsp.h>
 #include <alsa/sound/hdspm.h>
@@ -42,7 +43,8 @@ private:
 public:
     HDSPMixerWindow *basew;
     char name[6];
-    HDSPMixerCard(int cardtype, int id);
+    std::string cardname;
+    HDSPMixerCard(int cardtype, int id, char *shortname);
     int channels_input, channels_playback, window_width, window_height, card_id;
     int channels_output;
     int type;
diff --git a/hdspmixer/src/HDSPMixerCardSelector.cxx b/hdspmixer/src/HDSPMixerCardSelector.cxx
index 0e31847..d83c4c9 100644
--- a/hdspmixer/src/HDSPMixerCardSelector.cxx
+++ b/hdspmixer/src/HDSPMixerCardSelector.cxx
@@ -50,6 +50,7 @@ void HDSPMixerCardSelector::ActivateCard (int i)
   card = i + 1;
   basew->current_card = i;
   basew->cards[i]->setMode (basew->cards[i]->getSpeed ());
+  basew->setTitleWithFilename();
   redraw ();
 }
 
diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index 8f44c99..364d727 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -216,8 +216,7 @@ static void save_cb(Fl_Widget *widget, void *arg)
 	if (!(w->file_name = fl_file_chooser("Choose a file to save presets to :", "HDSPMixer preset file (*.mix)", NULL, 0))) return;
     }
     w->save();
-    snprintf(w->window_title, FL_PATH_MAX, "HDSPMixer - %s",  fl_filename_name(w->file_name));
-    w->label(w->window_title);
+    w->setTitleWithFilename();
 }
 
 static void make_default_cb(Fl_Widget *widget, void *arg)
@@ -241,8 +240,7 @@ static void restore_defaults_cb(Fl_Widget *widget, void *arg)
     w->prefs->deleteEntry("default_file");
     w->prefs->flush();
     w->file_name = NULL;
-    snprintf(w->window_title, FL_PATH_MAX, "HDSPMixer");
-    w->label(w->window_title);
+    w->setTitleWithFilename();
     w->resetMixer();
     while (i < MAX_CARDS && w->cards[i] != NULL) {
 	w->restoreDefaults(i++);
@@ -516,8 +514,7 @@ void HDSPMixerWindow::load()
 	}
     }
     fclose(file);
-    snprintf(window_title, FL_PATH_MAX, "HDSPMixer - %s",  fl_filename_name(file_name));
-    label(window_title);
+    setTitleWithFilename();
     resetMixer();
     inputs->buttons->presets->preset_change(1);
     return;
@@ -527,6 +524,29 @@ load_error:
     return;
 }
 
+void HDSPMixerWindow::setTitle(std::string suffix)
+{
+    std::string title = "HDSPMixer (";
+
+    title = title + cards[current_card]->cardname + ") "; /*cardname */
+    title = title + suffix;
+    snprintf(window_title, FL_PATH_MAX, "%s", title.c_str());
+    label(window_title);
+}
+
+void HDSPMixerWindow::setTitleWithFilename(void)
+{
+    const char *filename = fl_filename_name(file_name);
+
+    if (NULL == file_name) {
+        filename = "(unsaved)";
+    }
+
+    setTitle(filename);
+}
+
+
+
 void HDSPMixerWindow::restoreDefaults(int card)
 {
     int chnls[3];
@@ -883,16 +903,14 @@ void HDSPMixerWindow::checkState()
 	corrupt++;
 
     if (corrupt) {
-	if (!dirty) {
-	    dirty = 1;
-	    snprintf(window_title, FL_PATH_MAX, "HDSPMixer - %s *",  fl_filename_name(file_name));
-	    label(window_title);
-	    Fl::add_timeout(0.3, dirty_cb, (void *)this); 
-	}
+        if (!dirty) {
+            dirty = 1;
+            setTitleWithFilename();
+            Fl::add_timeout(0.3, dirty_cb, (void *)this); 
+        }
     } else {
-	snprintf(window_title, FL_PATH_MAX, "HDSPMixer - %s",  fl_filename_name(file_name));
-	label(window_title);
-	dirty = 0;
+        setTitleWithFilename();
+        dirty = 0;
     }
 }
 
diff --git a/hdspmixer/src/HDSPMixerWindow.h b/hdspmixer/src/HDSPMixerWindow.h
index 0eb6f1a..dfc7d59 100644
--- a/hdspmixer/src/HDSPMixerWindow.h
+++ b/hdspmixer/src/HDSPMixerWindow.h
@@ -93,6 +93,8 @@ public:
     void refreshMixerStrip(int idx, int src);
     void save();
     void load();
+    void setTitle(std::string suffix);
+    void setTitleWithFilename();
 };
 
 #endif
diff --git a/hdspmixer/src/hdspmixer.cxx b/hdspmixer/src/hdspmixer.cxx
index d57fe4c..4929863 100644
--- a/hdspmixer/src/hdspmixer.cxx
+++ b/hdspmixer/src/hdspmixer.cxx
@@ -39,7 +39,7 @@ int main(int argc, char **argv)
 {
     HDSPMixerWindow *window;
     HDSPMixerCard *hdsp_cards[3];
-    char *name;
+    char *name, *shortname;
     int card;
     int cards = 0;
 
@@ -55,42 +55,43 @@ int main(int argc, char **argv)
         }
 
         snd_card_get_longname(card, &name);
+        snd_card_get_name(card, &shortname);
         printf("Card %d: %s\n", card, name);
         if (!strncmp(name, "RME Hammerfall DSP + Multiface", 30)) {
             printf("Multiface found!\n");
-            hdsp_cards[cards] = new HDSPMixerCard(Multiface, card);
+            hdsp_cards[cards] = new HDSPMixerCard(Multiface, card, shortname);
             cards++;
         } else if (!strncmp(name, "RME Hammerfall DSP + Digiface", 29)) {
             printf("Digiface found!\n");
-            hdsp_cards[cards] = new HDSPMixerCard(Digiface, card);
+            hdsp_cards[cards] = new HDSPMixerCard(Digiface, card, shortname);
             cards++;
         } else if (!strncmp(name, "RME Hammerfall HDSP 9652", 24)) {
             printf("HDSP 9652 found!\n");
-            hdsp_cards[cards] = new HDSPMixerCard(H9652, card);
+            hdsp_cards[cards] = new HDSPMixerCard(H9652, card, shortname);
             cards++;
         } else if (!strncmp(name, "RME Hammerfall HDSP 9632", 24)) {
             printf("HDSP 9632 found!\n");
-            hdsp_cards[cards] = new HDSPMixerCard(H9632, card);
+            hdsp_cards[cards] = new HDSPMixerCard(H9632, card, shortname);
             cards++;
         } else if (!strncmp(name, "RME MADIface", 12)) {
             printf("RME MADIface found!\n");
-            hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card);
+            hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card, shortname);
             cards++;
         } else if (!strncmp(name, "RME MADI", 8)) {
             printf("RME MADI found!\n");
-            hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card);
+            hdsp_cards[cards] = new HDSPMixerCard(HDSPeMADI, card, shortname);
             cards++;
         } else if (!strncmp(name, "RME AES32", 8)) {
             printf("RME AES32 or HDSPe AES found!\n");
-            hdsp_cards[cards] = new HDSPMixerCard(HDSP_AES, card);
+            hdsp_cards[cards] = new HDSPMixerCard(HDSP_AES, card, shortname);
             cards++;
         } else if (!strncmp(name, "RME RayDAT", 10)) {
             printf("RME RayDAT found!\n");
-            hdsp_cards[cards] = new HDSPMixerCard(HDSPeRayDAT, card);
+            hdsp_cards[cards] = new HDSPMixerCard(HDSPeRayDAT, card, shortname);
             cards++;
         } else if (!strncmp(name, "RME AIO", 7)) {
             printf("RME AIO found!\n");
-            hdsp_cards[cards] = new HDSPMixerCard(HDSPeAIO, card);
+            hdsp_cards[cards] = new HDSPMixerCard(HDSPeAIO, card, shortname);
             cards++;
         } else if (!strncmp(name, "RME Hammerfall DSP", 18)) {
             printf("Uninitialized HDSP card found.\nUse hdsploader to upload configuration data to the card.\n");
-- 
1.7.4.1
