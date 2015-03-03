From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Tue, 03 Mar 2015 10:36:51 +0100
Message-ID: <54f58df6.3dd80617.bm000@wupperonline.de>
References: <CAN8cciaUw6RWgE859mNvvoDmeZ-ovPnu-21L6=YXJu+kxExeTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutD.wup.tal.de (moutd.wup.tal.de [213.240.144.30])
 by alsa0.perex.cz (Postfix) with ESMTP id B36682606CB
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 11:33:29 +0100 (CET)
In-Reply-To: <CAN8cciaUw6RWgE859mNvvoDmeZ-ovPnu-21L6=YXJu+kxExeTg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond,

I'm not familiar with hardware, so I had some difficulties to understand
what's going on here, but then I got really curious. So I grabbed an ALC662
datasheet and studied the block diagram. Now I think that I'm beginning to
understand.

>> >> > [    0.655493] sound hdaudioC1D0: autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
>> >> > [    0.655494] sound hdaudioC1D0:    speaker_outs=1 (0x15/0x0/0x0/0x0/0x0)
>> >> > [    0.655495] sound hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
>> >> > [    0.655496] sound hdaudioC1D0:    mono: mono_out=0x0
>> >> > [    0.655496] sound hdaudioC1D0:    dig-out=0x1e/0x0
>> >> > [    0.655497] sound hdaudioC1D0:    inputs:
>> >> > [    0.655498] sound hdaudioC1D0:      Front Mic=0x19
>> >> > [    0.655499] sound hdaudioC1D0:      Rear Mic=0x18
>> >> > [    0.655499] sound hdaudioC1D0:      Line=0x1a
>> >>
>> >> > This is a known bug of hda_generic.c for those desktop with internal
>> >> > speaker and three audio jacks at rear panel (e.g. those lenovo
>> >> > thinkcenter with alc66x codec)
>> >>
>> >> > The driver prefer to assign volume control/dac to headphone, line out and
>> >> > internal speaker instead of line out and the other two multi io jacks
>>
>> > or You need to increase BAD_MULTI_IO from 0x120 to 0x4120 since
>> > BAD_NO_DAC 0x4000 for the driver to select config with mio=1
>>

>==> lo_type=0, wired=1, mio=1, badness=0x352
> multi_outs = 14/0/0/0 : 2/0/0/0 (type LO)
>   out path: depth=3 '02:0c:14'
> hp_outs = 1b/0/0/0 : 2/0/0/0
>   hp  path: depth=3 '02:0c:1b'
> spk_outs = 15/0/0/0 : 3/0/0/0
>   spk path: depth=3 '03:0d:15'
>==> lo_type=0, wired=1, mio=0, badness=0x120
> multi_outs = 14/0/0/0 : 2/0/0/0 (type LO)
>   out path: depth=3 '02:0c:14'
> hp_outs = 1b/0/0/0 : 4/0/0/0
>   hp  path: depth=3 '04:0e:1b'
> spk_outs = 15/0/0/0 : 3/0/0/0
>   spk path: depth=3 '03:0d:15'
> send: NID=0x18, VERB=0xf00(get_parameters), PARM=0x12(amp_out_cap)
> receive: 0x80000000
>==> lo_type=0, wired=0, mio=1, badness=0x4112
> multi_outs = 14/0/0/0 : 2/3/4/0 (type LO)
>   out path: depth=3 '02:0c:14'
> multi_ios(2) = 1a/18 : 3/4
>   mio path: depth=3 '03:0d:1a'
>   mio path: depth=3 '04:0e:18'
> hp_outs = 1b/0/0/0 : 2/0/0/0
>   hp  path: depth=3 '02:0c:1b'
> spk_outs = 15/0/0/0 : 0/0/0/0
>==> lo_type=0, wired=0, mio=0, badness=0x4120
> multi_outs = 14/0/0/0 : 2/0/0/0 (type LO)
>   out path: depth=3 '02:0c:14'
> hp_outs = 1b/0/0/0 : 3/0/0/0
>   hp  path: depth=3 '03:0d:1b'
> spk_outs = 15/0/0/0 : 0/0/0/0
>==> restoring best_cfg
>==> Best config: lo_type=0, wired=1, mio=0
> multi_outs = 14/0/0/0 : 2/0/0/0 (type LO)
>   out path: depth=3 '02:0c:14'
> hp_outs = 1b/0/0/0 : 4/0/0/0
>   hp  path: depth=3 '04:0e:1b'
> spk_outs = 15/0/0/0 : 3/0/0/0
>   spk path: depth=3 '03:0d:15'

> The current driver select config with smallest badness
> You need an ad hoc check of increasing the badness due to multi io cannot
> be assigned  for those realtek alc66x codecs with 3stack and internal
> speaker

I think I've figured out how to safely perform a private kernel patch for it.

diff -Nur a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
--- a/sound/pci/hda/hda_generic.c	2015-02-11 08:01:12.000000000 +0100
+++ b/sound/pci/hda/hda_generic.c	2015-03-02 22:57:34.799192329 +0100
@@ -1233,7 +1233,8 @@
 				dac = spec->private_dac_nids[0];
 				badness += bad->shared_surr_main;
 			} else if (!i)
-				badness += bad->no_primary_dac;
+				/* no additional badness for 0x15 (speaker) without DAC (during multi-io check) */
+				badness += pin == 0x15 ? 0 : bad->no_primary_dac;
 			else
 				badness += bad->no_dac;
 		}

Now I'm getting the favored config:

==> lo_type=0, wired=1, mio=1, badness=0x352
multi_outs = 14/0/0/0 : 2/0/0/0 (type LO)
hp_outs = 1b/0/0/0 : 2/0/0/0
spk_outs = 15/0/0/0 : 3/0/0/0
==> lo_type=0, wired=1, mio=0, badness=0x120
multi_outs = 14/0/0/0 : 2/0/0/0 (type LO)
hp_outs = 1b/0/0/0 : 4/0/0/0
spk_outs = 15/0/0/0 : 3/0/0/0
==> lo_type=0, wired=0, mio=1, badness=0x112
multi_outs = 14/0/0/0 : 2/3/4/0 (type LO)
multi_ios(2) = 1a/18 : 3/4
hp_outs = 1b/0/0/0 : 2/0/0/0
spk_outs = 15/0/0/0 : 0/0/0/0
==> lo_type=0, wired=0, mio=0, badness=0x120
multi_outs = 14/0/0/0 : 2/0/0/0 (type LO)
hp_outs = 1b/0/0/0 : 3/0/0/0
spk_outs = 15/0/0/0 : 0/0/0/0
==> restoring best_cfg
==> Best config: lo_type=0, wired=0, mio=1
multi_outs = 14/0/0/0 : 2/3/4/0 (type LO)
multi_ios(2) = 1a/18 : 3/4
hp_outs = 1b/0/0/0 : 2/0/0/0
spk_outs = 15/0/0/0 : 0/0/0/0

> > The master volume control affects the line out volume (which is named PCM,
> > btw), but no other output. Muting the master, however, affects all outputs.
> >
> > After changing to 4ch or 6ch, the PCM (line out) volume control acts as a
> > "master" for surround and center/lfe.

> Seem "master playback volume" is not the correct name when using surround
> 5.1 and your config lost the virtual master playback volume

It seems that this is fixable. Patch will follow.

By the way, there is one thing I still don't understand. After booting there
is no "PCM Playback Volume" control in alsamixer. As soon as I've played some
wav file, it appears. Where does it come from, i.e. is it created by kernel
or alsa-lib/utils and why?

Ingo
