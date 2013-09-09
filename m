From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: No sound from internal speaker on 2013 Macbook Air
 6, 1
Date: Tue, 10 Sep 2013 00:24:43 +0800
Message-ID: <CAN8ccibUb-ghJZ6C6dD4BBtpeTKcGARKbStfrA=cQM9FhvaFgA@mail.gmail.com>
References: <CAH4=b6KOs-WJ+_KVGiQ4LRC9-3J_A_xK64UcrMq6NZFxyycS_w@mail.gmail.com>
 <CAN8cciZuiRR9=iqkxYLoj==UXqYzEdVM2M85y5vg6zBYArjhSQ@mail.gmail.com>
 <CAH4=b6Km5E5v18bvKqV661kudaKkpfnHGUWNEeGEY7ngXVARnw@mail.gmail.com>
 <s5h61uabc4l.wl%tiwai@suse.de>
 <CAH4=b6+KtfWnWcY6NyP_Ls7bPGHBCnhkPJjVqDSeFUJ2Ltz=4g@mail.gmail.com>
 <s5hwqmq9vgb.wl%tiwai@suse.de>
 <CAH4=b6LM4fexo4QpFeP1Nn9X77BcGExaL8-WkQ5Q-9chioKpRQ@mail.gmail.com>
 <s5ha9jm9jeu.wl%tiwai@suse.de>
 <CAH4=b6K1d+kkbF5m72A=GALJPa59rPrg5K3FspG1_OxBcp_3dA@mail.gmail.com>
 <s5h4n9u9h3h.wl%tiwai@suse.de>
 <CAH4=b6L=+_zZ0MeELKkVi_wnLDCDi1ETCCp5PH9rgXn8JgNfZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f176.google.com (mail-ie0-f176.google.com
 [209.85.223.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 98D4126512A
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 18:24:44 +0200 (CEST)
Received: by mail-ie0-f176.google.com with SMTP id s9so13587384iec.35
 for <alsa-devel@alsa-project.org>; Mon, 09 Sep 2013 09:24:43 -0700 (PDT)
In-Reply-To: <CAH4=b6L=+_zZ0MeELKkVi_wnLDCDi1ETCCp5PH9rgXn8JgNfZg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ian Munsie <darkstarsword@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
>
> One other weird thing I noticed while testing this is that setting the
> volume to 0% and/or muting does the controls does not seem to
> completely mute the sound - it is just really quiet (quiet enough not
> to be an issue for me). Some observations:
>
> __Speakers__
> Master: Mute AND/OR Speakers: Mute
> --> Speakers are muted.
>
> Master: 0% AND Speakers: 0%
> --> Sound still comes from speakers, but is very quiet.
>
> Master: 0%
> --> speaker control affects volume.
>
> __Headphones__
> Master: 0% AND/OR Headphones: 0%
> --> Sound still comes from headphones at low volume
> (if either control is 0%, the volume of the other control has no
> effect - both have to be non-zero to raise the volume).
>
> Master: Mute AND/OR Headphones: Mute
> --> Sound still comes from headphones, though is fairly quiet (much
> lower than 0%).
>

Because the driver select the amp at the pin complex of the headphone
instead of the amp at the audio output

These amps have different dB min

Node 0x02 [Audio Output] wcaps 0xd043d: Stereo Amp-Out Stripe
  Device: name="ID 4208 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=8, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x03 [Audio Output] wcaps 0xd043d: Stereo Amp-Out Stripe
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=8, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples

Node 0x10 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Jack", index=0, device=0
  Amp-Out caps: ofs=0x42, nsteps=0x42, stepsize=0x03, mute=1
  Amp-Out vals:  [0x42 0x42]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x032b401f: [Jack] HP Out at Ext Left
    Conn = Comb, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x02
