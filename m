From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Headphone output problems with HP ProDesk 600 G1
	(Realtek ALC221)
Date: Wed, 19 Feb 2014 10:58:18 +0800
Message-ID: <CAN8ccibdTiSp+-=C6TLPsAbwXmZ=iABAK4Hh9hXALsZAauArdg@mail.gmail.com>
References: <CAN8cciabECOHSBC0N0WP1nb17+HsLRDD9xEUn8LcmuuBsVH+3w@mail.gmail.com>
 <CADLC3L2B_osxvrVaT-MEbGrPWf99C7eHyzw6NZZvB8ayFxJgfg@mail.gmail.com>
 <CAN8ccia-cja=_Qh1cwtpvwoxB21F1MVAWYD9reefOn5z7Z0szQ@mail.gmail.com>
 <CADLC3L0PEC_sVrw-+PpQkodvFKOFNicvdL3M5LbiO1Ok8yKkbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f43.google.com (mail-qa0-f43.google.com
 [209.85.216.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D3FBD2652AA
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 03:58:19 +0100 (CET)
Received: by mail-qa0-f43.google.com with SMTP id o15so24579455qap.16
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 18:58:18 -0800 (PST)
In-Reply-To: <CADLC3L0PEC_sVrw-+PpQkodvFKOFNicvdL3M5LbiO1Ok8yKkbQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2014-02-19 9:33 GMT+08:00 Robert Hancock <hancockrwd@gmail.com>:

> On Tue, Feb 18, 2014 at 6:52 PM, Raymond Yau
> <superquad.vortex2@gmail.com> wrote:
> >> >>> I have a HP ProDesk 600 G1 machine which seems to have some strange
> >> > behavior with the front headphone jack(s) running under Fedora 20
> >> > (running 3.13.2 kernel):
> >
> >   HP ProDesk 600 G1 SFF
> >
> > Do SFF mean small form factor model ?
> >
> >
> > HD audio with Realtek ALC221 codec
> > DTS Studio Sound audio management technology
> > Microphone and headphone front ports (3.5mm)
> > Line-out and Line-In rear Ports (3.5mm)
> > Multi-streaming capable
> > Internal speaker (standard)
> >
>
> Yes, this is the small form factor. It is definitely ALC221 (I checked
> the codec chip on the system board).
>
> >
> >
> >> >
> >> >>> This machine has two front jacks: a headphone jack and a
> >> > microphone/headphone jack. When the headphones are plugged into the
> >> > headphone jack, there's usually no change in the sound outputs list in
> >> > the Sound control panel. The audio (mostly) works if the audio output
> >> > device is set to Analog Output, but sometimes spuriously changes back
> >> > to Speakers and the headphone output stops working (I suspect maybe
> >> > from a spurious jack-sensing event, though I'm not certain). More
> >> > confusingly, a couple of times I have gotten it into the state
> >> > (through various fiddling with jacks and playing in the Sound control
> >> > panel) where plugging into this jack is detected and causes the
> >> > Headphone output to be selected in the control panel. I haven't been
> >> > able to figure out consistently what causes this to happen.
> >> >
> >> >>> If the headphone is plugged into the microphone/headphone jack, then
> >> > the control panel consistently switches to the Headphone output and
> >> > consistently switches back the way it was when it's unplugged.
> >> > However, there's no actual audio output coming out of that jack. (From
> >> > some of the HP manuals, it sounds like with the Windows driver, when
> >> > you plug into this jack, it's supposed to pop up a prompt asking you
> >> > whether you want to use it as a microphone or headphones.)
> >> >
> >> >>> The other strange thing is that intermittently, on the headphone
> jack
> >> > you'll start getting a bunch of loud static (clicking noises) and any
> >> > actual audio playback becomes very faint and distorted.
> >> >
> >> >>> I'm guessing perhaps something isn't being initialized/setup
> properly
> >> > in the codec, causing this kind of erratic behavior. The alsa-info
> >> > output is uploaded at:
> >> >
> >> >
> >> >
> http://www.alsa-project.org/db/?f=594e837b7af07ffbe3473cf807465bc81a587880
> >> >
> >
> >> >
> >> > Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
> >> >   Control: name="PCM Playback Switch", index=0, device=0
> >> >     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
> >> >   Control: name="Line Out Jack", index=0, device=0
> >> >   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
> >> >   Amp-Out vals:  [0x00 0x00]
> >> >   Pincap 0x00010014: OUT EAPD Detect
> >> >   EAPD 0x2: EAPD
> >> >   Pin Default 0x01014020: [Jack] Line Out at Ext Rear
> >> >     Conn = 1/8, Color = Green
> >> >     DefAssociation = 0x2, Sequence = 0x0
> >> >
> >> > it is a driver bug which assign PCM playback Switch to Line Out Jack
> >> >
> >> > try the patch  https://bugzilla.kernel.org/attachment.cgi?id=124971
> >>
> >> With this patch, I get no audio output at all (totally silent on all
> >> ports). Even with playing around with alsamixer and muting/unmuting
> >> outputs I could not get anything coming out.
> >>
> >> The alsa-info output from the patched kernel is here:
> >>
> >>
> http://www.alsa-project.org/db/?f=df5874b4fdc01fd6d2c9541c9cde380fe844ac6c
> >
> >
> > autoconfig: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
> >     speaker_outs=1 (0x17/0x0/0x0/0x0/0x0)
> >     hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> >     mono: mono_out=0x0
> >     inputs:
> >       Mic=0x1a
> >       Line=0x1b
> >
> > do you mean one of the front panel jacks support TRRS headset ?
>
> I think that is what the labelling is indicating, yes.
>

http://h20566.www2.hp.com/portal/site/hpsc/public/psi/manualsResults/?sp4ts.oid=5387447

refer to the maintenance and service guide

When a device is plugged into the Microphone/Headph
one Connector, a dialog box will pop up asking if
you want to use the connector for a microphone Line-In
device or a headphone. You can reconfigure the connector
at any time by double-clicking the Audio Manager icon in the Windows
taskbar


 the hardware reference guide and Illustrated Parts and Service map
 microphone jack and headphone jack

it seem not support TRRS headset

Do the icon really show a headset ( headphone with mic) ?



> >
> > use hda-jack-sense-test to find the nodes of front panel jacks and rear
> > panel jacks
>
> From what I can tell:
>
> When the headphone-only jack is plugged into, nothing happens with jack
> sensing
> When the headphone/mic jack is plugged into, both Pin 0x1a (Black Mic)
> and Pin 0x21 (Black HP Out) show present
> When the rear line out jack is plugged into, Pin 0x14 (Green Line Out)
> shows present
> When the rear line in jack is plugged into, nothing happens with jack
> sensing
>

did you use "-a" option for hda-jack-sense-test ?
