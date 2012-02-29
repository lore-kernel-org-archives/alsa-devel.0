From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC PATCH] Inverted internal mic
Date: Wed, 29 Feb 2012 19:02:00 +0800
Message-ID: <CAN8cciYnQ4+vu2Qdw_7BWWm1pqxBC7iJDS8PaNuX-MO24WOieA@mail.gmail.com>
References: <4F4C9714.1080307@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2058324149
	for <alsa-devel@alsa-project.org>; Wed, 29 Feb 2012 12:02:01 +0100 (CET)
Received: by wgbed3 with SMTP id ed3so2393311wgb.20
	for <alsa-devel@alsa-project.org>; Wed, 29 Feb 2012 03:02:00 -0800 (PST)
In-Reply-To: <4F4C9714.1080307@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2012/2/28, David Henningsson <david.henningsson@canonical.com>:
> Hi,
>
> Recently I came across a Conexant as well, and I decided to write a
> patch for it, that would take the approach that the internal mic is
> forced mono on the kcontrol, and make sure the right channel is always
> muted. The patch is verified by the reporter to fix this problem. It
> could use some perfection though - it would make sense to to the same to
> the internal mic boost as well, and the strcmp('Internal Mic') call
> could maybe be turned into something more elegant. But before going
> ahead with that, I'd like to hear your opinion on the matter, if you
> agree that this is a good approach to the problem?
>
> References:
>
> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/903853/+attachment/2631623/+files/alsa-info.txt.VmCN7lMBL4
>
> https://bugs.launchpad.net/bugs/903853
>

Refer to the codec info

It seem that there is a path from [Audio Output]  0x10 through 0x24 to
[Audio Input]

Is there any technical reason for not implement "Stereo Mix" as "Input Source" ?


Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
  Control: name="Master Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="CONEXANT Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
  Amp-Out vals:  [0x4a 0x4a]
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=D0, actual=D0



Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
  Device: name="CONEXANT Analog", type="Audio", device=0
  Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
  Amp-In vals:  [0x50 0x50] [0x80 0x80] [0x50 0x50] [0x80 0x80]
  Converter: stream=4, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=D0, actual=D0
  Connection: 4
     0x17 0x18 0x23* 0x24





Node 0x24 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x10 0x11
