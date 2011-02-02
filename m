From: Robin Neatherway <neatherway@gmail.com>
Subject: Re: Jack sense fails on Fujitsu p7120
Date: Wed, 2 Feb 2011 00:04:56 +0000
Message-ID: <AANLkTi=u8QCzVRUjQVJVfPqOhy8wsA5P7bsFPP2t9w9Z@mail.gmail.com>
References: <AANLkTimGPyno7Wd3TfO7dhZe9e4a5QcXLS8Upa1Mq7q_@mail.gmail.com>
	<AANLkTimb+yqOhWP1Rc78F9pc+j6VEGp7v0SYvGi7mGrb@mail.gmail.com>
	<AANLkTim2ch5-QHoh67SuKwMmTMQL=HM6VG1iVCxxoo9+@mail.gmail.com>
	<AANLkTimszyfVj8pbt4jujQ3o96OqVHKb-bb7o8GXG5pU@mail.gmail.com>
	<AANLkTi=hFT5Sono3Sehq2WRZZcgEULs2jwwm-ZTDEb0R@mail.gmail.com>
	<AANLkTi=xPwCS0AH1jzGx9UB5=fSLNGMJa-J6tyFgjSaG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A91A103806
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 01:05:20 +0100 (CET)
Received: by qyk34 with SMTP id 34so4861339qyk.17
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 16:05:16 -0800 (PST)
In-Reply-To: <AANLkTi=xPwCS0AH1jzGx9UB5=fSLNGMJa-J6tyFgjSaG@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> Do you mean
>
> LOUT1 playback volume control at node 0x8 affect the volume of your
> headphone and LOUT2 playback volume control at node 0x9 affect the volume of
> your speakers ?
>
> If you look at 4.1 Block Diagram of alc260 datasheet ,
>
> LOUT1 is connected to 0xf Line Out and
> LOUT2 is connected to 0x10 HP

Having looked at the datasheet I agree with you, this seems
surprising. However, if I run speaker-test and then toggle the mutes
of LOUT1 and LOUT2 one by one, they toggle the headphones and speakers
respectively.

Additionally, to hear output on each device I have to set the
following pin modes:

Headphones: LINE1 pin mode at node 0x14 must be set to line out
(quieter)/headphones (louder)
Speakers: HP-OUT pin mode at node 0x10 must be set to line
out/headphones (same volume)

This bears little relationship to the datasheet.


>From the datasheet it looks like:

Node 0x1b [Volume Knob Widget] wcaps 0x600080: Mono
  Volume-Knob: delta=0, steps=64, direct=0, val=48
  Unsolicited: tag=00, enabled=0
  Connection: 0

should be responsible for the jack detection. I have noticed in my
testing that the "val" is sometimes 48 and sometimes 49, but I haven't
been able to correlate this with presence of headphones or otherwise.
