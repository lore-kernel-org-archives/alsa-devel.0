From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH] hda_analyzer: don't fail to display audio
	selector if caps variables aren't available
Date: Thu, 30 May 2013 14:14:07 +0200
Message-ID: <1369916047-27642-1-git-send-email-anisse@astier.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id B0A3526517C
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 14:14:58 +0200 (CEST)
Received: by mail-wi0-f170.google.com with SMTP id hr14so5213657wib.5
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 05:14:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
Cc: Anisse Astier <anisse@astier.eu>
List-Id: alsa-devel@alsa-project.org

In particular, when an audio selector node has Amp-In caps: N/A, it
allows to still interact with the selector, and not have TypeError traceback
throwns because of NoneType variables.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
Hi Jared,

I'm not sure if this is the proper way to fix this, so please consider this a
formal report for the error thrown while parsing this node:

Node 0x22 [Audio Selector] wcaps 0x30010b: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Connection: 7
     0x18* 0x19 0x1a 0x1b 0x1d 0x0b 0x12

Regards,

Anisse

--


 hda-analyzer/hda_guilib.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hda-analyzer/hda_guilib.py b/hda-analyzer/hda_guilib.py
index 93c85e1..62eddab 100644
--- a/hda-analyzer/hda_guilib.py
+++ b/hda-analyzer/hda_guilib.py
@@ -285,9 +285,9 @@ class NodeGui(gtk.ScrolledWindow):
       frame.set_border_width(4)
       vbox = gtk.VBox(False, 0)
       if caps:
-        str =  'Offset:          %d\n' % caps.ofs
-        str += 'Number of steps: %d\n' % caps.nsteps
-        str += 'Step size:       %d\n' % caps.stepsize
+        str =  'Offset:          %s\n' % (caps.ofs if caps.ofs else "N/A")
+        str += 'Number of steps: %s\n' % (caps.nsteps if caps.nsteps else "N/A")
+        str += 'Step size:       %s\n' % (caps.stepsize if caps.stepsize else "N/A")
         str += 'Mute:            %s\n' % (caps.mute and "True" or "False")
         vbox.pack_start(self.__new_text_view(text=str), True, True, 0)
         idx = 0
-- 
1.8.3.rc1
