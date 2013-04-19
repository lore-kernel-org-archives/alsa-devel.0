From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: snd-usb-audio: set the timeout for
 usb control set messages to 5000 ms
Date: Sat, 20 Apr 2013 00:50:11 +0200
Message-ID: <5171CA23.1000407@gmail.com>
References: <CABVYHNhLjkAknhypk3howphQk8KWV6OqJ415x1A-YAGVC-0J3w@mail.gmail.com>
 <516D5BC0.9020204@gmail.com>
 <CABVYHNis8cn5Y_BeTMQv0hn_AaJDsOw+=GaX7pFy9JjDvP5+Tw@mail.gmail.com>
 <516D6FA9.3020609@gmail.com> <516D76CC.7090408@gmail.com>
 <CABVYHNhXKXOmUQVmuwfQuZWbMK6c6aVSmzcafPLoD+LR_5xGBQ@mail.gmail.com>
 <516DA527.1070806@gmail.com> <5171B980.6050501@mixxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 20FC8265160
 for <alsa-devel@alsa-project.org>; Sat, 20 Apr 2013 00:50:03 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id e19so1908210bku.26
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2013 15:50:02 -0700 (PDT)
In-Reply-To: <5171B980.6050501@mixxx.org>
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

Hi Daniel,

On 19.04.2013 23:39, Daniel Sch=FCrmann wrote:
> This is a patch against
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/
> 581cbef46ae60073252208fc1f26dd1044f6e215

Yeah, we're getting there :)

> Set the timeout for USB control set messages according to the USB 2 spec
> =A79.2.6.4 to 5000 ms.
> To avoid new issues, the get timeout is unchanged at 1000 ms, though it
> is 500 ms in the spec.
> This patch is required to run the Hercules RMX2 which needs a timeout >
> 1240 ms
> =

> Signed-off-by: Daniel Sch=FCrmann <daschuer@mixxx.org>
> ---
> diff --git a/sound/usb/helper.c b/sound/usb/helper.c
> index c1db28f..b4f3876 100644
> --- a/sound/usb/helper.c
> +++ b/sound/usb/helper.c
> @@ -21,7 +21,11 @@
>  =

>  #include "usbaudio.h"
>  #include "helper.h"
> -#include "quirks.h"

That is a stray change which shouldn't be part of this patch.

> +
> +/* Value from 9.2.6.4 USB 2 spec */
> +#define USB_MSG_SET_TIMEOUT 5000
> +/* Value from spec is 500 but we pick 1000 for legacy reasons */
> +#define USB_MSG_GET_TIMEOUT 1000
>  =

>  /*
>   * combine bytes and get an integer value
> @@ -86,14 +90,24 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned
> int pipe, __u8 request,
>  {
>      int err;
>      void *buf =3D NULL;
> +    int timeout;

Can be unsigned, but that's a minor.

>  =

>      if (size > 0) {
>          buf =3D kmemdup(data, size, GFP_KERNEL);
>          if (!buf)
>              return -ENOMEM;
>      }
> +
> +    if (requesttype & USB_DIR_IN) {
> +        /* Get Request */
> +        timeout =3D USB_MSG_GET_TIMEOUT;
> +    } else {
> +        /* Set Request */
> +        timeout =3D USB_MSG_SET_TIMEOUT;
> +    }

You can omit the comments, they don't add any value for someone who's
reading the code. And you don't need the curly braces.

Other than that, looks good to me.


Can you send an updated version?


Thanks,
Daniel


>      err =3D usb_control_msg(dev, pipe, request, requesttype,
> -                  value, index, buf, size, 1000);
> +                  value, index, buf, size, timeout);
> +
>      if (size > 0) {
>          memcpy(data, buf, size);
>          kfree(buf);
> =
