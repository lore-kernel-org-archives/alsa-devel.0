From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echomixer - display fix
Date: Tue, 7 Jun 2005 23:23:12 +0200
Message-ID: <20050607232312.35bfc2a8.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


- Fix a display bug in the vmixer part of the graphic mixer that was
introduced recently.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-tools/echomixer/echomixer.c__orig	Mon Jun  6 19:39:41 2005
+++ alsa-tools/echomixer/echomixer.c	Mon Jun  6 19:43:25 2005
@@ -739,8 +739,10 @@
   // Draw vmixer elements (Vmixer cards only)
   if (vmixerId) {
     for (o=0; o<GMixerSection.Outputs; o++)
-      for (i=0; i<vmixerControl.vchannels; i++)
-        DrawBar(o+1, i+GMixerSection.VmixerFirst, VirLevel[i], DONT_DRAW, vmixerControl.mixer[o][i].Gain);
+      for (i=0; i<vmixerControl.vchannels; i++) {
+        dB=Add_dB(vmixerControl.mixer[o][i].Gain, VirLevel[i]);
+        DrawBar(o+1, i+GMixerSection.VmixerFirst, dB, DONT_DRAW, vmixerControl.mixer[o][i].Gain);
+      }
   }
 
   gtk_widget_draw(Mixdarea, &update_rect);



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
