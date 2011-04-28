From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/7] ASoC: DAPM: Pass snd_dapm_soc_update
	as parameter
Date: Thu, 28 Apr 2011 23:18:00 +0100
Message-ID: <20110428221800.GC19535@opensource.wolfsonmicro.com>
References: <1304009173-5786-1-git-send-email-lars@metafoo.de>
	<1304009173-5786-2-git-send-email-lars@metafoo.de>
	<20110428194054.GB16837@opensource.wolfsonmicro.com>
	<4DB9D06C.5090006@metafoo.de>
	<20110428205827.GA18350@opensource.wolfsonmicro.com>
	<4DB9DB16.1060507@metafoo.de>
	<20110428214817.GA19535@opensource.wolfsonmicro.com>
	<4DB9E454.3060903@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8C9FA24423
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 00:17:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DB9E454.3060903@metafoo.de>
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

On Fri, Apr 29, 2011 at 12:04:04AM +0200, Lars-Peter Clausen wrote:
> On 04/28/2011 11:48 PM, Mark Brown wrote:

> > Moving to the card doesn't seem helpful, while we're currently doing one
> > update at once it's not immediately obvious that we want to keep doing
> > that indefinitely.

> But keeping it in the dapm context would limit us to one update per context
> which doesn't seem very sustainable either.

The contexts are pretty much I/O limited - there's a limit to how much
you can do simultaneously on a context because at some point you have to
interact with the hardware and that's usually the only thing that takes
enough time to really care about.  Each context will usually go along
with a control interface and sometimes those control interfaces will be
able to run separately.

Though for global state changes like this that's pretty much irrelevant
as we need to walk the entire graph at once.

> Turning the pointer in the card struct into a list seems like an option though.

> dapm_power_widgets works over the whole card, so the updates to be done should
> in my opinion be kept on a per card basis as well.

They're going to be tied to a context anyway, simply as a result of
getting the I/O context for a register write - if they get moved to the
card they'll need to have a context added.
