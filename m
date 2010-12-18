From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: lenovo G560 internal microphone fix
Date: Sat, 18 Dec 2010 12:03:08 +0800
Message-ID: <AANLkTik+bZjsVqNdvvzpSYy+xcZetJYpU=gYGEBL+hk9@mail.gmail.com>
References: <AANLkTimZxT6A0-c_useJVDEhLF7+WN0C8SmW=8eNt3jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EA44A10391A
	for <alsa-devel@alsa-project.org>; Sat, 18 Dec 2010 05:03:09 +0100 (CET)
Received: by eyg24 with SMTP id 24so596680eyg.24
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 20:03:09 -0800 (PST)
In-Reply-To: <AANLkTimZxT6A0-c_useJVDEhLF7+WN0C8SmW=8eNt3jg@mail.gmail.com>
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

2010/12/18 Kayne Richens <kayno@kayno.net>

> hi
>
> I used hda_analyzer to fix my internal microphone on my lenovo G560 laptop.
> I had to make the following change before the microphone would work:
>
> Diff for codec 0/1 (0x14f15069):
> ---
> +++
> @@ -51,26 +51,26 @@
>     ControlAmp: chs=1, dir=1, idx=0, ofs=0
>   Control: name="Beep Playback Switch", index=0, device=0
>     ControlAmp: chs=1, dir=1, idx=0, ofs=0
>   Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0f, mute=0
>   Amp-Out vals: 0x00
>  Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
>   Device: name="CONEXANT Analog", type="Audio", device=0
>   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
> - Amp-In vals: [0x50 0x50] [0x80 0x80] [0x50 0x50] [0x80 0x80]
> + Amp-In vals: [0x50 0x50] [0x50 0x50] [0x50 0x50] [0x50 0x50]
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   PCM:
>     rates [0x160]: 44100 48000 96000
>     bits [0xe]: 16 20 24
>     formats [0x1]: PCM
>   Power: setting=D0, actual=D0
>   Connection: 4
> - 0x17 0x18 0x23* 0x24
> + 0x17 0x18* 0x23 0x24
>  Node 0x15 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
>   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
>   Amp-In vals: [0x4a 0x4a] [0x4a 0x4a] [0x4a 0x4a] [0x4a 0x4a]
>   Converter: stream=0, channel=0
>   SDI-Select: 0
>   PCM:
>     rates [0x160]: 44100 48000 96000
>     bits [0xe]: 16 20 2
>
> My alsa version is 1.0.23 (ubuntu 10.10). I've attached the output of
> alsa-info.sh.
>
> This fix has also helped other G560 owners:
>
> https://bugs.launchpad.net/ubuntu/+source/linux-backports-modules-2.6.32/+bug/590756
>
> If I need to provide anything else, let me know.
>

node 0x24 [Audio Mixer] seem to be "Stereo Mix" from [Audio Output] 0x10 and
0x11

Node 0x24 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Power: setting=D0, actual=D0
  Connection: 2
     0x10 0x11



This may mean that 5069 may need a more complex input source selection
instead of using cxt5066_capture_souce
