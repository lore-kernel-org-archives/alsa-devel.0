From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v3 2/2] ARM: dts: Append clock bindings for sai2 on VF610
 platform
Date: Wed, 9 Apr 2014 16:39:26 +0800
Message-ID: <20140409083925.GB12559@MrMyself>
References: <cover.1396605772.git.Guangyu.Chen@freescale.com>
 <08ba57a2fdce1a404a6bcb61e21e25509fcd6b30.1396605772.git.Guangyu.Chen@freescale.com>
 <20140409081137.GD28420@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140409081137.GD28420@dragon>
Sender: linux-doc-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, rob@landley.net, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Shawn,

On Wed, Apr 09, 2014 at 04:11:38PM +0800, Shawn Guo wrote:
> On Fri, Apr 04, 2014 at 06:08:13PM +0800, Nicolin Chen wrote:
> > Since we added fours clock to the DT binding, we should update the current
> > SAI dts/dtsi so as not to break their functions.
> 
> For the record, you're asking my ACK to have the dts change go via sound
> tree for not breaking vf610 function on the sound branch,  while
> ignoring the fact that the existing DTB will break with the new kernel
> anyway.
> 
> I'm not completely happy with the approach, but considering that the
> existing binding is incorrect, I'm fine with it as long as people agree
> to go this way.

Although I'm not a big fan of explaining, yet, I still want to say that
actually I've balanced this way and your last suggestion against the v1.

It'd be surely better to distinguish two platforms as you suggested if
we are looking at this change alone since the change is nearly tiny and
the code to specify them wouldn't be quite a lot. However, there's more
work to do based on this patch, an auto-selecting clock source mechanism
for SAI as a DAI master for example, which would need to drop the existing
code and to add the new one. If vf610 is still using the old one, it would
not benefit from the further feature and the code would be definitely ugly
as we would have to add too many platform checks. So personally I prefer
this reasonable change than the little sacrifice we're going to make here.

Right now I feel grateful for what Sascha suggested to the DT bindings of
fsl-spdif. It was a painstaking experience when getting it upstream last
year but what's done at that moment makes the driver more flexible. So I
think we should do the strict and comprehensive review for the clock part
to every module from now on since an once-defined-DT-binding would be so
painful to improved for us.

Thank you,
Nicolin

> 
> Shawn
> 
> > 
> > Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
> > Tested-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >  arch/arm/boot/dts/vf610.dtsi | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> > index d31ce1b..9fd0007 100644
> > --- a/arch/arm/boot/dts/vf610.dtsi
> > +++ b/arch/arm/boot/dts/vf610.dtsi
> > @@ -139,8 +139,10 @@
> >  				compatible = "fsl,vf610-sai";
> >  				reg = <0x40031000 0x1000>;
> >  				interrupts = <0 86 0x04>;
> > -				clocks = <&clks VF610_CLK_SAI2>;
> > -				clock-names = "sai";
> > +				clocks = <&clks VF610_CLK_SAI2>,
> > +				       <&clks VF610_CLK_SAI2>,
> > +				       <&clks 0>, <&clks 0>;
> > +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> >  				status = "disabled";
> >  			};
> >  
> > -- 
> > 1.8.4
> > 
> > 
> 

