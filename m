From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Sat, 1 May 2010 06:51:28 +0800
Message-ID: <m2z4f3252891004301551u6dd4d47elab1d03ec6fdf98b3@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<i2k4f3252891004291809z5604e08chfbd8c0c000b4d517@mail.gmail.com>
	<m2m6160a5131004300646v2c9af945geaec5bc8610e7146@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CF28A10392D
	for <alsa-devel@alsa-project.org>;
	Sat,  1 May 2010 00:51:30 +0200 (CEST)
Received: by pvc30 with SMTP id 30so357181pvc.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Apr 2010 15:51:29 -0700 (PDT)
In-Reply-To: <m2m6160a5131004300646v2c9af945geaec5bc8610e7146@mail.gmail.com>
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

2010/4/30 pl bossart <bossart.nospam@gmail.com>

> >
> > Do your test need the patch which you have posted to pulseaudio developer
> > mailing list
> >
> > http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/6671
> >
> > it seem that fix should be in driver side if it is hardware specific
>
> No it's totally unrelated.
>

>> On my HDAudio test system, 128 bytes was already more than enough to
prevent audible noises.

>> Rewinding the ring buffer completely causes audible issues with DMAs.
Previous solution didn't work with tsched=0, and used tsched_watermark
for guardband, which isn't linked to hardware and could become really high
if underflows occurred.

But the rewind issue is not limiting to (PCIE) HDaudio since all PCI sound
cards would have the same problem ?

i.e. snd_pcm_rewindable() return wrong value
