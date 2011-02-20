From: Mark Goldstein <goldstein.mark@gmail.com>
Subject: Re: pci/hda/patch_via.c - broken between 2.6.36 and
 2.6.37 (bisected)
Date: Sun, 20 Feb 2011 13:06:46 +0200
Message-ID: <AANLkTin4TQvLwZX_mjhHq66STrsrXJu9a+bvsiSdxXub@mail.gmail.com>
References: <ijqrmf$tlg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1612524413
	for <alsa-devel@alsa-project.org>; Sun, 20 Feb 2011 12:07:08 +0100 (CET)
Received: by gyg8 with SMTP id 8so2384543gyg.38
	for <alsa-devel@alsa-project.org>; Sun, 20 Feb 2011 03:07:07 -0800 (PST)
In-Reply-To: <ijqrmf$tlg$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfgang Scheicher <wolfgang.scheicher@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sun, Feb 20, 2011 at 12:50 PM, Wolfgang Scheicher
<wolfgang.scheicher@gmail.com> wrote:
>
> After the mentioned Kernel upgrade quite a view things went wrong on my
> hardware ( http://www.asrock.com/mb/overview.asp?Model=3D890GM%20Pro3 ):
>
> * Microphone doesn't work anymore. neither the front mic nor the rear one.
> Tried all thinkable settings.
>
> * Increasing Microphone levels leads to some strange internal feedback. T=
hat
> means, at some point when the feedback starts, it just starts, but i have=
 no
> clue what audio source did actually trigger it.
>
> * Touching the mixer channel "Smart 5.1" in alsamixer makes alsamicer cra=
sh.
>
>
> After quite some days of frustration and the inability to get help i howe=
ver
> managed to learn how to build a kernel and how to git bisect. So this is
> what i did:
>
>
> root@Blackrock ~src/alsa-kernel (git)-[7b315bb...|bisect] # git bisect log
> git bisect start '--' 'sound/pci'
> # bad: [81a2f603f94d6da108ddd8e3535294445097f730] ALSA: ac97: replace ope=
n-
> coded, error-prone stuff with AC97 bit defines
> git bisect bad 81a2f603f94d6da108ddd8e3535294445097f730
> # good: [f6f94e2ab1b33f0082ac22d71f66385a60d8157f] Linux 2.6.36
> git bisect good f6f94e2ab1b33f0082ac22d71f66385a60d8157f
> # bad: [28c4edb71d21623f1e47422194d865d2b6712fd4] ALSA: HDA: Rename "Int
> Mic" to "Internal Mic"
> git bisect bad 28c4edb71d21623f1e47422194d865d2b6712fd4
> # bad: [0e7adbe263f89ea2ef15b5af5e80a812b2a85025] ALSA: hda - Disable sti=
cky
> PCM stream assignment for AD codecs
> git bisect bad 0e7adbe263f89ea2ef15b5af5e80a812b2a85025
> # bad: [5637edb2e1c2d13b276748508ae17f319fb7f066] ALSA: HDA: Sort CXT5066
> quirk table
> git bisect bad 5637edb2e1c2d13b276748508ae17f319fb7f066
> # bad: [18675e4283f575594d55ef1239c14ab5b4de53b6] ALSA: hda - Add fixup f=
or
> FSC Celsius H270
> git bisect bad 18675e4283f575594d55ef1239c14ab5b4de53b6
> # good: [eea7dc932bfa802ad0377755ea821f416f4f8623] ALSA: hda - Use new
> inputs[] field to parse input-pins for STAC/IDT codecs
> git bisect good eea7dc932bfa802ad0377755ea821f416f4f8623
> # bad: [263d0328c46995d8e4fb478005177839104483d2] ALSA: hda - Improve inp=
ut
> control names for IDT/STAC codecs
> git bisect bad 263d0328c46995d8e4fb478005177839104483d2
> # bad: [9737731d64bfa64ab4fc04b46ae5b650f6432222] Merge branch 'fix/hda'
> into topic/hda
> git bisect bad 9737731d64bfa64ab4fc04b46ae5b650f6432222
> # bad: [7b315bb4980448250c80a7464c256b54d546cb26] ALSA: hda - Use new
> inputs[] field to parse input-pins for VIA codecs
> git bisect bad 7b315bb4980448250c80a7464c256b54d546cb26
>
>
> root@Blackrock ~src/alsa-kernel (git)-[7b315bb...|bisect] # git bisect bad
> 7b315bb4980448250c80a7464c256b54d546cb26 is the first bad commit
> commit 7b315bb4980448250c80a7464c256b54d546cb26
> Author: Takashi Iwai <tiwai@suse.de>
> Date: =A0 Mon Aug 30 13:06:30 2010 +0200
>
> =A0 =A0ALSA: hda - Use new inputs[] field to parse input-pins for VIA cod=
ecs
>
> =A0 =A0Signed-off-by: Takashi Iwai <tiwai@suse.de>
>
> :040000 040000 fb32bef12d78f90f00020cf375fddd36be1cdfbe
> 02f61291093ce6c7c8e7e1bd98fd87f9338702a1 M =A0 =A0 =A0sound
>
>
>
> Oh, and here are debug infos from when i first tried to report the proble=
m:
> bad:
> http://www.alsa-project.org/db/?f=3D0f29e6de98ea9fefae5c6e2adb43ff8f8eede=
697
>
> good:
> http://www.alsa-project.org/db/?f=3D11290fe50066e9bcd6a244f2c83b1c66c9dd2=
01b
>
>
> I hope someone can take it from here. I'm not much more than a user. Just
> because i managed to build a kernel doesn't mean i can fix this bug.
>

I think the Mic part might be the same problem I had. I found out that
the following code:

static void via_auto_init_analog_input(struct hda_codec *codec)
{
       struct via_spec *spec =3D codec->spec;
       const struct auto_pin_cfg *cfg =3D &spec->autocfg;
       unsigned int ctl;
       int i;

       for (i =3D 0; i < cfg->num_inputs; i++) {
               hda_nid_t nid =3D cfg->inputs[i].pin;
               if (spec->smart51_enabled && is_smart51_pins(spec, nid))
                       ctl =3D PIN_OUT;
               else if (i =3D=3D AUTO_PIN_MIC)
                         ^^^^^^^^^^^^^^^^^^^^^^^^^
                       ctl =3D PIN_VREF50;
               else
                       ctl =3D PIN_IN;
               snd_hda_codec_write(codec, nid, 0,
                                   AC_VERB_SET_PIN_WIDGET_CONTROL, ctl);
       }
}

configures correctly only the first MIC (in my case it was Rear MIC).
Front Mic pin was configured as HiZ.
Changing the underlined condition to

else if (cfg->input[i].type =3D=3D AUTO_PIN_MIC)

resolved the issue for me. (In alsa driver 1.0.23 this code was
different, it checked that i <=3D FRONT_MIC index).

I'm also just the user of alsa driver, so can't decide whether this is
the proper fix. Maybe someone of knowledgeable developers could check
it.

-- =

Mark Goldstein
