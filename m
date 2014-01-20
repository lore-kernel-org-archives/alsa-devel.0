From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Thinkpad T520 (Low Volume)
Date: Mon, 20 Jan 2014 21:22:07 +0800
Message-ID: <CAN8cciamgAXMbG++pr+08vgMfACENkSmhx2pg=Y43jsd_RWt9w@mail.gmail.com>
References: <CAN8ccib14G8pyLuMTi2BS6_hW0StBxEEu4EcUv2HKG==BQ27NQ@mail.gmail.com>
 <3997344.dLRXQbcGtH@t520.axxite.internal>
 <CAN8cciZTWd5zJDfBjqkaTRWfimirq+iqiaEHZpJKt8biY2poSQ@mail.gmail.com>
 <1850988.oa86JCBIJg@t520.axxite.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f180.google.com (mail-ie0-f180.google.com
 [209.85.223.180])
 by alsa0.perex.cz (Postfix) with ESMTP id DA971261703
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 14:22:08 +0100 (CET)
Received: by mail-ie0-f180.google.com with SMTP id at1so5310788iec.11
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 05:22:07 -0800 (PST)
In-Reply-To: <1850988.oa86JCBIJg@t520.axxite.internal>
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

2014/1/20 Axel Braun <axel.braun@gmx.de>

> Hi,
>
> Am Montag, 20. Januar 2014, 09:27:57 schrieb Raymond Yau:
> > > > > same problem on a ThinkPad T520, sound volume is way
> > > > > too low - watching movie via loudspeakers is fairly impossible.
> > > > > Any hint you could give me?
> > > > > post the output of alsa-info.sh , there is a bug in alsa-driver
> which
> > > > > treat
> > > > > dock headphone and headphone to support surround 4.0
> > > > > you get low volume because Amp Out vals are 0x3d instead of 0x4a
> but
> > > > > speaker volumes are at 100% (0dB)
> > >
> > > Can I influence that from the running system, e.g. by
> > > echo 0x4d > ....
> >
> > refer to user manual, it seem that both headset and headphone are
> supported
> > but you cannot use conventional mic  with this combo audio jack
> >
> > are you using headset or headphone ?
>
> I'm using a headset from a smartphone - it is the same 3,5mm jack
>
> > do headset mic work or not ?
>
> works fine
>
> > try hda_analyzer to change the volume slider of those nodes 0x10 and 0x11
>
> maybe I'm on the wrong track...but do I have to apply the diff code to the
> alsa source code and then rebuild the package?
>

http://www.alsa-project.org/main/index.php/HDA_Analyzer


>
> > > ?
> > >
> > > > Simple mixer control 'Speaker',0
> > > >
> > > >   Capabilities: pvolume pswitch
> > > >   Playback channels: Front Left - Front Right
> > > >   Limits: Playback 0 - 74
> > > >   Mono:
> > > >   Front Left: Playback 74 [100%] [0.00dB] [on]
> > > >   Front Right: Playback 74 [100%] [0.00dB] [on]
> > > >
> > > > Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
> > > >
> > > >   Control: name="Speaker Playback Volume", index=0, device=0
> > > >
> > > >     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
> > > >
> > > >   Control: name="Speaker Playback Switch", index=0, device=0
> > > >
> > > >     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
> > > >
> > > >   Device: name="CX20590 Analog", type="Audio", device=0
> > > >   Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
> > > >   Amp-Out vals:  [0x3d 0x3d]
> > > >
>

may be related to this patch

ALSA: hda - Enable codec->pin_amp_workaround always for Conexant auto-parser

try

codec->pin_amp_workaround = 0;



> > > > if you don't have docking station ,  the workaround is to remove
> those
> > >
> > > pin
> > >
> > > > fix of node 0x1a and 0x1c
> > >
> > > I dont have a docking station - but I have no clue what I should do
> > > here...
> >
> > the easy way is to use model=nofixup since your bios does not have dock
> > headphone and dock mic pins default but this also remove mic mute led
>
> model=nofixup ad parameter for the module snd_hda_intel ?
>

yes

or

try hdajackretask to remove the dock headphone and dock mic so that
surround 4.0 is not supported

http://git.alsa-project.org/?p=alsa-tools.git;a=blob;f=hdajackretask/README;hb=HEAD
