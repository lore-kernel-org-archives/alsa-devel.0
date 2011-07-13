From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000
	machine driver
Date: Wed, 13 Jul 2011 14:13:00 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CDD43@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713115711.GG1928@pengutronix.de>
	<65EE16ACC360FA4D99C96DC085B3F7721CDBAA@039-SN1MPN1-002.039d.mgd.msft.net>
	<65EE16ACC360FA4D99C96DC085B3F7721CDC7C@039-SN1MPN1-002.039d.mgd.msft.net>
	<20110713140038.GI1928@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	by alsa0.perex.cz (Postfix) with ESMTP id D72CB2446F
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 16:13:05 +0200 (CEST)
In-Reply-To: <20110713140038.GI1928@pengutronix.de>
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
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Wednesday, July 13, 2011 10:01 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; s.hauer@pengutronix.de;
> broonie@opensource.wolfsonmicro.com; u.kleine-koenig@pengutronix.de;
> lrg@ti.com; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
> 
> 
> > For regulator issue, One method is that just add two regulator
> > (VDDA&VDDIO) needed by sgtl5000 in platform code to make sgtl5000 work
> first.
> > If that I could add it in my the following patches.
> >
> > Or we do not add it (just leave sgtl5000 unwork), instead, we directly
> > implement the full regulator support for MX28 power management?
> >
> > What's your suggestion?
> 
> Hmmm, as we started now with the audio patches, I'd think we should
> concentrate on getting them in shape first. So, my preference would be
> adding just the two regulators. Whenever the power management gets
> complete, they should be easy to include/adapt, if I didn't miss anything.
OK, I will add it in my following patch.

> With your sgtl-patch, I can set the alsa-controls like volume. Yet the
> WAV played via simple aplay has a massive hall (like a concert at the
> other end of the cathedral ;)). Interrupting aplay, and trying again
> gives me sometimes: 
> 
> After that OOPS, playing works again (still with the hall). Didn't have
> the time to look at these issues yet, but since I was writing to you
> anyway, I thought I'd mention it...

I did not meet it in the first time of playing. However, it can happen
in the second play.
The root cause is that we get an unexpected dma irq before iprtd
is initialized when request dma channel(still not start channel).

It seemed to be a DMA issue that the dma channel of saif was in
an abnormal state after disable.

A patch already prepared to fix this issue is as follows:
I am going to send it out for review.
Can you help try if it can fix your issue?

commit d2e4437ddca8bf909ca6c53257e1de504274017e
Author: Dong Aisheng <b29396@freescale.com>
Date:   Tue Jul 12 21:52:55 2011 +0800

    ARM: mxs-dma: reset after disable channel

    We met some channels in abnormal state after disable.
    Reset it to get a clean state.

    Signed-off-by: Dong Aisheng <b29396@freescale.com>

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 88aad4f..5a24010 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -535,6 +535,7 @@ static int mxs_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
        switch (cmd) {
        case DMA_TERMINATE_ALL:
                mxs_dma_disable_chan(mxs_chan);
+               mxs_dma_reset_chan(mxs_chan);
                break;
        case DMA_PAUSE:
                mxs_dma_pause_chan(mxs_chan);

Regards
Dong Aisheng
