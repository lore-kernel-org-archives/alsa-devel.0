From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] Fix invalid volume resolution for Logitech HD Webcam
 C525
Date: Wed, 07 Aug 2013 23:40:31 +0400
Message-ID: <5202A2AF.60900@cogentembedded.com>
References: <80181375903486@web11g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <80181375903486-HW/GO1vs6rtxpj1cXAZ9Bg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?0JHQvtC50LrQviDQnNCw0LrRgdC40Lw=?= <maksboyko-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello.

On 08/07/2013 11:24 PM, =D0=91=D0=BE=D0=B9=D0=BA=D0=BE =D0=9C=D0=B0=D0=BA=
=D1=81=D0=B8=D0=BC wrote:

> From: Maksim Boyko <maksim.a.boyko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> Add the volume control quirk for avoiding the kernel warning for Logi=
tech HD Webcam C525.
> The similar patch was previously reported for Logitech HD Webcam C310=
 (see 36691e1be6ec551eef4a5225f126a281f8c051c2).

    Please also specif that commit's summary line in parens.
And wrap your changelog lines at 80 columns at least.

> --- linux-3.10.5-orig/sound/usb/mixer.c	2013-08-04 12:51:49.000000000=
 +0400
> +++ linux-3.10.5/sound/usb/mixer.c	2013-08-06 21:12:42.274197287 +040=
0
> @@ -888,6 +888,7 @@
>           case USB_ID(0x046d, 0x081b): /* HD Webcam c310 */
>           case USB_ID(0x046d, 0x081d): /* HD Webcam c510 */
>           case USB_ID(0x046d, 0x0825): /* HD Webcam c270 */
> +	case USB_ID(0x046d, 0x0826): /* HD Webcam c525 */
>           case USB_ID(0x046d, 0x0991):
>           /* Most audio usb devices lie about volume resolution.
>            * Most Logitech webcams have res =3D 384.

    Hm, the file has bad indentation (your added line is fine unless it=
's out=20
of sync with the surrounding ones).

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
