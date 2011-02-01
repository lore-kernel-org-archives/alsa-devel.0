From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Jack sense fails on Fujitsu p7120
Date: Tue, 1 Feb 2011 10:24:13 +0800
Message-ID: <AANLkTi=xPwCS0AH1jzGx9UB5=fSLNGMJa-J6tyFgjSaG@mail.gmail.com>
References: <AANLkTimGPyno7Wd3TfO7dhZe9e4a5QcXLS8Upa1Mq7q_@mail.gmail.com>
	<AANLkTimb+yqOhWP1Rc78F9pc+j6VEGp7v0SYvGi7mGrb@mail.gmail.com>
	<AANLkTim2ch5-QHoh67SuKwMmTMQL=HM6VG1iVCxxoo9+@mail.gmail.com>
	<AANLkTimszyfVj8pbt4jujQ3o96OqVHKb-bb7o8GXG5pU@mail.gmail.com>
	<AANLkTi=hFT5Sono3Sehq2WRZZcgEULs2jwwm-ZTDEb0R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id E9E28244D0
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 03:24:19 +0100 (CET)
Received: by ewy19 with SMTP id 19so2723099ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2011 18:24:17 -0800 (PST)
In-Reply-To: <AANLkTi=hFT5Sono3Sehq2WRZZcgEULs2jwwm-ZTDEb0R@mail.gmail.com>
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

2011/2/1 Robin Neatherway <neatherway@gmail.com>

> > Because ubuntu had disabled OSS emulation , you have to disable OSS
> > emulation too.
> >
> > ./configure --with-oss=no
>
> Thanks for the tip. I've compiled the 1.0.24 drivers tarball using
> ./configure --with-debug=full --with-oss=no and it now loads
> correctly. I have a large number of controls in alsamixer, having set
> model=test in /etc/modprobe.d/alsa-base.conf.
>
> The control names are now generic, but I have found that LOUT1 is the
> headphones and LOUT2 is the speakers. There are also GPIO pins 0-3
> available. I have tried toggling these, but it does not affect the
> jack sense, which still does not operate.
>
> The new alsa-info is at the following URL:
> http://www.alsa-project.org/db/?f=3fb1a67066b9d06ac8405685ff7358af053e2668
>

Do you mean

LOUT1 playback volume control at node 0x8 affect the volume of your
headphone and LOUT2 playback volume control at node 0x9 affect the volume of
your speakers ?

If you look at 4.1 Block Diagram of alc260 datasheet ,

LOUT1 is connected to 0xf Line Out and
LOUT2 is connected to 0x10 HP
