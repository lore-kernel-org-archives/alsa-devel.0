From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: Re: [PATCH v3 04/10] clk: sunxi-ng: add support for
 Allwinner H5 SoC
Date: Mon, 30 Jan 2017 22:02:04 +0800
Message-ID: <20170207000838.8UJeKISe@smtp2p.mail.yandex.net>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBYWL4PCAKGQEQA5QDJI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


2017=E5=B9=B41=E6=9C=8830=E6=97=A5 17:04=E4=BA=8E Maxime Ripard <maxime.rip=
ard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Jan 29, 2017 at 10:33:25AM +0800, Icenowy Zheng wrote:=20
> > Allwinner H5 is a SoC that features a CCU like H3, but with MMC phase=
=20
> > clocks removed (for new MMC controller) and a new bus gate/reset=20
> > imported.=20
> >=20
> > Add support for it.=20
> >=20
> > Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>=20
> > ---=20
> > See the comments of the previous patch.=20
> >=20
> >=C2=A0 .../devicetree/bindings/clock/sunxi-ccu.txt=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +=20
> >=C2=A0 drivers/clk/sunxi-ng/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-=20
> >=C2=A0 drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 137 +++++++++++++++++++++=
=20
> >=C2=A0 drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-=20
> >=C2=A0 include/dt-bindings/clock/sunxi-h3-h5-ccu.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +=20
> >=C2=A0 include/dt-bindings/reset/sunxi-h3-h5-ccu.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +=20
> >=C2=A0 6 files changed, 149 insertions(+), 2 deletions(-)=20
> >=20
> > diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Do=
cumentation/devicetree/bindings/clock/sunxi-ccu.txt=20
> > index f6032cf63f12..a33a4a5ecffa 100644=20
> > --- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt=20
> > +++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt=20
> > @@ -9,6 +9,7 @@ Required properties :=20
> >=C2=A0 - "allwinner,sun8i-h3-ccu"=20
> >=C2=A0 - "allwinner,sun8i-v3s-ccu"=20
> >=C2=A0 - "allwinner,sun50i-a64-ccu"=20
> > + - "allwinner,sun50i-h5-ccu"=20
> >=C2=A0=20
> >=C2=A0 - reg: Must contain the registers base address and length=20
> >=C2=A0 - clocks: phandle to the oscillators feeding the CCU. Two are nee=
ded:=20
> > diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfi=
g=20
> > index 4be083ae717f..bdf18e846731 100644=20
> > --- a/drivers/clk/sunxi-ng/Kconfig=20
> > +++ b/drivers/clk/sunxi-ng/Kconfig=20
> > @@ -117,7 +117,7 @@ config SUNXI_H3_H5_CCU=20
> >=C2=A0 select SUNXI_CCU_NM=20
> >=C2=A0 select SUNXI_CCU_MP=20
> >=C2=A0 select SUNXI_CCU_PHASE=20
> > - default MACH_SUN8I=20
> > + default MACH_SUN8I || (ARM64 && ARCH_SUNXI)=20
> >=C2=A0=20
> >=C2=A0 config SUN8I_V3S_CCU=20
> >=C2=A0 bool "Support for the Allwinner V3s CCU"=20
> > diff --git a/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c b/drivers/clk/sunxi=
-ng/ccu-sunxi-h3-h5.c=20
> > index be63b56315f5..b7b9f85f5c9f 100644=20
> > --- a/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c=20
> > +++ b/drivers/clk/sunxi-ng/ccu-sunxi-h3-h5.c=20
> > @@ -302,6 +302,8 @@ static SUNXI_CCU_GATE(bus_uart3_clk, "bus-uart3", "=
apb2",=20
> >=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x06c, BIT(19), 0);=20
> >=C2=A0 static SUNXI_CCU_GATE(bus_scr0_clk, "bus-scr0", "apb2",=20
> >=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x06c, BIT(20), 0);=20
> > +static SUNXI_CCU_GATE(bus_scr1_clk, "bus-scr1", "apb2",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x06c, BIT(21), 0);=20
> >=C2=A0=20
> >=C2=A0 static SUNXI_CCU_GATE(bus_ephy_clk, "bus-ephy", "ahb1",=20
> >=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x070, BIT(0), 0);=20
> > @@ -547,6 +549,7 @@ static struct ccu_common *sunxi_h3_h5_ccu_clks[] =
=3D {=20
> >=C2=A0 &bus_uart2_clk.common,=20
> >=C2=A0 &bus_uart3_clk.common,=20
> >=C2=A0 &bus_scr0_clk.common,=20
> > + &bus_scr1_clk.common,=20
> >=C2=A0 &bus_ephy_clk.common,=20
> >=C2=A0 &bus_dbg_clk.common,=20
> >=C2=A0 &ths_clk.common,=20
> > @@ -730,6 +733,122 @@ static struct clk_hw_onecell_data sun8i_h3_hw_clk=
s =3D {=20
> >=C2=A0 .num =3D CLK_NUMBER,=20
> >=C2=A0 };=20
> >=C2=A0=20
> > +static struct clk_hw_onecell_data sun50i_h5_hw_clks =3D {=20
> > + .hws =3D {=20
> > + [CLK_PLL_CPUX] =3D &pll_cpux_clk.common.hw,=20
> > + [CLK_PLL_AUDIO_BASE] =3D &pll_audio_base_clk.common.hw,=20
> > + [CLK_PLL_AUDIO] =3D &pll_audio_clk.hw,=20
> > + [CLK_PLL_AUDIO_2X] =3D &pll_audio_2x_clk.hw,=20
> > + [CLK_PLL_AUDIO_4X] =3D &pll_audio_4x_clk.hw,=20
> > + [CLK_PLL_AUDIO_8X] =3D &pll_audio_8x_clk.hw,=20
> > + [CLK_PLL_VIDEO] =3D &pll_video_clk.common.hw,=20
> > + [CLK_PLL_VE] =3D &pll_ve_clk.common.hw,=20
> > + [CLK_PLL_DDR] =3D &pll_ddr_clk.common.hw,=20
> > + [CLK_PLL_PERIPH0] =3D &pll_periph0_clk.common.hw,=20
> > + [CLK_PLL_PERIPH0_2X] =3D &pll_periph0_2x_clk.hw,=20
> > + [CLK_PLL_GPU] =3D &pll_gpu_clk.common.hw,=20
> > + [CLK_PLL_PERIPH1] =3D &pll_periph1_clk.common.hw,=20
> > + [CLK_PLL_DE] =3D &pll_de_clk.common.hw,=20
> > + [CLK_CPUX] =3D &cpux_clk.common.hw,=20
> > + [CLK_AXI] =3D &axi_clk.common.hw,=20
> > + [CLK_AHB1] =3D &ahb1_clk.common.hw,=20
> > + [CLK_APB1] =3D &apb1_clk.common.hw,=20
> > + [CLK_APB2] =3D &apb2_clk.common.hw,=20
> > + [CLK_AHB2] =3D &ahb2_clk.common.hw,=20
> > + [CLK_BUS_CE] =3D &bus_ce_clk.common.hw,=20
> > + [CLK_BUS_DMA] =3D &bus_dma_clk.common.hw,=20
> > + [CLK_BUS_MMC0] =3D &bus_mmc0_clk.common.hw,=20
> > + [CLK_BUS_MMC1] =3D &bus_mmc1_clk.common.hw,=20
> > + [CLK_BUS_MMC2] =3D &bus_mmc2_clk.common.hw,=20
> > + [CLK_BUS_NAND] =3D &bus_nand_clk.common.hw,=20
> > + [CLK_BUS_DRAM] =3D &bus_dram_clk.common.hw,=20
> > + [CLK_BUS_EMAC] =3D &bus_emac_clk.common.hw,=20
> > + [CLK_BUS_TS] =3D &bus_ts_clk.common.hw,=20
> > + [CLK_BUS_HSTIMER] =3D &bus_hstimer_clk.common.hw,=20
> > + [CLK_BUS_SPI0] =3D &bus_spi0_clk.common.hw,=20
> > + [CLK_BUS_SPI1] =3D &bus_spi1_clk.common.hw,=20
> > + [CLK_BUS_OTG] =3D &bus_otg_clk.common.hw,=20
> > + [CLK_BUS_EHCI0] =3D &bus_ehci0_clk.common.hw,=20
> > + [CLK_BUS_EHCI1] =3D &bus_ehci1_clk.common.hw,=20
> > + [CLK_BUS_EHCI2] =3D &bus_ehci2_clk.common.hw,=20
> > + [CLK_BUS_EHCI3] =3D &bus_ehci3_clk.common.hw,=20
> > + [CLK_BUS_OHCI0] =3D &bus_ohci0_clk.common.hw,=20
> > + [CLK_BUS_OHCI1] =3D &bus_ohci1_clk.common.hw,=20
> > + [CLK_BUS_OHCI2] =3D &bus_ohci2_clk.common.hw,=20
> > + [CLK_BUS_OHCI3] =3D &bus_ohci3_clk.common.hw,=20
> > + [CLK_BUS_VE] =3D &bus_ve_clk.common.hw,=20
> > + [CLK_BUS_TCON0] =3D &bus_tcon0_clk.common.hw,=20
> > + [CLK_BUS_TCON1] =3D &bus_tcon1_clk.common.hw,=20
> > + [CLK_BUS_DEINTERLACE] =3D &bus_deinterlace_clk.common.hw,=20
> > + [CLK_BUS_CSI] =3D &bus_csi_clk.common.hw,=20
> > + [CLK_BUS_TVE] =3D &bus_tve_clk.common.hw,=20
> > + [CLK_BUS_HDMI] =3D &bus_hdmi_clk.common.hw,=20
> > + [CLK_BUS_DE] =3D &bus_de_clk.common.hw,=20
> > + [CLK_BUS_GPU] =3D &bus_gpu_clk.common.hw,=20
> > + [CLK_BUS_MSGBOX] =3D &bus_msgbox_clk.common.hw,=20
> > + [CLK_BUS_SPINLOCK] =3D &bus_spinlock_clk.common.hw,=20
> > + [CLK_BUS_CODEC] =3D &bus_codec_clk.common.hw,=20
> > + [CLK_BUS_SPDIF] =3D &bus_spdif_clk.common.hw,=20
> > + [CLK_BUS_PIO] =3D &bus_pio_clk.common.hw,=20
> > + [CLK_BUS_THS] =3D &bus_ths_clk.common.hw,=20
> > + [CLK_BUS_I2S0] =3D &bus_i2s0_clk.common.hw,=20
> > + [CLK_BUS_I2S1] =3D &bus_i2s1_clk.common.hw,=20
> > + [CLK_BUS_I2S2] =3D &bus_i2s2_clk.common.hw,=20
> > + [CLK_BUS_I2C0] =3D &bus_i2c0_clk.common.hw,=20
> > + [CLK_BUS_I2C1] =3D &bus_i2c1_clk.common.hw,=20
> > + [CLK_BUS_I2C2] =3D &bus_i2c2_clk.common.hw,=20
> > + [CLK_BUS_UART0] =3D &bus_uart0_clk.common.hw,=20
> > + [CLK_BUS_UART1] =3D &bus_uart1_clk.common.hw,=20
> > + [CLK_BUS_UART2] =3D &bus_uart2_clk.common.hw,=20
> > + [CLK_BUS_UART3] =3D &bus_uart3_clk.common.hw,=20
> > + [CLK_BUS_SCR0] =3D &bus_scr0_clk.common.hw,=20
> > + [CLK_BUS_SCR1] =3D &bus_scr1_clk.common.hw,=20
> > + [CLK_BUS_EPHY] =3D &bus_ephy_clk.common.hw,=20
> > + [CLK_BUS_DBG] =3D &bus_dbg_clk.common.hw,=20
> > + [CLK_THS] =3D &ths_clk.common.hw,=20
> > + [CLK_NAND] =3D &nand_clk.common.hw,=20
> > + [CLK_MMC0] =3D &mmc0_clk.common.hw,=20
> > + [CLK_MMC1] =3D &mmc1_clk.common.hw,=20
> > + [CLK_MMC2] =3D &mmc2_clk.common.hw,=20
> > + [CLK_TS] =3D &ts_clk.common.hw,=20
> > + [CLK_CE] =3D &ce_clk.common.hw,=20
> > + [CLK_SPI0] =3D &spi0_clk.common.hw,=20
> > + [CLK_SPI1] =3D &spi1_clk.common.hw,=20
> > + [CLK_I2S0] =3D &i2s0_clk.common.hw,=20
> > + [CLK_I2S1] =3D &i2s1_clk.common.hw,=20
> > + [CLK_I2S2] =3D &i2s2_clk.common.hw,=20
> > + [CLK_SPDIF] =3D &spdif_clk.common.hw,=20
> > + [CLK_USB_PHY0] =3D &usb_phy0_clk.common.hw,=20
> > + [CLK_USB_PHY1] =3D &usb_phy1_clk.common.hw,=20
> > + [CLK_USB_PHY2] =3D &usb_phy2_clk.common.hw,=20
> > + [CLK_USB_PHY3] =3D &usb_phy3_clk.common.hw,=20
> > + [CLK_USB_OHCI0] =3D &usb_ohci0_clk.common.hw,=20
> > + [CLK_USB_OHCI1] =3D &usb_ohci1_clk.common.hw,=20
> > + [CLK_USB_OHCI2] =3D &usb_ohci2_clk.common.hw,=20
> > + [CLK_USB_OHCI3] =3D &usb_ohci3_clk.common.hw,=20
> > + [CLK_DRAM] =3D &dram_clk.common.hw,=20
> > + [CLK_DRAM_VE] =3D &dram_ve_clk.common.hw,=20
> > + [CLK_DRAM_CSI] =3D &dram_csi_clk.common.hw,=20
> > + [CLK_DRAM_DEINTERLACE] =3D &dram_deinterlace_clk.common.hw,=20
> > + [CLK_DRAM_TS] =3D &dram_ts_clk.common.hw,=20
> > + [CLK_DE] =3D &de_clk.common.hw,=20
> > + [CLK_TCON0] =3D &tcon_clk.common.hw,=20
> > + [CLK_TVE] =3D &tve_clk.common.hw,=20
> > + [CLK_DEINTERLACE] =3D &deinterlace_clk.common.hw,=20
> > + [CLK_CSI_MISC] =3D &csi_misc_clk.common.hw,=20
> > + [CLK_CSI_SCLK] =3D &csi_sclk_clk.common.hw,=20
> > + [CLK_CSI_MCLK] =3D &csi_mclk_clk.common.hw,=20
> > + [CLK_VE] =3D &ve_clk.common.hw,=20
> > + [CLK_AC_DIG] =3D &ac_dig_clk.common.hw,=20
> > + [CLK_AVS] =3D &avs_clk.common.hw,=20
> > + [CLK_HDMI] =3D &hdmi_clk.common.hw,=20
> > + [CLK_HDMI_DDC] =3D &hdmi_ddc_clk.common.hw,=20
> > + [CLK_MBUS] =3D &mbus_clk.common.hw,=20
> > + [CLK_GPU] =3D &gpu_clk.common.hw,=20
> > + },=20
> > + .num =3D CLK_NUMBER,=20
> > +};=20
> > +=20
> >=C2=A0 static struct ccu_reset_map sunxi_h3_h5_ccu_resets[] =3D {=20
> >=C2=A0 [RST_USB_PHY0] =3D=C2=A0 { 0x0cc, BIT(0) },=20
> >=C2=A0 [RST_USB_PHY1] =3D=C2=A0 { 0x0cc, BIT(1) },=20
> > @@ -791,6 +910,7 @@ static struct ccu_reset_map sunxi_h3_h5_ccu_resets[=
] =3D {=20
> >=C2=A0 [RST_BUS_UART2] =3D=C2=A0 { 0x2d8, BIT(18) },=20
> >=C2=A0 [RST_BUS_UART3] =3D=C2=A0 { 0x2d8, BIT(19) },=20
> >=C2=A0 [RST_BUS_SCR0] =3D=C2=A0 { 0x2d8, BIT(20) },=20
> > + [RST_BUS_SCR1] =3D=C2=A0 { 0x2d8, BIT(21) },=20
>
> That reset line is not valid on the H3.=20

So I should split a H3 reset array and a H5 one?

(I modelled after ccu-sun5i.c, which shares one reset array)

>
> Thanks,=20
> Maxime=20
>
> --=20
> Maxime Ripard, Free Electrons=20
> Embedded Linux and Kernel engineering=20
> http://free-electrons.com=20
>
> --=20
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.=20
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org=20
> For more options, visit https://groups.google.com/d/optout.=20

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
