From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: UCM questions
Date: Tue, 25 Jan 2011 12:13:25 +0000
Message-ID: <1295957605.3322.89.camel@odin>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk> <1295623491.3348.284.camel@odin>
	<AANLkTi=V9ouox2vp5VYA+_gmsOCCecBKOjpd58DsuaxK@mail.gmail.com>
	<alpine.LNX.2.00.1101231430550.6272@eeebox2.perex-int.cz>
	<AANLkTi=zH6SMyH4p2Uhy7dbS-qi1VBw4zDAqAsYb1MrP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D7A4810393F
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 13:13:29 +0100 (CET)
Received: by wwe15 with SMTP id 15so4726977wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 04:13:29 -0800 (PST)
In-Reply-To: <AANLkTi=zH6SMyH4p2Uhy7dbS-qi1VBw4zDAqAsYb1MrP@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-01-24 at 14:31 -0800, pl bossart wrote:

> Most of my questions are not really on the abstraction but really on
> how to handle devices that can be plugged or may not be active at all
> times. USB, HDMI, Wireless/remote displays fall in this category. So
> on top of the traditional local headset/speakers, I can either have a
> variety of devices that can be used for the same use case. It's still
> not clear to me if I would need to create a set of new verbs
> (hifi_usb, hifi_hdmi) or if I can stick to the existing verbs and add
> a modifier?

You should stick to the existing verb and use a new device in most cases
above where your use case is the same but the output device is
different.

Thanks

Liam
 
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
