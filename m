From: Antonio Ospite <ao2@ao2.it>
Subject: Re: how to ask you to write a new ALSA driver
Date: Fri, 22 May 2015 11:10:40 +0200
Message-ID: <20150522111040.e517d4743fb51514762f1e61@ao2.it>
References: <CABi1v2YRv3g1VU0OCJVZ3+zdKyAotyMn7dSmuQ-E+ug7uMboOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp205.alice.it (smtp205.alice.it [82.57.200.101])
 by alsa0.perex.cz (Postfix) with ESMTP id B871E2606D1
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 11:10:52 +0200 (CEST)
In-Reply-To: <CABi1v2YRv3g1VU0OCJVZ3+zdKyAotyMn7dSmuQ-E+ug7uMboOQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?jean-no=EBl?= chardron <rondrach@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 21 May 2015 12:28:00 +0200
jean-no=EBl chardron <rondrach@gmail.com> wrote:

> hello,
> =

> Last week I got a Komplet Audio 6 from Native intruments.
> The driver exist in ALSA driver for this king of interface audio
> (snd-usb-audio) (thanks for the team who write this) but for the model
> where Id Vendor is 0x17cc and Id product is 0x1000.
> =

> The KA6 that I got has not the same ID product (0x1001) therefore I don't
> have any device capture even with the driver snd-usb-audio.
> =

> The challenge is to write the modification for this new model.
> Who could do that ?

You can try yourself.

If you know or suspect that your device is similar to the supported ones
look where the 0x17cc vendor id is used and try to follow the existing
code, and try to come up with the _minimum_ amount of changes required to
make the device work.

For instance, after a "git grep 0x17cc -- sound/" I came up with this
diff:

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 2f6d3e9..d254b14 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2740,6 +2740,12 @@ YAMAHA_DEVICE(0x7010, "UB99"),
        .idProduct =3D 0x1000,
 },
 {
+       /* Komplete Audio 6 */
+       .match_flags =3D USB_DEVICE_ID_MATCH_DEVICE,
+       .idVendor =3D 0x17cc,
+       .idProduct =3D 0x1001,
+},
+{
        /* Traktor Audio 6 */
        .match_flags =3D USB_DEVICE_ID_MATCH_DEVICE,
        .idVendor =3D 0x17cc,
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 7c5a701..2f9ee824 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1007,6 +1007,7 @@ int snd_usb_apply_boot_quirk(struct usb_device *dev,
                return snd_usb_accessmusic_boot_quirk(dev);

        case USB_ID(0x17cc, 0x1000): /* Komplete Audio 6 */
+       case USB_ID(0x17cc, 0x1001): /* Komplete Audio 6 */
        case USB_ID(0x17cc, 0x1010): /* Traktor Audio 6 */
        case USB_ID(0x17cc, 0x1020): /* Traktor Audio 10 */
                return snd_usb_nativeinstruments_boot_quirk(dev);


However without knowing the device I am not sure if the second change is
strictly necessary, or if the two are even enough.

So please try to apply one of them at the time, recompile, test, and let
us know.

> If necessary I could send log, compile kernel source and so on.
> thanks,

Keep logs before and after changes you make so that you can compare the
result of the changes.

Ciao,
   Antonio

-- =

Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
