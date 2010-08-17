From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 0005090: hda-intel (alc887) unable to access
 alsamixer/amixer to unmute default sound
Date: Wed, 18 Aug 2010 07:58:43 +0800
Message-ID: <AANLkTimb=k6-eLnL3YZF7Q4qs8yUcB=8kZBB+hG-e9g2@mail.gmail.com>
References: <4C6A6BCE.5040906@iinet.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id BABA524460
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 01:58:43 +0200 (CEST)
Received: by ewy21 with SMTP id 21so9169ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2010 16:58:43 -0700 (PDT)
In-Reply-To: <4C6A6BCE.5040906@iinet.net.au>
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

2010/8/17 Brock <rbjclan@iinet.net.au>

>  Hi,
>
> I need some assistance with alc887 and amixer/alsamixer.
>
> Please see bug post 0005090.  Which explains the problem.
>
> Very happy to provide additional information or assistance is needed
>
> Unfortunately, I do not have the knowledge to fix the issue.
>
> cheers
> lumpy
>

it seem that node 0x0c of alc887 has "nsteps=0" and the alsa-driver had
created a volume control without any steps (i.e. min = max )

the error returned by snd_hda_mixer_amp_volume_info() cause both alsamixer
and amixer fail


 HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),


Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals: [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x02 0x0b

hda_codec: num_steps = 0 for NID=0xc (ctl = Front Playback Volume)

amixer: Mixer load hw:0 error: Invalid argument
Card hw:0 'Intel'/'HDA Intel at 0xfdff8000 irq 28'
  Mixer name : 'Realtek ALC887'
  Components : 'HDA:10ec0887,1458a002,00100302'
  Controls : 39
amixer: Mixer hw:0 load error: Invalid argument
