From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Fix invalid volume resolution for Logitech HD Webcam C525
Date: Thu, 8 Aug 2013 04:34:55 +0900
Message-ID: <20130807193455.GA3325@kroah.com>
References: <80181375903486@web11g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <80181375903486@web11g.yandex.ru>
Sender: stable-owner@vger.kernel.org
To: =?utf-8?B?0JHQvtC50LrQviDQnNCw0LrRgdC40Lw=?= <maksboyko@yandex.ru>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 07, 2013 at 11:24:46PM +0400, =D0=91=D0=BE=D0=B9=D0=BA=D0=BE=
 =D0=9C=D0=B0=D0=BA=D1=81=D0=B8=D0=BC wrote:
> From: Maksim Boyko <maksim.a.boyko@gmail.com>
>=20
> Add the volume control quirk for avoiding the kernel warning for Logi=
tech HD Webcam C525.
> The similar patch was previously reported for Logitech HD Webcam C310=
 (see 36691e1be6ec551eef4a5225f126a281f8c051c2).
>=20
> --- linux-3.10.5-orig/sound/usb/mixer.c	2013-08-04 12:51:49.000000000=
 +0400
> +++ linux-3.10.5/sound/usb/mixer.c	2013-08-06 21:12:42.274197287 +040=
0
> @@ -888,6 +888,7 @@
>          case USB_ID(0x046d, 0x081b): /* HD Webcam c310 */
>          case USB_ID(0x046d, 0x081d): /* HD Webcam c510 */
>          case USB_ID(0x046d, 0x0825): /* HD Webcam c270 */
> +	case USB_ID(0x046d, 0x0826): /* HD Webcam c525 */
>          case USB_ID(0x046d, 0x0991):
>          /* Most audio usb devices lie about volume resolution.
>           * Most Logitech webcams have res =3D 384.


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
