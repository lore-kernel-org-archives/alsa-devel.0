From: David Jander <david.jander@protonic.nl>
Subject: Re: ASoC driver parts probing order (MPC5200/MPC5121)
Date: Thu, 20 Oct 2011 15:26:33 +0200
Message-ID: <20111020152633.2d91146a@archvile>
References: <20111020122317.6c705289@archvile>
	<20111020123513.GA3484@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from protonic.xs4all.nl (protonic.xs4all.nl [213.84.116.84])
	by alsa0.perex.cz (Postfix) with ESMTP id AC1B7247A5
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 15:26:20 +0200 (CEST)
In-Reply-To: <20111020123513.GA3484@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Oct 2011 13:35:13 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > of the probe function. So obviously, it is supposed that the DMA driver
> > somehow gets probed before the PSC driver, but I can't see where this is
> > enforced. AFAIK, the order is fairly random, so it could be the other way
> > around.... and indeed, in my case it is.
> 
> The order the device model devices get probed in is entirely random and
> any driver which is relying on this is buggy.

That's what I understood, but I was being reluctant to fix something I
couldn't prove to be broken, nor being able to verify the fix. Fortunately
Wolfram Sang offered to help out with testing on the MPC5200B.

> > 2.- Simply turning the dev_get/set_drvdata and chip initialization order
> > around does work in my case, but doesn't seem a robust solution to me. Any
> > idea how this should be handled?
> 
> I'd expect that delaying whatever relies on both devices being there
> until the ASoC level probes happen is the way forward - you're
> guaranteed that both deivces will be present there and the probe
> ordering is guaranteed stable.

Thanks. I will investigate that path.
If you have a quick look at the named files(mpc5200-ac97.c and mpc5200_dma.c)
in mainline, can you confirm that it is indeed the wrong way of doing this?

Best regards,

-- 
David Jander
Protonic Holland.
