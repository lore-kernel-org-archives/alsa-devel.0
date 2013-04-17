From: =?ISO-8859-1?Q?Daniel_Sch=FCrmann?= <daschuer@mixxx.org>
Subject: Fwd:  Solved Hercules RMX2
Date: Wed, 17 Apr 2013 08:32:40 +0200
Message-ID: <CABVYHNiPNiBdizdzSKtb7gc+0b3S=4XJn_4zWvDUZoCSXUHf1w@mail.gmail.com>
References: <CABVYHNhLjkAknhypk3howphQk8KWV6OqJ415x1A-YAGVC-0J3w@mail.gmail.com>
 <516D5BC0.9020204@gmail.com>
 <CABVYHNis8cn5Y_BeTMQv0hn_AaJDsOw+=GaX7pFy9JjDvP5+Tw@mail.gmail.com>
 <516D6FA9.3020609@gmail.com> <516D76CC.7090408@gmail.com>
 <CABVYHNhXKXOmUQVmuwfQuZWbMK6c6aVSmzcafPLoD+LR_5xGBQ@mail.gmail.com>
 <516DA527.1070806@gmail.com> <516DA58B.3060207@gmail.com>
 <CABVYHNiUu+Bm=uVNHu+d6LUENAfr0FxnwE2HvmUGyzt7a1UYVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f182.google.com (mail-ia0-f182.google.com
 [209.85.210.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 907AB26538B
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 08:32:41 +0200 (CEST)
Received: by mail-ia0-f182.google.com with SMTP id u20so1126490iag.41
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 23:32:40 -0700 (PDT)
In-Reply-To: <CABVYHNiUu+Bm=uVNHu+d6LUENAfr0FxnwE2HvmUGyzt7a1UYVg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

thank your advice!

I am not a Hercules developer, I am developer of the Mixxx DJ Software and
I am just trying to make
the thing work!

I have just read within the USB 2.0 speck to find out if there are specific
timeouts to deal with.

I have found:
=A7 9.2.6.4 Standard Device Requests

If I understand it correct, there is a 5-second limit for storing data into
the device.
I think changing the sample rate is such a operation.

So what about changing the Limit to 5000 ms for all "Set requests"
bmRequest =3D 21.
See Audio20 =A7 5.2.2
All other timeouts might be reduced to 500 ms but I would leave them
untouched at 1000 ms , just in case.

I would prefer this general solution over a device specific one.
What do you think?

Kind regards,

Daniel




2013/4/16 Daniel Mack <zonque@gmail.com>

> On 16.04.2013 21:23, Daniel Mack wrote:
> > On 16.04.2013 21:14, Daniel Sch=FCrmann wrote:
>
> >> Against which Kernel should I patch?
> >
> >
> https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/log/?h=3Df=
or-next
>
> Eh, sorry. This one:
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/ for-next
>
>
