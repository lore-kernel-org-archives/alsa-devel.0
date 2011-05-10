From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Tue, 10 May 2011 10:03:03 +0800
Message-ID: <BANLkTikcUZESFMF-Y30jLJ889nCLEBwNhA@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
	<BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
	<BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5186310380F
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 04:03:06 +0200 (CEST)
Received: by fxm5 with SMTP id 5so4568505fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 09 May 2011 19:03:04 -0700 (PDT)
In-Reply-To: <BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/9 alex dot baldacchino dot alsasub at gmail dot com <
alex.baldacchino.alsasub@gmail.com>

you have to ask the distribution maintainer how to test the latest
alsa-driver without upgrading the kernel.

it look like the driver is not installed correctly

!!Aplay/Arecord output
!!------------

APLAY

aplay: device_list:240: no soundcards found...

ARECORD

arecord: device_list:240: no soundcards found...


!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [SB]

Invalid card number.
Usage: amixer <options> [command]




Most likely you will need this patch

cb34c207af4944e9c93e2b462e351430f15daad6

so that the driver do not create "smart5.1" control since blue jack may need
to retask as side according to the user manual

ALSA: hda - VIA: Fix Smart5.1 isn't useful for 6 audio jacks motherboard.



>
> Lastly, do I need to enable debug? (that is, is it required for better
> alsa-info output?)
>
>
The driver print debug messages in system log , you are able to know which
[Audio Output] is used when switch "Independent HP" on/off or retask blue
jack as output



> For now, below I'm posting alsa-info.sh output for current
> configuration and for kernel 2.6.33.2 (with working sound), hoping
> this can help for comparison.
>
> >
> > Post the output of alsa-info.sh
> >
> > What is the model of your computer (desktop/notebook) ?
> >
>
> Mine is a home-build desktop with an Asrock motherboard (I don't know of
> any
> notebook with asrock MoBo), model '890GX Extreme3', with integrated
> graphics (Radeon HD4290) and audio (via vt2020 codec and ati hdmi), NB
> AMD 890GX, SB850;
>
> > How many audio jacks ?
> >
>
> Rear panel: 5 jacks for 7.1 channels audio + 1 Optical SPDIF OUT port
> On board: front panel audio header for ac97/hd audio (connectors for
> mic, left, right -



Refer to page 12 of 890GX Extreme3 's user manual

TABLE for Audio Output Connection

Blue jack is re-tasked for "Side" channel to support 8 channels


>> "hda-codec: no NID for mapping control Independent HP:0:0".

Node 0x28 HP  is connected to 0x34 through 0x1b

[Audio Output] 0x0c has the "Headphone Volume" control

As "Line in" can only be connected to 0x0c

so the fix mainly depend on whether 0x0b can be used or not

if vt2020 is as same as vt1718s,  you need to find a correct nid in the
function side_mute_channel() for update_side_mute_status() which mute/unmute
side channel when independent HP Is "ON"/"OFF"


Node 0x2a [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00002334: IN OUT Detect
    Vref caps: HIZ 50 100
  Pin Default 0x0181303e: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x3, Sequence = 0xe
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D3, actual=D3
  Connection: 2
     0x09* 0x0c


send: NID=0x21, VERB=0x370(set_amp_gain_mute,I:LR#0), PARM=0x80
send: NID=0x21, VERB=0x371(set_amp_gain_mute,I:LR#1), PARM=0x80
send: NID=0x21, VERB=0x372(set_amp_gain_mute,I:LR#2), PARM=0x80
send: NID=0x21, VERB=0x373(set_amp_gain_mute,I:LR#3), PARM=0x80
send: NID=0x21, VERB=0x375(set_amp_gain_mute,I:LR#5), PARM=0x0
invalid amp index 5 (conns=5)

Node 0x21 only has 5 connections instead of 6

Seem no "Stereo Mix" ,  0x28 is HP and only 0x2c, 0x2b and 0x29 are input
sources and the other must be muted

node 0x2a "Line Playback Switch" have to be muted and write-protect whenever
blue jack is retask

need to modify vt1718S_auto_create_analog_input_ctls()


Node 0x21 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Control: name="Front Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=3, ofs=0
  Control: name="Front Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=3, ofs=0
  Control: name="Rear Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Rear Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Line Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Line Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x97 0x97]
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 5
     0x2c 0x2b 0x2a 0x29 0x28



> I'm not sure if that's for supporting 2 independent
> mono jacks, one stereo (headset) jack or both cases,


http://www.intel.com/support/motherboards/desktop/sb/cs-020642.htm#multistream

Multistreaming allows you to listen to two different audio sources on two
different speaker sets. For example, you can listen to one audio source
through the back panel speakers and a second audio source through front
panel headphones or speakers.

In page 13,

To enable Multi-Streaming function, you need to connect a front panel audio
cable to the front panel audio header,



> I don't know neither ac97, nor hd audio specifications) + header for 1
> hdmi_spdif
> out (to be connected to a discrete vga with hdmi capabilities)
>
>
http://www.intel.com/support/motherboards/desktop/sb/cs-020642.htm#standards
*

How to Identify your Front Panel Audio Solution Codec

*You can also physically check the audio cable of the front panel audio
solution. If there is a cable connected to Pin 4, you have an HD Audio
module; if there is no cable to Pin 4, you have an AC97 module.

page 60  (BIOS setup)

Front Panel
     Select [Auto] or [Disabled] for the onboard HD Audio Front Panel.
