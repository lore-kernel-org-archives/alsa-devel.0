From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: ALC892,
 Clevo P150HM: Input Source gets reset to "Mic" every resume
Date: Sun, 4 Dec 2011 11:27:00 +0800
Message-ID: <CAN8cciZ0Ud9ZL6nr=dVgT9Qc=cf9Aau_ys+4sQaW01aDB5R=5A@mail.gmail.com>
References: <4EDA65A3.6090604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 639BA2453B
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 04:27:03 +0100 (CET)
Received: by wgbdr1 with SMTP id dr1so3157465wgb.20
	for <alsa-devel@alsa-project.org>; Sat, 03 Dec 2011 19:27:02 -0800 (PST)
In-Reply-To: <4EDA65A3.6090604@gmail.com>
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

2011/12/4 Julian Sikorski <belegdol@gmail.com>:
> Hi,
>
> whenever I resume the machine, the Input Source would get changed back
> from "Internal Mic" to "Mic". This is a bit annoying, because pulseaudio
> is unaware of that change. As a result, everything looks fine in
> pavucontrol but no sound gets recorded. A quick look at alsamixer -c0
> revealed the problem. My alsa info:
>
> http://www.alsa-project.org/db/?f=c5776b615a5f3b9ae624e4250fb0c2b69118ce26
>
> This is unrelated to the other problems I have been reporting, since
> this happens on a mostly-stock Fedora 3.1.2 kernel (the patch I added
> deals with xhci, not alsa).
>

As alc892 has two [Audio Mixer] instead of [Audio Selector]

I wonder whether the hardware support a more an advanced  "Input
Source" controls to support

"Mic"
"Internal Mic"
"Line"
"Mic + Internal Mic"
"Mic + Line"
"Internal Mic" + "Line"

instead of the current implementation

Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Internal Mic' 'Line'
  Item0: 'Mic'


Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Input Source", index=1, device=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80] [0x80 0x80]
  Connection: 12
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b 0x12
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Input Source", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
