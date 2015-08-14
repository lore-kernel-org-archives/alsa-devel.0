From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: add wm8960 support
Date: Fri, 14 Aug 2015 10:21:18 +0800
Message-ID: <20150814022116.GA11145@shlinux2>
References: <dc4e5a52a90982cea95445e27a30f2ad6cb73513.1439349623.git.zidan.wang@freescale.com>
 <20150812034257.GA2980@Asurada-CZ80>
 <20150812044505.GA21786@shlinux2>
 <20150812064053.GA2807@Asurada-CZ80>
 <20150812073859.GB21786@shlinux2>
 <20150812222735.GA57015@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0106.outbound.protection.outlook.com [157.56.111.106])
 by alsa0.perex.cz (Postfix) with ESMTP id 404E7264FF9
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 05:32:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150812222735.GA57015@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, tiwai@suse.com, timur@tabi.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 12, 2015 at 03:27:36PM -0700, Nicolin Chen wrote:
> On Wed, Aug 12, 2015 at 03:39:00PM +0800, Zidan Wang wrote:
> > On Tue, Aug 11, 2015 at 11:40:54PM -0700, Nicolin Chen wrote:
> > > On Wed, Aug 12, 2015 at 12:45:10PM +0800, Zidan Wang wrote:
> > > 
> > > > > > +		/*
> > > > > > +		 * for imx6ul we should set SAI2_MCLK_DIR to enable
> > > > > > +		 * codec MCLK
> > > > > > +		 */
> > > > > > +		if (of_device_is_compatible(np, "fsl,imx6ul-evk-wm8960"))
> > > > > > +			regmap_update_bits(priv->gpr, 4, 1 << 20, 1 << 20);
> > > 
> > > > > What's this SAI2_MCLK_DIR? Can you provide the description of it?
> > > > SAI2_MCLK_DIR: SD1_CLK data direction control when sai2.MCLK is selected (ALT2)
> > > > 0 SD1_CLK output driver is disabled when configured for ALT2
> > > > 1 SD1_CLK output driver is enabled when configured for ALT2
> > > 
> > > > We are using SAI2 now, so we should enable SAI2_MCLK_DIR. If we want to
> > > > use SAI1 and SAI3, we should also enable SAI1_MCLK_DIR and SAI3_MCLK_DIR.
> > > > I don't consider SAI1 and SAI3 case, should i add it like below:
> > > 
> > > Yes. Just think about a general interface/configuration that can
> > > satisfy all the MCLK cases you can imagine.
> 
> > > And I still don't understand the meaning of this MCLK at all.
> > > Does it indicate SAI's MCLK or an MCLK for external CODEC chips?
> > > Will it be possible that a user needs this MCLK bit to be unset?
> 
> > For imx6ul-evk, MCLK for wm8960 CODEC chips and SAI's MCLK is the same pin.
> > So it should always be set for SAI.
> 
> Since the MCLK is driven to the external CODEC chip, it should
> be similar to the CLKO for wm8962 on the imx6qdl-sabresd board.
> So this configuration might be included in the clock tree in my
> opinion.
> 
> And I Just checked the Reference Manual, it seems the direction
> could be totally set to input by leaving this bit unset: MCLK
> outputs via the SD1_CLK pad of IOMUX when setting this bit in
> the GPR; and MCLK inputs from an external clock source on the
> board level when clearing this bit. The SAI chapter mentions
> something similar in its MCLK section as well.
> 
> But I can't find any clock MUX for the MCLK of SAI by selecting
> between the CCM and the external PAD: there is only a MUX inside
> the CCM. So I think you need to confirm with the IC team about
> this bit and the clock source of SAI MCLK.

Don't have such clock MUX. So i think it can't be add to clock tree. 

> 
> And there is a crucial problem I can imagine:
>   Is it okay to set this bit while setting SD1_CLK PAD as one
>   of other functions rather than SAI MCLK? -- Customers might
>   keep your code as they also use SAI2 while using SD1_CLK PAD
>   as a GPIO input.
> 
I just add a gpr node in device tree, if customer want to use SD1_CLK PAD as a GPIO input, remove the gpr node.

Best Regards,
Zidan Wang

> Nicolin
