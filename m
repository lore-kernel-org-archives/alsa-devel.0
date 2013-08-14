From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 resent 1/2] ASoC: fsl: Add S/PDIF CPU
	DAI driver
Date: Wed, 14 Aug 2013 09:50:17 +0200
Message-ID: <20130814075017.GE2324@pengutronix.de>
References: <cover.1376309076.git.b42378@freescale.com>
 <51808310dd97d2a35a28766ed7309f269521cafd.1376309076.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 4A411261A42
 for <alsa-devel@alsa-project.org>; Wed, 14 Aug 2013 09:50:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51808310dd97d2a35a28766ed7309f269521cafd.1376309076.git.b42378@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org, p.zabel@pengutronix.de, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 12, 2013 at 08:05:27PM +0800, Nicolin Chen wrote:
> This patch add S/PDIF controller driver for Freescale SoC.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> +
> +Required properties:
> +
> +  - compatible : Compatible list, contains "fsl,<chip>-spdif". Using general
> +  "fsl,fsl-spdif" will get the default SoC type -- imx6q-spdif.
> +
> +  - reg : Offset and length of the register set for the device.
> +
> +  - interrupts : Contains spdif interrupt.
> +
> +  - dmas : Generic dma devicetree binding as described in
> +  Documentation/devicetree/bindings/dma/dma.txt.
> +
> +  - dma-names : Two dmas have to be defined, "tx" and "rx".
> +
> +  - clocks : Contains an entry for each entry in clock-names.
> +
> +  - clock-names : Includes the following entries:
> +	name		type		comments
> +	"core"		Required	The core clock of spdif controller
> +	"rx"		Optional	Rx clock source for spdif record.
> +					If absent, will use core clock.
> +	"tx"		Optional	Tx clock source for spdif playback.
> +					If absent, will use core clock.
> +	"tx-32000"	Optional	Tx clock source for 32000Hz sample rate
> +					playback. If absent, will use tx clock.
> +	"tx-44100"	Optional	Tx clock source for 44100Hz sample rate
> +					playback. If absent, will use tx clock.
> +	"tx-48000"	Optional	Tx clock source for 48000Hz sample rate
> +					playback. If absent, will use tx clock.
> +
> +  - tx-clksrc-names : The names for all available clock sources for tx, which
> +  is also being listed in SoC reference manual, ClkSrc_Sel bit of SPDIF_SRPC.
> +  And the name list would be different between different SoC. Use 'null' for
> +  those unlisted names, and the max number of tx-clksrc-names should be 8.
> +
> +  - rx-clksrc-names : The names for all available clock sources for rx, which
> +  is also being listed in SoC reference manual, TxClk_Source bit of SPDIF_STC.
> +  And the name list would be different between different SoC. Use 'null' for
> +  those unlisted names, and the max number of rx-clksrc-names should be 16.
> +
> +Optional properties:
> +
> +  - rx-clksrc-lock: This is a boolean property. If present, ClkSrc_Sel bit
> +  of SPDIF_SRPC would be set a clock source that cares DPLL locked condition.
> +
> +Example1:
> +
> +spdif: spdif@02004000 {
> +	compatible = "fsl,imx6q-spdif";
> +	reg = <0x02004000 0x4000>;
> +	interrupts = <0 52 0x04>;
> +	dmas = <&sdma 14 18 0>,
> +	       <&sdma 15 18 0>;
> +	dma-names = "rx", "tx";
> +
> +	clocks = <&clks 197>;
> +	clock-names = "core";
> +	rx-clksrc-lock;
> +	rx-clksrc-names =
> +		"lock.ext", "lock.spdif", "lock.asrc",
> +		"lock.spdif_ext", "lock.esai", "ext",
> +		"spdif", "asrc", "spdif_ext", "esai",
> +		"lock.mlb", "lock.mlb_phy", "mlb",
> +		"mlb_phy";
> +	tx-clksrc-names =
> +		"xtal", "spdif", "asrc", "spdif_ext",
> +		"esai", "ipg", "mlb", "mlb_phy";

I had a hard time understanding what you are doing here.

With this the clk names in arch/arm/mach-imx/clk-imx6q.c become an API
between the Kernel and the devicetree. Don't do that.

There is a standardized devicetree binding for clocks. Use it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
