From: jfm3 <jfm3@ouroboros-complex.org>
Subject: serialmidi patch
Date: 21 Feb 2003 21:59:49 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045882795.1192.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-ziXCXyWaW87f5vS4KJPp"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-ziXCXyWaW87f5vS4KJPp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached  is a patch that fixes a bug. With this fix, an MS-124W will
work in MB mode (adaptor=3) as advertised. The patch also moves a sanity
check to a slightly better place in the code.

I am using the MS-124W with a USB serial port, and it certainly moves
the bits correctly. I'm not sure about the latency characteristics of
the usb->serial piece, but it seems to me about the same as on a
computer with a 16550.

-- 
(jfm3  2838 BCBA 93BA 3058 ED95  A42C 37DB 66D1 B43C 9FD0)

--=-ziXCXyWaW87f5vS4KJPp
Content-Disposition: attachment; filename=alsa-patch.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=alsa-patch.txt; charset=UTF-8

diff -urN alsa-driver-0.9.0.ORIG/drivers/serialmidi.c alsa-driver-0.9.0/dri=
vers/serialmidi.c
--- alsa-driver-0.9.0.ORIG/drivers/serialmidi.c	2003-02-21 19:31:00.0000000=
00 -0500
+++ alsa-driver-0.9.0/drivers/serialmidi.c	2003-02-21 19:32:20.000000000 -0=
500
@@ -439,10 +439,6 @@
 	serialmidi_t *serial;
 	int err;
=20
-	if (outs < 1)
-		outs =3D 1;
-	if (outs > 16)
-		outs =3D 16;
 	switch (adaptor) {
 	case SERIAL_ADAPTOR_SOUNDCANVAS:
 		break;
@@ -452,11 +448,16 @@
 		break;
 	case SERIAL_ADAPTOR_MS124W_MB:
 		outs =3D 16;
+		break;
 	default:
 		snd_printk(KERN_ERR "Adaptor type is out of range 0-%d (%d)\n",
 				SERIAL_ADAPTOR_MAX, adaptor);
 		return -ENODEV;
 	}
+	if (outs < 1)
+		outs =3D 1;
+	if (outs > 16)
+		outs =3D 16;
=20
 	if ((serial =3D snd_magic_kcalloc(serialmidi_t, 0, GFP_KERNEL)) =3D=3D NU=
LL)
 		return -ENOMEM;

--=-ziXCXyWaW87f5vS4KJPp--



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
