From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]snd-usb-usx2y yields much better latency....
Date: Thu, 24 Jun 2004 21:50:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406242150.02019.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pBz2A79/pelhw/2"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_pBz2A79/pelhw/2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

....with the default setting as in this patch.

Please commit with comment
	- set NRPACKS to 1 as default setting to improve latency.

Thanks & Regards
Karsten


--Boundary-00=_pBz2A79/pelhw/2
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-usb-usx2y.patch.1Packet"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.1Packet"

Index: alsa-driver/usb/usx2y/usbusx2y.h
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.h,v
retrieving revision 1.5
diff -u -r1.5 usbusx2y.h
--- alsa-driver/usb/usx2y/usbusx2y.h	15 Jun 2004 10:55:39 -0000	1.5
+++ alsa-driver/usb/usx2y/usbusx2y.h	24 Jun 2004 19:47:34 -0000
@@ -5,7 +5,13 @@
 #include "usbus428ctldefs.h" 
 
 #define NRURBS	        2	/* */
-#define NRPACKS		2	/* usb-frames/ms per urb: 1 and 2 are supported. set to 1 if you want lowest possible latency */
+#define NRPACKS		1	/* usb-frames/ms per urb: 1 and 2 are supported.
+				   setting to 2 will PERHAPS make it easier for slow machines.
+				   Jitter will be higher though.
+				   On my PIII 500Mhz Laptop setting to 1 is the only way to go 
+				   for PLAYING synths. i.e. Jack & Aeolus sound quit nicely 
+				   at 4 periods 64 frames. 
+				*/
 
 #define URBS_AsyncSeq 10
 #define URB_DataLen_AsyncSeq 32

--Boundary-00=_pBz2A79/pelhw/2--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
