From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/4] ASoC: sgtl5000: give it a ramping time
	before writting
Date: Mon, 1 Jul 2013 12:54:18 +0200
Message-ID: <201307011254.18952.marex@denx.de>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-2-git-send-email-shawn.guo@linaro.org>
 <20130701100710.GB27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by alsa0.perex.cz (Postfix) with ESMTP id CDE642625D8
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2013 12:54:21 +0200 (CEST)
In-Reply-To: <20130701100710.GB27646@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Dear Mark Brown,

> On Mon, Jul 01, 2013 at 04:16:08PM +0800, Shawn Guo wrote:
> > +	/*
> > +	 * It seems that sgtl5000 takes a longer time to get the registers
> > +	 * ready for write than bread.  Let's give it a ramping time before
> > +	 * the first write goes.
> > +	 */
> > +	msleep(50);
> > +
> > 
> >  	/* Ensure sgtl5000 will start with sane register values */
> >  	ret = sgtl5000_fill_defaults(sgtl5000);
> >  	if (ret)
> 
> This seems like a really odd place to add the sleep - I'd have expected
> this to be a part of or just after the reset operation.  It's a *really*
> long sleep too, though if that's what you need that's what you need.

The delay might also be caused by the I2C driver, I have this in my ToDo to 
check, but I didn't get to it yet. On the other hand, if subsequent IO does 
work, then it's unlikely to be the case.

> Also "bread" :)

Of course, sometimes you want to put a lot of things on it, like bacon and such.

Best regards,
Marek Vasut
