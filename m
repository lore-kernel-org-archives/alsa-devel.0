From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 0/3] make the sgtl5000-codec work
Date: Tue, 19 Jul 2011 11:09:44 +0100
Message-ID: <1311070184.3310.20.camel@CNA0741383>
References: <1311004385-14554-1-git-send-email-w.sang@pengutronix.de>
	<20110718191602.GA8576@ubuntu.localdomain>
	<20110719090404.GD1951@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id EE7EB244D8
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jul 2011 12:09:50 +0200 (CEST)
In-Reply-To: <20110719090404.GD1951@pengutronix.de>
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
Cc: Zeng Zhaoming <zhaoming.zeng@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>, Zeng Zhaoming <b32542@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-07-19 at 11:04 +0200, Wolfram Sang wrote:
> Hi,
> 
> >     pls check http://comments.gmane.org/gmane.linux.alsa.devel/83781
> > 
> >     I think Mark is right, sgtl5000 already declared its register_step is 2, soc_cache.c
> >     should generate a dense cache layout instead of padding it by driver.
> 
> Thanks for the pointer. I can follow Mark's reasoning. In fact, I was
> wondering why ASoC does not consider the step, but I assumed it was
> intentional. With my holidays coming along, nothing I am going to
> tackle in the next time, though ;)
> 
> >     But after check soc_cache.c, ASoC mix up index and register address to index cache,
> >     and many places need to modify to correct it, so I think we should re-consider
> >     if register_step != 1 is not a common case.
> 
> I think it should be properly fixed in ASoC. It should be carefully
> done, but otherwise not be a major task IMO. Note that sgtl5000 will
> need adaptions nonetheless. Which brings me back to the question: In
> what setup did the driver work for you? Did you have regulators on that
> board? I am still trying to understand the side-effects of what I am
> seeing...
> 
> Mark: Will you pick up patches 1 and 2 nonetheless?

Please CC me on all ASoC patches. 1 and 2 look OK.

Acked-by: Liam Girdwood <lrg@ti.com>

Thanks

Liam
