From: =?UTF-8?Q?Geyslan_Greg=C3=B3rio_Bem?= <geyslan@gmail.com>
Subject: Re: [PATCH] sound: pci: emu10k1: code refactoring and casting removal
Date: Thu, 17 Oct 2013 09:55:11 -0300
Message-ID: <CAGG-pUQAOZ852CamCE+T4zM2Wwc0xKr+WRbGQLEqK=EvC3JCvw@mail.gmail.com>
References: <1381961482-25085-1-git-send-email-geyslan@gmail.com>
	<s5hli1sqv7e.wl%tiwai@suse.de>
	<CAGG-pUQ_5jgrfSEN7_hV982FBtCmdba231gwtqfbxejshLmHhg@mail.gmail.com>
	<s5hzjq8t6pl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hzjq8t6pl.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: kernel-br <kernel-br@googlegroups.com>, Jaroslav Kysela <perex@perex.cz>, Bill Pemberton <wfp5p@virginia.edu>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

2013/10/17 Takashi Iwai <tiwai@suse.de>:
> At Thu, 17 Oct 2013 08:13:32 -0300,
> Geyslan Greg=C3=B3rio Bem wrote:
>>
>> 2013/10/17 Takashi Iwai <tiwai@suse.de>:
>> > At Wed, 16 Oct 2013 19:11:21 -0300,
>> > Geyslan G. Bem wrote:
>> >>
>> >> Partially restructures _snd_emu10k1_audigy_init_efx() and
>> >> _snd_emu10k1_init_efx() functions.
>> >>
>> >> Removes useless casting (void *) from value returned by kcalloc;
>> >> see Documentation/CodingStyle, Chap 14.
>> >>
>> >> Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
>> >> ---
>> >>  sound/pci/emu10k1/emufx.c | 84 ++++++++++++++++++++++++++-------=
--------------
>> >>  1 file changed, 46 insertions(+), 38 deletions(-)
>> >>
>> >> diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.=
c
>> >> index 0275209..afd4691 100644
>> >> --- a/sound/pci/emu10k1/emufx.c
>> >> +++ b/sound/pci/emu10k1/emufx.c
>> >> @@ -1182,15 +1182,20 @@ static int _snd_emu10k1_audigy_init_efx(s=
truct snd_emu10k1 *emu)
>> >>       u32 *gpr_map;
>> >>       mm_segment_t seg;
>> >>
>> >> -     if ((icode =3D kzalloc(sizeof(*icode), GFP_KERNEL)) =3D=3D =
NULL ||
>> >> -         (icode->gpr_map =3D (u_int32_t __user *)
>> >> -          kcalloc(512 + 256 + 256 + 2 * 1024, sizeof(u_int32_t),
>> >> -                  GFP_KERNEL)) =3D=3D NULL ||
>> >> -         (controls =3D kcalloc(SND_EMU10K1_GPR_CONTROLS,
>> >> -                             sizeof(*controls), GFP_KERNEL)) =3D=
=3D NULL) {
>> >> -             err =3D -ENOMEM;
>> >> -             goto __err;
>> >> -     }
>> >> +     err =3D -ENOMEM;
>> >> +     icode =3D kzalloc(sizeof(*icode), GFP_KERNEL);
>> >> +     if (!icode)
>> >> +             return err;
>> >> +
>> >> +     icode->gpr_map =3D (__user) kcalloc(512 + 256 + 256 + 2 * 1=
024,
>> >> +                                       sizeof(u_int32_t), GFP_KE=
RNEL);
>> >> +     if (!icode->gpr_map)
>> >> +             goto __err_gpr;
>> >> +     controls =3D kcalloc(SND_EMU10K1_GPR_CONTROLS,
>> >> +                        sizeof(*controls), GFP_KERNEL);
>> >> +     if (!controls)
>> >> +             goto __err_ctrls;
>> >> +
>> >>       gpr_map =3D (u32 __force *)icode->gpr_map;
>> >>
>> >>       icode->tram_data_map =3D icode->gpr_map + 512;
>> >> @@ -1741,12 +1746,12 @@ A_OP(icode, &ptr, iMAC0, A_GPR(var), A_GP=
R(var), A_GPR(vol), A_EXTIN(input))
>> >>       emu->support_tlv =3D 0; /* clear again */
>> >>       snd_leave_user(seg);
>> >>
>> >> - __err:
>> >> +__err:
>> >>       kfree(controls);
>> >> -     if (icode !=3D NULL) {
>> >> -             kfree((void __force *)icode->gpr_map);
>> >> -             kfree(icode);
>> >> -     }
>> >> +__err_ctrls:
>> >> +     kfree((void __force *)icode->gpr_map);
>> >> +__err_gpr:
>> >> +     kfree(icode);
>> >>       return err;
>> >>  }
>> >>
>> >> @@ -1813,18 +1818,26 @@ static int _snd_emu10k1_init_efx(struct s=
nd_emu10k1 *emu)
>> >>       u32 *gpr_map;
>> >>       mm_segment_t seg;
>> >>
>> >> -     if ((icode =3D kzalloc(sizeof(*icode), GFP_KERNEL)) =3D=3D =
NULL)
>> >> -             return -ENOMEM;
>> >> -     if ((icode->gpr_map =3D (u_int32_t __user *)
>> >> -          kcalloc(256 + 160 + 160 + 2 * 512, sizeof(u_int32_t),
>> >> -                  GFP_KERNEL)) =3D=3D NULL ||
>> >> -            (controls =3D kcalloc(SND_EMU10K1_GPR_CONTROLS,
>> >> -                             sizeof(struct snd_emu10k1_fx8010_co=
ntrol_gpr),
>> >> -                             GFP_KERNEL)) =3D=3D NULL ||
>> >> -         (ipcm =3D kzalloc(sizeof(*ipcm), GFP_KERNEL)) =3D=3D NU=
LL) {
>> >> -             err =3D -ENOMEM;
>> >> -             goto __err;
>> >> -     }
>> >> +     err =3D -ENOMEM;
>> >> +     icode =3D kzalloc(sizeof(*icode), GFP_KERNEL);
>> >> +     if (!icode)
>> >> +             return err;
>> >> +
>> >> +     icode->gpr_map =3D (__user) kcalloc(256 + 160 + 160 + 2 * 5=
12,
>> >> +                                       sizeof(u_int32_t), GFP_KE=
RNEL);
>> >> +     if (!icode->gpr_map)
>> >> +             goto __err_gpr;
>> >> +
>> >> +     controls =3D kcalloc(SND_EMU10K1_GPR_CONTROLS,
>> >> +                        sizeof(struct snd_emu10k1_fx8010_control=
_gpr),
>> >> +                        GFP_KERNEL);
>> >> +     if (!controls)
>> >> +             goto __err_ctrls;
>> >> +
>> >> +     ipcm =3D kzalloc(sizeof(*ipcm), GFP_KERNEL);
>> >> +     if (!ipcm)
>> >> +             goto __err_ipcm;
>> >> +
>> >>       gpr_map =3D (u32 __force *)icode->gpr_map;
>> >>
>> >>       icode->tram_data_map =3D icode->gpr_map + 256;
>> >> @@ -2335,14 +2348,8 @@ static int _snd_emu10k1_init_efx(struct sn=
d_emu10k1 *emu)
>> >>               for (z =3D 0; z < 16; z++)
>> >>                       OP(icode, &ptr, iACC3, FXBUS2(z), C_0000000=
0, C_00000000, EXTIN(z));
>> >>       }
>> >> -
>> >>
>> >> -     if (gpr > tmp) {
>> >> -             snd_BUG();
>> >> -             err =3D -EIO;
>> >> -             goto __err;
>> >> -     }
>> >> -     if (i > SND_EMU10K1_GPR_CONTROLS) {
>> >> +     if (gpr > tmp || i > SND_EMU10K1_GPR_CONTROLS) {
>> >>               snd_BUG();
>> >
>> > In that way, you can't distinguish which condition triggered the b=
ug
>> > (it could be shown in WARN() called in snd_BUG() in the original
>> > version), so this is a functional change.  Avoid it in a clean up
>> > patch.
>> >
>> >
>> > thanks,
>> >
>> > Takashi
>>
>> Takashi, I actually thought that that change was a cleanup.  :) But
>> ok, now I see the reason (tracing)
>> What about using this instead snd_BUG?
>>
>> snd_printd(KERN_WARN "BUG?\ngpr: %d, i: %d", gpr, i);
>>
>> It prints file, line and we can put the data. I really want to reduc=
e
>> repeated code.
>
> WARN() gives more precise information.
>
> Geyslan, you don't have to waste too much of your time (and my time
> for review) for this kind of so old driver code unless it really fixe=
s
> the bugs.  A clean up is good in general, but it can be sometimes
> worse than nothing since it also breaks the history, thus makes hard
> to follow via "git blame", for example, and of course, there is alway=
s
> a potential danger of regression.
>
> So, if it's about clean up, do it only in a systematic way that other=
s
> can follow easily, and don't do it too intensively.
>
>
> thanks,
>
> Takashi

Takashi, ok, I'll undo that patch part and send the new version later.

Thank you again for reply.
