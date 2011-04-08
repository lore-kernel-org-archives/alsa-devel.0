From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/3] hdspmixer: Handle channel count in old
	(v1.0.23) preset file format
Date: Fri,  8 Apr 2011 19:58:36 +0200
Message-ID: <1302285517-11127-3-git-send-email-adi@drcomp.erfurt.thur.de>
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

When reading a preset file, v1.0.23 only used 26 channels instead of 64.
Reading 64 channels from a 26 channel file won't work, hence set it
depending on the file format version.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index d6d28e3..fb41721 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -488,6 +488,7 @@ void HDSPMixerWindow::load()
     char buffer[sizeof(header)];
     bool ondisk_v1 = false;
     int pan_array_size = 14; /* old (pre 1.0.24) HDSP_MAX_DEST */
+    int channels_per_card = 26; /* old (pre 1.0.24) HDSP_MAX_CHANNELS */
 
     if (fread(&buffer, sizeof(char), sizeof(buffer), file) != sizeof(buffer)) {
             goto load_error;
@@ -496,6 +497,7 @@ void HDSPMixerWindow::load()
         /* new ondisk format found */
         ondisk_v1 = true;
         pan_array_size = HDSP_MAX_DEST;
+        channels_per_card = HDSP_MAX_CHANNELS;
     } else {
         /* old format, rewind to the start and simply read all data */
         rewind(file);
@@ -504,7 +506,7 @@ void HDSPMixerWindow::load()
     for (int speed = 0; speed < 3; ++speed) {
 	for (int card = 0; card < MAX_CARDS; ++card) {
 	    for (int preset = 0; preset < 8; ++preset) {
-		for (int channel = 0; channel < HDSP_MAX_CHANNELS; ++channel) {
+		for (int channel = 0; channel < channels_per_card; ++channel) {
 		    /* inputs pans and volumes */
 		    if (fread((void *)&(inputs->strips[channel]->data[card][speed][preset]->pan_pos[0]), sizeof(int), pan_array_size, file) != pan_array_size) {
 			goto load_error;
-- 
1.7.4.1
