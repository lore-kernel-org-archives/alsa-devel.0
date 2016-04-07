From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 6/6] ARM: DTS: da850: Add McBSP0 and McBSP1
Date: Thu, 7 Apr 2016 14:34:12 +0300
Message-ID: <570645B4.6060606@ti.com>
References: <1459948893-4206-1-git-send-email-petr@barix.com>
 <1459948893-4206-7-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EA1B264F34
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 13:34:20 +0200 (CEST)
In-Reply-To: <1459948893-4206-7-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, nsekhar@ti.com, khilman@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 04/06/16 16:21, Petr Kulhavy wrote:
> Add SoC nodes for McBSP0 and McBSP1 as well as the corresponding pinmux
> configurations.
> =

> Signed-off-by: Petr Kulhavy <petr@barix.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 45 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> =

> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index 5996e765e59c..9e2b1e97377c 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -148,7 +148,24 @@
>  					0xc 0x88888888 0xffffffff
>  				>;
>  			};
> -
> +			mcbsp0_pins: pinmux_mcbsp0_pins {
> +				pinctrl-single,bits =3D <
> +					/* PINMUX2:
> +					* CLKS0, DX0, DR0, FSX0
> +					* FSR0, CLKX0, CLKR0
> +					*/
> +					0x8 0x02222220 0xfffffff0
> +				>;
> +			};
> +			mcbsp1_pins: pinmux_mcbsp1_pins {
> +				pinctrl-single,bits =3D <
> +					/* PINMUX1:
> +					* CLKS1, DX1, DR1, FSX1,
> +					* FSR1, CLKX1, CLKR1
> +					*/
> +					0x4 0x22222220 0xfffffff0

This will conflict with the mcasp0_pins in da850-evm as AXR11 and AXR12 is
used by the board for audio. When I say conflict, I mean that audio will be
completely broken on the board.

> +				>;
> +			};
>  		};
>  		edma0: edma@01c00000 {
>  			compatible =3D "ti,edma3-tpcc";
> @@ -335,6 +352,32 @@
>  				<&edma0 0 1>;
>  			dma-names =3D "tx", "rx";
>  		};
> +
> +		mcbsp0: mcbsp@1d10000 {
> +			compatible =3D "ti,da850-mcbsp-audio";
> +			reg =3D	<0x00110000 0x1000>,
> +				<0x00310000 0x1000>;
> +			reg-names =3D "mpu", "dat";
> +			interrupts =3D <97 98>;
> +			interrupts-names =3D "rx", "tx";
> +			dmas =3D <&edma0 3
> +				&edma0 2>;

This will not work since the eDMA now has the new binding in use, you need =
to
have:
			dmas =3D <&edma0 3 1>,
				<&edma0 2 1>;

McBSP should also select the higher priority TPTC as the McASP does.

> +			dma-names =3D "tx", "rx";
> +			status =3D "disabled";
> +		};
> +		mcbsp1: mcbsp@1d11000 {
> +			compatible =3D "ti,da850-mcbsp-audio";
> +			reg =3D	<0x00111000 0x1000>,
> +				<0x00311000 0x1000>;
> +			reg-names =3D "mpu", "dat";
> +			interrupts =3D <99 100>;
> +			interrupts-names =3D "rx", "tx";
> +			dmas =3D <&edma0 5
> +				&edma0 4>;

Same here.

> +			dma-names =3D "tx", "rx";
> +			status =3D "disabled";
> +		};
> +
>  	};
>  	nand_cs3@62000000 {
>  		compatible =3D "ti,davinci-nand";
> =



-- =

P=E9ter
