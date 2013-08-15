From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v4 resent 1/2] ASoC: fsl: Add S/PDIF CPU
 DAI driver
Date: Thu, 15 Aug 2013 10:33:32 +0800
Message-ID: <20130815023331.GC1846@MrMyself>
References: <cover.1376309076.git.b42378@freescale.com>
 <51808310dd97d2a35a28766ed7309f269521cafd.1376309076.git.b42378@freescale.com>
 <20130814075017.GE2324@pengutronix.de>
 <20130814084801.GH31651@MrMyself>
 <20130814095652.GX26614@pengutronix.de>
 <20130814102346.GK31651@MrMyself>
 <20130814121937.GY26614@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 by alsa0.perex.cz (Postfix) with ESMTP id A46A1261A66
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2013 04:43:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130814121937.GY26614@pengutronix.de>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 14, 2013 at 02:19:37PM +0200, Sascha Hauer wrote:
> Yes, since the clk names are not an API. Exposing them to the devicetree
> is not an option. The fact that the names are defined in
> arch/arm/mach-imx/clk-imx6q.c and are used in the spdif driver makes
> this really clear.
> 
> The spdif core has 8 input clocks which have to be described in the
> devicetree. Nobody says the mapping which clock name corresponds to
> which bit combination has to be in the devicetree.

Thank you for the explain. I get your point and really appreciate it.

> Look at the possible clocks:
> 
> 0000 if (DPLL Locked) SPDIF_RxClk else extal
> 0001 if (DPLL Locked) SPDIF_RxClk else spdif_clk
> 0010 if (DPLL Locked) SPDIF_RxClk else asrc_clk
> 0011 if (DPLL Locked) SPDIF_RxClk else spdif_extclk
> 0100 if (DPLL Locked) SPDIF_Rxclk else esai_hckt
> 0101 extal_clk
> 0110 spdif_clk
> 0111 asrc_clk
> 1000 spdif_extclk
> 1001 esai_hckt
> 1010 if (DPLL Locked) SPDIF_RxClk else mlb_clk
> 1011 if (DPLL Locked) SPDIF_RxClk else mlb_phy_clk
> 1100 mkb_clk
> 1101 mlb_phy_clk
> 
> Only half of them actually are clocks. "if (DPLL Locked) SPDIF_RxClk
> else ..." is not a clock. Every sane hardware developer would have
> introduced a mux with 8 entries and an additional "Use DPLL if possible"
> bit. Now this is not the case here so we have to live with it and
> maintain the above table in the driver. And another one for the i.MX35
> and still another one for i.MX53.

I think I just have an idea for the table. I'll put them into the
next version. Please take a look after I send it.

Thank you,
Nicolin Chen
 
