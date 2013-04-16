From: Daniel Mack <zonque@gmail.com>
Subject: Re: Solved Hercules RMX2
Date: Tue, 16 Apr 2013 21:23:19 +0200
Message-ID: <516DA527.1070806@gmail.com>
References: <CABVYHNhLjkAknhypk3howphQk8KWV6OqJ415x1A-YAGVC-0J3w@mail.gmail.com>
 <516D5BC0.9020204@gmail.com>
 <CABVYHNis8cn5Y_BeTMQv0hn_AaJDsOw+=GaX7pFy9JjDvP5+Tw@mail.gmail.com>
 <516D6FA9.3020609@gmail.com> <516D76CC.7090408@gmail.com>
 <CABVYHNhXKXOmUQVmuwfQuZWbMK6c6aVSmzcafPLoD+LR_5xGBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 583C22602AD
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 21:23:22 +0200 (CEST)
Received: by mail-bk0-f46.google.com with SMTP id je9so441666bkc.19
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2013 12:23:22 -0700 (PDT)
In-Reply-To: <CABVYHNhXKXOmUQVmuwfQuZWbMK6c6aVSmzcafPLoD+LR_5xGBQ@mail.gmail.com>
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

On 16.04.2013 21:14, Daniel Sch=FCrmann wrote:
> Thank you for the suggestion. If there is no other solution than
> increasing the timeout, IMHO the code is simpler if we just increase the
> timeout for all devices. This way we will automatically fix all other
> devices based on the same hardware.

How many are there? Can you come up with a list of VID/PID? I never
heard of problems of that kind really.

OTOH, I can't think of any obvious reason how a longer timeout should
cause any problem for other devices, but as a general concern, we like
to keep quirks as specific to the device as possible.

> The long timeout is only quired by the first write command and 1 s is
> already quite long. Do you have another idea how to fix this?

Fix the firmware :) I can't think of anything that take a full second
inside such a device.

> Do you have a Idea what the remaining error messages are about? I cannot
> see a misbehavior anyway.

Also firmware problems. You can ignore them for now.

> Just read:
> https://www.kernel.org/doc/Documentation/SubmittingPatches
> Is the patch fine to send out?

Which one? Also, before sending it, run scripts/checkpatch.pl on it,
which will point out obvious style issues.

> Against which Kernel should I patch?

https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/log/?h=3Dfor=
-next

> Where should I send it?

To the alsa-devel ML, and take Takashi and Clemens in Cc: (both copied
in this mail).



Thanks,
Daniel


> =

> =

> 2013/4/16 Daniel Mack <zonque@gmail.com <mailto:zonque@gmail.com>>
> =

>     On 16.04.2013 17:35, Gabriel M. Beddingfield wrote:
>     > On 04/16/2013 08:12 AM, Daniel Sch=FCrmann wrote:
>     >> Hi Gabriel,
>     >>
>     >> Thank you for your quick response.
>     >> The patch against the alsa-kernel is also attached at
>     >> https://bugs.launchpad.net/mixxx/+bug/1096687 and here:
>     >
>     > OK, I see now.  FYI, most maintainers prefer that you submit patches
>     > according to the guidelines in Documentation/SubmittingPatches.  (I=
'm
>     > not a maintainer, BTW...)
>     >
>     >>
>     >> diff --git a/sound/usb/helper.c b/sound/usb/helper.c
>     >> index c1db28f..e044804 100644
>     >> --- a/sound/usb/helper.c
>     >> +++ b/sound/usb/helper.c
>     >> @@ -23,6 +23,9 @@
>     >>   #include "helper.h"
>     >>   #include "quirks.h"
>     >>
>     >> +/* Hercules RMX2 needs 1240 ms for setting the sample rate the
>     first time */
>     >> +#define USB_MSG_TIMEOUT 1500
>     >> +
>     >>   /*
>     >>    * combine bytes and get an integer value
>     >>    */
>     >> @@ -93,7 +96,7 @@ int snd_usb_ctl_msg(struct usb_device *dev,
>     unsigned int pipe, __u8 request,
>     >>                      return -ENOMEM;
>     >>      }
>     >>      err =3D usb_control_msg(dev, pipe, request, requesttype,
>     >> -                          value, index, buf, size, 1000);
>     >> +                          value, index, buf, size, USB_MSG_TIMEOU=
T);
>     >>      if (size > 0) {
>     >>              memcpy(data, buf, size);
>     >>              kfree(buf);
>     >
>     > This changes the value for every USB audio device... not just the
>     RMX2.
>     >   Daniel, is there a better way to do this?
> =

>     Yes, you can store an integer in struct snd_usb_audio (call it
>     usb_msg_timeout or s.th.), initialize it to 1000 from
>     snd_usb_audio_probe() and add a quirk to override that value in
>     snd_usb_apply_boot_quirk().
> =

> =

>     Thanks,
>     Daniel
> =

> =
