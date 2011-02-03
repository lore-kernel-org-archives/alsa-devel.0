From: Robin Neatherway <neatherway@gmail.com>
Subject: Re: Jack sense fails on Fujitsu p7120
Date: Thu, 3 Feb 2011 23:49:55 +0000
Message-ID: <AANLkTimfN_d+BoB-NLtVuYTnMuKnF7N+Bj7fqi+3mxOJ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 05B61103AD5
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 00:50:16 +0100 (CET)
Received: by vws20 with SMTP id 20so1091496vws.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Feb 2011 15:50:15 -0800 (PST)
In-Reply-To: <s5hlj1xy3ph.wl%tiwai@suse.de>
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

> if not, you will need to find any alc269 model which create "Headphone
> Playback Volume" at node 0x8 and "Speaker Playback volume" at node 0x09

With model=3Dauto, these appear at the correct nodes, but I no longer
get any sound over the speakers. How can I control where these appear,
or add an EAPD pin to try and reenable the speakers?

> Others are no pin widgets. =A0See HD-audio specification for more details.

OK, I've found "7.3.3.31 Configuration Default" in the spec which
describes the meaning of the pin config register. From the discussion
so far I think I need to change node 0x1B to be a jack sense pin. I
must misunderstand though because a) Configuration Default has nothing
to do with whether it is a jack sense pin and b) 0x1B is not a pin
widget anyway.
