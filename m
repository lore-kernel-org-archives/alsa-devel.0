From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/5] hdspmixer: Fix toggle of master mute and
	solo buttons
Date: Tue, 22 Mar 2011 11:53:44 +0100
Message-ID: <1300791228-11427-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

The sensitive area for master mute and solo buttons was slightly off.
Discovered and fixed by Reuben Martin. Thanks for the patch.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/src/HDSPMixerMaster.cxx b/hdspmixer/src/HDSPMixerMaster.cxx
index 77c4a28..f4399eb 100644
--- a/hdspmixer/src/HDSPMixerMaster.cxx
+++ b/hdspmixer/src/HDSPMixerMaster.cxx
@@ -31,21 +31,21 @@ HDSPMixerMaster::HDSPMixerMaster(int x, int y, int w, int h):Fl_Widget(x, y, 62,
 void HDSPMixerMaster::draw() 
 {
     if (mute && mute_active) {
-	fl_push_clip(x(), y(), 29, 10);
+	fl_push_clip(x(), y(), 30, 11);
 	fl_draw_pixmap(b_mute_xpm, x(), y());
 	fl_pop_clip();
     } else if (mute) {
-	fl_push_clip(x(), y(), 29, 10);
-	fl_draw_pixmap(b_mute_xpm, x(), y()-10);
+	fl_push_clip(x(), y(), 30, 11);
+	fl_draw_pixmap(b_mute_xpm, x(), y()-11);
 	fl_pop_clip();
     }	
     if (solo && solo_active) {
-	fl_push_clip(x()+32, y(), 29, 10);
+	fl_push_clip(x()+32, y(), 30, 11);
 	fl_draw_pixmap(b_solo_xpm, x()+32, y());
 	fl_pop_clip();
     } else if (solo) {
-	fl_push_clip(x()+32, y(), 29, 10);
-	fl_draw_pixmap(b_solo_xpm, x()+32, y()-10);
+	fl_push_clip(x()+32, y(), 30, 11);
+	fl_draw_pixmap(b_solo_xpm, x()+32, y()-11);
 	fl_pop_clip();
     }	
 }
@@ -55,7 +55,7 @@ int HDSPMixerMaster::handle(int e)
     int xpos = Fl::event_x()-x();
     switch (e) {
 	case FL_PUSH:
-	    if (xpos >= 0 && xpos <= 29) {
+	    if (xpos >= 0 && xpos <= 30) {
 		if (mute) {
 		    mute = 0;
 		} else {
-- 
1.7.4.1
