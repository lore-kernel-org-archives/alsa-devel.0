From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: Alsa Support for Korg Pandora Mini, Vox ToneLab ST
Date: Tue, 17 May 2011 01:20:59 +1000
Message-ID: <BANLkTimUPRYXcpY9fhcyOACJG+NaurOZxA@mail.gmail.com>
References: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>
	<BANLkTinXgstKju=8-Ow7o542-zZxvKZdTQ@mail.gmail.com>
	<loom.20110514T184918-282@post.gmane.org>
	<BANLkTi=uT5xEJ1xtOqXFqPAH6ghRcJhEhg@mail.gmail.com>
	<BANLkTimWe6OJjRLjNFKKSKyPuSjuZcBLgQ@mail.gmail.com>
	<BANLkTin7JRp6wZeX049Atqn+zmZdkQ1vGQ@mail.gmail.com>
	<BANLkTikUS1qcLa_OdCkW68cwFLRB7qqFbg@mail.gmail.com>
	<BANLkTinUrXN6KiYLOT=F=jdPmn=2t5F5OQ@mail.gmail.com>
	<BANLkTikjU3KiL9HJJSwjHQ8qO-eLG3HWzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 65FC0244FB
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 17:21:01 +0200 (CEST)
Received: by eyg5 with SMTP id 5so1365490eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 16 May 2011 08:21:00 -0700 (PDT)
In-Reply-To: <BANLkTikjU3KiL9HJJSwjHQ8qO-eLG3HWzQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: =?ISO-8859-1?Q?Fr=E9d=E9ric_Jaume?= <frederic.jaume@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

2011/5/16 Daniel Mack <zonque@gmail.com>

> 2011/5/15 Daniel Mack <zonque@gmail.com>:
> > 2011/5/14 Fr=E9d=E9ric Jaume <frederic.jaume@gmail.com>:
> >> Hi!
> >>
> >> Here's the "lsusb -v" for the Korg Pandora PX5D, attached. Hope this
> helps.
> >
> > The MIDI part of the descriptors is clearly marked as vendor specific,
> > so there is nothing the driver can do about this, except for adding a
> > quirk.
> >
> > Assuming the MIDI interface is class compliant, the following patch
> > should help. Can you give it a try?
>
> For the Pandora PX5D, we also have to use the USB_DEVICE_VENDOR_SPEC
> macro, so the class compliant audio interfaces are not ignored by
> adding the quirk.
>
> Daniel
>

A winner.

[  115.420064] usb 4-1: new high speed USB device using ehci_hcd and address
3
[  115.553783] usb 4-1: config 1 interface 3 altsetting 0 bulk endpoint 0x7
has invalid maxpacket 8
[  115.553789] usb 4-1: config 1 interface 3 altsetting 0 bulk endpoint 0x87
has invalid maxpacket 8
[  115.554896] usb 4-1: New USB device found, idVendor=3D0763, idProduct=3D=
2080
[  115.554898] usb 4-1: New USB device strings: Mfr=3D1, Product=3D2,
SerialNumber=3D0
[  115.554901] usb 4-1: Product: Fast Track Ultra
[  115.554903] usb 4-1: Manufacturer: M-Audio
nevyn@cetacea:~/linux$ amidi -l
Dir Device    Name
IO  hw:1,0,0  Fast Track Ultra MIDI 1

Huzzah! Please commit. your 8 character diff ;) oh. and you probably should
change the 8R at the same time given it's essentially the same hardware with
different analog bits. (8 pre's instead of 4)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 196c753..6d7b357 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -1926,7 +1926,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
        }
 },
 {
-       USB_DEVICE(0x0763, 0x2080),
+       USB_DEVICE_VENDOR_SPEC(0x0763, 0x2080),
        .driver_info =3D (unsigned long) & (const struct snd_usb_audio_quir=
k)
{
                /* .vendor_name =3D "M-Audio", */
                /* .product_name =3D "Fast Track Ultra", */
@@ -1993,7 +1993,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
        }
 },
 {
-       USB_DEVICE(0x0763, 0x2081),
+       USB_DEVICE_VENDOR_SPEC(0x0763, 0x2081),
        .driver_info =3D (unsigned long) & (const struct snd_usb_audio_quir=
k)
{
                /* .vendor_name =3D "M-Audio", */
                /* .product_name =3D "Fast Track Ultra 8R", */



Grant
