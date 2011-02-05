From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Jack sense fails on Fujitsu p7120
Date: Sun, 6 Feb 2011 07:36:02 +0800
Message-ID: <AANLkTi=TJcxbJWs4Yz4rMVAqhFBZWz7cFm2uLCQAOiGw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 163D7243F2
	for <alsa-devel@alsa-project.org>; Sun,  6 Feb 2011 00:36:05 +0100 (CET)
Received: by ewy19 with SMTP id 19so1687414ewy.38
	for <alsa-devel@alsa-project.org>; Sat, 05 Feb 2011 15:36:02 -0800 (PST)
In-Reply-To: <AANLkTimfN_d+BoB-NLtVuYTnMuKnF7N+Bj7fqi+3mxOJ@mail.gmail.com>
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

2011/2/4 Robin Neatherway <neatherway@gmail.com>

> > if not, you will need to find any alc269 model which create "Headphone
> > Playback Volume" at node 0x8 and "Speaker Playback volume" at node 0x09
>
> With model=auto, these appear at the correct nodes, but I no longer
> get any sound over the speakers. How can I control where these appear,
> or add an EAPD pin to try and reenable the speakers?
>

If you look at the datasheet  LOUT1 and LOUT2 can be connected to 0xf, 0x10,
0x12 , 0x13, 0x14 and 0x15

So you have to find out which pin complex is your speaker by mute/unmute the
mute switch of those pin complex
