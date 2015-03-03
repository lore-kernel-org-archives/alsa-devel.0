From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Wed, 4 Mar 2015 00:17:12 +0800
Message-ID: <CAN8cciYA_XRRFtCx8BZHYO=bfdObRr9P84Yfj99mwLq_cW1N=A@mail.gmail.com>
References: <CAN8ccib6-oLgZAhYpKTnh_Bjm6G1axN2NCv8mQBPczRy4=qmqg@mail.gmail.com>
 <54f5d2c8.52ffed47.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f174.google.com (mail-ob0-f174.google.com
 [209.85.214.174])
 by alsa0.perex.cz (Postfix) with ESMTP id D01552616B9
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 17:17:15 +0100 (CET)
Received: by obbnt9 with SMTP id nt9so702915obb.13
 for <alsa-devel@alsa-project.org>; Tue, 03 Mar 2015 08:17:13 -0800 (PST)
In-Reply-To: <54f5d2c8.52ffed47.bm000@wupperonline.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?SW5nbyBCcsO8Y2ts?= <ib@wupperonline.de>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> >> Now I'm getting the favored config:
> >>
> >> ==> Best config: lo_type=0, wired=0, mio=1
> >> multi_outs = 14/0/0/0 : 2/3/4/0 (type LO)
> >> multi_ios(2) = 1a/18 : 3/4
> >> hp_outs = 1b/0/0/0 : 2/0/0/0
> >> spk_outs = 15/0/0/0 : 0/0/0/0
>
> > How do the driver know the volume control at node 0x02 is shared by hp,
> > line out and speaker when your spk_outs path not contain node 0x02
>
> It probably doesn't know. I suppose I'm losing the speaker (which isn't
> connected nor used by me anyway).

> >> multi_outs = 14/0/0/0 : 2/3/4/0 (type LO)
> >> multi_ios(2) = 1a/18 : 3/4
> >> hp_outs = 1b/0/0/0 : 2/0/0/0

path_has_mixer() does not imply shared volume

get_amp_nid_( path->ctls[NID_PATH_VOL_CTL] )  of two paths are same

if you just want Front+Headphone playback volume

>
> On the other hand I'm getting a real Master as well as a Headphone switch,
> Front, Surround, Center and LFE controls, and the channel mode.
Everything's
> working just great!
>
> > BTW do the driver need to disable independent headphone after your
> > change ?
>
> I have only a headphone mute switch, no headphone volume control, if
that's
> what you mean. But since the master affects headphone volume, that's OK.

As the original config only support stereo, pcm playback volume control
line out volume , headphone and speaker using different DAC 0x02 and 0x03

Try specify

spec->gen.indep_hp = 1;

before callin the auto parser in patch_alc662

Device: name="ALC662 rev3 Alt Analog", type="Audio", device=2

should appear in node 0x03 which has headphone playback volume

Codec: Realtek ALC662 rev3
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0662
Subsystem Id: 0x8086204c
Revision Id: 0x100300
No Modem Function Group found
Default PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0
GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="PCM Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="ALC662 rev3 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x57 0x57]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x57 0x57]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x57 0x57]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
