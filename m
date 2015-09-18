From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: add wm8960 support
Date: Fri, 18 Sep 2015 21:19:18 +0800
Message-ID: <20150918131918.GA3770@tiger>
References: <20150812044505.GA21786@shlinux2>
 <20150812064053.GA2807@Asurada-CZ80>
 <20150812073859.GB21786@shlinux2>
 <20150812222735.GA57015@Asurada-CZ80>
 <20150814022116.GA11145@shlinux2> <20150814035805.GA2180@Asurada>
 <20150814073758.GB11145@shlinux2>
 <20150814092252.GA4164@Asurada-CZ80> <20150906113344.GN30746@tiger>
 <20150917080339.GA9365@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A4AD260415
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 15:19:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150917080339.GA9365@Asurada-CZ80>
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
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, tiwai@suse.com, timur@tabi.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 17, 2015 at 01:03:40AM -0700, Nicolin Chen wrote:
> Hi Shawn,
> 
>    Sorry for my late reply.
> 
> On Sun, Sep 06, 2015 at 07:33:44PM +0800, Shawn Guo wrote:
> > On Fri, Aug 14, 2015 at 02:22:53AM -0700, Nicolin Chen wrote:
> > > I have to add Shawn for help :)
> > > 
> > > On Fri, Aug 14, 2015 at 03:38:16PM +0800, Zidan Wang wrote:
> > > 
> > > > ccm ----->1------------------>2<------------>3
> > > > 	  |                   |
> > > >     	  |                   |		
> > > > 	  4 SAIx MCLK1        5 SAIx MCLK2
> > > > 
> > > > If this bit is set, the clock route is ccm->1->2->3, 2 to 5 is disconnect.
> > > > If this bit is clear, the clock route is 3->2->5, 1 to 2 is disconnect.
> > > 
> > > @Shawn
> > > 
> > > Suppose 1 and 2 are clock MUXs that we can't specifically touch
> > > via registers. And 3 is an IO PAD that can either output a clock
> > > from CCM or input a clock from an external source outside SoC.
> > > Both 4 and 5 are two clock sources for one single SAI, SAI2 for
> > > example.
> > > 
> > > There is a bit in the GPR register to control above routes. And
> > > my question is where should be the best place to put this bit.
> > 
> > If this route selection is a decision of board design, it should fit
> > device tree quite well.  As the platform maintainer, I surely hope we
> > can handle this in audio driver.  But if there is really no place better
> > than platform code to handle it, I can accept it.
> 
> I understand your concern. This route decides the source of mclk2,
> 
> 955                         sai1: sai@021d4000 {
> 956                                 compatible = "fsl,imx6sx-sai";
> 957                                 reg = <0x021d4000 0x4000>;
> 958                                 interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> 959                                 clocks = <&clks IMX6SX_CLK_SAI1_IPG>,
> 960                                          <&clks IMX6SX_CLK_SAI1>,
> 961                                          <&clks 0>, <&clks 0>;
> 962                                 clock-names = "bus", "mclk1", "mclk2", "mclk3";
> 
> So it doesn't make sense to me if putting it in the audio driver as
> it then would be out of the clock tree.
> 
> I'm not familiar with the current platform code. Is that possible we
> put it in the clock tree? Would you please give me and Zidan another
> hint for the implementation?

The platform code we generally mean is the code in arch/arm/mach-imx,
mostly these mach-imx*.c files.  I guess you would need to define a
device tree property to reflect the board design on this mclk2 route,
and parse the property in platform code and set up the GPR register
accordingly.

Shawn
