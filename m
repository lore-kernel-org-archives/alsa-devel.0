From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] hdspmixer: fix drawing problems with black
	background
Date: Sat,  2 Apr 2011 14:44:11 +0200
Message-ID: <b3f40168e52421fa2468654f41f6269d7a03d62d.1301748214.git.tim@klingt.org>
References: <1301653709.3951.52.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 65537103839
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 14:44:19 +0200 (CEST)
In-Reply-To: <1301653709.3951.52.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Tim Blechmann <tim@klingt.org>
List-Id: alsa-devel@alsa-project.org

- use foreground color instead of black
- HDSPMixerSelector: set colors before setting labels

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 hdspmixer/src/HDSPMixerAboutText.cxx |    2 +-
 hdspmixer/src/HDSPMixerIOMixer.cxx   |    2 +-
 hdspmixer/src/HDSPMixerOutput.cxx    |    2 +-
 hdspmixer/src/HDSPMixerSelector.cxx  |    4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hdspmixer/src/HDSPMixerAboutText.cxx b/hdspmixer/src/HDSPMixerAboutText.cxx
index c8c9b1a..26a5bbc 100644
--- a/hdspmixer/src/HDSPMixerAboutText.cxx
+++ b/hdspmixer/src/HDSPMixerAboutText.cxx
@@ -48,7 +48,7 @@ HDSPMixerAboutText::HDSPMixerAboutText(int x, int y, int w, int h):Fl_Widget(x,
 
 void HDSPMixerAboutText::draw()
 {
-	fl_color(FL_BLACK);
+	fl_color(FL_FOREGROUND_COLOR);
 	fl_font(FL_HELVETICA, 10);
 	fl_draw(text, x(), y(), w(), h(), FL_ALIGN_LEFT);
 }
diff --git a/hdspmixer/src/HDSPMixerIOMixer.cxx b/hdspmixer/src/HDSPMixerIOMixer.cxx
index 987be41..b5c293b 100644
--- a/hdspmixer/src/HDSPMixerIOMixer.cxx
+++ b/hdspmixer/src/HDSPMixerIOMixer.cxx
@@ -71,7 +71,7 @@ void HDSPMixerIOMixer::draw()
     Fl_Widget *const* a = array();
     if (damage() & ~FL_DAMAGE_CHILD) {
 	draw_background();
-	fl_color(FL_BLACK);
+	fl_color(FL_FOREGROUND_COLOR);
 	fl_font(FL_HELVETICA, 8);
 	fl_draw(channel_name.str().c_str(), x()+4, y()+225, 27, 9, FL_ALIGN_CENTER);
 	for (int i=children(); i--;) {
diff --git a/hdspmixer/src/HDSPMixerOutput.cxx b/hdspmixer/src/HDSPMixerOutput.cxx
index 5047825..f30d8c6 100644
--- a/hdspmixer/src/HDSPMixerOutput.cxx
+++ b/hdspmixer/src/HDSPMixerOutput.cxx
@@ -303,7 +303,7 @@ void HDSPMixerOutput::draw()
     Fl_Widget*const* a = array();
     if (damage() & ~FL_DAMAGE_CHILD) {
 	draw_background();
-	fl_color(FL_BLACK);
+	fl_color(FL_FOREGROUND_COLOR);
 	fl_font(FL_HELVETICA, 8);
 	fl_draw(labels_playback[out_num], x()+4, y()+193, 27, 9, FL_ALIGN_CENTER);
 	for (int i=children(); i--;) {
diff --git a/hdspmixer/src/HDSPMixerSelector.cxx b/hdspmixer/src/HDSPMixerSelector.cxx
index 098658f..12f186f 100644
--- a/hdspmixer/src/HDSPMixerSelector.cxx
+++ b/hdspmixer/src/HDSPMixerSelector.cxx
@@ -164,10 +164,10 @@ HDSPMixerSelector::HDSPMixerSelector(int x, int y, int w, int h):Fl_Menu_(x, y,
     max_dest = 0;
     selected = 0;
     basew = (HDSPMixerWindow *)window();
-    setLabels();
     textfont(FL_HELVETICA);
     textsize(8);
-    textcolor(FL_BLACK);
+    textcolor(FL_FOREGROUND_COLOR);
+    setLabels();
 }
 
 void HDSPMixerSelector::draw() {
-- 
1.7.4.1
