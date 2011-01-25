From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: UCM questions
Date: Tue, 25 Jan 2011 13:58:19 -0800
Message-ID: <AANLkTim8=jOV8toPMbeFTC+JMEKYXJ7TJEq1RxC24GMx@mail.gmail.com>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk>
	<1295623491.3348.284.camel@odin>
	<AANLkTi=V9ouox2vp5VYA+_gmsOCCecBKOjpd58DsuaxK@mail.gmail.com>
	<alpine.LNX.2.00.1101231430550.6272@eeebox2.perex-int.cz>
	<AANLkTi=zH6SMyH4p2Uhy7dbS-qi1VBw4zDAqAsYb1MrP@mail.gmail.com>
	<1295957605.3322.89.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 75296244EE
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 22:58:22 +0100 (CET)
Received: by iye19 with SMTP id 19so6276253iye.38
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 13:58:20 -0800 (PST)
In-Reply-To: <1295957605.3322.89.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

>> Most of my questions are not really on the abstraction but really on
>> how to handle devices that can be plugged or may not be active at all
>> times. USB, HDMI, Wireless/remote displays fall in this category. So
>> on top of the traditional local headset/speakers, I can either have a
>> variety of devices that can be used for the same use case. It's still
>> not clear to me if I would need to create a set of new verbs
>> (hifi_usb, hifi_hdmi) or if I can stick to the existing verbs and add
>> a modifier?
>
> You should stick to the existing verb and use a new device in most cases
> above where your use case is the same but the output device is
> different.

ok, thanks for clarifying.
