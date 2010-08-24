From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Tue, 24 Aug 2010 11:10:32 +0100
Message-ID: <20100824101032.GA15278@rakim.wolfsonmicro.main>
References: <1281943770-2990-1-git-send-email-jhnikula@gmail.com>
	<20100816100705.GA3276@rakim.wolfsonmicro.main>
	<20100816135328.077b5ea3.jhnikula@gmail.com>
	<20100816110902.GA10354@sirena.org.uk>
	<20100819144451.1d827367.jhnikula@gmail.com>
	<20100819135413.GA19582@opensource.wolfsonmicro.com>
	<20100819182049.3ecdd0bc.jhnikula@gmail.com>
	<20100820115144.451b474f.jhnikula@gmail.com>
	<20100823152145.GD14504@rakim.wolfsonmicro.main>
	<20100824102343.4dfaafe1.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B999D24688
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 12:10:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100824102343.4dfaafe1.jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 24, 2010 at 10:23:43AM +0300, Jarkko Nikula wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Best not in the header; these are not things individual drivers should
> > be worrying their pretty little heads about.  If they should be used by
> > individual drivers then we need better names than just _.

> Yeah, I picked up _ prefix so that name indicates that these functions
> are more like for internal use and drivers should use them only
> exceptionally. What I'm thinking if we can rid of them completely.

I figured.

> From your commit 26b01cc it looks like there's a work in progress to
> support DAI-less codecs/amplifiers. If that would be possible then
> there is no need to register controls from other drivers in machine DAI

DAIless devices should work already.

> init. Well, CPU DAI controls are possible but they don't need a prefix
> I think.

There might be an issue disambiguating against collisions with other
drivers in the system, I guess.

> > I don't see how a DAI link can ever be used to configure prefix names -
> > there's just not any real association between DAI links and controls,
> > and as soon as you hit mixing any that does exist gets lost.  Probably a
> > table of CODEC to prefix mappings would be better.

> Sorry, I didn't emphasis this well enough that this hack was
> temporary just after your comment to first version and it got finally
> removed in yesterday's version :-)

Yeah, I was writing my reply as you sent that.

> > This one is a bit more fun.  For this to work properly we need to
> > consider what happens with the cross-device links in the DAI maps which
> > means we need to able to cope with separate prefixes for the source and
> > the sink.

> Prefixing is not problem I think since we can specify them in
> machine's audio map (like two mono amplifiers registered to 1st codec
> are prefixed below) but how to link DAPMs of two codec together?

We'll be fine just using the prefixed name in the machine drivers I
think and not advertising the prefix-adding route add function.
