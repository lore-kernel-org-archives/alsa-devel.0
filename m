From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000
	machine driver
Date: Wed, 13 Jul 2011 13:40:39 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CDC7C@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713115711.GG1928@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F7721CDBAA@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E0D72445E
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 15:40:47 +0200 (CEST)
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7721CDBAA@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-
> kernel-bounces@lists.infradead.org] On Behalf Of Dong Aisheng-B29396
> Sent: Wednesday, July 13, 2011 8:19 PM
> To: Wolfram Sang
> Cc: alsa-devel@alsa-project.org; s.hauer@pengutronix.de;
> broonie@opensource.wolfsonmicro.com; u.kleine-koenig@pengutronix.de;
> lrg@ti.com; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver

> >
> > Proper regulator support for mxs is not in mainline yet. Is that
> planned?
> > How do you do it?
> 
> Yes, it's not in mainline yet.
> Fixed regulator may be a method.
> However currently I just removed VDDIO and VDDA checking in sgtl5000
> driver.
> Additionally, it seems sgtl5000 driver still needs another fix to get it
> running.
> I copy the patch as below for your info(Just for test).
> I'm going to do that in my following work.
> 

For regulator issue, One method is that just add two regulator (VDDA&VDDIO)
needed by sgtl5000 in platform code to make sgtl5000 work first.
If that I could add it in my the following patches.

Or we do not add it (just leave sgtl5000 unwork), instead, we directly
implement the full regulator support for MX28 power management?

What's your suggestion?

Regards
Dong Aisheng
