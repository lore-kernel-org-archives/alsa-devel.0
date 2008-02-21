From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Convert ASoC pxa2xx-ac97 driver to use the
	clock API
Date: Thu, 21 Feb 2008 15:43:51 +0000
Message-ID: <20080221154351.GA9341@rakim.wolfsonmicro.main>
References: <20080219160341.GA6387@rakim.wolfsonmicro.main>
	<1203437058-7288-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1203437058-7288-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1203437058-7288-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080221152613.GA19670@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7109624347
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 16:43:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080221152613.GA19670@flint.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, eric miao <eric.miao@marvell.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 21, 2008 at 03:26:13PM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 19, 2008 at 04:04:17PM +0000, Mark Brown wrote:

> 		ret = PTR_ERR(ac97conf_clk);

> Always propagate error codes.

I've fixed both of these.

> > + err_irq:
> > +	GCR |= GCR_ACLINK_OFF;
> > +	if (ac97_clk) {
> > +		clk_disable(ac97_clk);
> > +		clk_put(ac97_clk);
> > +		ac97_clk = NULL;
> >  	}

> Under what circumstance will we get here with a non-NULL ac97_clk?

We can't - the check is redundant now due to the addition of IRQ.  Fixed
as well.

Thanks for the review, I'll resubmit.
