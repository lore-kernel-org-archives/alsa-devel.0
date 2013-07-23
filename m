From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [alsa-devel] [PATCH v3] ARM: kirkwood: extend the kirkwood i2s
 driver for DT usage
Date: Tue, 23 Jul 2013 11:48:23 +0200
Message-ID: <20130723094823.GO9434@pengutronix.de>
References: <20130723104615.3696f1a9@armhf>
 <20130723085346.GQ24642@n2100.arm.linux.org.uk>
 <20130723090820.GN9434@pengutronix.de>
 <20130723093950.GR24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130723093950.GR24642@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 23, 2013 at 10:39:50AM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 23, 2013 at 11:08:20AM +0200, Sascha Hauer wrote:
> > On Tue, Jul 23, 2013 at 09:53:46AM +0100, Russell King - ARM Linux wrote:
> > > On Tue, Jul 23, 2013 at 10:46:15AM +0200, Jean-Francois Moine wrote:
> > > > The kirkwood i2s driver is used without DT in the Kirkwood machine.
> > > > This patch adds a DT compatible definition for use in other Marvell
> > > > machines as the Armada 88AP510 (Dove).
> > > 
> > > Yet again, this illustrates why converting to DT causes backwards
> > > steps in drivers: the conversion of devm_clk_get() to of_clk_get()
> > > necessitates a clk_put().
> > > 
> > > Can someone please provide a devm_of_clk_get() function before we
> > > accept any more patches doing this kind of thing?
> > 
> > The question is why isn't regular [devm_]clk_get used here? I don't know
> > what the Marvell stuff is doing here, but if the clk stuff is
> > implemented correctly then
> > 
> > 	np = pdev->dev.of_node;
> > 	priv->clk = of_clk_get(np, 0);
> > 
> > and
> > 
> > 	devm_clk_get(&pdev->dev, "label");
> > 
> > should both work
> 
> You tell me - I keep seeing patches on this list converting drivers from
> using devm_clk_get() to using of_clk_get().  Maybe of_clk_get() should be
> marked deprecated to stop people using it?

I don't think that's possible. There are some valid usecases for
of_clk_get() when there's no struct device * available, like in many
clocksource drivers.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
