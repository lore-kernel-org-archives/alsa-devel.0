From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: Linux 3.10.4 and Logitech HD Webcam C525/C310
Date: Tue, 6 Aug 2013 09:59:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1308060958070.1154-100000@iolanthe.rowland.org>
References: <36731375776759@web15h.yandex.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <36731375776759-pkmkBaL7+f1xpj1cXAZ9Bg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?koi8-r?B?4s/Ky88g7cHL08nN?= <maksboyko-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Aug 2013, [koi8-r] =E2=CF=CA=CB=CF =ED=C1=CB=D3=C9=CD wrote:

> Hi,
>=20
> I have Logitech HD Webcam 525  (046d:0826) but its mic works strange.=
 The mic is turned off while video works fine. In dmesg I see the follo=
wing messages
>=20
> [  472.079738] cannot submit urb (err =3D -18)
> [  472.079748] cannot submit urb (err =3D -18)
> [  472.079754] cannot submit urb (err =3D -18)
> [  472.079759] cannot submit urb (err =3D -18)
> [  472.079783] cannot submit urb (err =3D -18)
> [  472.079787] cannot submit urb (err =3D -18)
> [  472.079792] cannot submit urb (err =3D -18)
> [  472.079797] cannot submit urb (err =3D -18)

> I have not enough experience to fix it myself but I can help with
> finding a bug and testing fixes. I have also found that the same
> problem exists for Logitech Webcam C310 (046d:081b). The bug is not
> specific for my laptop. I have the same issue on my desktop with both
> cameras.

Does this patch help?

Alan Stern



Index: usb-3.11/drivers/usb/host/ehci-sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- usb-3.11.orig/drivers/usb/host/ehci-sched.c
+++ usb-3.11/drivers/usb/host/ehci-sched.c
@@ -1391,21 +1391,20 @@ iso_stream_schedule (
=20
 		/* Behind the scheduling threshold? */
 		if (unlikely(start < next)) {
+			unsigned now2 =3D (now - base) & (mod - 1);
=20
 			/* USB_ISO_ASAP: Round up to the first available slot */
 			if (urb->transfer_flags & URB_ISO_ASAP)
 				start +=3D (next - start + period - 1) & -period;
=20
 			/*
-			 * Not ASAP: Use the next slot in the stream.  If
-			 * the entire URB falls before the threshold, fail.
+			 * Not ASAP: Use the next slot in the stream,
+			 * no matter what.
 			 */
-			else if (start + span - period < next) {
-				ehci_dbg(ehci, "iso urb late %p (%u+%u < %u)\n",
+			else if (start + span - period < now2) {
+				ehci_dbg(ehci, "iso underrun %p (%u+%u < %u)\n",
 						urb, start + base,
-						span - period, next + base);
-				status =3D -EXDEV;
-				goto fail;
+						span - period, now2 + base);
 			}
 		}
=20

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
