From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [PATCH]snd-usb-usx2y 0.6.1
Date: Fri, 14 May 2004 13:26:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405141326.53653.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9zKpAArzc6++2T/"
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


--Boundary-00=_9zKpAArzc6++2T/
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Takashi,

little fix attached. Please commit with comment
	- avoid entry in system log when device disconnects (for RELEASE build)

Thanks,
Karsten

--Boundary-00=_9zKpAArzc6++2T/
Content-Type: text/x-diff;
  charset="us-ascii";
  name="snd-usb-usx2y.patch.0.6.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="snd-usb-usx2y.patch.0.6.1"

Index: alsa-driver/usb/usx2y/usbusx2y.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/usb/usx2y/usbusx2y.c,v
retrieving revision 1.9
diff -u -r1.9 usbusx2y.c
--- alsa-driver/usb/usx2y/usbusx2y.c	7 Apr 2004 11:46:35 -0000	1.9
+++ alsa-driver/usb/usx2y/usbusx2y.c	14 May 2004 10:49:34 -0000
@@ -98,7 +98,7 @@
 
 
 MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
-MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.6.0");
+MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.6.1");
 MODULE_LICENSE("GPL");
 MODULE_CLASSES("{sound}");
 MODULE_DEVICES("{{TASCAM(0x1604), "NAME_ALLCAPS"(0x8001)(0x8007) }}");
@@ -155,7 +155,7 @@
 	usX2Y->In04IntCalls++;
 
 	if (urb->status) {
-		snd_printk( "Interrupt Pipe 4 came back with status=%i\n", urb->status);
+		snd_printd("Interrupt Pipe 4 came back with status=%i\n", urb->status);
 		return;
 	}
 

--Boundary-00=_9zKpAArzc6++2T/--


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
