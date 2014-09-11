From: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [PATCH V1] ASoC: fsl_ssi: refine ipg clock usage
	in this module
Date: Thu, 11 Sep 2014 15:07:12 +0800
Message-ID: <20140911070710.GA25251@audiosh1>
References: <e5a50d8bfde3aea5fcd092118da5aea4072c7e2f.1410254125.git.shengjiu.wang@freescale.com>
 <20140909183804.GA6944@Asurada> <20140910081251.GA14662@audiosh1>
 <20140910174204.GA4628@Asurada> <20140911063651.GD16489@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0140.outbound.protection.outlook.com [65.55.169.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 7936C262631
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 09:07:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140911063651.GD16489@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, Li.Xiubo@freescale.com, timur@tabi.org, Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 11, 2014 at 08:36:51AM +0200, Markus Pargmann wrote:
> On Wed, Sep 10, 2014 at 10:42:04AM -0700, Nicolin Chen wrote:
> > On Wed, Sep 10, 2014 at 04:12:53PM +0800, Shengjiu Wang wrote:
> > > > Then we can get a patch like:
> > > > open() {
> > > > +	clk_prepare_enable();
> > > > 	....
> > > > }
> > > > 
> > > > close() {
> > > > 	....
> > > > +	clk_disable_unprepare()
> > > > }
> > 
> > > what is the open() and close()? do you mean the fsl_ssi_startup()
> > > and fsl_ssi_shutdown()?
> > 
> > Yea.
> > 
> > > > probe() {
> > > > 	clk_get();
> > > > 	clk_prepare_enable();
> > > > 	....
> > > > 	if (xxx)
> > > > -		goto err_xx;
> > > > +		return ret;
> > > > 	....
> > > > +	clk_disable_unprepare();
> > > > 	return 0;
> > > > -err_xx:
> > > > -	clk_disable_unprepare()
> > > > }
> > 
> > > If this probe() is fsl_ssi_imx_probe(), I think no need to add
> > > clk_prepare_enable() or clk_disable_unprepare(), seems there is no 
> > > registers accessing in this probe.
> > 
> > This is trying to be safe, especially for such a driver being used
> > by multiple platforms. You can omit this as long as the patch can
> > pass the test on old imx, PowerPC, and AC97 platforms.
> > 
> > >
> > 
> > And another risk just came to my mind is that there would be a
> > possibility that a machine driver would call set_dai_fmt() early,
> > after SSI's probe() and before SSI's startup(), if the machine
> > driver contains dai_fmt assignment in its probe(). Then, without
> > regmap_mmio_clk(), it'll be tough for us over here because we may
> > also need to add clock enable/disable for set_dai_fmt/set_sysclk(),
> > even if there might be still tiny risk that we missed something.
> 
> Thanks, didn't thought about that. As there are no restrictions on when
> these functions may be called, it has to be handled.
> 
> > 
> > Then there could be a selfish approach to circumvent it is to use
> > regmap_mmio_clk() with "ipg" at the beginning and call regmap_mmio()
> > without "ipg" if getting a failed return value from regmap_mmio_clk,
> > and meanwhile to keep the clock always enabled for the regmap_mmio()
> > case just like what the current driver is doing. This may result
> > those non-ipg-clk platforms can't benefit from this refinement
> > unless they update their DT bindings -- use "ipg" for core clock
> > This might be the safest and simplest way for us, I'm not sure
> > everyone would be comfortable with this idea though.
> 
> I like the "selfish" approach. It would save a lot of clock
> enabling/disabling and error handling and at the same time it doesn't break
> the DT compatibility. The platforms with an old DT would have the old
> behaviour, but that could be changed by updating the devicetrees which
> should be easy to do for all the imx SoCs.
> 
> Best regards,
> 
> Markus
>
Thanks Markus and Nicolin

I have sent version 2 for this patch. Please review it.

best regards
wang shengjiu 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
