From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/8] hdspmixer: Replace hardcoded 3 by MAX_CARDS
Date: Mon,  7 Mar 2011 19:03:02 +0100
Message-ID: <1299520989-14273-2-git-send-email-adi@drcomp.erfurt.thur.de>
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

We have a define for the number of cards. Use it.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerIOMixer.cxx b/hdspmixer/src/HDSPMixerIOMixer.cxx
index a81f4a2..987be41 100644
--- a/hdspmixer/src/HDSPMixerIOMixer.cxx
+++ b/hdspmixer/src/HDSPMixerIOMixer.cxx
@@ -37,7 +37,7 @@ HDSPMixerIOMixer::HDSPMixerIOMixer(int x, int y, int w, int h, int ch, int type)
 	relative_num = channel_num-1;
 	p_iomixer_xpm = iomixer_r_xpm;
     }
-    for (int j = 0; j < 3; ++j) {
+    for (int j = 0; j < MAX_CARDS; ++j) {
 	for (int i = 0; i < 8; ++i) {
 	    data[j][0][i] = new HDSPMixerStripData();
 	    data[j][1][i] = new HDSPMixerStripData();
diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index 27003a0..f52470f 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -344,7 +344,7 @@ void HDSPMixerWindow::save()
 	inputs->buttons->presets->save_preset(current_preset+1);
     }
     for (int speed = 0; speed < 3; ++speed) {
-	for (int card = 0; card < 3; ++card) {
+	for (int card = 0; card < MAX_CARDS; ++card) {
 	    for (int preset = 0; preset < 8; ++preset) {
 		for (int channel = 0; channel < HDSP_MAX_CHANNELS; ++channel) {
 		    /* inputs pans and volumes */
@@ -440,7 +440,7 @@ void HDSPMixerWindow::load()
 	return;
     }
     for (int speed = 0; speed < 3; ++speed) {
-	for (int card = 0; card < 3; ++card) {
+	for (int card = 0; card < MAX_CARDS; ++card) {
 	    for (int preset = 0; preset < 8; ++preset) {
 		for (int channel = 0; channel < HDSP_MAX_CHANNELS; ++channel) {
 		    /* inputs pans and volumes */
@@ -705,7 +705,7 @@ HDSPMixerWindow::HDSPMixerWindow(int x, int y, int w, int h, const char *label,
 	    prefs->flush();
 	}	
     }
-    for (int j = 0; j < 3; ++j) {
+    for (int j = 0; j < MAX_CARDS; j++) {
 	for (int i = 0; i < 8; ++i) {
 	    data[j][0][i] = new HDSPMixerPresetData();
 	    data[j][1][i] = new HDSPMixerPresetData();
-- 
1.7.4.1
