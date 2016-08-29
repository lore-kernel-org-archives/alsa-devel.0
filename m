From: Xavi Drudis Ferran <xdrudis@tinet.cat>
Subject: Re: Setting some clocks back to DUMMY fixes spdif output on imx6q
 wandboard rev B1
Date: Mon, 29 Aug 2016 21:54:28 +0200
Message-ID: <20160829195428.GD1967@begut>
References: <20160828160055.GA2122@begut>
 <20160829192820.GA14207@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <20160829192820.GA14207@Asurada-Nvidia>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@freescale.com>, Xavi Drudis Ferran <xdrudis@tinet.cat>, alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

El Mon, Aug 29, 2016 at 12:28:21PM -0700, Nicolin Chen deia:
> 
> Yes, it seems that it also tried to correct the clock sources
> as those were not available when adding the S/PDIF support at
> the first place.
>

I wonder if maybe they need to be defined, assigned or somehow listed
elsewhere and they are not for wandboard quad (but are for other boards)?
 
> > The issue is fixed for me with this patch but I'm not sure what's the
> > best way to help fix any issue someone else may have or what other
> > info or test you might need. Any guidance welcome. 
> 
> > --- linux-4.7-no-spdif-out/arch/arm/boot/dts/imx6qdl.dtsi	2016-07-25 00:19:43.000000000 +0200
> > +++ linux-4.7/arch/arm/boot/dts/imx6qdl.dtsi	2016-08-28 17:59:14.276774409 +0200
> > @@ -240,9 +240,9 @@
> >  					       <&sdma 15 18 0>;
> >  					dma-names = "rx", "tx";
> >  					clocks = <&clks IMX6QDL_CLK_SPDIF_GCLK>, <&clks IMX6QDL_CLK_OSC>,
> > -						 <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_ASRC>,
> > -						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_ESAI_EXTAL>,
> > -						 <&clks IMX6QDL_CLK_IPG>, <&clks IMX6QDL_CLK_MLB>,
> > +						 <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_DUMMY>,
> > +						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
> > +						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
> >  						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_SPBA>;
> >  					clock-names = "core",  "rxtx0",
> >  						      "rxtx1", "rxtx2",
> 

> This looks like that you merely revert the SPDIF_GCLK. 

I revert only some clocks, yes. I left SPDIF_GCLK and CLK_SBPA intact.
So it is a partial revert of the commit.

> Would you
> please do a little debug using "#define DEBUG 1" and check printk
> from fsl_spdif_probe_txclk() to see the difference between before
> and after Shengjiu's commit?

Yes, but I'm compiling the kernel in the wandboard, so it'll take me some time. 

Thank you. 
