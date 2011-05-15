From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Multistreaming Playback using Front Panel
 Headphone with realtek codec
Date: Sun, 15 May 2011 11:21:10 +0800
Message-ID: <BANLkTi=V0kg7wW2YztzKzbk63MQ5AzTZdw@mail.gmail.com>
References: <BANLkTimSTYjZoMACA4PoLJa0swo3L2_e4Q@mail.gmail.com>
	<4DC2FFA3.9040601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 0876624179
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 05:21:11 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2731731fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 14 May 2011 20:21:10 -0700 (PDT)
In-Reply-To: <4DC2FFA3.9040601@gmail.com>
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

2011/5/6 Valerio Tesei <valerio.tesei@gmail.com>

> Il 04/05/2011 17:42, Raymond Yau ha scritto:
> > Request for testers to test the patch
> >
> > Multistreaming allows you to listen to one audio source through the back
> > panel speakers and a second audio source through front panel headphones
> or
> > speakers.
> >
> > Hardware requirement
> > 1) 10 channels realtek codec (e.g. alc892) which already work with
> > model=auto
> > 2) Headphone at front panel and Line out at rear panel
> >
> > "hw:0,0" is used for the rear panel audio jack
> > "hw:0,2" is used for the front panel headphone when "Independent HP" is
> > switched ON
> >
> > Add an "Independent HP" switch to turn this feature on/off for desktop
> for
> > those HDA codec
> >
> > Test:
> > 1) speaker-test -c 8 -t wav -Dhw:0,0
> > 2) speaker-test -c 2 -t wav -Dhw:0,2
> >
> > It will need modification to support this feature for those desktop with
> 8
> > channels codec
> >
> So i made the test, i correctly hear the tests, 7 outputs for the rear
> panel, and 2 for the front, but when i play the first test, i hear on
> the front panel some noise and realy crackly and whispered the tests
> when front left and front right are played, i guess it is not normal,
> may this help?
>

using hda-emu , it seem that the "Headpone Playback Switch" still using 0x0c
instead of 0x26


> get 11
send: NID=0x1b, VERB=0xba0(get_amp_gain_mute,O:L#0), PARM=0x0
receive: 0x0
send: NID=0x1b, VERB=0xb80(get_amp_gain_mute,O:R#0), PARM=0x0
receive: 0x0
11 Headphone Playback Switch:0
MIN/MAX: 0/1,  VAL: [1] [1]
> set 11 0 0
send: NID=0xc, VERB=0xb20(get_amp_gain_mute,I:L#0), PARM=0x0
receive: 0x0
send: NID=0xc, VERB=0xb00(get_amp_gain_mute,I:R#0), PARM=0x0
receive: 0x0
send: NID=0x1b, VERB=0x3a0(set_amp_gain_mute,O:L#0), PARM=0x80
send: NID=0x1b, VERB=0x390(set_amp_gain_mute,O:R#0), PARM=0x80
> set 11 1 1
send: NID=0x1b, VERB=0x3a0(set_amp_gain_mute,O:L#0), PARM=0x0
send: NID=0x1b, VERB=0x390(set_amp_gain_mute,O:R#0), PARM=0x0



Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  EAPD 0x0:
  Pin Default 0x02214820: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c 0x0d 0x0e 0x0f 0x26*
