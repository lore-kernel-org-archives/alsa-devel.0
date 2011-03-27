From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH 2/2] hdspconf: use foreground color instead of
	black
Date: Sun, 27 Mar 2011 13:34:20 +0200
Message-ID: <7d1508ccac4be2d08ce424b140530c66767b84ba.1301225609.git.tim@klingt.org>
References: <76cbed03b80210d5905e3017ac0dff1b919edd82.1301225609.git.tim@klingt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <76cbed03b80210d5905e3017ac0dff1b919edd82.1301225609.git.tim@klingt.org>
In-Reply-To: <76cbed03b80210d5905e3017ac0dff1b919edd82.1301225609.git.tim@klingt.org>
References: <76cbed03b80210d5905e3017ac0dff1b919edd82.1301225609.git.tim@klingt.org>
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
Cc: Tim Blechmann <tim@klingt.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

if the background color of the color scheme is black, black text is hard
to read. using the foreground color fixes this problem

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 hdspconf/src/HC_AboutText.cxx   |    2 +-
 hdspconf/src/HC_AutoSyncRef.cxx |    2 +-
 hdspconf/src/HC_SpdifFreq.cxx   |    2 +-
 hdspconf/src/HC_SyncCheck.cxx   |    2 +-
 hdspconf/src/HC_SystemClock.cxx |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hdspconf/src/HC_AboutText.cxx b/hdspconf/src/HC_AboutText.cxx
index 4014bf1..2205d15 100644
--- a/hdspconf/src/HC_AboutText.cxx
+++ b/hdspconf/src/HC_AboutText.cxx
@@ -39,7 +39,7 @@ HC_AboutText::HC_AboutText(int x, int y, int w, int h):Fl_Widget(x, y, w, h, "Ab
 
 void HC_AboutText::draw()
 {
-	fl_color(FL_BLACK);
+	fl_color(FL_FOREGROUND_COLOR);
 	fl_font(FL_HELVETICA, 10);
 	fl_draw(text, x(), y(), w(), h(), FL_ALIGN_LEFT);
 }
diff --git a/hdspconf/src/HC_AutoSyncRef.cxx b/hdspconf/src/HC_AutoSyncRef.cxx
index f20bbad..4f569e4 100644
--- a/hdspconf/src/HC_AutoSyncRef.cxx
+++ b/hdspconf/src/HC_AutoSyncRef.cxx
@@ -37,7 +37,7 @@ void HC_AutoSyncRef::draw()
 	fl_color(FL_BACKGROUND_COLOR);
 	fl_rectf(x(), y(), w(), h());
 	draw_box(x(), y(), w(), h(), FL_WHITE);
-	fl_color(FL_BLACK);
+	fl_color(FL_FOREGROUND_COLOR);
 	fl_font(FL_HELVETICA, 10);
 	fl_draw("Input", x()+4, y(), w()/2, h()/2, FL_ALIGN_LEFT);
 	fl_draw(ref[external_ref], x()+w()/2-4, y(), w()/2, h()/2, FL_ALIGN_CENTER);
diff --git a/hdspconf/src/HC_SpdifFreq.cxx b/hdspconf/src/HC_SpdifFreq.cxx
index b607d65..894058b 100644
--- a/hdspconf/src/HC_SpdifFreq.cxx
+++ b/hdspconf/src/HC_SpdifFreq.cxx
@@ -37,7 +37,7 @@ void HC_SpdifFreq::draw()
 	fl_color(FL_BACKGROUND_COLOR);
 	fl_rectf(x(), y(), w(), h());
 	draw_box(x(), y(), w(), h(), FL_WHITE);
-	fl_color(FL_BLACK);
+	fl_color(FL_FOREGROUND_COLOR);
 	fl_font(FL_HELVETICA, 10);
 	fl_draw(freqs[spdif_freq], x(), y(), w(), h(), FL_ALIGN_CENTER);
 }
diff --git a/hdspconf/src/HC_SyncCheck.cxx b/hdspconf/src/HC_SyncCheck.cxx
index 111c9bc..bd03d35 100644
--- a/hdspconf/src/HC_SyncCheck.cxx
+++ b/hdspconf/src/HC_SyncCheck.cxx
@@ -50,7 +50,7 @@ void HC_SyncCheck::draw()
 	fl_color(FL_BACKGROUND_COLOR);
 	fl_rectf(x(), y(), w(), h());
 	draw_box(x(), y(), w(), h(), FL_WHITE);
-	fl_color(FL_BLACK);
+	fl_color(FL_FOREGROUND_COLOR);
 	fl_font(FL_HELVETICA, 10);
 	fl_draw(adat_name, x()+h_pos, y()+V_STEP*i, h_step, V_STEP, FL_ALIGN_LEFT);
 	fl_draw(lock_status[adat1_lock_status], x()+h_pos+h_step, y()+V_STEP*i++, h_step-h_pos, V_STEP, FL_ALIGN_CENTER);
diff --git a/hdspconf/src/HC_SystemClock.cxx b/hdspconf/src/HC_SystemClock.cxx
index d549a6f..a7ce675 100644
--- a/hdspconf/src/HC_SystemClock.cxx
+++ b/hdspconf/src/HC_SystemClock.cxx
@@ -38,7 +38,7 @@ void HC_SystemClock::draw()
 	fl_color(FL_BACKGROUND_COLOR);
 	fl_rectf(x(), y(), w(), h());
 	draw_box(x(), y(), w(), h(), FL_WHITE);
-	fl_color(FL_BLACK);
+	fl_color(FL_FOREGROUND_COLOR);
 	fl_font(FL_HELVETICA, 10);
 	fl_draw("Mode", x()+4, y(), w()/2, h()/2, FL_ALIGN_LEFT);
 	fl_draw(system_mode ? "Slave" : "Master", x()+w()/2-4, y(), w()/2, h()/2, FL_ALIGN_CENTER);
-- 
1.7.1
