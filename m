From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: add a WM8978 codec driver
Date: Wed, 20 Jan 2010 20:21:09 +0000
Message-ID: <20100120202108.GA15238@rakim.wolfsonmicro.main>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
	<Pine.LNX.4.64.1001190851380.4607@axis700.grange>
	<1263897964.3089.54.camel@odin>
	<Pine.LNX.4.64.1001202051370.4151@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 732D710381D
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 21:21:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1001202051370.4151@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 20, 2010 at 09:01:46PM +0100, Guennadi Liakhovetski wrote:
> On Tue, 19 Jan 2010, Liam Girdwood wrote:

> > It would be nice to have the relevant bits defined here for set_fmt()
> > etc instead of just the magic numbers used in the above codec driver. 

> As I explained privately, I agree, that using names instead of bits helps 
> - but (mostly) only where those bits are reused multiple times in the 
> code. If you only have to initialise a register once with some bitmask, I 
> think, code like

> 	/* Enable input X, output Y, set default W polarity to Z */
> 	__raw_writel(0x123, reg);

> looks better than

> 	__raw_writel(CHIP_INPUT_X_ENABLE | CHIP_OUTPUT_Y_ENABLE | 
> 			CHIP_SIGNAL_W_POLARITY_Z, reg);

> so, unless there strong preferences in ALSA world, I'll try to combine 
> both. Let me know if this contradicts the common ALSA style.

It's nice to have the names used when they're readily available (as they
are for much of this device).  It's much easier to figure out exactly
what the latter case is supposed to do than reverse engineer a bitmask
and sometimes scratch your head over why exactly some of the bits were
set or if (as happens) someone made a mistake when converting to hex.

I'm not too religious about it, though - it's a relatively mild
preference.
