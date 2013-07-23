From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3] ARM: kirkwood: extend the kirkwood
	i2s	driver for DT usage
Date: Tue, 23 Jul 2013 10:39:50 +0100
Message-ID: <20130723093950.GR24642@n2100.arm.linux.org.uk>
References: <20130723104615.3696f1a9@armhf>
 <20130723085346.GQ24642@n2100.arm.linux.org.uk>
 <20130723090820.GN9434@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id A0893261B1E
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 11:40:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130723090820.GN9434@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Liam Girdwood <lgirdwood@gmail.com>, devicetree-discuss@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 23, 2013 at 11:08:20AM +0200, Sascha Hauer wrote:
> On Tue, Jul 23, 2013 at 09:53:46AM +0100, Russell King - ARM Linux wrote:
> > On Tue, Jul 23, 2013 at 10:46:15AM +0200, Jean-Francois Moine wrote:
> > > The kirkwood i2s driver is used without DT in the Kirkwood machine.
> > > This patch adds a DT compatible definition for use in other Marvell
> > > machines as the Armada 88AP510 (Dove).
> > 
> > Yet again, this illustrates why converting to DT causes backwards
> > steps in drivers: the conversion of devm_clk_get() to of_clk_get()
> > necessitates a clk_put().
> > 
> > Can someone please provide a devm_of_clk_get() function before we
> > accept any more patches doing this kind of thing?
> 
> The question is why isn't regular [devm_]clk_get used here? I don't know
> what the Marvell stuff is doing here, but if the clk stuff is
> implemented correctly then
> 
> 	np = pdev->dev.of_node;
> 	priv->clk = of_clk_get(np, 0);
> 
> and
> 
> 	devm_clk_get(&pdev->dev, "label");
> 
> should both work

You tell me - I keep seeing patches on this list converting drivers from
using devm_clk_get() to using of_clk_get().  Maybe of_clk_get() should be
marked deprecated to stop people using it?
