From: Georg Rudolph <georg.rudolph@schwaben.de>
Subject: [PATCH] hdspmixer buffer overflow
Date: Sat, 15 May 2010 09:37:34 +0200
Message-ID: <4BEE4F3E.9030900@schwaben.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.headlight.de (mail.headlight.de [192.55.84.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F2BA24569
	for <alsa-devel@alsa-project.org>;
	Sat, 15 May 2010 09:37:44 +0200 (CEST)
Received: from localhost (amavis.headlight.de [192.55.84.73])
	by mail.headlight.de (Postfix) with ESMTP id EAD6A35E968
	for <alsa-devel@alsa-project.org>;
	Sat, 15 May 2010 09:37:43 +0200 (CEST)
Received: from mail.headlight.de ([192.55.84.71])
	by localhost (amavis.headlight.de [192.55.84.73]) (amavisd-new,
	port 10024)
	with ESMTP id FEJbxeMZtkKr for <alsa-devel@alsa-project.org>;
	Sat, 15 May 2010 09:37:40 +0200 (CEST)
Received: from [192.168.178.20] (p5B2018C7.dip0.t-ipconnect.de [91.32.24.199])
	(Authenticated sender: m10009-0370)
	by mail.headlight.de (Postfix) with ESMTPA id 1C43F2B5816
	for <alsa-devel@alsa-project.org>;
	Sat, 15 May 2010 09:37:39 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

Hello,

to fix https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5006
the attached patch for alsa-tools is proposed:

Summary: Fix buffer overflow in hdspmixer

A one off string buffer overflow fixed by handling it properly with
string stream.

Signed-off-by: Georg Rudolph <georg.rudolph@schwaben.de
<mailto:foo@bar.com>>



 

--- alsa-tools-1.0.23/hdspmixer/src/HDSPMixerIOMixer.h  2010-04-16
13:11:09.000000000 +0200
+++ alsa-tools-1.0.23-work/hdspmixer/src/HDSPMixerIOMixer.h 2010-05-12
22:07:49.549949993 +0200
@@ -36,6 +36,7 @@
 #include "HDSPMixerStripData.h"
 #include "HDSPMixerMeter.h"
 #include "pixmaps.h"
+#include <sstream>

 class HDSPMixerWindow;
 class HDSPMixerSelector;
@@ -52,7 +53,7 @@
 private:
     char **p_iomixer_xpm;
     int channel_num, relative_num, mixer_type;
-    char channel_name[6];
+   std::stringstream channel_name;
     void update_child(Fl_Widget &widget);
 public:
     HDSPMixerStripData *data[3][3][8]; /*
data[card][mode(ss/ds/qs)][preset number] */
--- alsa-tools-1.0.23/hdspmixer/src/HDSPMixerIOMixer.cxx    2010-04-16
13:11:09.000000000 +0200
+++ alsa-tools-1.0.23-work/hdspmixer/src/HDSPMixerIOMixer.cxx  
2010-05-12 22:00:26.754950707 +0200
@@ -25,9 +25,9 @@
 {
     mixer_type = type;
     if (type) {
-   sprintf(channel_name, "Out %d", ch);
+   channel_name << "Out " << ch;
     } else {
-   sprintf(channel_name, "In %d", ch);
+   channel_name << "In " << ch;
     }
     channel_num = ch;
     if (channel_num%2) {
@@ -73,7 +73,7 @@
    draw_background();
    fl_color(FL_BLACK);
    fl_font(FL_HELVETICA, 8);
-   fl_draw(channel_name, x()+4, y()+225, 27, 9, FL_ALIGN_CENTER);
+   fl_draw(channel_name.str().c_str(), x()+4, y()+225, 27, 9,
FL_ALIGN_CENTER);
    for (int i=children(); i--;) {
        Fl_Widget& o = **a++;
        draw_child(o);

Best Regards,
Georg Rudolph
