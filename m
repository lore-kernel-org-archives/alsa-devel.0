From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [BUG] GPF in snd_hda_intel
Date: Tue, 13 Oct 2009 14:54:46 +0200
Message-ID: <68676e00910130554x418f8689x10bccec31df8d49c@mail.gmail.com>
References: <20091010130110.GA5445@nb-core2.darkstar.lan>
	 <s5hk4z1f90p.wl%tiwai@suse.de>
	 <68676e00910121239qd2d87cbnbdab32efe041a65d@mail.gmail.com>
	 <s5h63ajx1nh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757023AbZJMMzZ@vger.kernel.org>
In-Reply-To: <s5h63ajx1nh.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2009 at 8:12 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 12 Oct 2009 21:39:21 +0200,
> Luca Tettamanti wrote:
>>
>> On Mon, Oct 12, 2009 at 7:58 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > At Sat, 10 Oct 2009 15:01:10 +0200,
>> > Luca Tettamanti wrote:
>> >>
>> >> Hello,
>> >> with current git kernel (bd381934) I see a GPF when the snd_hda_i=
ntel driver is
>> >> loaded; the regression is recent, 0eca52a works fine.
>> >> The machine is an ASUS laptop (F3Sa), this is the sound card:
>> >
>> > Could you load the snd-hda-intel module with probe_only=3D1 option=
,
>> > and give the output of "alsa-info.sh --no-upload" ?
>> >
>> > If 0eca52a worked, there are only a few changes regarding hda-inte=
l.
>> >
>> > f8f25ba3563dab14b1c3ea4d829642b8a61ca5d7
>> > =C2=A0 =C2=A0ALSA: hda - Add a workaround for ASUS A7K
>>
>> This is probably related; I haven't actually tested yet, but I have
>> one more information: I had "model=3Dlenovo" in modprobe configurati=
on.
>
> Ah, this is it. =C2=A0I can reproduce the problem with my emulator no=
w.
> The patch below fixes the issue.

Yup, no more GPF.

> From 2d9c648295d7bc376305337d29f540a5e411f632 Mon Sep 17 00:00:00 200=
1
> From: Takashi Iwai <tiwai@suse.de>
> Date: Tue, 13 Oct 2009 08:06:55 +0200
> Subject: [PATCH] ALSA: hda - Fix overflow of spec->init_verbs in patc=
h_realtek.c
>
> ALC861-VD lenovo model causes overflow of spec->init_verbs entries du=
e to
> the recent changes. =C2=A0Simply increase the array size to avoid the=
 overflow.
>
> Reported-by: Luca Tettamanti <kronos.it@gmail.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Tested-by: Luca Tettamanti <kronos.it@gmail.com>

> ---
> =C2=A0sound/pci/hda/patch_realtek.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_real=
tek.c
> index 470fd74..c08ca66 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -275,7 +275,7 @@ struct alc_spec {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct snd_kcontrol_new *cap_mixer; =C2=A0=
 =C2=A0 /* capture mixer */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int beep_amp; =C2=A0/* beep amp v=
alue, set via set_beep_amp() */
>
> - =C2=A0 =C2=A0 =C2=A0 const struct hda_verb *init_verbs[5]; =C2=A0 /=
* initialization verbs
> + =C2=A0 =C2=A0 =C2=A0 const struct hda_verb *init_verbs[10]; =C2=A0/=
* initialization verbs
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * don't forget NULL
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * termination!
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> --
> 1.6.4.2
>
>
