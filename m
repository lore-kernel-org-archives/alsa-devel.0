From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: CS4271 codec support
Date: Mon, 17 Jan 2011 15:40:44 +0000
Message-ID: <20110117154044.GL21113@opensource.wolfsonmicro.com>
References: <1295217350.16460.11.camel@r60e>
	<1295260210.11031.38.camel@dplaptop.localdomain>
	<1295271449.16460.34.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D08CB10386D
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 16:40:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295271449.16460.34.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 17, 2011 at 04:37:29PM +0300, Alexander wrote:
> On Mon, 2011-01-17 at 10:30 +0000, Dimitris Papastamos wrote:

> > On Mon, 2011-01-17 at 01:35 +0300, Alexander wrote:
> > > +/* CS4271 default register settings, except auto-mute is off */
> > > +static const u8 cs4271_dflt_reg[CS4271_NR_REGS] = {
> > > +	0, 0, 0, CS4271_DACVOL_ATAPI_AL_BR, 0, 0, 0,
> > > +	CS4271_MODE2_CPEN | CS4271_MODE2_PDN,
> > > +};

> > I'd be better to leave these as defaults, and perform any initialization
> > in the the cs4271_probe() function.

> It's space optimized without affecting readability. I can rename it to
> cs4271_init_reg[].

You're missing Dimitris' point here.  There's an expectation that the
register defaults will be the physical register defaults, if you need to
change them do it with an explicit write during startup.

There's several other places where you're responding to review with
similar comments about space optimisation which don't really seem to
engage at all with what Dimitris has said.

> > > +/* CS4271 controls */
> > > +static DECLARE_TLV_DB_SCALE(cs4271_dac_tlv, -12700, 100, 0);

> > Are you use this doesn't mute the DAC?  If so the the last parameter
> > should be 1.

> No I do not use this, some people asked for this last time I've tried to
> submit this code. And no, this doesn't mute the DAC.

Then again -127dB is more attenuation than many actual mutes.

> > > +	ret = (cs4271->bus_type == SND_SOC_SPI) ? 16 : 8;

> > Please avoid using the ternary operator like this.

> What's wrong with it?

It's not great for legibility.
