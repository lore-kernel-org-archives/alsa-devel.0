From: Pierre Ossman <ossman@cendio.se>
Subject: [PATCH] Incorrect revents in polypaudio plugin
Date: Tue, 07 Mar 2006 18:19:24 +0100
Message-ID: <440DC09C.5080102@cendio.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030600000600080201050701"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BEDFF19D
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 18:19:25 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030600000600080201050701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The revent flags POLLIN/POLLOUT got switched in the Polypaudio plugin. 
Most applications check both so it went unnoticed until now.

Signed-off-by: Pierre Ossman <ossman@cendio.se>


--------------030600000600080201050701
Content-Type: text/x-patch;
 name="alsa-plugins-switch-polls.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-plugins-switch-polls.patch"

Index: polyp/pcm_polyp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-plugins/polyp/pcm_polyp.c,v
retrieving revision 1.2
diff -u -r1.2 pcm_polyp.c
--- polyp/pcm_polyp.c	22 Feb 2006 15:38:52 -0000	1.2
+++ polyp/pcm_polyp.c	7 Mar 2006 17:17:43 -0000
@@ -314,9 +314,9 @@
      */
     if (pcm->last_size >= pcm->buffer_attr.minreq) {
         if (io->stream == SND_PCM_STREAM_PLAYBACK)
-            *revents |= POLLIN;
-        else
             *revents |= POLLOUT;
+        else
+            *revents |= POLLIN;
     }
 
     return 0;

--------------030600000600080201050701--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
