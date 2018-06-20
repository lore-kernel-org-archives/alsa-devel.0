From: =?UTF-8?Q?=C3=89meric_MASCHINO?= <emeric.maschino@gmail.com>
Subject: Re: [PATCH] ALSA: fm801: add error handling for snd_ctl_add
Date: Wed, 20 Jun 2018 21:39:14 +0200
Message-ID: <CAA9xbM7_vrn-f_m67eowzLzWjoJP=9Hkgyxfc=yu=aDtmk=Qvw@mail.gmail.com>
References: <1528704248-33818-1-git-send-email-jiazhouyang09@gmail.com>
 <520e80a8b8de0f532e8dd3ee15af9efbc748dd9a.camel@linux.intel.com> <s5hmuw1bgmd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hmuw1bgmd.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jiazhouyang09@gmail.com, alsa-devel@alsa-project.org, BhumikaGoyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Patch tested on my ia64 workstation. Works flawlessly.

Thanks,

     =C3=89meric


2018-06-11 15:24 GMT+02:00 Takashi Iwai <tiwai@suse.de>:
> On Mon, 11 Jun 2018 10:49:56 +0200,
> Andy Shevchenko wrote:
>>
>> On Mon, 2018-06-11 at 16:04 +0800, jiazhouyang09@gmail.com wrote:
>> > When snd_ctl_add fails, the lack of error-handling code may
>> > cause unexpected results.
>> >
>> > This patch adds error-handling code after calling snd_ctl_add.
>> >
>>
>> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Though I can't test this (I have FM-only card). Last person who would
>> able to test was =C3=89meric (Cc'ed).
>
> I applied now as this change is pretty safe.
>
>
> thanks,
>
> Takashi
>
>>
>> > Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
>> > ---
>> >  sound/pci/fm801.c | 16 ++++++++++++----
>> >  1 file changed, 12 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
>> > index 73a67bc..e3fb9c6 100644
>> > --- a/sound/pci/fm801.c
>> > +++ b/sound/pci/fm801.c
>> > @@ -1068,11 +1068,19 @@ static int snd_fm801_mixer(struct fm801 *chip)
>> >             if ((err =3D snd_ac97_mixer(chip->ac97_bus, &ac97,
>> > &chip->ac97_sec)) < 0)
>> >                     return err;
>> >     }
>> > -   for (i =3D 0; i < FM801_CONTROLS; i++)
>> > -           snd_ctl_add(chip->card,
>> > snd_ctl_new1(&snd_fm801_controls[i], chip));
>> > +   for (i =3D 0; i < FM801_CONTROLS; i++) {
>> > +           err =3D snd_ctl_add(chip->card,
>> > +                   snd_ctl_new1(&snd_fm801_controls[i], chip));
>> > +           if (err < 0)
>> > +                   return err;
>> > +   }
>> >     if (chip->multichannel) {
>> > -           for (i =3D 0; i < FM801_CONTROLS_MULTI; i++)
>> > -                   snd_ctl_add(chip->card,
>> > snd_ctl_new1(&snd_fm801_controls_multi[i], chip));
>> > +           for (i =3D 0; i < FM801_CONTROLS_MULTI; i++) {
>> > +                   err =3D snd_ctl_add(chip->card,
>> > +                           snd_ctl_new1(&snd_fm801_controls_mult
>> > i[i], chip));
>> > +                   if (err < 0)
>> > +                           return err;
>> > +           }
>> >     }
>> >     return 0;
>> >  }
>>
>> --
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Intel Finland Oy
>>
