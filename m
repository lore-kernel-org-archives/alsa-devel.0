From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/4] hdspmixer: Add a 9th pseudo preset
Date: Mon,  4 Apr 2011 14:34:27 +0200
Message-ID: <1301920470-4615-2-git-send-email-adi@drcomp.erfurt.thur.de>
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

When switching cards, all current settings are lost. To have a place
where to store them, let's add a virtual 9th preset which can be used as
a temporary scratch pad.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
---
 hdspmixer/src/HDSPMixerIOMixer.cxx |    2 +-
 hdspmixer/src/HDSPMixerIOMixer.h   |    2 +-
 hdspmixer/src/HDSPMixerOutput.cxx  |    4 ++--
 hdspmixer/src/HDSPMixerOutput.h    |    2 +-
 hdspmixer/src/HDSPMixerWindow.cxx  |    2 +-
 hdspmixer/src/HDSPMixerWindow.h    |    2 +-
 hdspmixer/src/defines.h            |    6 ++++++
 7 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/hdspmixer/src/HDSPMixerIOMixer.cxx b/hdspmixer/src/HDSPMixerIOMixer.cxx
index 987be41..9283d64 100644
--- a/hdspmixer/src/HDSPMixerIOMixer.cxx
+++ b/hdspmixer/src/HDSPMixerIOMixer.cxx
@@ -38,7 +38,7 @@ HDSPMixerIOMixer::HDSPMixerIOMixer(int x, int y, int w, int h, int ch, int type)
 	p_iomixer_xpm = iomixer_r_xpm;
     }
     for (int j = 0; j < MAX_CARDS; ++j) {
-	for (int i = 0; i < 8; ++i) {
+	for (int i = 0; i < NUM_PRESETS; ++i) {
 	    data[j][0][i] = new HDSPMixerStripData();
 	    data[j][1][i] = new HDSPMixerStripData();
 	    data[j][2][i] = new HDSPMixerStripData();
diff --git a/hdspmixer/src/HDSPMixerIOMixer.h b/hdspmixer/src/HDSPMixerIOMixer.h
index 2ec7f05..aa12487 100644
--- a/hdspmixer/src/HDSPMixerIOMixer.h
+++ b/hdspmixer/src/HDSPMixerIOMixer.h
@@ -56,7 +56,7 @@ private:
 	std::stringstream channel_name;
     void update_child(Fl_Widget &widget);
 public:
-    HDSPMixerStripData *data[MAX_CARDS][3][8]; /* data[card][mode(ss/ds/qs)][preset number] */
+    HDSPMixerStripData *data[MAX_CARDS][3][NUM_PRESETS]; /* data[card][mode(ss/ds/qs)][preset number] */
     HDSPMixerPan *pan;
     HDSPMixerFader *fader;
     HDSPMixerPeak *peak;
diff --git a/hdspmixer/src/HDSPMixerOutput.cxx b/hdspmixer/src/HDSPMixerOutput.cxx
index 5047825..f5981b0 100644
--- a/hdspmixer/src/HDSPMixerOutput.cxx
+++ b/hdspmixer/src/HDSPMixerOutput.cxx
@@ -170,8 +170,8 @@ static char const *labels_9632_qs[8] = {
 HDSPMixerOutput::HDSPMixerOutput(int x, int y, int w, int h, int num):Fl_Group(x, y, w, h)
 {
 
-    for (int j = 0; j < 3; ++j) {
-	for (int i = 0; i < 8; ++i) {
+    for (int j = 0; j < MAX_CARDS; ++j) {
+	for (int i = 0; i < NUM_PRESETS; ++i) {
 	    data[j][0][i] = new HDSPMixerOutputData();
 	    data[j][1][i] = new HDSPMixerOutputData();
 	    data[j][2][i] = new HDSPMixerOutputData();
diff --git a/hdspmixer/src/HDSPMixerOutput.h b/hdspmixer/src/HDSPMixerOutput.h
index 2bc3d5c..6278cfd 100644
--- a/hdspmixer/src/HDSPMixerOutput.h
+++ b/hdspmixer/src/HDSPMixerOutput.h
@@ -52,7 +52,7 @@ private:
     HDSPMixerWindow *basew;    
     void update_child(Fl_Widget& widget);
 public:
-    HDSPMixerOutputData *data[MAX_CARDS][3][8]; /* data[card][mode(ss/ds/qs)][preset number] */
+    HDSPMixerOutputData *data[MAX_CARDS][3][NUM_PRESETS]; /* data[card][mode(ss/ds/qs)][preset number] */
     HDSPMixerFader *fader;
     HDSPMixerGain *gain;
     HDSPMixerMeter *meter;
diff --git a/hdspmixer/src/HDSPMixerWindow.cxx b/hdspmixer/src/HDSPMixerWindow.cxx
index 960ec0f..a327904 100644
--- a/hdspmixer/src/HDSPMixerWindow.cxx
+++ b/hdspmixer/src/HDSPMixerWindow.cxx
@@ -791,7 +791,7 @@ HDSPMixerWindow::HDSPMixerWindow(int x, int y, int w, int h, const char *label,
 	}	
     }
     for (int j = 0; j < MAX_CARDS; j++) {
-	for (int i = 0; i < 8; ++i) {
+	for (int i = 0; i < NUM_PRESETS; ++i) {
 	    data[j][0][i] = new HDSPMixerPresetData();
 	    data[j][1][i] = new HDSPMixerPresetData();
 	    data[j][2][i] = new HDSPMixerPresetData();
diff --git a/hdspmixer/src/HDSPMixerWindow.h b/hdspmixer/src/HDSPMixerWindow.h
index dfc7d59..0c2674f 100644
--- a/hdspmixer/src/HDSPMixerWindow.h
+++ b/hdspmixer/src/HDSPMixerWindow.h
@@ -73,7 +73,7 @@ public:
     Fl_Scroll *scroll;
     HDSPMixerSetup *setup;
     HDSPMixerAbout *about;
-    HDSPMixerPresetData *data[MAX_CARDS][3][8]; /* data[card number][mode(ss/ds/qs)][preset number] */
+    HDSPMixerPresetData *data[MAX_CARDS][3][NUM_PRESETS]; /* data[card number][mode(ss/ds/qs)][preset number] */
     HDSPMixerCard *cards[MAX_CARDS];
     HDSPMixerInputs *inputs;
     HDSPMixerPlaybacks *playbacks;
diff --git a/hdspmixer/src/defines.h b/hdspmixer/src/defines.h
index d29c37c..af5c382 100644
--- a/hdspmixer/src/defines.h
+++ b/hdspmixer/src/defines.h
@@ -49,6 +49,12 @@
 
 #define MAX_CARDS	3
 
+/* Number of presets. 8 presets visible to the user, the 9th is used for
+ * holding temporary mixer data when switching cards, so it's not a real
+ * preset but more like a scratch pad.
+ */
+#define NUM_PRESETS	9
+
 typedef unsigned long long int int64;
 
 #endif
-- 
1.7.4.1
