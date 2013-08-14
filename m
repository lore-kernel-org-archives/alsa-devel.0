From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v4 resent 1/2] ASoC: fsl: Add S/PDIF CPU
	DAI driver
Date: Wed, 14 Aug 2013 16:48:02 +0800
Message-ID: <20130814084801.GH31651@MrMyself>
References: <cover.1376309076.git.b42378@freescale.com>
 <51808310dd97d2a35a28766ed7309f269521cafd.1376309076.git.b42378@freescale.com>
 <20130814075017.GE2324@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C63A261A4B
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2013 10:56:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130814075017.GE2324@pengutronix.de>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi Sascha,

On Wed, Aug 14, 2013 at 09:50:17AM +0200, Sascha Hauer wrote:
> > +  - tx-clksrc-names : The names for all available clock sources for tx, which
> > +  is also being listed in SoC reference manual, ClkSrc_Sel bit of SPDIF_SRPC.
> > +  And the name list would be different between different SoC. Use 'null' for
> > +  those unlisted names, and the max number of tx-clksrc-names should be 8.
> > +
> > +  - rx-clksrc-names : The names for all available clock sources for rx, which
> > +  is also being listed in SoC reference manual, TxClk_Source bit of SPDIF_STC.
> > +  And the name list would be different between different SoC. Use 'null' for
> > +  those unlisted names, and the max number of rx-clksrc-names should be 16.
> > +
> > +Optional properties:
> > +
> > +  - rx-clksrc-lock: This is a boolean property. If present, ClkSrc_Sel bit
> > +  of SPDIF_SRPC would be set a clock source that cares DPLL locked condition.
> > +
> > +Example1:
> > +
> > +spdif: spdif@02004000 {
> > +	clocks = <&clks 197>;
> > +	clock-names = "core";
> > +	rx-clksrc-lock;
> > +	rx-clksrc-names =
> > +		"lock.ext", "lock.spdif", "lock.asrc",
> > +		"lock.spdif_ext", "lock.esai", "ext",
> > +		"spdif", "asrc", "spdif_ext", "esai",
> > +		"lock.mlb", "lock.mlb_phy", "mlb",
> > +		"mlb_phy";
> > +	tx-clksrc-names =
> > +		"xtal", "spdif", "asrc", "spdif_ext",
> > +		"esai", "ipg", "mlb", "mlb_phy";
> 
> I had a hard time understanding what you are doing here.
> 
> With this the clk names in arch/arm/mach-imx/clk-imx6q.c become an API
> between the Kernel and the devicetree. Don't do that.
> 
> There is a standardized devicetree binding for clocks. Use it.
 
I think I should first explain to you what this part is doing:
The driver needs to set Clk_source bit for TX/RX to select the 
clock from a clock mux. The names listed above are those of the 
clocks connecting to the mux, while they are not only internal 
clocks which're included in clk-imx6q.c but also external ones,
an on-board external osc for example.

The driver does get the clock by using the standard DT binding,
see the 'clocks = <&clks 197>' above, and then compare this
obtained clock->name with the name list to decide which value
should be set to the Clk_source bit.

==================================================================
ClkSrc_Sel from i.MX6Q reference manual:

Clock source selection, all other settings not shown are reserved:
0000 if (DPLL Locked) SPDIF_RxClk else extal
0001 if (DPLL Locked) SPDIF_RxClk else spdif_clk
0010 if (DPLL Locked) SPDIF_RxClk else asrc_clk
0011 if (DPLL Locked) SPDIF_RxClk else spdif_extclk
0100 if (DPLL Locked) SPDIF_Rxclk else esai_hckt
0101 extal_clk
0110 spdif_clk
0111 asrc_clk
1000 spdif_extclk
1001 esai_hckt
1010 if (DPLL Locked) SPDIF_RxClk else mlb_clk
==================================================================

So the name list here basically is not being used to obtain a
clock like what standardized DT binding does but to provide the
driver a full list to look up which value should be exactly used
according to the obtained clock.

I think I should revise the binding doc for these two lists. It 
might be hard to explain within that kinda short paragraph. 

Surely, if I misunderstand your point, please correct me. And
if you have any sage idea, please guide me.

Thank you,
Nicolin Chen
