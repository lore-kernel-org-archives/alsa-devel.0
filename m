From: Nirbheek Chauhan <nirbheek.chauhan@gmail.com>
Subject: Re: [bisected] snd_hda_intel, 2.6.37: automuting on headphone connect
 broken; headphone connecter no longer shown in userspace
Date: Mon, 10 Jan 2011 23:10:54 +0530
Message-ID: <AANLkTiku+Cu0iNagjz00wn7d8A6YkioBGWYmO=ObdPZi@mail.gmail.com>
References: <AANLkTi=Fza-mJyAKtsryAUMMgPoXur4oQ6F2keBmxF6B@mail.gmail.com> <s5hhbdgdfu6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hhbdgdfu6.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Kailang Yang <kailang@realtek.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, arun@accosted.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 10, 2011 at 7:24 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 5 Jan 2011 13:07:41 +0530,
> Nirbheek Chauhan wrote:
>> Upon upgrading to 2.6.37,
>> auto-muting-laptop-speakers-on-headphone-connect stopped working, an=
d
>> the headphone connector completely disappeared from alsamixer as wel=
l
>> as the pulseaudio volume control panel. The headphone jack was still
>> transmitting sound, though.
>>
>> I bisected the problem, with 'good' being v2.6.36, and found the
>> commit below as the first bad commit. Reverting it on v2.6.37 fixes
>> the problem. I also tried the latest alsa-kernel master git tree,
>> which had the same problem.
>>
>> alsa-info when 'good':
>>
>> http://www.alsa-project.org/db/?f=3Da0b5c95f764a0b01746be46f98968599=
6e1f9210
>>
>> alsa-info when 'bad':
>>
>> http://www.alsa-project.org/db/?f=3D30f30ca5461f03b98ab6c7c611cf24ea=
4526f537
>>
>> Note: both were taken without X running, before pulseaudio came up.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> 03642c9a444079aa13f0864383a8f9ca04bfd198 is the first bad commit
>> commit 03642c9a444079aa13f0864383a8f9ca04bfd198
>> Author: Takashi Iwai <tiwai@suse.de>
>> Date: =C2=A0 Wed Sep 8 15:28:19 2010 +0200
>>
>> =C2=A0 =C2=A0 ALSA: hda - Clear left-over hp_pins in snd_hda_parse_p=
in_def_config()
>>
[snip]
>
> It seems that the driver worked casually in the earlier versions :)
> Does the patch below fix your problem?
>
> Note that the "Headphone" control will still not appear even with thi=
s
> patch, but these two outputs are controlled by "Front" and "Surround"
> controls. =C2=A0The lack of "Headphone" is no regression but simply i=
t
> shouldn't have been there.
>

I tested it, and the patch below does exactly what you describe it's
supposed to do. Auto-muting and volume control is the way it used to
be -- somewhat weird, but not a regression from 2.6.36. As a humble
reporter, I agree that it's perfect for -stable.

Thank you!

> I'll work on 2.6.38 tree for better handling of multi headphone
> cases.
>

Results of the second patch are in a reply to the other email.

[snip]
> =3D=3D=3D
> From b2d0576055bd1cafcd91a23cf85064815f1396cd Mon Sep 17 00:00:00 200=
1
> From: Takashi Iwai <tiwai@suse.de>
> Date: Mon, 10 Jan 2011 14:47:35 +0100
> Subject: [PATCH] ALSA: hda - Fix multi-headphone handling for Realtek=
 codecs
>
> When multiple headphone pins are defined without line-out pins, the
> driver takes them as primary outputs. =C2=A0But it forgot to set line=
_out_type
> to HP by assuming there is some rest of HP pins. =C2=A0This results i=
n some
> mis-handling of these pins for Realtek codec parser. =C2=A0It takes a=
s if
> these are pure line-out jacks.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Cc: <stable@kernel.org>
> ---
> =C2=A0sound/pci/hda/hda_codec.c | =C2=A0 =C2=A03 +++
> =C2=A01 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index 98b6d02..05e5ec8 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -4571,6 +4571,9 @@ int snd_hda_parse_pin_def_config(struct hda_cod=
ec *codec,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(cfg->hp=
_pins + cfg->hp_outs, 0,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 sizeof(hda_nid_t) * (AUTO_CFG_MAX_OUTS - cfg->hp_outs));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!cfg->hp_outs)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 cfg->line_out_type =3D AUTO_PIN_HP_OUT;
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* sort by sequence */
> --
> 1.7.3.4
>
>



--=20
~Nirbheek Chauhan

Gentoo GNOME+Mozilla Team
