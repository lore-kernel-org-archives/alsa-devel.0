From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] asoc tlv320aic33: skip usage of PLL
	in	some cases
Date: Fri, 18 Apr 2008 16:03:07 +0200
Message-ID: <20080418140307.GA26197@buzzloop.caiaq.de>
References: <20080417191245.GA17039@buzzloop.caiaq.de>
	<20080417192552.GC17039@buzzloop.caiaq.de>
	<bd7b27490804180059h67a481b0md6fb1a5648338513@mail.gmail.com>
	<20080418081315.GA23555@buzzloop.caiaq.de>
	<bd7b27490804180158j6607dbefyddbb48cbde51fc55@mail.gmail.com>
	<20080418093821.GA23651@buzzloop.caiaq.de>
	<bd7b27490804180347u30a3c456yed3438925d0fa4ae@mail.gmail.com>
	<20080418114113.GC23651@buzzloop.caiaq.de>
	<bd7b27490804180647n7c44da87l7a7d25080360f4f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id CF1F424BB0
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 16:03:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd7b27490804180647n7c44da87l7a7d25080360f4f4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 18, 2008 at 04:47:16PM +0300, Jarkko Nikula wrote:
> > Ok, I agree. I changed that to find an appropriate value for Q
> > programmatically. Have a look at the attached patch, please. I hope i
> > finally got it now ;)
> 
> 
> That sounds a good idea. Then more cases will be covered.
> 
> What I noticed that instead of params_rate, I think we should compare here
> the FSref of 44.1 and 48 kHz (how about dual-rate mode?) when defining can
> the PLL be bypassed
> 
> if (params_rate(params) == aic3x->sysclk / (128 * pll_q))

Hmm? Why do you think so? I'm afraid I don't get your point here.

> Probably you forgot to move bypass case in this version after writing the
> AIC3X_SAMPLE_RATE_SEL_REG?

No, actually not.

> Spec is also saying that when NDAC is 1.5, 2.5, ... 5.5, then odd values of
> Q are not allowed.

NDAC and NADC are both hard-coded to 0 (divider of 1) at the moment.
Support for more flexible settings could be done in another step.
Also, the PLL setup could be done by calculation of values rather
that by a lookup table.

I'd like to see this patch applied now as base for further refinements.
Do you agree?

Daniel
