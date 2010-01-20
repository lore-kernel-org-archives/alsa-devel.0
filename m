From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [alsa-devel] [PATCH 1/4] ASoC: add a WM8978 codec driver
Date: Wed, 20 Jan 2010 20:25:46 +0000
Message-ID: <1264019146.6554.25.camel@odin>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
	 <Pine.LNX.4.64.1001190851380.4607@axis700.grange>
	 <1263897964.3089.54.camel@odin>
	 <Pine.LNX.4.64.1001202051370.4151@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1001202051370.4151@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Magnus Damm <damm@opensource.se>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-sh@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-01-20 at 21:01 +0100, Guennadi Liakhovetski wrote:
> On Tue, 19 Jan 2010, Liam Girdwood wrote:
> > 
> > It would be nice to have the relevant bits defined here for set_fmt()
> > etc instead of just the magic numbers used in the above codec driver. 
> 
> As I explained privately, I agree, that using names instead of bits helps 
> - but (mostly) only where those bits are reused multiple times in the 
> code. If you only have to initialise a register once with some bitmask, I 
> think, code like
> 
> 	/* Enable input X, output Y, set default W polarity to Z */
> 	__raw_writel(0x123, reg);
> 
> looks better than
> 
> 	__raw_writel(CHIP_INPUT_X_ENABLE | CHIP_OUTPUT_Y_ENABLE | 
> 			CHIP_SIGNAL_W_POLARITY_Z, reg);
> 
> so, unless there strong preferences in ALSA world, I'll try to combine 
> both. Let me know if this contradicts the common ALSA style.

I disagree, it's far better to use the bottom example as I can see
explicitly which bits you intend to write.  This makes it easier for
others to extend and debug your code.

Furthermore, WM codecs also have software generated register bits and
register macros (available upon request) that further reduce any effort
and any potential register value bugs.

Liam

