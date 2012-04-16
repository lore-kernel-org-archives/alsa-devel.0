From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: da7210: Add support for PLL and SRM
Date: Mon, 16 Apr 2012 17:53:13 +0530
Message-ID: <1334578993.26734.6.camel@matrix>
References: <1334122120.3991.13.camel@matrix>
	<20120413093012.GK3168@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BEB724374
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 14:12:10 +0200 (CEST)
In-Reply-To: <20120413093012.GK3168@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-04-13 at 10:30 +0100, Mark Brown wrote:
> On Wed, Apr 11, 2012 at 10:58:40AM +0530, Ashish Chavan wrote:
> 
> > +/* PLL dividers table */
> > +static const struct pll_div da7210_pll_div[] = {
> > +	/* for MASTER mode, fs = 44.1Khz */
> > +	{ 12000000, 0xE8, 0x6C, 0x2, },		/* MCLK=12Mhz */
> > +	{ 13000000, 0xDF, 0x28, 0xC, },		/* MCLK=13Mhz */
> > +	{ 13500000, 0xDB, 0x0A, 0xD, },		/* MCLK=13.5Mhz */
> > +	{ 14400000, 0xD4, 0x5A, 0x2, },		/* MCLK=14.4Mhz */
> > +	{ 19200000, 0xBB, 0x43, 0x9, },		/* MCLK=19.2Mhz */
> > +	{ 19680000, 0xB9, 0x6D, 0xA, },		/* MCLK=19.68Mhz */
> > +	{ 19800000, 0xB8, 0xFB, 0xB, },		/* MCLK=19.8Mhz */
> > +	/* for MASTER mode, fs = 48Khz */
> > +	{ 12000000, 0xF3, 0x12, 0x7, },		/* MCLK=12Mhz */
> 
> This *still* has magic number problems.
> 

OK, will replace frequency values with defines. That is what you are
pointing, right?

> > +	if (da7210->master) {
> > +		/* In PLL master mode, use master mode PLL dividers */
> > +		switch (fout) {
> > +		case 2822400:
> > +			row_idx = MASTER_2822400_DIV_OFFSET;
> > +			break;
> > +		case 3072000:
> > +			row_idx = MASTER_3072000_DIV_OFFSET;
> > +			break;
> 
> These defines now need to be kept in sync with the table and are going
> to be *very* painful to review.

Yes, these defines need to be kept in sync with the table. Can you
suggest any other, preferred way to do this?

Thanks!
