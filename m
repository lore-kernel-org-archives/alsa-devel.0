From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/4] hdspmixer: Save preset before switching
	cards
Date: Mon,  4 Apr 2011 14:34:28 +0200
Message-ID: <1301920470-4615-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1301920470-4615-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1301920470-4615-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

When running with more than one card, switching cards would lose any
changes made to the current card. To avoid this inconvenience, save the
current settings to the virtual 9th preset and restore them when
switching back.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
---
 hdspmixer/src/HDSPMixerCard.cxx         |    1 +
 hdspmixer/src/HDSPMixerCard.h           |    2 +
 hdspmixer/src/HDSPMixerCardSelector.cxx |    2 +
 hdspmixer/src/HDSPMixerWindow.cxx       |   41 ++++++++++++++++++++++++++++++-
 hdspmixer/src/HDSPMixerWindow.h         |    2 +
 5 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/hdspmixer/src/HDSPMixerCard.cxx b/hdspmixer/src/HDSPMixerCard.cxx
index f3205b9..fbd5de5 100644
--- a/hdspmixer/src/HDSPMixerCard.cxx
+++ b/hdspmixer/src/HDSPMixerCard.cxx
@@ -186,6 +186,7 @@ HDSPMixerCard::HDSPMixerCard(int cardtype, int id, char *shortname)
     
     /* Set channels and mappings */
     adjustSettings();
+    last_preset = last_dirty = 0;
         
     basew = NULL;
 }
diff --git a/hdspmixer/src/HDSPMixerCard.h b/hdspmixer/src/HDSPMixerCard.h
index 032c61f..d2ef8a6 100644
--- a/hdspmixer/src/HDSPMixerCard.h
+++ b/hdspmixer/src/HDSPMixerCard.h
@@ -48,6 +48,8 @@ public:
     int channels_input, channels_playback, window_width, window_height, card_id;
     int channels_output;
     int type;
+    int last_preset; /* Last activated preset before switching to another card */
+    int last_dirty; /* Last dirty flag before switching to another card */
     char *channel_map_input, *channel_map_playback;
     char *dest_map;
     char *meter_map_input, *meter_map_playback;
diff --git a/hdspmixer/src/HDSPMixerCardSelector.cxx b/hdspmixer/src/HDSPMixerCardSelector.cxx
index d83c4c9..d685009 100644
--- a/hdspmixer/src/HDSPMixerCardSelector.cxx
+++ b/hdspmixer/src/HDSPMixerCardSelector.cxx
@@ -48,9 +48,11 @@ void HDSPMixerCardSelector::draw()
 void HDSPMixerCardSelector::ActivateCard (int i)
 {
   card = i + 1;
+  basew->stashPreset(); /* save current mixer state */
   basew->current_card = i;
   basew->cards[i]->setMode (basew->cards[i]->getSpeed ());
   basew->setTitleWithFilename();
+  basew->unstashPreset(); /* restore previous mixer state */
   redraw ();
 }
 
diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index a327904..7848190 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -609,7 +609,44 @@ void HDSPMixerWindow::setTitleWithFilename(void)
     setTitle(filename);
 }
 
+void HDSPMixerWindow::stashPreset(void)
+{
+    cards[current_card]->last_preset = current_preset;
+    cards[current_card]->last_dirty = dirty;
+    /* save the current mixer state to the virtual 9th preset */
+    inputs->buttons->presets->save_preset(9);
+}
 
+void HDSPMixerWindow::unstashPreset(void)
+{
+    /* load temporary data from virtual 9th preset */
+    inputs->buttons->presets->restore_preset(9);
+    
+    current_preset = cards[current_card]->last_preset;
+    /* Internal notion of playback in use. Relevant for blinking buttons */
+    inputs->buttons->presets->preset = current_preset + 1;
+    dirty = cards[current_card]->last_dirty;
+    /* Preset masks (which preset button is green) */
+    inputs->buttons->presets->presetmask = (int)pow(2, current_preset);
+    if (dirty) {
+        /* make the buttons blink if it's unsaved. We need to remove any
+         * existing triggers to dirty_cb, because dirty_cb is called
+         * every 0.3 seconds and enabling/disabling (highlight/unlight) the
+         * buttons, so if we have too many callbacks, the buttons would
+         * remain in one state --> no blinking. We need exactly one.
+         */
+        Fl::remove_timeout(dirty_cb, (void *)this);
+        Fl::add_timeout(0.3, dirty_cb, (void *)this);
+    } else {
+        /* Hack. I don't know why this is necessary, but if we're clean,
+         * we need to recall the preset again to correctly reflect
+         * the dirty/undirty state.
+         *
+         * Though it's a little bit redundant, it at least won't do any harm.
+         */
+        inputs->buttons->presets->preset_change(current_preset+1);
+    }
+}
 
 void HDSPMixerWindow::restoreDefaults(int card)
 {
@@ -848,8 +885,10 @@ HDSPMixerWindow::HDSPMixerWindow(int x, int y, int w, int h, const char *label,
     Fl::add_handler(handler_cb);
     Fl::add_timeout(0.030, readregisters_cb, this);
     i = 0;
-    while (i < MAX_CARDS && cards[i] != NULL)
+    while (i < MAX_CARDS && cards[i] != NULL) {
+      current_card = i;
       inputs->buttons->cardselector->ActivateCard (i++);
+    }
 }
 
 int HDSPMixerWindow::handle(int e) 
diff --git a/hdspmixer/src/HDSPMixerWindow.h b/hdspmixer/src/HDSPMixerWindow.h
index 0c2674f..134db3e 100644
--- a/hdspmixer/src/HDSPMixerWindow.h
+++ b/hdspmixer/src/HDSPMixerWindow.h
@@ -95,6 +95,8 @@ public:
     void load();
     void setTitle(std::string suffix);
     void setTitleWithFilename();
+    void stashPreset();
+    void unstashPreset();
 };
 
 #endif
-- 
1.7.4.1
