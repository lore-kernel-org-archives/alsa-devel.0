From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: da7210: Add support for PLL and SRM
Date: Mon, 16 Apr 2012 19:12:30 +0530
Message-ID: <1334583750.26734.15.camel@matrix>
References: <1334122120.3991.13.camel@matrix>
	<20120413093012.GK3168@opensource.wolfsonmicro.com>
	<1334578993.26734.6.camel@matrix>
	<20120416125930.GB3219@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D95924413
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 15:31:04 +0200 (CEST)
In-Reply-To: <20120416125930.GB3219@opensource.wolfsonmicro.com>
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

On Mon, 2012-04-16 at 13:59 +0100, Mark Brown wrote:
> On Mon, Apr 16, 2012 at 05:53:13PM +0530, Ashish Chavan wrote:
> > On Fri, 2012-04-13 at 10:30 +0100, Mark Brown wrote:
> > > On Wed, Apr 11, 2012 at 10:58:40AM +0530, Ashish Chavan wrote:
> 
> > > > +	/* for MASTER mode, fs = 48Khz */
> > > > +	{ 12000000, 0xF3, 0x12, 0x7, },		/* MCLK=12Mhz */
> 
> > > This *still* has magic number problems.
> 
> > OK, will replace frequency values with defines. That is what you are
> > pointing, right?
> 
> No!  As with *all* the other times you've submitted this you're relying
> on magic array indexes to find stuff in the table which I've *repeatedly* 
> pointed out is terrible for readability and maintainability.  It's very
> disappointing to see the same problem coming back repeatedly.
> 

Thanks for bearing with me Mark. But the only other way I can think is
to make the *extra* info like master/slave and fs a part of array itself
and then search through the array to get required divisors. In this
case, every time I need to search through entire array to pick up
correct divisors. Wouldn't that be inefficient, especially when the
array indexes are fixed? Or the readability/maintainability of that
would outweigh slight performance overhead?

> > > These defines now need to be kept in sync with the table and are going
> > > to be *very* painful to review.
> 
> > Yes, these defines need to be kept in sync with the table. Can you
> > suggest any other, preferred way to do this?
> 
> Yes.  For example, you could use the same technique you're using for the
> frequencies.
