From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Tue, 7 Apr 2015 11:00:21 +0800
Message-ID: <CAN8ccib+0yf_haX4gFK+VkN2CgQQQ6tQUKWhbv=4kxeU60e_gQ@mail.gmail.com>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <1427820547.2856.10.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <1427891224.2711.31.camel@loki>
 <CAEUnVG4iCJGGPw2=R+TxVCoj3ky2SBgZDpZrFbswXh36b-WydA@mail.gmail.com>
 <CAN8cciaYWDECp0cP+E0i-rMbfJKn=WiEZXe0YvS9q48MmB89Ng@mail.gmail.com>
 <1428312393.2616.19.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
 [209.85.214.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DAFC260533
 for <alsa-devel@alsa-project.org>; Tue,  7 Apr 2015 05:00:22 +0200 (CEST)
Received: by obbfy7 with SMTP id fy7so69737830obb.2
 for <alsa-devel@alsa-project.org>; Mon, 06 Apr 2015 20:00:21 -0700 (PDT)
In-Reply-To: <1428312393.2616.19.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Arun Raghavan <arun@accosted.net>, Han Lu <han.lu@intel.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

> >
> > How do these kind of jack handle by UCM ?
> >
> >
http://www.dell.com/support/home/us/en/19/product-support/product/inspiron-15-3537/manuals
> >
> > 6 Headset port Connect a headphone, a microphone, or a headphone and
> > microphone combo (headset).
> >
>
> UCM is not really needed for this device as Pulseaudio handles the
> standardised HDA jacks and routing (there is nothing stopping a UCM
> config being defined though). So for each input/output endpoint above
> you would list it's jack kcontrol in the endpoint device section. e.g.
> sound server reads jack input and type, checks UCM config and matches
> the device before setting routing according to UCM device.

#ifdef CONFIG_SND_HDA_INPUT_JACK
if (!phantom_jack) {
jack->type = get_input_jack_type(codec, nid);
err = snd_jack_new(codec->card, name, jack->type,
   &jack->jack);
if (err < 0)
return err;
jack->jack->private_data = jack;
jack->jack->private_free = hda_free_jack_priv;
snd_jack_report(jack->jack, state ? jack->type : 0);
}
#endif

Current implementation only create input jack when
CONFIG_SND_HDA_INPUT_JACK is defined but those input jacks are always
created by the proposed change

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
Node 0x1a [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Control: name="Headphone Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003724: IN Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN VREF_HIZ
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

This mean that those application which want to use kctl must ask the user
to select the type of the jack whenever the user plugged the jack if the
hatdware cannot distinguish headset, headphone or mic jack

What will happen when the user already plugged the jack before boot or
restart pulseaudio server ?

http://bazaar.launchpad.net/~unity-settings-daemon-team/unity-settings-daemon/trunk/view/head:/plugins/media-keys/what-did-you-plug-in/pa-backend.c

In PulseAudio ports will show up with the following names:
   Headphones - analog-output-headphones
   Headset mic - analog-input-microphone-headset
   Jack in mic-in mode - analog-input-microphone

   However, since regular mics also show up as analog-input-microphone,
   we need to check for certain controls on alsa mixer level too, to know
   if we deal with a separate mic jack, or a multi-function jack with a
   mic-in mode (also called "headphone mic").
   We check for the following names:

   Headphone Mic Jack - indicates headphone and mic-in mode share the same
jack, i e, not two separate jacks. Hardware cannot distinguish between a
headphone and a mic.
   Headset Mic Phantom Jack - indicates headset jack where hardware can not
distinguish between headphones and headsets
   Headset Mic Jack - indicates headset jack where hardware can distinguish
between headphones and headsets. There is no use popping up a dialog in
this case, unless we already need to do this for the mic-in mode.

>
> UCM is mainly needed for non HDA devices that have different jack pins,
> volume controls and routing controls. Sound servers have no way of
> guessing the correct mixers and volume controls to use for non HDA
> devices as they are all very different HW.
>

Do this mean that for those notebook which have three physical jacks :
headset, headphone and mic jack should create headset jack headset mic
jack, headphone jack and mic jack kctls ?

http://www.dell.com/support/home/us/en/19/product-support/product/alienware-14/manuals

17. Headphones and microphone combo port
18. Headphones/Speakers port
19. Microphone port

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1302090

https://launchpadlibrarian.net/171704958/alsa-info.txt.ReoE61oqo9

Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Front Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x0321101f: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 3
     0x0c* 0x0d 0x0e
Node 0x16 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=1, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Surround Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x03211020: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 3
     0x0c 0x0d* 0x0e

Node 0x19 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x03a11030: [Jack] Mic at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=03, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 3
     0x0c* 0x0d 0x0e
