From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: Solved Hercules RMX2
Date: Tue, 16 Apr 2013 08:35:05 -0700
Message-ID: <516D6FA9.3020609@gmail.com>
References: <CABVYHNhLjkAknhypk3howphQk8KWV6OqJ415x1A-YAGVC-0J3w@mail.gmail.com>
 <516D5BC0.9020204@gmail.com>
 <CABVYHNis8cn5Y_BeTMQv0hn_AaJDsOw+=GaX7pFy9JjDvP5+Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-da0-f52.google.com (mail-da0-f52.google.com
 [209.85.210.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 432572610A6
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 17:35:15 +0200 (CEST)
Received: by mail-da0-f52.google.com with SMTP id f10so305212dak.39
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 08:35:13 -0700 (PDT)
In-Reply-To: <CABVYHNis8cn5Y_BeTMQv0hn_AaJDsOw+=GaX7pFy9JjDvP5+Tw@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

+Daniel Mack <daniel@caiaq.de> (I think he's doing a lot of USB audio =

maint. these days)

On 04/16/2013 08:12 AM, Daniel Sch=FCrmann wrote:
> Hi Gabriel,
>
> Thank you for your quick response.
> The patch against the alsa-kernel is also attached at
> https://bugs.launchpad.net/mixxx/+bug/1096687 and here:

OK, I see now.  FYI, most maintainers prefer that you submit patches =

according to the guidelines in Documentation/SubmittingPatches.  (I'm =

not a maintainer, BTW...)

>
> diff --git a/sound/usb/helper.c b/sound/usb/helper.c
> index c1db28f..e044804 100644
> --- a/sound/usb/helper.c
> +++ b/sound/usb/helper.c
> @@ -23,6 +23,9 @@
>   #include "helper.h"
>   #include "quirks.h"
>
> +/* Hercules RMX2 needs 1240 ms for setting the sample rate the first tim=
e */
> +#define USB_MSG_TIMEOUT 1500
> +
>   /*
>    * combine bytes and get an integer value
>    */
> @@ -93,7 +96,7 @@ int snd_usb_ctl_msg(struct usb_device *dev, unsigned in=
t pipe, __u8 request,
>   			return -ENOMEM;
>   	}
>   	err =3D usb_control_msg(dev, pipe, request, requesttype,
> -			      value, index, buf, size, 1000);
> +			      value, index, buf, size, USB_MSG_TIMEOUT);
>   	if (size > 0) {
>   		memcpy(data, buf, size);
>   		kfree(buf);

This changes the value for every USB audio device... not just the RMX2. =

  Daniel, is there a better way to do this?

-gabriel
