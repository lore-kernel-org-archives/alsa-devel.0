From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/3] hdspmixer: Fix read/write from/to preset
	files on MADI-like cards
Date: Fri,  8 Apr 2011 19:58:35 +0200
Message-ID: <1302285517-11127-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1302285517-11127-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1302285517-11127-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

The old hdspmixer (prior to e24e56795ea57e3dd7da45063ab71f04e231192d,
that is pre-1.0.24) has used the hard-coded value "14" for
reading/storing 14 ints from/to preset files, however, it's actually
HDSP_MAX_DEST that should be used.

HDSP_MAX_DEST was bumped from 14 to 32 to allow for MADI cards (32
stereo pairs equal 64 output channels on MADI cards)

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index 75fbc4f..d6d28e3 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -337,7 +337,25 @@ static int handler_cb(int event)
 
 void HDSPMixerWindow::save() 
 {
+    const int pan_array_size =
+        sizeof(inputs->strips[0]->data[0][0][0]->pan_pos) /
+        sizeof(inputs->strips[0]->data[0][0][0]->pan_pos[0]);
+    /* MixerStripData defines pan_pos[HDSP_MAX_DEST], but just in case this
+     * will ever change, let's detect it early and fail safely instead of
+     * reading/writing garbage from/to preset files
+     */
+    assert (HDSP_MAX_DEST == pan_array_size);
+
+    /* also make sure that fader_pos[] has the same size as pan_pos. This comes
+     * naturally, but just to be sure.
+     */
+    assert (pan_array_size ==
+            sizeof(inputs->strips[0]->data[0][0][0]->fader_pos) /
+            sizeof(inputs->strips[0]->data[0][0][0]->fader_pos[0]));
+
+
     FILE *file;
+
     if ((file = fopen(file_name, "w")) == NULL) {
 	fl_alert("Error opening file %s for saving", file_name);
     }
@@ -356,17 +374,17 @@ void HDSPMixerWindow::save()
 	    for (int preset = 0; preset < 8; ++preset) {
 		for (int channel = 0; channel < HDSP_MAX_CHANNELS; ++channel) {
 		    /* inputs pans and volumes */
-		    if (fwrite((void *)&(inputs->strips[channel]->data[card][speed][preset]->pan_pos[0]), sizeof(int), 14, file) != 14) {
+		    if (fwrite((void *)&(inputs->strips[channel]->data[card][speed][preset]->pan_pos[0]), sizeof(int), pan_array_size, file) != pan_array_size) {
 			goto save_error;
 		    }
-		    if (fwrite((void *)&(inputs->strips[channel]->data[card][speed][preset]->fader_pos[0]), sizeof(int), 14, file) != 14) {
+		    if (fwrite((void *)&(inputs->strips[channel]->data[card][speed][preset]->fader_pos[0]), sizeof(int), pan_array_size, file) != pan_array_size) {
 			goto save_error;
 		    }
 		    /* playbacks pans and volumes */
-		    if (fwrite((void *)&(playbacks->strips[channel]->data[card][speed][preset]->pan_pos[0]), sizeof(int), 14, file) != 14) {
+		    if (fwrite((void *)&(playbacks->strips[channel]->data[card][speed][preset]->pan_pos[0]), sizeof(int), pan_array_size, file) != pan_array_size) {
 			goto save_error;
 		    }
-		    if (fwrite((void *)&(playbacks->strips[channel]->data[card][speed][preset]->fader_pos[0]), sizeof(int), 14, file) != 14) {
+		    if (fwrite((void *)&(playbacks->strips[channel]->data[card][speed][preset]->fader_pos[0]), sizeof(int), pan_array_size, file) != pan_array_size) {
 			goto save_error;
 		    }
 		    /* inputs mute/solo/dest */
@@ -469,12 +487,15 @@ void HDSPMixerWindow::load()
     /* check for new ondisk format */
     char buffer[sizeof(header)];
     bool ondisk_v1 = false;
+    int pan_array_size = 14; /* old (pre 1.0.24) HDSP_MAX_DEST */
+
     if (fread(&buffer, sizeof(char), sizeof(buffer), file) != sizeof(buffer)) {
             goto load_error;
     }
     if (0 == strncmp(buffer, header, sizeof(buffer))) {
         /* new ondisk format found */
         ondisk_v1 = true;
+        pan_array_size = HDSP_MAX_DEST;
     } else {
         /* old format, rewind to the start and simply read all data */
         rewind(file);
@@ -485,17 +506,17 @@ void HDSPMixerWindow::load()
 	    for (int preset = 0; preset < 8; ++preset) {
 		for (int channel = 0; channel < HDSP_MAX_CHANNELS; ++channel) {
 		    /* inputs pans and volumes */
-		    if (fread((void *)&(inputs->strips[channel]->data[card][speed][preset]->pan_pos[0]), sizeof(int), 14, file) != 14) {
+		    if (fread((void *)&(inputs->strips[channel]->data[card][speed][preset]->pan_pos[0]), sizeof(int), pan_array_size, file) != pan_array_size) {
 			goto load_error;
 		    }
-		    if (fread((void *)&(inputs->strips[channel]->data[card][speed][preset]->fader_pos[0]), sizeof(int), 14, file) != 14) {
+		    if (fread((void *)&(inputs->strips[channel]->data[card][speed][preset]->fader_pos[0]), sizeof(int), pan_array_size, file) != pan_array_size) {
 			goto load_error;
 		    }
 		    /* playbacks pans and volumes */
-		    if (fread((void *)&(playbacks->strips[channel]->data[card][speed][preset]->pan_pos[0]), sizeof(int), 14, file) != 14) {
+		    if (fread((void *)&(playbacks->strips[channel]->data[card][speed][preset]->pan_pos[0]), sizeof(int), pan_array_size, file) != pan_array_size) {
 			goto load_error;
 		    }
-		    if (fread((void *)&(playbacks->strips[channel]->data[card][speed][preset]->fader_pos[0]), sizeof(int), 14, file) != 14) {
+		    if (fread((void *)&(playbacks->strips[channel]->data[card][speed][preset]->fader_pos[0]), sizeof(int), pan_array_size, file) != pan_array_size) {
 			goto load_error;
 		    }
 		    /* inputs mute/solo/dest */
-- 
1.7.4.1
