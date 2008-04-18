From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc tlv320aic33: skip usage of PLL
	in	some cases
Date: Fri, 18 Apr 2008 11:08:59 +0100
Message-ID: <20080418100858.GA19457@rakim.wolfsonmicro.main>
References: <20080417191245.GA17039@buzzloop.caiaq.de>
	<20080417192552.GC17039@buzzloop.caiaq.de>
	<bd7b27490804180059h67a481b0md6fb1a5648338513@mail.gmail.com>
	<20080418081315.GA23555@buzzloop.caiaq.de>
	<bd7b27490804180158j6607dbefyddbb48cbde51fc55@mail.gmail.com>
	<20080418093821.GA23651@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9599F24AEF
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 12:09:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080418093821.GA23651@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 18, 2008 at 11:38:21AM +0200, Daniel Mack wrote:
> On Fri, Apr 18, 2008 at 11:58:49AM +0300, Jarkko Nikula wrote:

> > > AIC3X_SAMPLE_RATE_SEL_REG defaults to 0 which is what I want in this
> > > case. Thus, I don't have to write it.

> > Are you sure this is a general case?

> Well, the reset default is 0 (as stated on page 44) and set_hw_params()
> is the only location where this value is written. So if it's never 
> written with a different value, it should always be set to its default,
> no?

Not all systems use a static SYSCLK rate - sometimes systems will select
the rate based on their current usage.  If the system has previously had
to configure it then the register won't be at the default value any more.
