From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: [PATCH] usbaudio.c in 2.5.45
Date: Fri, 1 Nov 2002 02:20:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211010220.03101.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_FDIV51KXA0N2TYNH366Y"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--------------Boundary-00=_FDIV51KXA0N2TYNH366Y
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

Please, find attached a trivial patch for usbaudio.c (2.5.45) that fixes =
a=20
compilation problem triggered by CONFIG_SND_DEBUG_DETECT

Regards,
Pedro

--=20
ALSA Library Bindings for Pascal
http://alsapas.alturl.com

--------------Boundary-00=_FDIV51KXA0N2TYNH366Y
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch.usbaudio"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch.usbaudio"

--- usbaudio.c.orig	Fri Nov  1 02:09:38 2002
+++ usbaudio.c	Thu Oct 31 22:10:30 2002
@@ -1879,7 +1879,7 @@
 		}
 		if (iface->altsetting[0].desc.bInterfaceClass != USB_CLASS_AUDIO ||
 		    iface->altsetting[0].desc.bInterfaceSubClass != USB_SUBCLASS_AUDIO_STREAMING) {
-			snd_printdd(KERN_ERR "%d:%u:%d: skipping non-supported interface %d\n", dev->devnum, ctrlif, j, iface->altsetting[0].bInterfaceClass);
+			snd_printdd(KERN_ERR "%d:%u:%d: skipping non-supported interface %d\n", dev->devnum, ctrlif, j, iface->altsetting[0].desc.bInterfaceClass);
 			/* skip non-supported classes */
 			continue;
 		}

--------------Boundary-00=_FDIV51KXA0N2TYNH366Y--



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
