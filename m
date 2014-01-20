From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Thinkpad T520 (Low Volume)
Date: Mon, 20 Jan 2014 09:27:57 +0800
Message-ID: <CAN8cciZTWd5zJDfBjqkaTRWfimirq+iqiaEHZpJKt8biY2poSQ@mail.gmail.com>
References: <CAN8ccib14G8pyLuMTi2BS6_hW0StBxEEu4EcUv2HKG==BQ27NQ@mail.gmail.com>
 <3997344.dLRXQbcGtH@t520.axxite.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 40FE3261A10
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 02:27:59 +0100 (CET)
Received: by mail-ie0-f179.google.com with SMTP id ar20so2968974iec.10
 for <alsa-devel@alsa-project.org>; Sun, 19 Jan 2014 17:27:58 -0800 (PST)
In-Reply-To: <3997344.dLRXQbcGtH@t520.axxite.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Braun <axel.braun@gmx.de>
Cc: tiwai@suse.de, danny@danysek.cz, ALSA Development Mailing List <alsa-devel@alsa-project.org>, jens.taprogge@taprogge.org
List-Id: alsa-devel@alsa-project.org

> >
> > > same problem on a ThinkPad T520, sound volume is way
> > > too low - watching movie via loudspeakers is fairly impossible.
> > > Any hint you could give me?
> > >
> > > post the output of alsa-info.sh , there is a bug in alsa-driver which
> >
> > treat
> >
> > > dock headphone and headphone to support surround 4.0
> >
> > you get low volume because Amp Out vals are 0x3d instead of 0x4a but
> > speaker volumes are at 100% (0dB)
>
> Can I influence that from the running system, e.g. by
> echo 0x4d > ....
>

refer to user manual, it seem that both headset and headphone are supported
but you cannot use conventional mic  with this combo audio jack

are you using headset or headphone ?

do headset mic work or not ?

try hda_analyzer to change the volume slider of those nodes 0x10 and 0x11


> ?
>
> > Simple mixer control 'Speaker',0
> >   Capabilities: pvolume pswitch
> >   Playback channels: Front Left - Front Right
> >   Limits: Playback 0 - 74
> >   Mono:
> >   Front Left: Playback 74 [100%] [0.00dB] [on]
> >   Front Right: Playback 74 [100%] [0.00dB] [on]
> >
> > Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
> >   Control: name="Speaker Playback Volume", index=0, device=0
> >     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
> >   Control: name="Speaker Playback Switch", index=0, device=0
> >     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
> >   Device: name="CX20590 Analog", type="Audio", device=0
> >   Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
> >   Amp-Out vals:  [0x3d 0x3d]
> >
>
> >
> >
> > if you don't have docking station ,  the workaround is to remove those
> pin
> > fix of node 0x1a and 0x1c
>
> I dont have a docking station - but I have no clue what I should do here...


the easy way is to use model=nofixup since your bios does not have dock
headphone and dock mic pins default but this also remove mic mute led

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_conexant.c?id=2fd3f170e5ba04acc60ee94b2c76ee166727c734


https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_conexant.c?id=d70f363222ef373c2037412f09a600357cfa1c7a

just remove dock mic and dock hp from cxt_pincfg_lenovo_tp410

/* ThinkPad 410/420/510/520, X201 & co with cxt5066 */
static const struct cxt_pincfg cxt_pincfg_lenovo_tp410[] = {
 { 0x19, 0x042110ff }, /* HP (seq# overridden) */
- { 0x1a, 0x21a190f0 }, /* dock-mic */
- { 0x1c, 0x212140ff }, /* dock-HP */
 {}
};


there are dock stations which only has combo jack for the dock headset and
some have dock mic and dock headphone jacks


as some notebooks have dual headphone jacks , should those headphone pin
put in multi out with mic jack retasked to support 5.1
