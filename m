From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Wed, 17 Feb 2010 10:52:02 +0000
Message-ID: <20100217105202.GB31765@sirena.org.uk>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<4B7B9387.1070506@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CAB5A24394
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 11:52:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B7B9387.1070506@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, jassi brar <jassisinghbrar@gmail.com>, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2010 at 03:58:15PM +0900, Joonyoung Shim wrote:

> At the ASoC, is there a situation to share the dai(cpu or codec)?
> If the dai is shared, i just think the ASoC core cannot support it.

I'm not sure what you mean by "sharing" the DAI - sharing between what?
I think you mean using the same DAI in multiple dai_links but I'm not
100% sure?

> There is the case at the S5PC1XX, it supports the hardware mixing by
> using two tx fifo. First Jassi implemented codes using each other cpu
> dai as Jassi says at the above for the hardware mixing, but it should
> share codec_dai and need some modification of ASoC core.

What modifications are you looking for here?  ASoC doesn't make any
effort to avoid reuse of DAIs in multiple links - it doesn't actively do
anything to help here but equally well it's not supposed to get in the
way.

The only thing I can think of off the top of my head that would cause
actual problems is that the DAPM events for stream stop/start in the
CODEC might not be doing reference counting, I'd need to check.  Other
than that there's a bunch of things that could make use cases like this
nicer like providing a way of bundling links that share signals together
and providing callbacks when things start and stop (so shared clocking
can be turned on and off, for example) but these should be things that
could be open coded in individual drivers.
