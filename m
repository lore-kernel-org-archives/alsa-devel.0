From: Daniel Mack <daniel@zonque.org>
Subject: Re: Volume issues: Logitech S-150 USB Digital Speaker
 / "usb_audio: Warning! Unlikely big volume range"
Date: Mon, 16 Dec 2013 20:18:26 +0100
Message-ID: <20131216191825.GA25312@tamtam.fritz.box>
References: <20131212013529.GE5606@Linus-Debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C26C261729
 for <alsa-devel@alsa-project.org>; Mon, 16 Dec 2013 20:18:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131212013529.GE5606@Linus-Debian>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@web.de>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 12, 2013 at 02:35:29AM +0100, Linus L=FCssing wrote:
> I'm currently trying to use a Logitech S-150 USB Digital Speaker.
> Unfortunately, the volume range is way off, i.e. only 1% and 2%
> settings in the alsamixer are actually usable for general
> playback.
> =

> dmesg:
> -----
> [ 9850.768093] usb 1-1: new full-speed USB device number 2 using uhci_hcd
> [ 9850.948103] usb 1-1: New USB device found, idVendor=3D1130, idProduct=
=3D1620
> [ 9850.948123] usb 1-1: New USB device strings: Mfr=3D0, Product=3D2, Ser=
ialNumber=3D0
> [ 9850.948138] usb 1-1: Product: USB  AUDIO
> [ 9852.353857] hidraw: raw HID events driver (C) Jiri Kosina
> [ 9852.397038] usb_audio: Warning! Unlikely big volume range (=3D17152), =
cval->res is probably wrong.

You're facing a firmware bug, most probably just an endianess issue
(17152 =3D 0x4300). You can add a quirk for this device in order to fix
it up. Have a look at volume_control_quirks() in sound/usb/mixer.c if
you want, or tell me the name of the affected volume control.

> [ 9852.397054] usb_audio: [2] FU [PCM Playback Volume] ch =3D 2, val =3D =
0/17152/1<6>[ 9852.399123] usbcore: registered new interface driver snd-usb=
-audio
> [ 9852.412386] usbcore: registered new interface driver usbhid
> [ 9852.412400] usbhid: USB HID core driver
> [ 9852.562358] input: USB  AUDIO   as /devices/pci0000:00/0000:00:1d.0/us=
b1/1-1/1-1:1.2/input/input12
> [ 9852.563157] hid-generic 0003:1130:1620.0001: input,hidraw0: USB HID v1=
.10 Device [USB  AUDIO  ] on usb-0000:00:1d.0-1/input2
> -----
> =

> lsusb -d 1130:1620 (for lsusb -vvv, see attachment)
> -----
> Bus 001 Device 002: ID 1130:1620 Tenx Technology, Inc.
> -----
> =

> The detected vendor does not seem to match, so all in all
> looks like a kernel bug?

No, lsusb just shows you the name of the company that registered the USB
vendor ID, 0x1130 in this case. Logitech seems to have licensed a design
from another company here.


Daniel
