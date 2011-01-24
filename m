From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: UCM questions
Date: Mon, 24 Jan 2011 14:31:31 -0800
Message-ID: <AANLkTi=zH6SMyH4p2Uhy7dbS-qi1VBw4zDAqAsYb1MrP@mail.gmail.com>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk>
	<1295623491.3348.284.camel@odin>
	<AANLkTi=V9ouox2vp5VYA+_gmsOCCecBKOjpd58DsuaxK@mail.gmail.com>
	<alpine.LNX.2.00.1101231430550.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9996C103848
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 23:31:32 +0100 (CET)
Received: by iye19 with SMTP id 19so5073460iye.38
	for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2011 14:31:31 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1101231430550.6272@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> You may have for example USB microphone and USB speakers plugged to the
> system (each represents one card for the ALSA driver with different USB
> physical links). UCM can join these two cards as one "virtual", so if an app
> asks for playback device, USB speakers are returned and for capture device,
> USB MIC is returned. Only one alsa-lib's device should be returned for given
> verb/device/modifier identifiers. I admit that the PCM configuration for
> alsa-lib allows this too, but UCM handles also the mixer control mapping.

Makes sense now.

> Anyway, your questions are mostly about the abstract mapping. The purpose of
> UCM is to allow any abstraction, so strings in the header file like "HiFi"
> or so are just common cases. But anyone can create own abstraction for
> different purposes.

Most of my questions are not really on the abstraction but really on
how to handle devices that can be plugged or may not be active at all
times. USB, HDMI, Wireless/remote displays fall in this category. So
on top of the traditional local headset/speakers, I can either have a
variety of devices that can be used for the same use case. It's still
not clear to me if I would need to create a set of new verbs
(hifi_usb, hifi_hdmi) or if I can stick to the existing verbs and add
a modifier?
Thanks for your comments,
-Pierre
