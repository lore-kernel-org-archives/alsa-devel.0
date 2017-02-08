From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v4 3/9] clk: sunxi-ng: add support for
	Allwinner H5 SoC
Date: Wed, 8 Feb 2017 09:00:10 +0100
Message-ID: <20170208080010.ntaavpe5wbipn4dl@lukather>
References: <20170207183042.62699-1-icenowy@aosc.xyz>
 <20170207183042.62699-4-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6215953633880306873=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 35AFD26695F
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 09:37:42 +0100 (CET)
In-Reply-To: <20170207183042.62699-4-icenowy@aosc.xyz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-sunxi@googlegroups.com, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Andre Przywara <andre.przywara@arm.com>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6215953633880306873==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zyv3wsxpr673xijb"
Content-Disposition: inline


--zyv3wsxpr673xijb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 08, 2017 at 02:30:36AM +0800, Icenowy Zheng wrote:
> Allwinner H5 is a SoC that features a CCU like H3, but with MMC phase
> clocks removed (for new MMC controller) and a new bus gate/reset
> imported.
>=20
> Add support for it.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Changes since v3:
> - Add a dedicated reset line list for H5, as SCR1 reset is not valid
>   on H3.
>=20
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
>  drivers/clk/sunxi-ng/Kconfig                       |   2 +-
>  drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c             | 206 +++++++++++++++=
+++++-
>  drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.h             |   5 +-
>  include/dt-bindings/clock/sunxi-h3-h5-ccu.h        |   3 +
>  include/dt-bindings/reset/sunxi-h3-h5-ccu.h        |   3 +
>  6 files changed, 215 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Docu=
mentation/devicetree/bindings/clock/sunxi-ccu.txt
> index bae5668cf427..68512aa398a9 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> @@ -10,6 +10,7 @@ Required properties :
>  		- "allwinner,sun8i-v3s-ccu"
>  		- "allwinner,sun9i-a80-ccu"
>  		- "allwinner,sun50i-a64-ccu"
> +		- "allwinner,sun50i-h5-ccu"
> =20
>  - reg: Must contain the registers base address and length
>  - clocks: phandle to the oscillators feeding the CCU. Two are needed:
> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index edc5bbbcb5bb..ec3e5f56b6ec 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -117,7 +117,7 @@ config SUNXI_H3_H5_CCU
>  	select SUNXI_CCU_NM
>  	select SUNXI_CCU_MP
>  	select SUNXI_CCU_PHASE
> -	default MACH_SUN8I
> +	default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
> =20
>  config SUN8I_V3S_CCU
>  	bool "Support for the Allwinner V3s CCU"
> diff --git a/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c b/drivers/clk/sunxi-n=
g/ccu-sunxi-h3-h5.c
> index e2d065973794..360709966e8f 100644
> --- a/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c
> +++ b/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c
> @@ -302,6 +302,8 @@ static SUNXI_CCU_GATE(bus_uart3_clk,	"bus-uart3",	"ap=
b2",
>  		      0x06c, BIT(19), 0);
>  static SUNXI_CCU_GATE(bus_scr0_clk,	"bus-scr0",	"apb2",
>  		      0x06c, BIT(20), 0);
> +static SUNXI_CCU_GATE(bus_scr1_clk,	"bus-scr1",	"apb2",
> +		      0x06c, BIT(21), 0);
> =20
>  static SUNXI_CCU_GATE(bus_ephy_clk,	"bus-ephy",	"ahb1",
>  		      0x070, BIT(0), 0);
> @@ -547,6 +549,7 @@ static struct ccu_common *sunxi_h3_h5_ccu_clks[] =3D {
>  	&bus_uart2_clk.common,
>  	&bus_uart3_clk.common,
>  	&bus_scr0_clk.common,
> +	&bus_scr1_clk.common,

There's only one SCR gate in the H3.

>  	&bus_ephy_clk.common,
>  	&bus_dbg_clk.common,
>  	&ths_clk.common,
> @@ -730,7 +733,186 @@ static struct clk_hw_onecell_data sun8i_h3_hw_clks =
=3D {
>  	.num	=3D CLK_NUMBER,
>  };
> =20
> -static struct ccu_reset_map sunxi_h3_h5_ccu_resets[] =3D {
> +static struct clk_hw_onecell_data sun50i_h5_hw_clks =3D {
> +	.hws	=3D {
> +		[CLK_PLL_CPUX]		=3D &pll_cpux_clk.common.hw,
> +		[CLK_PLL_AUDIO_BASE]	=3D &pll_audio_base_clk.common.hw,
> +		[CLK_PLL_AUDIO]		=3D &pll_audio_clk.hw,
> +		[CLK_PLL_AUDIO_2X]	=3D &pll_audio_2x_clk.hw,
> +		[CLK_PLL_AUDIO_4X]	=3D &pll_audio_4x_clk.hw,
> +		[CLK_PLL_AUDIO_8X]	=3D &pll_audio_8x_clk.hw,
> +		[CLK_PLL_VIDEO]		=3D &pll_video_clk.common.hw,
> +		[CLK_PLL_VE]		=3D &pll_ve_clk.common.hw,
> +		[CLK_PLL_DDR]		=3D &pll_ddr_clk.common.hw,
> +		[CLK_PLL_PERIPH0]	=3D &pll_periph0_clk.common.hw,
> +		[CLK_PLL_PERIPH0_2X]	=3D &pll_periph0_2x_clk.hw,
> +		[CLK_PLL_GPU]		=3D &pll_gpu_clk.common.hw,
> +		[CLK_PLL_PERIPH1]	=3D &pll_periph1_clk.common.hw,
> +		[CLK_PLL_DE]		=3D &pll_de_clk.common.hw,
> +		[CLK_CPUX]		=3D &cpux_clk.common.hw,
> +		[CLK_AXI]		=3D &axi_clk.common.hw,
> +		[CLK_AHB1]		=3D &ahb1_clk.common.hw,
> +		[CLK_APB1]		=3D &apb1_clk.common.hw,
> +		[CLK_APB2]		=3D &apb2_clk.common.hw,
> +		[CLK_AHB2]		=3D &ahb2_clk.common.hw,
> +		[CLK_BUS_CE]		=3D &bus_ce_clk.common.hw,
> +		[CLK_BUS_DMA]		=3D &bus_dma_clk.common.hw,
> +		[CLK_BUS_MMC0]		=3D &bus_mmc0_clk.common.hw,
> +		[CLK_BUS_MMC1]		=3D &bus_mmc1_clk.common.hw,
> +		[CLK_BUS_MMC2]		=3D &bus_mmc2_clk.common.hw,
> +		[CLK_BUS_NAND]		=3D &bus_nand_clk.common.hw,
> +		[CLK_BUS_DRAM]		=3D &bus_dram_clk.common.hw,
> +		[CLK_BUS_EMAC]		=3D &bus_emac_clk.common.hw,
> +		[CLK_BUS_TS]		=3D &bus_ts_clk.common.hw,
> +		[CLK_BUS_HSTIMER]	=3D &bus_hstimer_clk.common.hw,
> +		[CLK_BUS_SPI0]		=3D &bus_spi0_clk.common.hw,
> +		[CLK_BUS_SPI1]		=3D &bus_spi1_clk.common.hw,
> +		[CLK_BUS_OTG]		=3D &bus_otg_clk.common.hw,
> +		[CLK_BUS_EHCI0]		=3D &bus_ehci0_clk.common.hw,
> +		[CLK_BUS_EHCI1]		=3D &bus_ehci1_clk.common.hw,
> +		[CLK_BUS_EHCI2]		=3D &bus_ehci2_clk.common.hw,
> +		[CLK_BUS_EHCI3]		=3D &bus_ehci3_clk.common.hw,
> +		[CLK_BUS_OHCI0]		=3D &bus_ohci0_clk.common.hw,
> +		[CLK_BUS_OHCI1]		=3D &bus_ohci1_clk.common.hw,
> +		[CLK_BUS_OHCI2]		=3D &bus_ohci2_clk.common.hw,
> +		[CLK_BUS_OHCI3]		=3D &bus_ohci3_clk.common.hw,
> +		[CLK_BUS_VE]		=3D &bus_ve_clk.common.hw,
> +		[CLK_BUS_TCON0]		=3D &bus_tcon0_clk.common.hw,
> +		[CLK_BUS_TCON1]		=3D &bus_tcon1_clk.common.hw,
> +		[CLK_BUS_DEINTERLACE]	=3D &bus_deinterlace_clk.common.hw,
> +		[CLK_BUS_CSI]		=3D &bus_csi_clk.common.hw,
> +		[CLK_BUS_TVE]		=3D &bus_tve_clk.common.hw,
> +		[CLK_BUS_HDMI]		=3D &bus_hdmi_clk.common.hw,
> +		[CLK_BUS_DE]		=3D &bus_de_clk.common.hw,
> +		[CLK_BUS_GPU]		=3D &bus_gpu_clk.common.hw,
> +		[CLK_BUS_MSGBOX]	=3D &bus_msgbox_clk.common.hw,
> +		[CLK_BUS_SPINLOCK]	=3D &bus_spinlock_clk.common.hw,
> +		[CLK_BUS_CODEC]		=3D &bus_codec_clk.common.hw,
> +		[CLK_BUS_SPDIF]		=3D &bus_spdif_clk.common.hw,
> +		[CLK_BUS_PIO]		=3D &bus_pio_clk.common.hw,
> +		[CLK_BUS_THS]		=3D &bus_ths_clk.common.hw,
> +		[CLK_BUS_I2S0]		=3D &bus_i2s0_clk.common.hw,
> +		[CLK_BUS_I2S1]		=3D &bus_i2s1_clk.common.hw,
> +		[CLK_BUS_I2S2]		=3D &bus_i2s2_clk.common.hw,
> +		[CLK_BUS_I2C0]		=3D &bus_i2c0_clk.common.hw,
> +		[CLK_BUS_I2C1]		=3D &bus_i2c1_clk.common.hw,
> +		[CLK_BUS_I2C2]		=3D &bus_i2c2_clk.common.hw,
> +		[CLK_BUS_UART0]		=3D &bus_uart0_clk.common.hw,
> +		[CLK_BUS_UART1]		=3D &bus_uart1_clk.common.hw,
> +		[CLK_BUS_UART2]		=3D &bus_uart2_clk.common.hw,
> +		[CLK_BUS_UART3]		=3D &bus_uart3_clk.common.hw,
> +		[CLK_BUS_SCR0]		=3D &bus_scr0_clk.common.hw,
> +		[CLK_BUS_SCR1]		=3D &bus_scr1_clk.common.hw,
> +		[CLK_BUS_EPHY]		=3D &bus_ephy_clk.common.hw,
> +		[CLK_BUS_DBG]		=3D &bus_dbg_clk.common.hw,
> +		[CLK_THS]		=3D &ths_clk.common.hw,
> +		[CLK_NAND]		=3D &nand_clk.common.hw,
> +		[CLK_MMC0]		=3D &mmc0_clk.common.hw,
> +		[CLK_MMC1]		=3D &mmc1_clk.common.hw,
> +		[CLK_MMC2]		=3D &mmc2_clk.common.hw,
> +		[CLK_TS]		=3D &ts_clk.common.hw,
> +		[CLK_CE]		=3D &ce_clk.common.hw,
> +		[CLK_SPI0]		=3D &spi0_clk.common.hw,
> +		[CLK_SPI1]		=3D &spi1_clk.common.hw,
> +		[CLK_I2S0]		=3D &i2s0_clk.common.hw,
> +		[CLK_I2S1]		=3D &i2s1_clk.common.hw,
> +		[CLK_I2S2]		=3D &i2s2_clk.common.hw,
> +		[CLK_SPDIF]		=3D &spdif_clk.common.hw,
> +		[CLK_USB_PHY0]		=3D &usb_phy0_clk.common.hw,
> +		[CLK_USB_PHY1]		=3D &usb_phy1_clk.common.hw,
> +		[CLK_USB_PHY2]		=3D &usb_phy2_clk.common.hw,
> +		[CLK_USB_PHY3]		=3D &usb_phy3_clk.common.hw,
> +		[CLK_USB_OHCI0]		=3D &usb_ohci0_clk.common.hw,
> +		[CLK_USB_OHCI1]		=3D &usb_ohci1_clk.common.hw,
> +		[CLK_USB_OHCI2]		=3D &usb_ohci2_clk.common.hw,
> +		[CLK_USB_OHCI3]		=3D &usb_ohci3_clk.common.hw,
> +		[CLK_DRAM]		=3D &dram_clk.common.hw,
> +		[CLK_DRAM_VE]		=3D &dram_ve_clk.common.hw,
> +		[CLK_DRAM_CSI]		=3D &dram_csi_clk.common.hw,
> +		[CLK_DRAM_DEINTERLACE]	=3D &dram_deinterlace_clk.common.hw,
> +		[CLK_DRAM_TS]		=3D &dram_ts_clk.common.hw,
> +		[CLK_DE]		=3D &de_clk.common.hw,
> +		[CLK_TCON0]		=3D &tcon_clk.common.hw,
> +		[CLK_TVE]		=3D &tve_clk.common.hw,
> +		[CLK_DEINTERLACE]	=3D &deinterlace_clk.common.hw,
> +		[CLK_CSI_MISC]		=3D &csi_misc_clk.common.hw,
> +		[CLK_CSI_SCLK]		=3D &csi_sclk_clk.common.hw,
> +		[CLK_CSI_MCLK]		=3D &csi_mclk_clk.common.hw,
> +		[CLK_VE]		=3D &ve_clk.common.hw,
> +		[CLK_AC_DIG]		=3D &ac_dig_clk.common.hw,
> +		[CLK_AVS]		=3D &avs_clk.common.hw,
> +		[CLK_HDMI]		=3D &hdmi_clk.common.hw,
> +		[CLK_HDMI_DDC]		=3D &hdmi_ddc_clk.common.hw,
> +		[CLK_MBUS]		=3D &mbus_clk.common.hw,
> +		[CLK_GPU]		=3D &gpu_clk.common.hw,
> +	},
> +	.num	=3D CLK_NUMBER,
> +};
> +
> +static struct ccu_reset_map sun8i_h3_ccu_resets[] =3D {
> +	[RST_USB_PHY0]		=3D  { 0x0cc, BIT(0) },
> +	[RST_USB_PHY1]		=3D  { 0x0cc, BIT(1) },
> +	[RST_USB_PHY2]		=3D  { 0x0cc, BIT(2) },
> +	[RST_USB_PHY3]		=3D  { 0x0cc, BIT(3) },
> +
> +	[RST_MBUS]		=3D  { 0x0fc, BIT(31) },
> +
> +	[RST_BUS_CE]		=3D  { 0x2c0, BIT(5) },
> +	[RST_BUS_DMA]		=3D  { 0x2c0, BIT(6) },
> +	[RST_BUS_MMC0]		=3D  { 0x2c0, BIT(8) },
> +	[RST_BUS_MMC1]		=3D  { 0x2c0, BIT(9) },
> +	[RST_BUS_MMC2]		=3D  { 0x2c0, BIT(10) },
> +	[RST_BUS_NAND]		=3D  { 0x2c0, BIT(13) },
> +	[RST_BUS_DRAM]		=3D  { 0x2c0, BIT(14) },
> +	[RST_BUS_EMAC]		=3D  { 0x2c0, BIT(17) },
> +	[RST_BUS_TS]		=3D  { 0x2c0, BIT(18) },
> +	[RST_BUS_HSTIMER]	=3D  { 0x2c0, BIT(19) },
> +	[RST_BUS_SPI0]		=3D  { 0x2c0, BIT(20) },
> +	[RST_BUS_SPI1]		=3D  { 0x2c0, BIT(21) },
> +	[RST_BUS_OTG]		=3D  { 0x2c0, BIT(23) },
> +	[RST_BUS_EHCI0]		=3D  { 0x2c0, BIT(24) },
> +	[RST_BUS_EHCI1]		=3D  { 0x2c0, BIT(25) },
> +	[RST_BUS_EHCI2]		=3D  { 0x2c0, BIT(26) },
> +	[RST_BUS_EHCI3]		=3D  { 0x2c0, BIT(27) },
> +	[RST_BUS_OHCI0]		=3D  { 0x2c0, BIT(28) },
> +	[RST_BUS_OHCI1]		=3D  { 0x2c0, BIT(29) },
> +	[RST_BUS_OHCI2]		=3D  { 0x2c0, BIT(30) },
> +	[RST_BUS_OHCI3]		=3D  { 0x2c0, BIT(31) },
> +
> +	[RST_BUS_VE]		=3D  { 0x2c4, BIT(0) },
> +	[RST_BUS_TCON0]		=3D  { 0x2c4, BIT(3) },
> +	[RST_BUS_TCON1]		=3D  { 0x2c4, BIT(4) },
> +	[RST_BUS_DEINTERLACE]	=3D  { 0x2c4, BIT(5) },
> +	[RST_BUS_CSI]		=3D  { 0x2c4, BIT(8) },
> +	[RST_BUS_TVE]		=3D  { 0x2c4, BIT(9) },
> +	[RST_BUS_HDMI0]		=3D  { 0x2c4, BIT(10) },
> +	[RST_BUS_HDMI1]		=3D  { 0x2c4, BIT(11) },
> +	[RST_BUS_DE]		=3D  { 0x2c4, BIT(12) },
> +	[RST_BUS_GPU]		=3D  { 0x2c4, BIT(20) },
> +	[RST_BUS_MSGBOX]	=3D  { 0x2c4, BIT(21) },
> +	[RST_BUS_SPINLOCK]	=3D  { 0x2c4, BIT(22) },
> +	[RST_BUS_DBG]		=3D  { 0x2c4, BIT(31) },
> +
> +	[RST_BUS_EPHY]		=3D  { 0x2c8, BIT(2) },
> +
> +	[RST_BUS_CODEC]		=3D  { 0x2d0, BIT(0) },
> +	[RST_BUS_SPDIF]		=3D  { 0x2d0, BIT(1) },
> +	[RST_BUS_THS]		=3D  { 0x2d0, BIT(8) },
> +	[RST_BUS_I2S0]		=3D  { 0x2d0, BIT(12) },
> +	[RST_BUS_I2S1]		=3D  { 0x2d0, BIT(13) },
> +	[RST_BUS_I2S2]		=3D  { 0x2d0, BIT(14) },
> +
> +	[RST_BUS_I2C0]		=3D  { 0x2d8, BIT(0) },
> +	[RST_BUS_I2C1]		=3D  { 0x2d8, BIT(1) },
> +	[RST_BUS_I2C2]		=3D  { 0x2d8, BIT(2) },
> +	[RST_BUS_UART0]		=3D  { 0x2d8, BIT(16) },
> +	[RST_BUS_UART1]		=3D  { 0x2d8, BIT(17) },
> +	[RST_BUS_UART2]		=3D  { 0x2d8, BIT(18) },
> +	[RST_BUS_UART3]		=3D  { 0x2d8, BIT(19) },
> +	[RST_BUS_SCR0]		=3D  { 0x2d8, BIT(20) },
> +};
> +
> +static struct ccu_reset_map sun50i_h5_ccu_resets[] =3D {
>  	[RST_USB_PHY0]		=3D  { 0x0cc, BIT(0) },
>  	[RST_USB_PHY1]		=3D  { 0x0cc, BIT(1) },
>  	[RST_USB_PHY2]		=3D  { 0x0cc, BIT(2) },
> @@ -791,6 +973,7 @@ static struct ccu_reset_map sunxi_h3_h5_ccu_resets[] =
=3D {
>  	[RST_BUS_UART2]		=3D  { 0x2d8, BIT(18) },
>  	[RST_BUS_UART3]		=3D  { 0x2d8, BIT(19) },
>  	[RST_BUS_SCR0]		=3D  { 0x2d8, BIT(20) },
> +	[RST_BUS_SCR1]		=3D  { 0x2d8, BIT(21) },
>  };
> =20
>  static const struct sunxi_ccu_desc sun8i_h3_ccu_desc =3D {
> @@ -799,8 +982,18 @@ static const struct sunxi_ccu_desc sun8i_h3_ccu_desc=
 =3D {
> =20
>  	.hw_clks	=3D &sun8i_h3_hw_clks,
> =20
> -	.resets		=3D sunxi_h3_h5_ccu_resets,
> -	.num_resets	=3D ARRAY_SIZE(sunxi_h3_h5_ccu_resets),
> +	.resets		=3D sun8i_h3_ccu_resets,
> +	.num_resets	=3D ARRAY_SIZE(sun8i_h3_ccu_resets),
> +};
> +
> +static const struct sunxi_ccu_desc sun50i_h5_ccu_desc =3D {
> +	.ccu_clks	=3D sunxi_h3_h5_ccu_clks,
> +	.num_ccu_clks	=3D ARRAY_SIZE(sunxi_h3_h5_ccu_clks),
> +
> +	.hw_clks	=3D &sun50i_h5_hw_clks,
> +
> +	.resets		=3D sun50i_h5_ccu_resets,
> +	.num_resets	=3D ARRAY_SIZE(sun50i_h5_ccu_resets),
>  };
> =20
>  static struct ccu_mux_nb sunxi_h3_h5_cpu_nb =3D {
> @@ -840,3 +1033,10 @@ static void __init sun8i_h3_ccu_setup(struct device=
_node *node)
>  }
>  CLK_OF_DECLARE(sun8i_h3_ccu, "allwinner,sun8i-h3-ccu",
>  	       sun8i_h3_ccu_setup);
> +
> +static void __init sun50i_h5_ccu_setup(struct device_node *node)
> +{
> +	sunxi_h3_h5_ccu_init(node, &sun50i_h5_ccu_desc);
> +}
> +CLK_OF_DECLARE(sun50i_h5_ccu, "allwinner,sun50i-h5-ccu",
> +	       sun50i_h5_ccu_setup);
> diff --git a/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.h b/drivers/clk/sunxi-n=
g/ccu-sunxi-h3-h5.h
> index e2a4656d2cf3..e5a78cc66d6b 100644
> --- a/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.h
> +++ b/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.h
> @@ -57,6 +57,9 @@
> =20
>  /* And the GPU module clock is exported */
> =20
> -#define CLK_NUMBER		(CLK_GPU + 1)
> +/* New clocks imported in H5 */

H5 clocks seems more natural, and you don't have to put it twice.

> +/* The SCR1 bus gate is exported */
> +
> +#define CLK_NUMBER		(CLK_BUS_SCR1 + 1)

This introduces an off-by-one error on the H3

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--zyv3wsxpr673xijb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYmtAGAAoJEBx+YmzsjxAgvjcP/1PUDU15VR1vZG8S8aaU5GRK
8nByVE/xyhCGUEr7R+DvL3I4aQqMs+TebXtYP3U7rXNuKXNL+GPmNeQcQjjUGfbh
gBqfJqP7XCWm1GUQLOD2WnYkw99CBRjG2pqba1owzNR+FqJtJz2mcvEPh3WKpk/g
KQe6ODAFek2G1+0wHgVXZrDT3s5KbRx//YSRseMwmqx5/x/5nu+8AXnuE7EvLsUC
HyNNr4uvzvsZvgvqpDbjh60SedSfNLj1whXGYsf8xM7urpsyKLlQKwtDunI5Bq64
Zo9nJJS0ZrzY0/cOsUf4PzFYq3nqlPRgS6DqgIlW79cu431MC3I+OLT8vKb0CMan
truab30LulHOOTm/Oqr4ciLvuKoFcXehjRbi66uVPzUEZ20tFTSsRmof2sgwhm43
B5Qm4YDb2WS3xifmfkv0+C//ObkiGCYoaYgex4bkLxJIN/waoQv0VK0PZjXUPB0G
KBKqPwBU93SU671gbWshbBE6/C3BgryOJwklRoW9FYHRnBYVpeWD+6AO3pv6y9I8
GdeJ66c4xec5pH78SIhTi5a72YAVn1S/2rO0p9j3UYIqJ028qCAmp6MLfNUiQUMS
y/Ik3muH/l07rfWMp/U7NJB7X27wu9l3BFFqD4ZqrAG6myu0+FpcNEG8bbg+guLJ
xm4e1we6YBzNGd/4XTTC
=ArGp
-----END PGP SIGNATURE-----

--zyv3wsxpr673xijb--

--===============6215953633880306873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6215953633880306873==--
