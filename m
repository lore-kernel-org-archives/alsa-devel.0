From: Robin Neatherway <neatherway@gmail.com>
Subject: Re: Jack sense fails on Fujitsu p7120
Date: Fri, 4 Feb 2011 10:17:07 +0000
Message-ID: <AANLkTinaE_N=aqMXRLgXMg_O-jsGXz2ea3xFDh74QK1G@mail.gmail.com>
References: <AANLkTimGPyno7Wd3TfO7dhZe9e4a5QcXLS8Upa1Mq7q_@mail.gmail.com>
	<AANLkTimb+yqOhWP1Rc78F9pc+j6VEGp7v0SYvGi7mGrb@mail.gmail.com>
	<AANLkTim2ch5-QHoh67SuKwMmTMQL=HM6VG1iVCxxoo9+@mail.gmail.com>
	<AANLkTimszyfVj8pbt4jujQ3o96OqVHKb-bb7o8GXG5pU@mail.gmail.com>
	<AANLkTi=hFT5Sono3Sehq2WRZZcgEULs2jwwm-ZTDEb0R@mail.gmail.com>
	<AANLkTi=xPwCS0AH1jzGx9UB5=fSLNGMJa-J6tyFgjSaG@mail.gmail.com>
	<AANLkTi=u8QCzVRUjQVJVfPqOhy8wsA5P7bsFPP2t9w9Z@mail.gmail.com>
	<AANLkTimt3U7Dxs5ufTqJ1Qd5uCNcLs_Lexcp5B9MP6E1@mail.gmail.com>
	<s5hmxme5sue.wl%tiwai@suse.de>
	<AANLkTi=xW-_Myvi279yJEySDDRsktrMkVpFyQhu0mu0w@mail.gmail.com>
	<s5hlj1xy3ph.wl%tiwai@suse.de>
	<AANLkTimfN_d+BoB-NLtVuYTnMuKnF7N+Bj7fqi+3mxOJ@mail.gmail.com>
	<s5hy65wwcby.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F7EA103AF6
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 11:17:29 +0100 (CET)
Received: by vxb40 with SMTP id 40so626441vxb.38
	for <alsa-devel@alsa-project.org>; Fri, 04 Feb 2011 02:17:27 -0800 (PST)
In-Reply-To: <s5hy65wwcby.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> The auto codec parser reads the default config values of all pin
> widgets, and enables the jack sense when a pin is a HP jack. =A0That's
> why it's important to figure out which pin widget corresponds to which
> actual I/O.

Right. With "auto", the jack sense might well be working then, but I
can't tell because there is no output over the speakers. Unless there
is another way of telling?

I'm pretty confused right now. Raymond suggested that the important
thing is to ensure that the nodes 0x8 and 0x9 are HP and Speaker
volume respectively, while you are suggesting that I should alter the
pin configuration, which only affects pin widgets and these are only
from 0xF to 0x19. The pin configuration doesn't seem to contain
anything to do with jack sense, so I'm not sure what I should change
there.

How do you normally figure out which pin widget corresponds to which
I/O? Is it just trial and error?

The ALC260 datasheet (http://realtek.info/pdf/alc260.pdf section 4.1,
page 4) seems to make it pretty clear that the jack sense is at node
0x1b, and the block diagram indicates that it is a pin, so why is it
not showing up as a pin widget?

Thanks,
Robin
