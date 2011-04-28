From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/7] ASoC: DAPM: Pass snd_dapm_soc_update
	as parameter
Date: Thu, 28 Apr 2011 23:48:17 +0100
Message-ID: <20110428224817.GA11103@opensource.wolfsonmicro.com>
References: <1304009173-5786-2-git-send-email-lars@metafoo.de>
	<20110428194054.GB16837@opensource.wolfsonmicro.com>
	<4DB9D06C.5090006@metafoo.de>
	<20110428205827.GA18350@opensource.wolfsonmicro.com>
	<4DB9DB16.1060507@metafoo.de>
	<20110428214817.GA19535@opensource.wolfsonmicro.com>
	<4DB9E454.3060903@metafoo.de>
	<20110428221800.GC19535@opensource.wolfsonmicro.com>
	<20110428222315.GA19741@opensource.wolfsonmicro.com>
	<4DB9EB63.5020007@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9F98A24467
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 00:48:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DB9EB63.5020007@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 29, 2011 at 12:34:11AM +0200, Lars-Peter Clausen wrote:

> If we'd keep the update in the dapm context we'd have to iterate over all
> contexts to find the one context which contains the update.
> As you've said we have to walk the whole graph and it does not make a nice
> interface if the function takes one specific dapm context while it works on the
> whole card.

So that's part of a separate refactoring and only applies if we're not
running DAPM in a particular context and should be something along the
lines of "now we pass the card in it's much more sensible to..."; I'm
writing this while looking at current code.

> Currently we get the codec from the widget for which the update is run and not
> from the dapm context anyway.

That's just a redundancy in the data structure; the codec and context
are just two different ways of getting to the same thing.
