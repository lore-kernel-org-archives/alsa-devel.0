From: Dirk Jagdmann <doj@cubic.org>
Subject: midi fix for envy24control
Date: Thu, 23 Dec 2004 21:07:24 +0100
Message-ID: <41CB257C.30807@cubic.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050404020306060009050401"
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050404020306060009050401
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hello developers,

I just gave the latest CVS version of envy24control a try and had to add 
this simple patch, so it would not abort upon program start immediately.

-- 
---> doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org

--------------050404020306060009050401
Content-Type: text/plain;
 name="envy24control-midi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="envy24control-midi.diff"

? envy24control-midi.diff
Index: midi.c
===================================================================
RCS file: /cvsroot/alsa/alsa-tools/envy24control/midi.c,v
retrieving revision 1.1
diff -u -r1.1 midi.c
--- midi.c	17 Nov 2004 11:41:57 -0000	1.1
+++ midi.c	23 Dec 2004 20:04:59 -0000
@@ -55,6 +55,7 @@
 static void do_controller(int c, int v)
 {
   snd_seq_event_t ev;
+  if(!seq) return;
   snd_seq_ev_clear(&ev);
   snd_seq_ev_set_source(&ev, port);
   snd_seq_ev_set_subs(&ev);

--------------050404020306060009050401--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
