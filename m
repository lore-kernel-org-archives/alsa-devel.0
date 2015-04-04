From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Sat, 4 Apr 2015 13:39:17 +0800
Message-ID: <CAN8cciaYWDECp0cP+E0i-rMbfJKn=WiEZXe0YvS9q48MmB89Ng@mail.gmail.com>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <1427820547.2856.10.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <1427891224.2711.31.camel@loki>
 <CAEUnVG4iCJGGPw2=R+TxVCoj3ky2SBgZDpZrFbswXh36b-WydA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f172.google.com (mail-ob0-f172.google.com
 [209.85.214.172])
 by alsa0.perex.cz (Postfix) with ESMTP id ADED8260496
 for <alsa-devel@alsa-project.org>; Sat,  4 Apr 2015 07:39:18 +0200 (CEST)
Received: by obbgh1 with SMTP id gh1so185536313obb.1
 for <alsa-devel@alsa-project.org>; Fri, 03 Apr 2015 22:39:17 -0700 (PDT)
In-Reply-To: <CAEUnVG4iCJGGPw2=R+TxVCoj3ky2SBgZDpZrFbswXh36b-WydA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Arun Raghavan <arun@accosted.net>, Han Lu <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

> >> >
> >> > I've added a few others on the CC that would be interested.
> >> >
> >> > > My understanding is that a UCM device can represent a thing that
has
> >> > > both input and output (I don't particularly like that, but it's
too late
> >> > > to complain).
> >> >
> >> > Yes, but it can also represent simplex devices too e.g.
> >> > "Headset-Speakers" and "Headset-Mic". There are not any hard rules
here,
> >> > but most examples are using duplex devices as historically UCM came
from
> >> > the phone ecosystem use cases.
> >> >
> >> > > How likely do you think that there are or there will be
> >> > > some drivers that expose separate input and output jack kcontrols
for a
> >> > > headset jack, to differentiate between
headphones/headset/microphone? My
> >> > > understanding is that jack kcontrols store only booleans, so
there's no
> >> > > way to distinguish between headphones and a headset with just one
kcontrol.
> >> > >
> >> >
> >> > This sounds like we need to extend the jack kcontrol so that we can
> >> > differentiate between Headphones and Headset unless the kcontrol
naming
> >> > was intended to differentiate and define the jack type ?
> >>
> >> I guess it's now clear that all jack kcontrols will be booleans, and
> >> headset jacks will require two jack kcontrols.
> >>
> >> > > The current UCM "spec" doesn't support specifying multiple
kcontrols,
> >> > > since there's only one "JackControl" value. (Perhaps the "JackDev"
value
> >> > > suffers from this problem too, but I don't know if jack input
devices
> >> > > already support reporting the state separately for input and
output.)
> >> > >
> >> >
> >> > I think in this case we could define simplex UCM devices and attach a
> >> > JackControl value to each device.
> >>
> >> So is your preference that UCM configuration authors are forced to
> >> define simplex devices to deal with headset jacks, rather than using
> >> duplex devices and defining "PlaybackJackControl" and
> >> "CaptureJackControl" separately? (I don't personally mind either way.)
> >
> > I don't really mind either, but what's easier for audio servers like
> > pulseaudio that will be the main UCM clients ? I guess that pulseaudio,
> > CRAS, and other audio servers probably deal with simplex PCM streams
> > internally so mapping to simplex jacks/devices might be better ?
>
> There is an advantage to having a separate device for the headphone and
mic
> even if they are connected to the same jack.  The user can enable one and
not
> the other, most commonly to use the headphones but record from the
built-in mic,
> ignoring the headset mic.  Because of this we require all ChromeOS
devices to
> support separate reporting and selection of headphone/mic on the headset
jack.
> There is always one UCM device and one user-visible i/o node per jack.
>
> >

How do these kind of jack handle by UCM ?

http://www.dell.com/support/home/us/en/19/product-support/product/inspiron-15-3537/manuals

6 Headset port Connect a headphone, a microphone, or a headphone and
microphone combo (headset).

https://launchpadlibrarian.net/193669943/AlsaInfo.txt

Seem there are three pin complexes for this combo jack

Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Headset Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Headset Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Headphone Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Headphone Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 5
     0x18 0x19 0x1a 0x1b 0x1d

Node 0x12 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Control: name="Internal Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Internal Mic Phantom Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x03 0x03]
  Pincap 0x00000020: IN
  Pin Default 0x90a60130: [Fixed] Mic at Int N/A
    Conn = Digital, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0

Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Phantom Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00010014: OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x90170110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0c

Node 0x19 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Control: name="Headset Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Headset Mic Phantom Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x03 0x03]
  Pincap 0x00003724: IN Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0

Node 0x21 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Mic Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x0321101f: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x0c 0x0d*

sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC1D0/init_pin_configs:
0x12 0x90a60130
0x14 0x90170110
0x17 0x40020008
0x18 0x411111f0
0x19 0x411111f0
0x1a 0x411111f0
0x1b 0x411111f0
0x1d 0x40e00001
0x1e 0x411111f0
0x21 0x0321101f

/sys/class/sound/hwC1D0/driver_pin_configs:
0x19 0x01a1913c
0x1a 0x01a1913d
