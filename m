From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Set TLV_DB_SCALE_MUTE bit for
 cx5051 vmaster
Date: Tue, 19 Aug 2014 13:16:47 +0800
Message-ID: <CAN8ccibL5F7uetAUGDjmBFX=sBc7f7xZiN2ySHpgLSgRY2NSAQ@mail.gmail.com>
References: <1408009543-4789-1-git-send-email-tiwai@suse.de>
 <CAN8ccibXnfcqthFGv9e1ivv-rx+NdQ56sOCTL4P5f30S-GkJSA@mail.gmail.com>
 <s5h4mxcx5z4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 544272655A0
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 07:16:48 +0200 (CEST)
Received: by mail-qa0-f51.google.com with SMTP id k15so5181107qaq.38
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 22:16:47 -0700 (PDT)
In-Reply-To: <s5h4mxcx5z4.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> >
> > > Conexnat HD-audio driver has a workaround for cx5051 (aka CX20561)
> > > chip to add fake mute controls to each amp (commit 3868137e).  This
> > > implies the minimum-as-mute TLV bit in TLV for each corresponding
> > > control.  Meanwhile we build the virtual master from these, but the
> > > TLV bit is missing, even though the slaves have it.
> > >
> > > This patch simply adds the missing TLV_DB_SCALE_MUTE bit for vmaster,
> > > as already done in patch_sigmatel.c.
> > >
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > ---
> > >  sound/pci/hda/patch_conexant.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/sound/pci/hda/patch_conexant.c
> > b/sound/pci/hda/patch_conexant.c
> > > index 7627a69ca6d7..6f2fa838b635 100644
> > > --- a/sound/pci/hda/patch_conexant.c
> > > +++ b/sound/pci/hda/patch_conexant.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/module.h>
> > >  #include <sound/core.h>
> > >  #include <sound/jack.h>
> > > +#include <sound/tlv.h>
> > >
> > >  #include "hda_codec.h"
> > >  #include "hda_local.h"
> > > @@ -859,6 +860,11 @@ static int patch_conexant_auto(struct hda_codec
> > *codec)
> > >         if (err < 0)
> > >                 goto error;
> > >
> > > +       if (codec->vendor_id == 0x14f15051) {
> > > +               /* minimum value is actually mute */
> > > +               spec->gen.vmaster_tlv[3] |= TLV_DB_SCALE_MUTE;
> > > +       }
> > > +
> > >         codec->patch_ops = cx_auto_patch_ops;
> > >
> > >         /* Some laptops with Conexant chips show stalls in S3 resume,
> > > --
> >
> > Does this mean that when there is no hardware mute switch, the driver
> > create a fake one using mindB of volume as mute ?
>
> The fake mutes are, yes.
>
> > But this mean that the volume control and mute are not independent
anymore,
> > just like those pulseaudio volume controls,  volume always change to
zero
> > after mute and unmute
>
> No, the mute controls are handled individually.
> And, this commit itself isn't about the fake mute implementations.
> It just give the hint to TLV.
>

If the codec  support mute in default amp out caps of afg node, should the
driver still use min as mute for the virtual master since all slaves have
real mute switch

Why the driver add fake mute switch when the hardware real mute switches ?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/?id=3868137ea41866773e75d9ac4b9988dcc361ff1d

https://launchpadlibrarian.net/182545365/AlsaInfo.txt

Codec: IDT 92HD73C1X5
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x111d7675
Subsystem Id: 0x102802eb
Revision Id: 0x100103
No Modem Function Group found
Default PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1

Node 0x15 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="PCM Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="PCM Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="92HD73C1X5 Analog", type="Audio", device=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0x80 0x80]
  Converter: stream=8, channel=0
  Power states:
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x16 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0xab 0xab]
  Converter: stream=8, channel=0
  Power states:
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x17 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: N/A
  Amp-Out vals:  [0xab 0xab]
  Converter: stream=8, channel=0
  Power states:
  Power: setting=D0, actual=D0
  Delay: 13 samples

control.1 {
iface MIXER
name 'PCM Playback Volume'
value.0 55
value.1 55
comment {
access 'read write'
type INTEGER
count 2
range '0 - 127'
dbmin -9525
dbmax 0
dbvalue.0 -5400
dbvalue.1 -5400
}
}
control.2 {
iface MIXER
name 'PCM Playback Switch'
value.0 false
value.1 false
comment {
access 'read write'
type BOOLEAN
count 2
}
}
control.3 {
iface MIXER
name 'Headphone Playback Volume'
value.0 127
value.1 127
comment {
access 'read write'
type INTEGER
count 2
range '0 - 127'
dbmin -9525
dbmax 0
dbvalue.0 0
dbvalue.1 0
}
}
control.4 {
iface MIXER
name 'Headphone Playback Switch'
value.0 false
value.1 false
comment {
access 'read write'
type BOOLEAN
count 2
}
}
control.5 {
iface MIXER
name 'Speaker Playback Volume'
value.0 127
value.1 127
comment {
access 'read write'
type INTEGER
count 2
range '0 - 127'
dbmin -9525
dbmax 0
dbvalue.0 0
dbvalue.1 0
}
}
control.6 {
iface MIXER
name 'Speaker Playback Switch'
value.0 false
value.1 false
comment {
access 'read write'
type BOOLEAN
count 2
}
}

control.17 {
iface MIXER
name 'Master Playback Volume'
value 43
comment {
access 'read write'
type INTEGER
count 1
range '0 - 127'
dbmin -9999999
dbmax 0
dbvalue.0 -6300
}
}
