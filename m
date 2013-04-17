From: Daniel Mack <zonque@gmail.com>
Subject: Re: Fwd:  Solved Hercules RMX2
Date: Wed, 17 Apr 2013 15:36:27 +0200
Message-ID: <516EA55B.90001@gmail.com>
References: <CABVYHNhLjkAknhypk3howphQk8KWV6OqJ415x1A-YAGVC-0J3w@mail.gmail.com>
 <516D5BC0.9020204@gmail.com>
 <CABVYHNis8cn5Y_BeTMQv0hn_AaJDsOw+=GaX7pFy9JjDvP5+Tw@mail.gmail.com>
 <516D6FA9.3020609@gmail.com> <516D76CC.7090408@gmail.com>
 <CABVYHNhXKXOmUQVmuwfQuZWbMK6c6aVSmzcafPLoD+LR_5xGBQ@mail.gmail.com>
 <516DA527.1070806@gmail.com> <516DA58B.3060207@gmail.com>
 <CABVYHNiUu+Bm=uVNHu+d6LUENAfr0FxnwE2HvmUGyzt7a1UYVg@mail.gmail.com>
 <CABVYHNiPNiBdizdzSKtb7gc+0b3S=4XJn_4zWvDUZoCSXUHf1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 68F1D26164D
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 15:36:18 +0200 (CEST)
Received: by mail-bk0-f47.google.com with SMTP id ik5so760982bkc.34
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 06:36:18 -0700 (PDT)
In-Reply-To: <CABVYHNiPNiBdizdzSKtb7gc+0b3S=4XJn_4zWvDUZoCSXUHf1w@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On 17.04.2013 08:32, Daniel Sch=FCrmann wrote:
> thank your advice!
> =

> I am not a Hercules developer, I am developer of the Mixxx DJ Software and
> I am just trying to make
> the thing work!
> =

> I have just read within the USB 2.0 speck to find out if there are specif=
ic
> timeouts to deal with.
> =

> I have found:
> =A7 9.2.6.4 Standard Device Requests
> =

> If I understand it correct, there is a 5-second limit for storing data in=
to
> the device.
> I think changing the sample rate is such a operation.
> =

> So what about changing the Limit to 5000 ms for all "Set requests"
> bmRequest =3D 21.
> See Audio20 =A7 5.2.2
> All other timeouts might be reduced to 500 ms but I would leave them
> untouched at 1000 ms , just in case.

Ok, can you cook a patch which sets the limit parameter
usb_control_msg() to 5000 for SET request but leaves the former default
value of 1000 in other cases? The patch should be all local to
snd_usb_ctl_msg() then.


Thanks,
Daniel
