From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 2/3] ALSA: HDA: Rename "Front" to "Master
 Front" on ALC861VD and ALC887
Date: Tue, 23 Nov 2010 06:50:11 +0800
Message-ID: <AANLkTinUpM-WuyiMo6RAcaPihVO9KLnpSNcNVp2bQfnU@mail.gmail.com>
References: <4CE64381.4070003@canonical.com> <s5h1v6dsvgl.wl%tiwai@suse.de>
	<4CEA2D06.4010205@canonical.com> <s5hpqtxvizc.wl%tiwai@suse.de>
	<4CEA856E.5070209@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id A131524380
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 23:50:11 +0100 (CET)
Received: by ewy2 with SMTP id 2so4282814ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 14:50:11 -0800 (PST)
In-Reply-To: <4CEA856E.5070209@canonical.com>
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

2010/11/22 David Henningsson <david.henningsson@canonical.com>

> Unfortunately I don't have access to the actual hardware at the moment, so
> I'm attaching a codec dump from the hardware before the patch. Running it
> against current HEAD, with today's patch from Kailang in, probably makes
> hda-emu take the wrong code path (since hda-emu can't read proc coefs).
>
>
>
How about the volume control at node 0x25 ?

Is it "Independent headphone" for multi stream playback when 0x1b connected
to 0x26 ?

alc887 has 5 [Audio Output], 0x02, 0x3, 0x04 ,0x05 and 0x25 and they are
connected to 0x0c, 0x0d , 0x0e , 0x0f and 0x26 [audio mixer] mute switches


Node 0x25 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x26 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x25 0x0b


Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  EAPD 0x0:
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
