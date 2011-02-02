From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Jack sense fails on Fujitsu p7120
Date: Wed, 2 Feb 2011 11:14:19 +0800
Message-ID: <AANLkTimt3U7Dxs5ufTqJ1Qd5uCNcLs_Lexcp5B9MP6E1@mail.gmail.com>
References: <AANLkTimGPyno7Wd3TfO7dhZe9e4a5QcXLS8Upa1Mq7q_@mail.gmail.com>
	<AANLkTimb+yqOhWP1Rc78F9pc+j6VEGp7v0SYvGi7mGrb@mail.gmail.com>
	<AANLkTim2ch5-QHoh67SuKwMmTMQL=HM6VG1iVCxxoo9+@mail.gmail.com>
	<AANLkTimszyfVj8pbt4jujQ3o96OqVHKb-bb7o8GXG5pU@mail.gmail.com>
	<AANLkTi=hFT5Sono3Sehq2WRZZcgEULs2jwwm-ZTDEb0R@mail.gmail.com>
	<AANLkTi=xPwCS0AH1jzGx9UB5=fSLNGMJa-J6tyFgjSaG@mail.gmail.com>
	<AANLkTi=u8QCzVRUjQVJVfPqOhy8wsA5P7bsFPP2t9w9Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 30B12103804
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 04:14:22 +0100 (CET)
Received: by ewy19 with SMTP id 19so3370697ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 01 Feb 2011 19:14:19 -0800 (PST)
In-Reply-To: <AANLkTi=u8QCzVRUjQVJVfPqOhy8wsA5P7bsFPP2t9w9Z@mail.gmail.com>
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

2011/2/2 Robin Neatherway <neatherway@gmail.com>

> > Do you mean
> >
> > LOUT1 playback volume control at node 0x8 affect the volume of your
> > headphone and LOUT2 playback volume control at node 0x9 affect the volume
> of
> > your speakers ?
> >
> > If you look at 4.1 Block Diagram of alc260 datasheet ,
> >
> > LOUT1 is connected to 0xf Line Out and
> > LOUT2 is connected to 0x10 HP
>
> Having looked at the datasheet I agree with you, this seems
> surprising. However, if I run speaker-test and then toggle the mutes
> of LOUT1 and LOUT2 one by one, they toggle the headphones and speakers
> respectively.
>
> Additionally, to hear output on each device I have to set the
> following pin modes:
>
> Headphones: LINE1 pin mode at node 0x14 must be set to line out
> (quieter)/headphones (louder)
> Speakers: HP-OUT pin mode at node 0x10 must be set to line
> out/headphones (same volume)
>
>
hp_automute work only when it get the correct position of HP and speaker
[Pin complex]

Can you post the output of alsa-info.sh using model=auto after a cold boot
to find out whether BIOS setup pin default of node 0x0f and 0x10 to HP and
Speakers  ?

if not, you will need to find any alc269 model which create "Headphone
Playback Volume" at node 0x8 and "Speaker Playback volume" at node 0x09
