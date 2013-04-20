From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2] ALSA: snd-usb-audio: set the timeout
 for usb control set messages to 5000 ms
Date: Sat, 20 Apr 2013 21:09:11 +0200
Message-ID: <5172E7D7.109@gmail.com>
References: <CABVYHNhfzWNhi0Jv=Z-WET-4amLnhB7Kq1Gi_bKc-Pf4cqqHHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f43.google.com (mail-bk0-f43.google.com
 [209.85.214.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A7184265191
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 21:09:04 +0200 (CEST)
Received: by mail-bk0-f43.google.com with SMTP id jm19so935516bkc.2
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 12:09:04 -0700 (PDT)
In-Reply-To: <CABVYHNhfzWNhi0Jv=Z-WET-4amLnhB7Kq1Gi_bKc-Pf4cqqHHw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Daniel_Sch=FCrmann?= <daschuer@mixxx.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 20.04.2013 20:58, Daniel Sch=FCrmann wrote:
> Thank you Daniel for review.
> Here is an updated version of the patch against
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/
> 581cbef46ae60073252208fc1f26dd1044f6e215
> =

> Set the timeout for USB control set messages according to the USB 2 spec
> =A79.2.6.4 to 5000 ms.
> To avoid new issues, the get timeout is unchanged at 1000 ms, though it
> is 500 ms in the spec.
> This patch is required to run the Hercules RMX2 which needs a timeout >
> 1240 ms
> =

> Signed-off-by: Daniel Sch=FCrmann <daschuer@mixxx.org
> <mailto:daschuer@mixxx.org>>
> ---
> diff --git a/sound/usb/helper.c b/sound/usb/helper.c
> index c1db28f..c1caae4 100644
> --- a/sound/usb/helper.c
> +++ b/sound/usb/helper.c
> @@ -23,6 +23,11 @@
>  #include "helper.h"
>  #include "quirks.h"
>  =

> +/* Value from 9.2.6.4 USB 2 spec */
> +#define USB_MSG_SET_TIMEOUT 5000
> +/* Value from spec is 500 but we pick 1000 for legacy reasons */
> +#define USB_MSG_GET_TIMEOUT 1000
> +
>  /*
>   * combine bytes and get an integer value
>   */
> @@ -86,14 +91,19 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned
> int pipe, __u8 request,
>  {
>      int err;
>      void *buf =3D NULL;
> +    int timeout;
>  =

>      if (size > 0) {
>          buf =3D kmemdup(data, size, GFP_KERNEL);
>          if (!buf)
>              return -ENOMEM;
>      }

Blank line please.

> +    if (requesttype & USB_DIR_IN)
> +        timeout =3D USB_MSG_GET_TIMEOUT;
> +    else
> +        timeout =3D USB_MSG_SET_TIMEOUT;

Dito.


Also, the patch does not apply to Takashi's for-next branch, but I
believe that's just because your mailer mangled the patch. Could you
resend using 'git send-email'?


Thanks,
Daniel
