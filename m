From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/5] hdspmixer: Fix compiler warnings.
Date: Tue,  1 Mar 2011 10:42:23 +0100
Message-ID: <1298972547-8759-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298972547-8759-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298972547-8759-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

All compiler warnings were caused by a conversion from "foo" to a
char pointer. Given that the string itself really is constant, simply
add the keyword to make g++ happy.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/hdspmixer/pixmaps/Slider1.xpm b/hdspmixer/pixmaps/Slider1.xpm
index 017f4d2..7c24161 100644
--- a/hdspmixer/pixmaps/Slider1.xpm
+++ b/hdspmixer/pixmaps/Slider1.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * Slider1_xpm[] = {
+char const * Slider1_xpm[] = {
 "13 12 257 2",
 "  	c None",
 ". 	c #000000",
diff --git a/hdspmixer/pixmaps/Slider2.xpm b/hdspmixer/pixmaps/Slider2.xpm
index f7d76b1..743b5cf 100644
--- a/hdspmixer/pixmaps/Slider2.xpm
+++ b/hdspmixer/pixmaps/Slider2.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * Slider2_xpm[] = {
+char const * Slider2_xpm[] = {
 "2 13 257 2",
 "  	c None",
 ". 	c #7DF846",
diff --git a/hdspmixer/pixmaps/Zlmloop2.xpm b/hdspmixer/pixmaps/Zlmloop2.xpm
index 42377c9..f27f075 100644
--- a/hdspmixer/pixmaps/Zlmloop2.xpm
+++ b/hdspmixer/pixmaps/Zlmloop2.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * Zlmloop2_xpm[] = {
+char const * Zlmloop2_xpm[] = {
 "76 253 257 2",
 "  	c None",
 ". 	c #D1E0E5",
diff --git a/hdspmixer/pixmaps/Zlmloopm2.xpm b/hdspmixer/pixmaps/Zlmloopm2.xpm
index 55b121f..77d7dab 100644
--- a/hdspmixer/pixmaps/Zlmloopm2.xpm
+++ b/hdspmixer/pixmaps/Zlmloopm2.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * Zlmloopm2_xpm[] = {
+char const * Zlmloopm2_xpm[] = {
 "76 253 257 2",
 "  	c None",
 ". 	c #D1E0E5",
diff --git a/hdspmixer/pixmaps/b_blank.xpm b/hdspmixer/pixmaps/b_blank.xpm
index c0374d2..bafadd7 100644
--- a/hdspmixer/pixmaps/b_blank.xpm
+++ b/hdspmixer/pixmaps/b_blank.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_blank_xpm[] = {
+char const * b_blank_xpm[] = {
 "13 13 13 1",
 " 	c None",
 ".	c #1AA00D",
diff --git a/hdspmixer/pixmaps/b_card1.xpm b/hdspmixer/pixmaps/b_card1.xpm
index c832a10..d818674 100644
--- a/hdspmixer/pixmaps/b_card1.xpm
+++ b/hdspmixer/pixmaps/b_card1.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_card1_xpm[] = {
+char const * b_card1_xpm[] = {
 "13 13 14 1",
 " 	c None",
 ".	c #8D8F0F",
diff --git a/hdspmixer/pixmaps/b_card2.xpm b/hdspmixer/pixmaps/b_card2.xpm
index 5dd8da8..9a27ce6 100644
--- a/hdspmixer/pixmaps/b_card2.xpm
+++ b/hdspmixer/pixmaps/b_card2.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_card2_xpm[] = {
+char const * b_card2_xpm[] = {
 "13 13 14 1",
 " 	c None",
 ".	c #8D8F0F",
diff --git a/hdspmixer/pixmaps/b_card3.xpm b/hdspmixer/pixmaps/b_card3.xpm
index 10e9e30..05961a0 100644
--- a/hdspmixer/pixmaps/b_card3.xpm
+++ b/hdspmixer/pixmaps/b_card3.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_card3_xpm[] = {
+char const * b_card3_xpm[] = {
 "13 13 14 1",
 " 	c None",
 ".	c #8D8F0F",
diff --git a/hdspmixer/pixmaps/b_mute.xpm b/hdspmixer/pixmaps/b_mute.xpm
index dcdc8cd..86bec57 100644
--- a/hdspmixer/pixmaps/b_mute.xpm
+++ b/hdspmixer/pixmaps/b_mute.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_mute_xpm[] = {
+char const * b_mute_xpm[] = {
 "30 22 52 1",
 " 	c None",
 ".	c #DE8C00",
diff --git a/hdspmixer/pixmaps/b_pre1.xpm b/hdspmixer/pixmaps/b_pre1.xpm
index b81f85a..62b8874 100644
--- a/hdspmixer/pixmaps/b_pre1.xpm
+++ b/hdspmixer/pixmaps/b_pre1.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_pre1_xpm[] = {
+char const * b_pre1_xpm[] = {
 "13 13 14 1",
 " 	c None",
 ".	c #1AA00D",
diff --git a/hdspmixer/pixmaps/b_pre2.xpm b/hdspmixer/pixmaps/b_pre2.xpm
index 731c030..4c33101 100644
--- a/hdspmixer/pixmaps/b_pre2.xpm
+++ b/hdspmixer/pixmaps/b_pre2.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_pre2_xpm[] = {
+char const * b_pre2_xpm[] = {
 "13 13 14 1",
 " 	c None",
 ".	c #1AA00D",
diff --git a/hdspmixer/pixmaps/b_pre3.xpm b/hdspmixer/pixmaps/b_pre3.xpm
index 77162c2..0b14cb2 100644
--- a/hdspmixer/pixmaps/b_pre3.xpm
+++ b/hdspmixer/pixmaps/b_pre3.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_pre3_xpm[] = {
+char const * b_pre3_xpm[] = {
 "13 13 14 1",
 " 	c None",
 ".	c #1AA00D",
diff --git a/hdspmixer/pixmaps/b_pre4.xpm b/hdspmixer/pixmaps/b_pre4.xpm
index 30ab560..c22909b 100644
--- a/hdspmixer/pixmaps/b_pre4.xpm
+++ b/hdspmixer/pixmaps/b_pre4.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_pre4_xpm[] = {
+char const * b_pre4_xpm[] = {
 "13 13 14 1",
 " 	c None",
 ".	c #1AA00D",
diff --git a/hdspmixer/pixmaps/b_pre5.xpm b/hdspmixer/pixmaps/b_pre5.xpm
index f563537..bfc2784 100644
--- a/hdspmixer/pixmaps/b_pre5.xpm
+++ b/hdspmixer/pixmaps/b_pre5.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_pre5_xpm[] = {
+char const * b_pre5_xpm[] = {
 "13 13 14 1",
 " 	c None",
 ".	c #1AA00D",
diff --git a/hdspmixer/pixmaps/b_pre6.xpm b/hdspmixer/pixmaps/b_pre6.xpm
index 2d47537..b5ab0f5 100644
--- a/hdspmixer/pixmaps/b_pre6.xpm
+++ b/hdspmixer/pixmaps/b_pre6.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_pre6_xpm[] = {
+char const * b_pre6_xpm[] = {
 "13 13 14 1",
 " 	c None",
 ".	c #1AA00D",
diff --git a/hdspmixer/pixmaps/b_pre7.xpm b/hdspmixer/pixmaps/b_pre7.xpm
index 8de4470..4690875 100644
--- a/hdspmixer/pixmaps/b_pre7.xpm
+++ b/hdspmixer/pixmaps/b_pre7.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_pre7_xpm[] = {
+char const * b_pre7_xpm[] = {
 "13 13 14 1",
 " 	c None",
 ".	c #1AA00D",
diff --git a/hdspmixer/pixmaps/b_pre8.xpm b/hdspmixer/pixmaps/b_pre8.xpm
index 895263f..aa4073a 100644
--- a/hdspmixer/pixmaps/b_pre8.xpm
+++ b/hdspmixer/pixmaps/b_pre8.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_pre8_xpm[] = {
+char const * b_pre8_xpm[] = {
 "13 13 14 1",
 " 	c None",
 ".	c #1AA00D",
diff --git a/hdspmixer/pixmaps/b_save.xpm b/hdspmixer/pixmaps/b_save.xpm
index a984e28..c39529b 100644
--- a/hdspmixer/pixmaps/b_save.xpm
+++ b/hdspmixer/pixmaps/b_save.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_save_xpm[] = {
+char const * b_save_xpm[] = {
 "13 13 14 1",
 " 	c None",
 ".	c #5C7B1B",
diff --git a/hdspmixer/pixmaps/b_solo.xpm b/hdspmixer/pixmaps/b_solo.xpm
index f678b19..ad6c9f5 100644
--- a/hdspmixer/pixmaps/b_solo.xpm
+++ b/hdspmixer/pixmaps/b_solo.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_solo_xpm[] = {
+char const * b_solo_xpm[] = {
 "30 22 53 1",
 " 	c None",
 ".	c #7C2000",
diff --git a/hdspmixer/pixmaps/b_zlm.xpm b/hdspmixer/pixmaps/b_zlm.xpm
index c44e75b..6e9c6e9 100644
--- a/hdspmixer/pixmaps/b_zlm.xpm
+++ b/hdspmixer/pixmaps/b_zlm.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * b_zlm_xpm[] = {
+char const * b_zlm_xpm[] = {
 "13 13 11 1",
 " 	c None",
 ".	c #000D00",
diff --git a/hdspmixer/pixmaps/buttons.xpm b/hdspmixer/pixmaps/buttons.xpm
index 7cbe5f1..3e3f44f 100644
--- a/hdspmixer/pixmaps/buttons.xpm
+++ b/hdspmixer/pixmaps/buttons.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * buttons_xpm[] = {
+char const * buttons_xpm[] = {
 "76 253 257 2",
 "  	c None",
 ". 	c #C08480",
diff --git a/hdspmixer/pixmaps/empty.xpm b/hdspmixer/pixmaps/empty.xpm
index 284abc1..c86fe46 100644
--- a/hdspmixer/pixmaps/empty.xpm
+++ b/hdspmixer/pixmaps/empty.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * empty_xpm[] = {
+char const * empty_xpm[] = {
 "76 253 402 2",
 "  	c None",
 ". 	c #404840",
diff --git a/hdspmixer/pixmaps/empty_2.xpm b/hdspmixer/pixmaps/empty_2.xpm
index 31ff7b2..fb40d88 100644
--- a/hdspmixer/pixmaps/empty_2.xpm
+++ b/hdspmixer/pixmaps/empty_2.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * empty_2_xpm[] = {
+char const * empty_2_xpm[] = {
 "76 253 257 2",
 "  	c None",
 ". 	c #D1E0E5",
diff --git a/hdspmixer/pixmaps/empty_linux.xpm b/hdspmixer/pixmaps/empty_linux.xpm
index e74ff51..10088d6 100644
--- a/hdspmixer/pixmaps/empty_linux.xpm
+++ b/hdspmixer/pixmaps/empty_linux.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * empty_linux_xpm[] = {
+char const * empty_linux_xpm[] = {
 "76 253 1535 2",
 "  	c None",
 ". 	c #404840",
diff --git a/hdspmixer/pixmaps/iomixer.xpm b/hdspmixer/pixmaps/iomixer.xpm
index 31a4b16..15b7536 100644
--- a/hdspmixer/pixmaps/iomixer.xpm
+++ b/hdspmixer/pixmaps/iomixer.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * iomixer_xpm[] = {
+char const * iomixer_xpm[] = {
 "36 253 257 2",
 "  	c None",
 ". 	c #000000",
diff --git a/hdspmixer/pixmaps/iomixer_r.xpm b/hdspmixer/pixmaps/iomixer_r.xpm
index 6428cd4..cac66c9 100644
--- a/hdspmixer/pixmaps/iomixer_r.xpm
+++ b/hdspmixer/pixmaps/iomixer_r.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * iomixer_r_xpm[] = {
+char const * iomixer_r_xpm[] = {
 "36 253 257 2",
 "  	c None",
 ". 	c #000000",
diff --git a/hdspmixer/pixmaps/level.xpm b/hdspmixer/pixmaps/level.xpm
index a92fe26..3b776a5 100644
--- a/hdspmixer/pixmaps/level.xpm
+++ b/hdspmixer/pixmaps/level.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * level_xpm[] = {
+char const * level_xpm[] = {
 "8 139 257 2",
 "  	c None",
 ". 	c #149003",
diff --git a/hdspmixer/pixmaps/matrix_black.xpm b/hdspmixer/pixmaps/matrix_black.xpm
index e96c3cf..69e1e50 100644
--- a/hdspmixer/pixmaps/matrix_black.xpm
+++ b/hdspmixer/pixmaps/matrix_black.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * matrix_black_xpm[] = {
+char const * matrix_black_xpm[] = {
 "32 12 257 2",
 "  	c None",
 ". 	c #000000",
diff --git a/hdspmixer/pixmaps/matrix_grey.xpm b/hdspmixer/pixmaps/matrix_grey.xpm
index 40d0a34..ad5b369 100644
--- a/hdspmixer/pixmaps/matrix_grey.xpm
+++ b/hdspmixer/pixmaps/matrix_grey.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * matrix_grey_xpm[] = {
+char const * matrix_grey_xpm[] = {
 "32 12 22 1",
 " 	c None",
 ".	c #A0A0A0",
diff --git a/hdspmixer/pixmaps/matrix_grey_l.xpm b/hdspmixer/pixmaps/matrix_grey_l.xpm
index b1a434e..5eeedbe 100644
--- a/hdspmixer/pixmaps/matrix_grey_l.xpm
+++ b/hdspmixer/pixmaps/matrix_grey_l.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * matrix_grey_l_xpm[] = {
+char const * matrix_grey_l_xpm[] = {
 "32 12 22 1",
 " 	c None",
 ".	c #6F776F",
diff --git a/hdspmixer/pixmaps/matrix_grey_o.xpm b/hdspmixer/pixmaps/matrix_grey_o.xpm
index 8dce291..033e00b 100644
--- a/hdspmixer/pixmaps/matrix_grey_o.xpm
+++ b/hdspmixer/pixmaps/matrix_grey_o.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * matrix_grey_o_xpm[] = {
+char const * matrix_grey_o_xpm[] = {
 "32 12 22 1",
 " 	c None",
 ".	c #6F776F",
diff --git a/hdspmixer/pixmaps/matrix_grey_ol.xpm b/hdspmixer/pixmaps/matrix_grey_ol.xpm
index 64c6c40..4ced7f4 100644
--- a/hdspmixer/pixmaps/matrix_grey_ol.xpm
+++ b/hdspmixer/pixmaps/matrix_grey_ol.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * matrix_grey_ol_xpm[] = {
+char const * matrix_grey_ol_xpm[] = {
 "32 12 22 1",
 " 	c None",
 ".	c #6F776F",
diff --git a/hdspmixer/pixmaps/matrix_mute.xpm b/hdspmixer/pixmaps/matrix_mute.xpm
index 3c917d8..fcc30b2 100644
--- a/hdspmixer/pixmaps/matrix_mute.xpm
+++ b/hdspmixer/pixmaps/matrix_mute.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * matrix_mute_xpm[] = {
+char const * matrix_mute_xpm[] = {
 "32 12 25 1",
 " 	c None",
 ".	c #C5C5BD",
diff --git a/hdspmixer/pixmaps/matrix_white.xpm b/hdspmixer/pixmaps/matrix_white.xpm
index c741b5b..ab5808a 100644
--- a/hdspmixer/pixmaps/matrix_white.xpm
+++ b/hdspmixer/pixmaps/matrix_white.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * matrix_white_xpm[] = {
+char const * matrix_white_xpm[] = {
 "32 12 257 2",
 "  	c None",
 ". 	c #000000",
diff --git a/hdspmixer/pixmaps/matrix_yellow.xpm b/hdspmixer/pixmaps/matrix_yellow.xpm
index c4ab7f7..6a6565c 100644
--- a/hdspmixer/pixmaps/matrix_yellow.xpm
+++ b/hdspmixer/pixmaps/matrix_yellow.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * matrix_yellow_xpm[] = {
+char const * matrix_yellow_xpm[] = {
 "32 12 257 2",
 "  	c None",
 ". 	c #000000",
diff --git a/hdspmixer/pixmaps/monitor.xpm b/hdspmixer/pixmaps/monitor.xpm
index 4d84ef6..8c29898 100644
--- a/hdspmixer/pixmaps/monitor.xpm
+++ b/hdspmixer/pixmaps/monitor.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * monitor_xpm[] = {
+char const * monitor_xpm[] = {
 "76 253 257 2",
 "  	c None",
 ". 	c #D1E0E5",
diff --git a/hdspmixer/pixmaps/mute.xpm b/hdspmixer/pixmaps/mute.xpm
index 83c71e4..fbc4707 100644
--- a/hdspmixer/pixmaps/mute.xpm
+++ b/hdspmixer/pixmaps/mute.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * mute_xpm[] = {
+char const * mute_xpm[] = {
 "13 26 30 1",
 " 	c None",
 ".	c #1B7B1B",
diff --git a/hdspmixer/pixmaps/output.xpm b/hdspmixer/pixmaps/output.xpm
index 3fc334f..a9ccb80 100644
--- a/hdspmixer/pixmaps/output.xpm
+++ b/hdspmixer/pixmaps/output.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * output_xpm[] = {
+char const * output_xpm[] = {
 "36 208 257 2",
 "  	c None",
 ". 	c #000000",
diff --git a/hdspmixer/pixmaps/output_r.xpm b/hdspmixer/pixmaps/output_r.xpm
index 78fc61b..2e73c7f 100644
--- a/hdspmixer/pixmaps/output_r.xpm
+++ b/hdspmixer/pixmaps/output_r.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * output_r_xpm[] = {
+char const * output_r_xpm[] = {
 "36 208 257 2",
 "  	c None",
 ". 	c #000000",
diff --git a/hdspmixer/pixmaps/over.xpm b/hdspmixer/pixmaps/over.xpm
index 6b0e7e3..5918170 100644
--- a/hdspmixer/pixmaps/over.xpm
+++ b/hdspmixer/pixmaps/over.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * over_xpm[] = {
+char const * over_xpm[] = {
 "30 13 257 2",
 "  	c None",
 ". 	c #000000",
diff --git a/hdspmixer/pixmaps/peak.xpm b/hdspmixer/pixmaps/peak.xpm
index 88b20e3..19d46be 100644
--- a/hdspmixer/pixmaps/peak.xpm
+++ b/hdspmixer/pixmaps/peak.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * peak_xpm[] = {
+char const * peak_xpm[] = {
 "8 5 257 2",
 "  	c None",
 ". 	c #61FF48",
diff --git a/hdspmixer/pixmaps/solo.xpm b/hdspmixer/pixmaps/solo.xpm
index 1bfb438..42f3aca 100644
--- a/hdspmixer/pixmaps/solo.xpm
+++ b/hdspmixer/pixmaps/solo.xpm
@@ -1,5 +1,5 @@
 /* XPM */
-char * solo_xpm[] = {
+char const * solo_xpm[] = {
 "13 26 28 1",
 " 	c None",
 ".	c #3C3E2D",
diff --git a/hdspmixer/src/HDSPMixerAbout.cxx b/hdspmixer/src/HDSPMixerAbout.cxx
index 709529a..39587d0 100644
--- a/hdspmixer/src/HDSPMixerAbout.cxx
+++ b/hdspmixer/src/HDSPMixerAbout.cxx
@@ -22,7 +22,7 @@
 #include "HDSPMixerAbout.h"
 
 
-HDSPMixerAbout::HDSPMixerAbout(int w, int h, char *label, HDSPMixerWindow *win):Fl_Double_Window(w, h, label)
+HDSPMixerAbout::HDSPMixerAbout(int w, int h, char const *label, HDSPMixerWindow *win):Fl_Double_Window(w, h, label)
 {
     basew = win;
     text = new HDSPMixerAboutText(10,10,w-20,h-20);
diff --git a/hdspmixer/src/HDSPMixerAbout.h b/hdspmixer/src/HDSPMixerAbout.h
index f59b256..e539935 100644
--- a/hdspmixer/src/HDSPMixerAbout.h
+++ b/hdspmixer/src/HDSPMixerAbout.h
@@ -36,7 +36,7 @@ private:
     HDSPMixerAboutText *text;
     HDSPMixerWindow *basew;
 public:
-    HDSPMixerAbout(int w, int h, char *label, HDSPMixerWindow *win);
+    HDSPMixerAbout(int w, int h, char const *label, HDSPMixerWindow *win);
     int handle(int e);
 };
 
diff --git a/hdspmixer/src/HDSPMixerAboutText.h b/hdspmixer/src/HDSPMixerAboutText.h
index 75b96ce..7ccac25 100644
--- a/hdspmixer/src/HDSPMixerAboutText.h
+++ b/hdspmixer/src/HDSPMixerAboutText.h
@@ -32,7 +32,7 @@ public:
     HDSPMixerAboutText(int x, int y, int w, int h);
     void draw();
 private:
-    char *text;
+    char const *text;
 };
 
 #endif
diff --git a/hdspmixer/src/HDSPMixerGain.cxx b/hdspmixer/src/HDSPMixerGain.cxx
index 9d43a73..fd6339e 100644
--- a/hdspmixer/src/HDSPMixerGain.cxx
+++ b/hdspmixer/src/HDSPMixerGain.cxx
@@ -33,7 +33,7 @@ void HDSPMixerGain::draw()
     fl_draw(text, x(), y(), w(), h(), FL_ALIGN_CENTER);
 }
 
-void HDSPMixerGain::setText(char *txt)
+void HDSPMixerGain::setText(char const *txt)
 {
     strncpy(text, txt, 10);
     redraw();
diff --git a/hdspmixer/src/HDSPMixerGain.h b/hdspmixer/src/HDSPMixerGain.h
index 9f70778..a5ab55a 100644
--- a/hdspmixer/src/HDSPMixerGain.h
+++ b/hdspmixer/src/HDSPMixerGain.h
@@ -39,7 +39,7 @@ public:
     char text[10];
     HDSPMixerGain(int x, int y, int parenttype);
     void draw();
-    void setText(char *txt);
+    void setText(char const *txt);
 };
 
 #endif
diff --git a/hdspmixer/src/HDSPMixerIOMixer.h b/hdspmixer/src/HDSPMixerIOMixer.h
index a9a35de..b440007 100644
--- a/hdspmixer/src/HDSPMixerIOMixer.h
+++ b/hdspmixer/src/HDSPMixerIOMixer.h
@@ -51,7 +51,7 @@ class HDSPMixerMeter;
 class HDSPMixerIOMixer:public Fl_Group
 {
 private:
-    char **p_iomixer_xpm;
+    char const **p_iomixer_xpm;
     int channel_num, relative_num, mixer_type;
 	std::stringstream channel_name;
     void update_child(Fl_Widget &widget);
diff --git a/hdspmixer/src/HDSPMixerOutput.cxx b/hdspmixer/src/HDSPMixerOutput.cxx
index dd0c9f8..05a126c 100644
--- a/hdspmixer/src/HDSPMixerOutput.cxx
+++ b/hdspmixer/src/HDSPMixerOutput.cxx
@@ -21,7 +21,7 @@
 #pragma implementation
 #include "HDSPMixerOutput.h"
 
-static char *labels_madi_ss[64] = {
+static char const *labels_madi_ss[64] = {
    "1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",
    "9", "10", "11", "12", "13", "14", "15", "16", 
   "17", "18", "19", "20", "21", "22", "23", "24", 
@@ -32,25 +32,25 @@ static char *labels_madi_ss[64] = {
   "57", "58", "59", "60", "61", "62", "63", "64"
 };
 
-static char *labels_madi_ds[64] = {
+static char const *labels_madi_ds[64] = {
    "1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",
    "9", "10", "11", "12", "13", "14", "15", "16", 
   "17", "18", "19", "20", "21", "22", "23", "24", 
   "25", "26", "27", "28", "29", "30", "31", "32", 
 };
 
-static char *labels_madi_qs[16] = {
+static char const *labels_madi_qs[16] = {
    "1",  "2",  "3",  "4",  "5",  "6",  "7",  "8",
    "9", "10", "11", "12", "13", "14", "15", "16", 
 };
 
 
-static char *labels_aes32[16] = {
+static char const *labels_aes32[16] = {
   "AES 1", "AES 2", "AES 3", "AES 4", "AES 5", "AES 6", "AES 7", "AES 8",
   "AES 9", "AES 10", "AES 11", "AES 12", "AES 13", "AES 14", "AES 15", "AES 16"
 };
 
-static char *labels_raydat_ss[36] = {
+static char const *labels_raydat_ss[36] = {
   "A1.1", "A1.2", "A1.3", "A1.4", "A1.5", "A1.6", "A1.7", "A1.8",
   "A2.1", "A2.2", "A2.3", "A2.4", "A2.5", "A2.6", "A2.7", "A2.8",
   "A3.1", "A3.2", "A3.3", "A3.4", "A3.5", "A3.6", "A3.7", "A3.8",
@@ -59,7 +59,7 @@ static char *labels_raydat_ss[36] = {
   "SP.L", "SP.R"
 };
 
-static char *labels_raydat_ds[20] = {
+static char const *labels_raydat_ds[20] = {
   "A1.1", "A1.2", "A1.3", "A1.4",
   "A2.1", "A2.2", "A2.3", "A2.4",
   "A3.1", "A3.2", "A3.3", "A3.4",
@@ -68,7 +68,7 @@ static char *labels_raydat_ds[20] = {
   "SP.L", "SP.R"
 };
 
-static char *labels_raydat_qs[12] = {
+static char const *labels_raydat_qs[12] = {
   "A1.1", "A1.2",
   "A2.1", "A2.2",
   "A3.1", "A3.2",
@@ -78,7 +78,7 @@ static char *labels_raydat_qs[12] = {
 };
 
 
-static char *labels_aio_ss_input[14] = {
+static char const *labels_aio_ss_input[14] = {
   "AN 1",  "AN 2",
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
@@ -86,7 +86,7 @@ static char *labels_aio_ss_input[14] = {
   "A 5", "A 6", "A 7", "A 8"
 };
 
-static char *labels_aio_ss_playback[16] = {
+static char const *labels_aio_ss_playback[16] = {
   "AN 1",  "AN 2",
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
@@ -95,14 +95,14 @@ static char *labels_aio_ss_playback[16] = {
   "PH.L", "PH.R"
 };
 
-static char *labels_aio_ds_input[10] = {
+static char const *labels_aio_ds_input[10] = {
   "AN 1",  "AN 2",  
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
   "A 1", "A 2", "A 3", "A 4"
 };
 
-static char *labels_aio_ds_playback[12] = {
+static char const *labels_aio_ds_playback[12] = {
   "AN 1",  "AN 2",  
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
@@ -110,14 +110,14 @@ static char *labels_aio_ds_playback[12] = {
   "PH.L", "PH.R"
  };
 
-static char *labels_aio_qs_input[8] = {
+static char const *labels_aio_qs_input[8] = {
   "AN 1",  "AN 2",
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
   "A 1", "A 2"
 };
 
-static char *labels_aio_qs_playback[10] = {
+static char const *labels_aio_qs_playback[10] = {
   "AN 1",  "AN 2",
   "SP.L", "SP.R",
   "AES.L",  "AES.R",
@@ -126,44 +126,44 @@ static char *labels_aio_qs_playback[10] = {
 };
 
 
-static char *labels_mf_ss[20] = {
+static char const *labels_mf_ss[20] = {
     "AN 1", "AN 2", "AN 3", "AN 4", "AN 5", "AN 6", "AN 7", "AN 8",
     "A 1", "A 2", "A 3", "A 4", "A 5", "A 6", "A 7", "A 8",
     "SP.L", "SP.R", "AN.L", "AN.R"
 };
 
-static char *labels_mf_ds[16] = {
+static char const *labels_mf_ds[16] = {
     "AN 1", "AN 2", "AN 3", "AN 4", "AN 5", "AN 6", "AN 7", "AN 8",
     "A 1", "A 2", "A 3", "A 4",
     "SP.L", "SP.R", "AN.L", "AN.R"
 };
 
 
-static char *labels_df_ss[28] = {
+static char const *labels_df_ss[28] = {
     "A1 1", "A1 2", "A1 3", "A1 4", "A1 5", "A1 6", "A1 7", "A1 8",
     "A2 1", "A2 2", "A2 3", "A2 4", "A2 5", "A2 6", "A2 7", "A2 8",
     "A3 1", "A3 2", "A3 3", "A3 4", "A3 5", "A3 6", "A3 7", "A3 8",
     "SP.L", "SP.R", "AN.L", "AN.R"
 };
 
-static char *labels_df_ds[16] = {
+static char const *labels_df_ds[16] = {
     "A1 1", "A1 2", "A1 3", "A1 4",
     "A2 1", "A2 2", "A2 3", "A2 4",
     "A3 1", "A3 2", "A3 3", "A3 4",
     "SP.L", "SP.R", "AN.L", "AN.R"
 };
 
-static char *labels_9632_ss[16] = {
+static char const *labels_9632_ss[16] = {
     "A 1", "A 2", "A 3", "A 4", "A 5", "A 6", "A 7", "A 8",
     "SP.L", "SP.R", "AN 1", "AN 2", "AN 3", "AN 4", "AN 5", "AN 6"
 };
 
-static char *labels_9632_ds[12] = {
+static char const *labels_9632_ds[12] = {
     "A 1", "A 2", "A 3", "A 4",
     "SP.L", "SP.R", "AN 1", "AN 2", "AN 3", "AN 4", "AN 5", "AN 6"
 };
 
-static char *labels_9632_qs[8] = {
+static char const *labels_9632_qs[8] = {
     "SP.L", "SP.R", "AN 1", "AN 2", "AN 3", "AN 4", "AN 5", "AN 6"
 };
 
diff --git a/hdspmixer/src/HDSPMixerOutput.h b/hdspmixer/src/HDSPMixerOutput.h
index 2e7fb09..f38d263 100644
--- a/hdspmixer/src/HDSPMixerOutput.h
+++ b/hdspmixer/src/HDSPMixerOutput.h
@@ -46,8 +46,8 @@ class HDSPMixerOutput:public Fl_Group
 {
 private:
     int out_num;
-    char **labels_input, **labels_playback;
-    char **p_output_xpm;
+    char const **labels_input, **labels_playback;
+    char const **p_output_xpm;
     HDSPMixerPeak *peak;
     HDSPMixerWindow *basew;    
     void update_child(Fl_Widget& widget);
diff --git a/hdspmixer/src/HDSPMixerSelector.cxx b/hdspmixer/src/HDSPMixerSelector.cxx
index a4156b0..098658f 100644
--- a/hdspmixer/src/HDSPMixerSelector.cxx
+++ b/hdspmixer/src/HDSPMixerSelector.cxx
@@ -24,7 +24,7 @@
 #pragma implementation
 #include "HDSPMixerSelector.h"
 
-static char *destinations_madi_ss[32] = {
+static char const *destinations_madi_ss[32] = {
   "1+2", "3+4", "5+6", "7+8",
   "9+10", "11+12", "13+14", "15+16",
   "17+18", "19+20", "21+22", "23+24",
@@ -35,24 +35,24 @@ static char *destinations_madi_ss[32] = {
   "57+58", "59+60", "61+62", "63+64"
 };
 
-static char *destinations_madi_ds[16] = {
+static char const *destinations_madi_ds[16] = {
   "1+2", "3+4", "5+6", "7+8",
   "9+10", "11+12", "13+14", "15+16",
   "17+18", "19+20", "21+22", "23+24",
   "25+26", "27+28", "29+30", "31+32"
 };
 
-static char *destinations_madi_qs[8] = {
+static char const *destinations_madi_qs[8] = {
   "1+2", "3+4", "5+6", "7+8",
   "9+10", "11+12", "13+14", "15+16"
 };
 
-static char *destinations_aes32[8] = {
+static char const *destinations_aes32[8] = {
   "AES 1+2", "AES 3+4", "AES 5+6", "AES 7+8",
   "AES 9+10", "AES 11+12", "AES 13+14", "AES 15+16",
 };
 
-static char *destinations_raydat_ss[18] = {
+static char const *destinations_raydat_ss[18] = {
 
   "A1 1+2", "A1 3+4", "A1 5+6", "A1 7+8",
   "A2 1+2", "A2 3+4", "A2 5+6", "A2 7+8",
@@ -62,7 +62,7 @@ static char *destinations_raydat_ss[18] = {
   "SPDIF"
 };
 
-static char *destinations_raydat_ds[10] = {
+static char const *destinations_raydat_ds[10] = {
   "A1 1+2", "A1 3+4",
   "A2 1+2", "A2 3+4",
   "A3 1+2", "A3 3+4",
@@ -71,7 +71,7 @@ static char *destinations_raydat_ds[10] = {
   "SPDIF"
 };
 
-static char *destinations_raydat_qs[6] = {
+static char const *destinations_raydat_qs[6] = {
   "A1 1+2",
   "A2 1+2",
   "A3 1+2",
@@ -81,7 +81,7 @@ static char *destinations_raydat_qs[6] = {
 };
 
 
-static char *destinations_aio_ss[8] = {
+static char const *destinations_aio_ss[8] = {
   "AN 1+2",
   "AES",
   "SPDIF",
@@ -89,7 +89,7 @@ static char *destinations_aio_ss[8] = {
   "Phones"
 };
 
-static char *destinations_aio_ds[6] = {
+static char const *destinations_aio_ds[6] = {
   "AN 1+2", 
   "AES",
   "SPDIF",
@@ -97,7 +97,7 @@ static char *destinations_aio_ds[6] = {
   "Phones"
 };
 
-static char *destinations_aio_qs[5] = {
+static char const *destinations_aio_qs[5] = {
   "AN 1+2",
   "AES",
   "SPDIF",
@@ -105,57 +105,57 @@ static char *destinations_aio_qs[5] = {
   "Phones"
 };
 
-static char *destinations_mf_ss[10] = {
+static char const *destinations_mf_ss[10] = {
   "AN 1+2", "AN 3+4", "AN 5+6", "AN 7+8",
   "A 1+2", "A 3+4", "A 5+6", "A 7+8",
   "SPDIF", "Analog"
 };
 
-static char *destinations_mf_ds[8] = {
+static char const *destinations_mf_ds[8] = {
   "AN 1+2", "AN 3+4", "AN 5+6", "AN 7+8",
   "A 1+2", "A 3+4",
   "SPDIF", "Analog"
 };
 
-static char *destinations_df_ss[14] = {
+static char const *destinations_df_ss[14] = {
   "A1 1+2", "A1 3+4", "A1 5+6", "A1 7+8",
   "A2 1+2", "A2 3+4", "A2 5+6", "A2 7+8",
   "A3 1+2", "A3 3+4", "A3 5+6", "A3 7+8",
   "SPDIF", "Analog"
 };
 
-static char *destinations_df_ds[8] = {
+static char const *destinations_df_ds[8] = {
   "A1 1+2", "A1 3+4",
   "A2 1+2", "A2 3+4",
   "A3 1+2", "A3 3+4",
   "SPDIF", "Analog"
 };
 
-static char *destinations_h9652_ss[13] = {
+static char const *destinations_h9652_ss[13] = {
   "A1 1+2", "A1 3+4", "A1 5+6", "A1 7+8",
   "A2 1+2", "A2 3+4", "A2 5+6", "A2 7+8",
   "A3 1+2", "A3 3+4", "A3 5+6", "A3 7+8",
   "SPDIF"
 };
 
-static char *destinations_h9652_ds[7] = {
+static char const *destinations_h9652_ds[7] = {
   "A1 1+2", "A1 3+4",
   "A2 1+2", "A2 3+4",
   "A3 1+2", "A3 3+4",
   "SPDIF"
 };
 
-static char *destinations_h9632_ss[8] = {
+static char const *destinations_h9632_ss[8] = {
   "A 1+2", "A 3+4", "A 5+6", "A 7+8",
   "SPDIF", "AN 1+2", "AN 3+4", "AN 5+6"
 };
 
-static char *destinations_h9632_ds[6] = {
+static char const *destinations_h9632_ds[6] = {
   "A 1+2", "A 3+4",
   "SPDIF", "AN 1+2", "AN 3+4", "AN 5+6"    
 };
 
-static char *destinations_h9632_qs[4] = {
+static char const *destinations_h9632_qs[4] = {
   "SPDIF", "AN 1+2", "AN 3+4", "AN 5+6"    
 };
 
diff --git a/hdspmixer/src/HDSPMixerSelector.h b/hdspmixer/src/HDSPMixerSelector.h
index 6f232cf..7994305 100644
--- a/hdspmixer/src/HDSPMixerSelector.h
+++ b/hdspmixer/src/HDSPMixerSelector.h
@@ -39,7 +39,7 @@ class HDSPMixerIOMixer;
 class HDSPMixerSelector:public Fl_Menu_
 {
 private:
-    char **destinations;
+    char const **destinations;
     HDSPMixerWindow *basew;
 public:
     int max_dest;
diff --git a/hdspmixer/src/HDSPMixerSetup.cxx b/hdspmixer/src/HDSPMixerSetup.cxx
index 6fa3551..593ee70 100644
--- a/hdspmixer/src/HDSPMixerSetup.cxx
+++ b/hdspmixer/src/HDSPMixerSetup.cxx
@@ -91,7 +91,7 @@ static void rmsplus3_cb(Fl_Widget *widget, void *arg)
 }
 
 
-HDSPMixerSetup::HDSPMixerSetup(int w, int h, char *label, HDSPMixerWindow *win):Fl_Double_Window(w, h, label)
+HDSPMixerSetup::HDSPMixerSetup(int w, int h, char const *label, HDSPMixerWindow *win):Fl_Double_Window(w, h, label)
 {
     basew = win;
     plm = new Fl_Group(10, 25, 380, 60, "Peak Level Meters");    
diff --git a/hdspmixer/src/HDSPMixerSetup.h b/hdspmixer/src/HDSPMixerSetup.h
index 21ffbb2..ba95951 100644
--- a/hdspmixer/src/HDSPMixerSetup.h
+++ b/hdspmixer/src/HDSPMixerSetup.h
@@ -54,7 +54,7 @@ public:
     int level_val;
     int numbers_val;
     int rmsplus3_val;
-    HDSPMixerSetup(int w, int h, char *label, HDSPMixerWindow *win);
+    HDSPMixerSetup(int w, int h, char const *label, HDSPMixerWindow *win);
     HDSPMixerWindow *basew;
     void updateValues();
 };
diff --git a/hdspmixer/src/pixmaps.h b/hdspmixer/src/pixmaps.h
index 624bd28..b980a62 100644
--- a/hdspmixer/src/pixmaps.h
+++ b/hdspmixer/src/pixmaps.h
@@ -21,44 +21,44 @@
 #ifndef pixmaps_H
 #define pixmaps_H
 
-extern char * Slider1_xpm[];
-extern char * Slider2_xpm[];
-extern char * b_blank_xpm[];
-extern char * b_card1_xpm[];
-extern char * b_card2_xpm[];
-extern char * b_card3_xpm[];
-extern char * b_mute_xpm[];
-extern char * b_pre1_xpm[];
-extern char * b_pre2_xpm[];
-extern char * b_pre3_xpm[];
-extern char * b_pre4_xpm[];
-extern char * b_pre5_xpm[];
-extern char * b_pre6_xpm[];
-extern char * b_pre7_xpm[];
-extern char * b_pre8_xpm[];
-extern char * b_save_xpm[];
-extern char * b_solo_xpm[];
-extern char * buttons_xpm[];
-extern char * empty_xpm[];
-extern char * empty_linux_xpm[];
-extern char * iomixer_xpm[];
-extern char * level_xpm[];
-extern char * monitor_xpm[];
-extern char * mute_xpm[];
-extern char * output_xpm[];
-extern char * over_xpm[];
-extern char * peak_xpm[];
-extern char * solo_xpm[];
-extern char * iomixer_r_xpm[];
-extern char * output_r_xpm[];
-extern char * matrix_white_xpm[];
-extern char * matrix_black_xpm[];
-extern char * matrix_yellow_xpm[];
-extern char * matrix_mute_xpm[];
-extern char * matrix_grey_xpm[];
-extern char * matrix_grey_l_xpm[];
-extern char * matrix_grey_ol_xpm[];
-extern char * matrix_grey_o_xpm[];
+extern char const * Slider1_xpm[];
+extern char const * Slider2_xpm[];
+extern char const * b_blank_xpm[];
+extern char const * b_card1_xpm[];
+extern char const * b_card2_xpm[];
+extern char const * b_card3_xpm[];
+extern char const * b_mute_xpm[];
+extern char const * b_pre1_xpm[];
+extern char const * b_pre2_xpm[];
+extern char const * b_pre3_xpm[];
+extern char const * b_pre4_xpm[];
+extern char const * b_pre5_xpm[];
+extern char const * b_pre6_xpm[];
+extern char const * b_pre7_xpm[];
+extern char const * b_pre8_xpm[];
+extern char const * b_save_xpm[];
+extern char const * b_solo_xpm[];
+extern char const * buttons_xpm[];
+extern char const * empty_xpm[];
+extern char const * empty_linux_xpm[];
+extern char const * iomixer_xpm[];
+extern char const * level_xpm[];
+extern char const * monitor_xpm[];
+extern char const * mute_xpm[];
+extern char const * output_xpm[];
+extern char const * over_xpm[];
+extern char const * peak_xpm[];
+extern char const * solo_xpm[];
+extern char const * iomixer_r_xpm[];
+extern char const * output_r_xpm[];
+extern char const * matrix_white_xpm[];
+extern char const * matrix_black_xpm[];
+extern char const * matrix_yellow_xpm[];
+extern char const * matrix_mute_xpm[];
+extern char const * matrix_grey_xpm[];
+extern char const * matrix_grey_l_xpm[];
+extern char const * matrix_grey_ol_xpm[];
+extern char const * matrix_grey_o_xpm[];
 
 #endif
 
-- 
1.7.4.1
