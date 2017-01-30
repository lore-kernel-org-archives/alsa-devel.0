From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: Re: Re: [PATCH v3 05/10] arm: dts: sun8i: split
 Allwinner H3 .dtsi
Date: Mon, 30 Jan 2017 14:26:55 +0800
Message-ID: <20170130092704.QsWSQuEM@smtp2j.mail.yandex.net>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBBUNZXPCAKGQEAIYR27Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: =?ISO-8859-1?Q?Andr=E9_Przywara?= <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


2017=E5=B9=B41=E6=9C=8830=E6=97=A5 09:42=E4=BA=8E Andr=C3=A9 Przywara <andr=
e.przywara-5wv7dgnIgG8@public.gmane.org>=E5=86=99=E9=81=93=EF=BC=9A
>
> On 29/01/17 02:33, Icenowy Zheng wrote:=20
> > From: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>=20
>
> (Adding DT folks to CC:)=20
>
> see below ...=20
>
> > The new Allwinner H5 SoC is pin-compatible to the H3 SoC, but with the=
=20
> > Cortex-A7 cores replaced by Cortex-A53 cores and the MMC controller=20
> > updated. So we should really share almost the whole .dtsi.=20
> > In preparation for that move the peripheral parts of the existing=20
> > sun8i-h3.dtsi into a new sun8i-h3-h5.dtsi.=20
> > The actual sun8i-h3.dtsi then includes that and defines the H3 specific=
=20
> > parts on top of it.=20
> > On the way get rid of skeleton.dtsi, as recommended in that very file.=
=20
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>=20
> > [Icenowy: also split out mmc, as well as pio and ccu's compatible]=20
> > Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>=20
> > ---=20
> > Changes in v3:=20
> > - Use label-based syntax to reference nodes in H3 DTSI file.=20
> > Changes in v2:=20
> > - Rebase on current linux-next (because of the add of audio codec)=20
> >=20
> >=C2=A0 arch/arm/boot/dts/sun8i-h3.dtsi=C2=A0=C2=A0=C2=A0 | 571 +++------=
----------------------------=20
> >=C2=A0 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 557 ++++++++++++++++++++++++=
++++++++++++=20
> >=C2=A0 2 files changed, 598 insertions(+), 530 deletions(-)=20
> >=C2=A0 create mode 100644 arch/arm/boot/dts/sunxi-h3-h5.dtsi=20
> >=20
> > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-=
h3.dtsi=20
> > index 08fd0860bb6b..f3a3033789b9 100644=20
> > --- a/arch/arm/boot/dts/sun8i-h3.dtsi=20
> > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi=20
> > @@ -40,12 +40,7 @@=20
> >=C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0 OTHER DEALINGS IN THE SOFTWARE.=
=20
> >=C2=A0=C2=A0 */=20
> >=C2=A0=20
> > -#include "skeleton.dtsi"=20
> > -=20
> > -#include <dt-bindings/clock/sun8i-h3-ccu.h>=20
> > -#include <dt-bindings/interrupt-controller/arm-gic.h>=20
> > -#include <dt-bindings/pinctrl/sun4i-a10.h>=20
> > -#include <dt-bindings/reset/sun8i-h3-ccu.h>=20
> > +#include "sunxi-h3-h5.dtsi"=20
> >=C2=A0=20
> >=C2=A0 / {=20
> >=C2=A0 interrupt-parent =3D <&gic>;=20
> > @@ -87,489 +82,7 @@=20
> >=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IR=
Q_TYPE_LEVEL_LOW)>;=20
> >=C2=A0 };=20
> >=C2=A0=20
> > - clocks {=20
> > - #address-cells =3D <1>;=20
> > - #size-cells =3D <1>;=20
> > - ranges;=20
> > -=20
> > - osc24M: osc24M_clk {=20
> > - #clock-cells =3D <0>;=20
> > - compatible =3D "fixed-clock";=20
> > - clock-frequency =3D <24000000>;=20
> > - clock-output-names =3D "osc24M";=20
> > - };=20
> > -=20
> > - osc32k: osc32k_clk {=20
> > - #clock-cells =3D <0>;=20
> > - compatible =3D "fixed-clock";=20
> > - clock-frequency =3D <32768>;=20
> > - clock-output-names =3D "osc32k";=20
> > - };=20
> > -=20
> > - apb0: apb0_clk {=20
> > - compatible =3D "fixed-factor-clock";=20
> > - #clock-cells =3D <0>;=20
> > - clock-div =3D <1>;=20
> > - clock-mult =3D <1>;=20
> > - clocks =3D <&osc24M>;=20
> > - clock-output-names =3D "apb0";=20
> > - };=20
> > -=20
> > - apb0_gates: clk@01f01428 {=20
> > - compatible =3D "allwinner,sun8i-h3-apb0-gates-clk",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0 "allwinner,sun4i-a10-gates-clk";=20
> > - reg =3D <0x01f01428 0x4>;=20
> > - #clock-cells =3D <1>;=20
> > - clocks =3D <&apb0>;=20
> > - clock-indices =3D <0>, <1>;=20
> > - clock-output-names =3D "apb0_pio", "apb0_ir";=20
> > - };=20
> > -=20
> > - ir_clk: ir_clk@01f01454 {=20
> > - compatible =3D "allwinner,sun4i-a10-mod0-clk";=20
> > - reg =3D <0x01f01454 0x4>;=20
> > - #clock-cells =3D <0>;=20
> > - clocks =3D <&osc32k>, <&osc24M>;=20
> > - clock-output-names =3D "ir";=20
> > - };=20
> > - };=20
> > -=20
> >=C2=A0 soc {=20
> > - compatible =3D "simple-bus";=20
> > - #address-cells =3D <1>;=20
> > - #size-cells =3D <1>;=20
> > - ranges;=20
> > -=20
> > - dma: dma-controller@01c02000 {=20
> > - compatible =3D "allwinner,sun8i-h3-dma";=20
> > - reg =3D <0x01c02000 0x1000>;=20
> > - interrupts =3D <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_DMA>;=20
> > - resets =3D <&ccu RST_BUS_DMA>;=20
> > - #dma-cells =3D <1>;=20
> > - };=20
> > -=20
> > - mmc0: mmc@01c0f000 {=20
> > - compatible =3D "allwinner,sun7i-a20-mmc";=20
> > - reg =3D <0x01c0f000 0x1000>;=20
> > - clocks =3D <&ccu CLK_BUS_MMC0>,=20
> > - <&ccu CLK_MMC0>,=20
> > - <&ccu CLK_MMC0_OUTPUT>,=20
> > - <&ccu CLK_MMC0_SAMPLE>;=20
> > - clock-names =3D "ahb",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mmc",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "output",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sample";=20
> > - resets =3D <&ccu RST_BUS_MMC0>;=20
> > - reset-names =3D "ahb";=20
> > - interrupts =3D <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;=20
> > - status =3D "disabled";=20
> > - #address-cells =3D <1>;=20
> > - #size-cells =3D <0>;=20
> > - };=20
> > -=20
> > - mmc1: mmc@01c10000 {=20
> > - compatible =3D "allwinner,sun7i-a20-mmc";=20
> > - reg =3D <0x01c10000 0x1000>;=20
> > - clocks =3D <&ccu CLK_BUS_MMC1>,=20
> > - <&ccu CLK_MMC1>,=20
> > - <&ccu CLK_MMC1_OUTPUT>,=20
> > - <&ccu CLK_MMC1_SAMPLE>;=20
> > - clock-names =3D "ahb",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mmc",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "output",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sample";=20
> > - resets =3D <&ccu RST_BUS_MMC1>;=20
> > - reset-names =3D "ahb";=20
> > - interrupts =3D <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;=20
> > - status =3D "disabled";=20
> > - #address-cells =3D <1>;=20
> > - #size-cells =3D <0>;=20
> > - };=20
> > -=20
> > - mmc2: mmc@01c11000 {=20
> > - compatible =3D "allwinner,sun7i-a20-mmc";=20
> > - reg =3D <0x01c11000 0x1000>;=20
> > - clocks =3D <&ccu CLK_BUS_MMC2>,=20
> > - <&ccu CLK_MMC2>,=20
> > - <&ccu CLK_MMC2_OUTPUT>,=20
> > - <&ccu CLK_MMC2_SAMPLE>;=20
> > - clock-names =3D "ahb",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mmc",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "output",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sample";=20
> > - resets =3D <&ccu RST_BUS_MMC2>;=20
> > - reset-names =3D "ahb";=20
> > - interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;=20
> > - status =3D "disabled";=20
> > - #address-cells =3D <1>;=20
> > - #size-cells =3D <0>;=20
> > - };=20
> > -=20
> > - usbphy: phy@01c19400 {=20
> > - compatible =3D "allwinner,sun8i-h3-usb-phy";=20
> > - reg =3D <0x01c19400 0x2c>,=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x01c1a800 0x4>,=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x01c1b800 0x4>,=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x01c1c800 0x4>,=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x01c1d800 0x4>;=20
> > - reg-names =3D "phy_ctrl",=20
> > - =C2=A0=C2=A0=C2=A0 "pmu0",=20
> > - =C2=A0=C2=A0=C2=A0 "pmu1",=20
> > - =C2=A0=C2=A0=C2=A0 "pmu2",=20
> > - =C2=A0=C2=A0=C2=A0 "pmu3";=20
> > - clocks =3D <&ccu CLK_USB_PHY0>,=20
> > - <&ccu CLK_USB_PHY1>,=20
> > - <&ccu CLK_USB_PHY2>,=20
> > - <&ccu CLK_USB_PHY3>;=20
> > - clock-names =3D "usb0_phy",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "usb1_phy",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "usb2_phy",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "usb3_phy";=20
> > - resets =3D <&ccu RST_USB_PHY0>,=20
> > - <&ccu RST_USB_PHY1>,=20
> > - <&ccu RST_USB_PHY2>,=20
> > - <&ccu RST_USB_PHY3>;=20
> > - reset-names =3D "usb0_reset",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "usb1_reset",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "usb2_reset",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "usb3_reset";=20
> > - status =3D "disabled";=20
> > - #phy-cells =3D <1>;=20
> > - };=20
> > -=20
> > - ehci1: usb@01c1b000 {=20
> > - compatible =3D "allwinner,sun8i-h3-ehci", "generic-ehci";=20
> > - reg =3D <0x01c1b000 0x100>;=20
> > - interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_EHCI1>, <&ccu CLK_BUS_OHCI1>;=20
> > - resets =3D <&ccu RST_BUS_EHCI1>, <&ccu RST_BUS_OHCI1>;=20
> > - phys =3D <&usbphy 1>;=20
> > - phy-names =3D "usb";=20
> > - status =3D "disabled";=20
> > - };=20
> > -=20
> > - ohci1: usb@01c1b400 {=20
> > - compatible =3D "allwinner,sun8i-h3-ohci", "generic-ohci";=20
> > - reg =3D <0x01c1b400 0x100>;=20
> > - interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_EHCI1>, <&ccu CLK_BUS_OHCI1>,=20
> > - <&ccu CLK_USB_OHCI1>;=20
> > - resets =3D <&ccu RST_BUS_EHCI1>, <&ccu RST_BUS_OHCI1>;=20
> > - phys =3D <&usbphy 1>;=20
> > - phy-names =3D "usb";=20
> > - status =3D "disabled";=20
> > - };=20
> > -=20
> > - ehci2: usb@01c1c000 {=20
> > - compatible =3D "allwinner,sun8i-h3-ehci", "generic-ehci";=20
> > - reg =3D <0x01c1c000 0x100>;=20
> > - interrupts =3D <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_EHCI2>, <&ccu CLK_BUS_OHCI2>;=20
> > - resets =3D <&ccu RST_BUS_EHCI2>, <&ccu RST_BUS_OHCI2>;=20
> > - phys =3D <&usbphy 2>;=20
> > - phy-names =3D "usb";=20
> > - status =3D "disabled";=20
> > - };=20
> > -=20
> > - ohci2: usb@01c1c400 {=20
> > - compatible =3D "allwinner,sun8i-h3-ohci", "generic-ohci";=20
> > - reg =3D <0x01c1c400 0x100>;=20
> > - interrupts =3D <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_EHCI2>, <&ccu CLK_BUS_OHCI2>,=20
> > - <&ccu CLK_USB_OHCI2>;=20
> > - resets =3D <&ccu RST_BUS_EHCI2>, <&ccu RST_BUS_OHCI2>;=20
> > - phys =3D <&usbphy 2>;=20
> > - phy-names =3D "usb";=20
> > - status =3D "disabled";=20
> > - };=20
> > -=20
> > - ehci3: usb@01c1d000 {=20
> > - compatible =3D "allwinner,sun8i-h3-ehci", "generic-ehci";=20
> > - reg =3D <0x01c1d000 0x100>;=20
> > - interrupts =3D <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_EHCI3>, <&ccu CLK_BUS_OHCI3>;=20
> > - resets =3D <&ccu RST_BUS_EHCI3>, <&ccu RST_BUS_OHCI3>;=20
> > - phys =3D <&usbphy 3>;=20
> > - phy-names =3D "usb";=20
> > - status =3D "disabled";=20
> > - };=20
> > -=20
> > - ohci3: usb@01c1d400 {=20
> > - compatible =3D "allwinner,sun8i-h3-ohci", "generic-ohci";=20
> > - reg =3D <0x01c1d400 0x100>;=20
> > - interrupts =3D <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_EHCI3>, <&ccu CLK_BUS_OHCI3>,=20
> > - <&ccu CLK_USB_OHCI3>;=20
> > - resets =3D <&ccu RST_BUS_EHCI3>, <&ccu RST_BUS_OHCI3>;=20
> > - phys =3D <&usbphy 3>;=20
> > - phy-names =3D "usb";=20
> > - status =3D "disabled";=20
> > - };=20
> > -=20
> > - ccu: clock@01c20000 {=20
> > - compatible =3D "allwinner,sun8i-h3-ccu";=20
> > - reg =3D <0x01c20000 0x400>;=20
> > - clocks =3D <&osc24M>, <&osc32k>;=20
> > - clock-names =3D "hosc", "losc";=20
> > - #clock-cells =3D <1>;=20
> > - #reset-cells =3D <1>;=20
> > - };=20
> > -=20
> > - pio: pinctrl@01c20800 {=20
> > - compatible =3D "allwinner,sun8i-h3-pinctrl";=20
> > - reg =3D <0x01c20800 0x400>;=20
> > - interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0 <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;=20
> > - clock-names =3D "apb", "hosc", "losc";=20
> > - gpio-controller;=20
> > - #gpio-cells =3D <3>;=20
> > - interrupt-controller;=20
> > - #interrupt-cells =3D <3>;=20
> > -=20
> > - i2c0_pins: i2c0 {=20
> > - pins =3D "PA11", "PA12";=20
> > - function =3D "i2c0";=20
> > - };=20
> > -=20
> > - i2c1_pins: i2c1 {=20
> > - pins =3D "PA18", "PA19";=20
> > - function =3D "i2c1";=20
> > - };=20
> > -=20
> > - i2c2_pins: i2c2 {=20
> > - pins =3D "PE12", "PE13";=20
> > - function =3D "i2c2";=20
> > - };=20
> > -=20
> > - mmc0_pins_a: mmc0@0 {=20
> > - pins =3D "PF0", "PF1", "PF2", "PF3",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "PF4", "PF5";=20
> > - function =3D "mmc0";=20
> > - drive-strength =3D <30>;=20
> > - bias-pull-up;=20
> > - };=20
> > -=20
> > - mmc0_cd_pin: mmc0_cd_pin@0 {=20
> > - pins =3D "PF6";=20
> > - function =3D "gpio_in";=20
> > - bias-pull-up;=20
> > - };=20
> > -=20
> > - mmc1_pins_a: mmc1@0 {=20
> > - pins =3D "PG0", "PG1", "PG2", "PG3",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "PG4", "PG5";=20
> > - function =3D "mmc1";=20
> > - drive-strength =3D <30>;=20
> > - bias-pull-up;=20
> > - };=20
> > -=20
> > - mmc2_8bit_pins: mmc2_8bit {=20
> > - pins =3D "PC5", "PC6", "PC8",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "PC9", "PC10", "PC11",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "PC12", "PC13", "PC14",=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "PC15", "PC16";=20
> > - function =3D "mmc2";=20
> > - drive-strength =3D <30>;=20
> > - bias-pull-up;=20
> > - };=20
> > -=20
> > - spi0_pins: spi0 {=20
> > - pins =3D "PC0", "PC1", "PC2", "PC3";=20
> > - function =3D "spi0";=20
> > - };=20
> > -=20
> > - spi1_pins: spi1 {=20
> > - pins =3D "PA15", "PA16", "PA14", "PA13";=20
> > - function =3D "spi1";=20
> > - };=20
> > -=20
> > - uart0_pins_a: uart0@0 {=20
> > - pins =3D "PA4", "PA5";=20
> > - function =3D "uart0";=20
> > - };=20
> > -=20
> > - uart1_pins: uart1 {=20
> > - pins =3D "PG6", "PG7";=20
> > - function =3D "uart1";=20
> > - };=20
> > -=20
> > - uart1_rts_cts_pins: uart1_rts_cts {=20
> > - pins =3D "PG8", "PG9";=20
> > - function =3D "uart1";=20
> > - };=20
> > -=20
> > - uart2_pins: uart2 {=20
> > - pins =3D "PA0", "PA1";=20
> > - function =3D "uart2";=20
> > - };=20
> > -=20
> > - uart3_pins: uart3 {=20
> > - pins =3D "PA13", "PA14";=20
> > - function =3D "uart3";=20
> > - };=20
> > - };=20
> > -=20
> > - timer@01c20c00 {=20
> > - compatible =3D "allwinner,sun4i-a10-timer";=20
> > - reg =3D <0x01c20c00 0xa0>;=20
> > - interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0 <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&osc24M>;=20
> > - };=20
> > -=20
> > - spi0: spi@01c68000 {=20
> > - compatible =3D "allwinner,sun8i-h3-spi";=20
> > - reg =3D <0x01c68000 0x1000>;=20
> > - interrupts =3D <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;=20
> > - clock-names =3D "ahb", "mod";=20
> > - dmas =3D <&dma 23>, <&dma 23>;=20
> > - dma-names =3D "rx", "tx";=20
> > - pinctrl-names =3D "default";=20
> > - pinctrl-0 =3D <&spi0_pins>;=20
> > - resets =3D <&ccu RST_BUS_SPI0>;=20
> > - status =3D "disabled";=20
> > - #address-cells =3D <1>;=20
> > - #size-cells =3D <0>;=20
> > - };=20
> > -=20
> > - spi1: spi@01c69000 {=20
> > - compatible =3D "allwinner,sun8i-h3-spi";=20
> > - reg =3D <0x01c69000 0x1000>;=20
> > - interrupts =3D <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;=20
> > - clock-names =3D "ahb", "mod";=20
> > - dmas =3D <&dma 24>, <&dma 24>;=20
> > - dma-names =3D "rx", "tx";=20
> > - pinctrl-names =3D "default";=20
> > - pinctrl-0 =3D <&spi1_pins>;=20
> > - resets =3D <&ccu RST_BUS_SPI1>;=20
> > - status =3D "disabled";=20
> > - #address-cells =3D <1>;=20
> > - #size-cells =3D <0>;=20
> > - };=20
> > -=20
> > - wdt0: watchdog@01c20ca0 {=20
> > - compatible =3D "allwinner,sun6i-a31-wdt";=20
> > - reg =3D <0x01c20ca0 0x20>;=20
> > - interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;=20
> > - };=20
> > -=20
> > - pwm: pwm@01c21400 {=20
> > - compatible =3D "allwinner,sun8i-h3-pwm";=20
> > - reg =3D <0x01c21400 0x8>;=20
> > - clocks =3D <&osc24M>;=20
> > - #pwm-cells =3D <3>;=20
> > - status =3D "disabled";=20
> > - };=20
> > -=20
> > - codec: codec@01c22c00 {=20
> > - #sound-dai-cells =3D <0>;=20
> > - compatible =3D "allwinner,sun8i-h3-codec";=20
> > - reg =3D <0x01c22c00 0x400>;=20
> > - interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;=20
> > - clock-names =3D "apb", "codec";=20
> > - resets =3D <&ccu RST_BUS_CODEC>;=20
> > - dmas =3D <&dma 15>, <&dma 15>;=20
> > - dma-names =3D "rx", "tx";=20
> > - allwinner,codec-analog-controls =3D <&codec_analog>;=20
> > - status =3D "disabled";=20
> > - };=20
> > -=20
> > - uart0: serial@01c28000 {=20
> > - compatible =3D "snps,dw-apb-uart";=20
> > - reg =3D <0x01c28000 0x400>;=20
> > - interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;=20
> > - reg-shift =3D <2>;=20
> > - reg-io-width =3D <4>;=20
> > - clocks =3D <&ccu CLK_BUS_UART0>;=20
> > - resets =3D <&ccu RST_BUS_UART0>;=20
> > - dmas =3D <&dma 6>, <&dma 6>;=20
> > - dma-names =3D "rx", "tx";=20
> > - status =3D "disabled";=20
> > - };=20
> > -=20
> > - uart1: serial@01c28400 {=20
> > - compatible =3D "snps,dw-apb-uart";=20
> > - reg =3D <0x01c28400 0x400>;=20
> > - interrupts =3D <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;=20
> > - reg-shift =3D <2>;=20
> > - reg-io-width =3D <4>;=20
> > - clocks =3D <&ccu CLK_BUS_UART1>;=20
> > - resets =3D <&ccu RST_BUS_UART1>;=20
> > - dmas =3D <&dma 7>, <&dma 7>;=20
> > - dma-names =3D "rx", "tx";=20
> > - status =3D "disabled";=20
> > - };=20
> > -=20
> > - uart2: serial@01c28800 {=20
> > - compatible =3D "snps,dw-apb-uart";=20
> > - reg =3D <0x01c28800 0x400>;=20
> > - interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;=20
> > - reg-shift =3D <2>;=20
> > - reg-io-width =3D <4>;=20
> > - clocks =3D <&ccu CLK_BUS_UART2>;=20
> > - resets =3D <&ccu RST_BUS_UART2>;=20
> > - dmas =3D <&dma 8>, <&dma 8>;=20
> > - dma-names =3D "rx", "tx";=20
> > - status =3D "disabled";=20
> > - };=20
> > -=20
> > - uart3: serial@01c28c00 {=20
> > - compatible =3D "snps,dw-apb-uart";=20
> > - reg =3D <0x01c28c00 0x400>;=20
> > - interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;=20
> > - reg-shift =3D <2>;=20
> > - reg-io-width =3D <4>;=20
> > - clocks =3D <&ccu CLK_BUS_UART3>;=20
> > - resets =3D <&ccu RST_BUS_UART3>;=20
> > - dmas =3D <&dma 9>, <&dma 9>;=20
> > - dma-names =3D "rx", "tx";=20
> > - status =3D "disabled";=20
> > - };=20
> > -=20
> > - i2c0: i2c@01c2ac00 {=20
> > - compatible =3D "allwinner,sun6i-a31-i2c";=20
> > - reg =3D <0x01c2ac00 0x400>;=20
> > - interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_I2C0>;=20
> > - resets =3D <&ccu RST_BUS_I2C0>;=20
> > - pinctrl-names =3D "default";=20
> > - pinctrl-0 =3D <&i2c0_pins>;=20
> > - status =3D "disabled";=20
> > - #address-cells =3D <1>;=20
> > - #size-cells =3D <0>;=20
> > - };=20
> > -=20
> > - i2c1: i2c@01c2b000 {=20
> > - compatible =3D "allwinner,sun6i-a31-i2c";=20
> > - reg =3D <0x01c2b000 0x400>;=20
> > - interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_I2C1>;=20
> > - resets =3D <&ccu RST_BUS_I2C1>;=20
> > - pinctrl-names =3D "default";=20
> > - pinctrl-0 =3D <&i2c1_pins>;=20
> > - status =3D "disabled";=20
> > - #address-cells =3D <1>;=20
> > - #size-cells =3D <0>;=20
> > - };=20
> > -=20
> > - i2c2: i2c@01c2b400 {=20
> > - compatible =3D "allwinner,sun6i-a31-i2c";=20
> > - reg =3D <0x01c2b000 0x400>;=20
> > - interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&ccu CLK_BUS_I2C2>;=20
> > - resets =3D <&ccu RST_BUS_I2C2>;=20
> > - pinctrl-names =3D "default";=20
> > - pinctrl-0 =3D <&i2c2_pins>;=20
> > - status =3D "disabled";=20
> > - #address-cells =3D <1>;=20
> > - #size-cells =3D <0>;=20
> > - };=20
> > -=20
> >=C2=A0 gic: interrupt-controller@01c81000 {=20
> >=C2=A0 compatible =3D "arm,cortex-a7-gic", "arm,cortex-a15-gic";=20
> >=C2=A0 reg =3D <0x01c81000 0x1000>,=20
> > @@ -580,51 +93,49 @@=20
> >=C2=A0 #interrupt-cells =3D <3>;=20
> >=C2=A0 interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVE=
L_HIGH)>;=20
> >=C2=A0 };=20
> > + };=20
> > +};=20
> >=C2=A0=20
> > - rtc: rtc@01f00000 {=20
> > - compatible =3D "allwinner,sun6i-a31-rtc";=20
> > - reg =3D <0x01f00000 0x54>;=20
> > - interrupts =3D <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,=20
> > - =C2=A0=C2=A0=C2=A0=C2=A0 <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;=20
> > - };=20
> > -=20
> > - apb0_reset: reset@01f014b0 {=20
> > - reg =3D <0x01f014b0 0x4>;=20
> > - compatible =3D "allwinner,sun6i-a31-clock-reset";=20
> > - #reset-cells =3D <1>;=20
> > - };=20
> > +&ccu {=20
> > + compatible =3D "allwinner,sun8i-h3-ccu";=20
> > +};=20
>
> I believe this kind of sharing nodes is a bit frowned upon in connection=
=20
> with sharing .dtsi's. If the compatible name differs, I think it=20
> deserves to be a separate node spelt out in each SoC's .dtsi.=20
> This also makes the DT more readable, since a reader doesn't have to=20
> refer to two files to see what's in that node.=20

For such a device tree, see sun8i-a23-a33.c .

>
> >=C2=A0=20
> > - codec_analog: codec-analog@01f015c0 {=20
> > - compatible =3D "allwinner,sun8i-h3-codec-analog";=20
> > - reg =3D <0x01f015c0 0x4>;=20
> > - };=20
> > +&mmc0 {=20
> > + compatible =3D "allwinner,sun7i-a20-mmc";=20
> > + clocks =3D <&ccu CLK_BUS_MMC0>,=20
> > + <&ccu CLK_MMC0>,=20
> > + <&ccu CLK_MMC0_OUTPUT>,=20
> > + <&ccu CLK_MMC0_SAMPLE>;=20
> > + clock-names =3D "ahb",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mmc",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "output",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sample";=20
>
> This applies even more here, since the MMC controllers also have=20
> different clock requirements.=20
>
> So why can't we just leave the CCU, MMC and possibly the pinctrl nodes=20
> completely out of the shared h3-h5.dtsi and introduce them from scratch=
=20
> in the SoC specific .dtsi?=20
>
> I think we still have enough identical nodes to justify this kind of=20
> .dtsi sharing.=20
>
> Cheers,=20
> Andre.=20
>
> > +};=20
> >=C2=A0=20
> > - ir: ir@01f02000 {=20
> > - compatible =3D "allwinner,sun5i-a13-ir";=20
> > - clocks =3D <&apb0_gates 1>, <&ir_clk>;=20
> > - clock-names =3D "apb", "ir";=20
> > - resets =3D <&apb0_reset 1>;=20
> > - interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;=20
> > - reg =3D <0x01f02000 0x40>;=20
> > - status =3D "disabled";=20
> > - };=20
> > +&mmc1 {=20
> > + compatible =3D "allwinner,sun7i-a20-mmc";=20
> > + clocks =3D <&ccu CLK_BUS_MMC1>,=20
> > + <&ccu CLK_MMC1>,=20
> > + <&ccu CLK_MMC1_OUTPUT>,=20
> > + <&ccu CLK_MMC1_SAMPLE>;=20
> > + clock-names =3D "ahb",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mmc",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "output",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sample";=20
> > +};=20
> >=C2=A0=20
> > - r_pio: pinctrl@01f02c00 {=20
> > - compatible =3D "allwinner,sun8i-h3-r-pinctrl";=20
> > - reg =3D <0x01f02c00 0x400>;=20
> > - interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;=20
> > - clocks =3D <&apb0_gates 0>, <&osc24M>, <&osc32k>;=20
> > - clock-names =3D "apb", "hosc", "losc";=20
> > - resets =3D <&apb0_reset 0>;=20
> > - gpio-controller;=20
> > - #gpio-cells =3D <3>;=20
> > - interrupt-controller;=20
> > - #interrupt-cells =3D <3>;=20
> > +&mmc2 {=20
> > + compatible =3D "allwinner,sun7i-a20-mmc";=20
> > + clocks =3D <&ccu CLK_BUS_MMC2>,=20
> > + <&ccu CLK_MMC2>,=20
> > + <&ccu CLK_MMC2_OUTPUT>,=20
> > + <&ccu CLK_MMC2_SAMPLE>;=20
> > + clock-names =3D "ahb",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "mmc",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "output",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "sample";=20
> > +};=20
> >=C2=A0=20
> > - ir_pins_a: ir@0 {=20
> > - pins =3D "PL11";=20
> > - function =3D "s_cir_rx";=20
> > - };=20
> > - };=20
> > - };=20
> > +&pio {=20
> > + compatible =3D "allwinner,sun8i-h3-pinctrl";=20
> >=C2=A0 };=20
> > diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sun=
xi-h3-h5.dtsi=20
> > new file mode 100644=20
> > index 000000000000..4a57c65e8869=20
> > --- /dev/null=20
> > +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi=20
> > @@ -0,0 +1,557 @@=20
> > +/*=20
> > + * Copyright (C) 2015 Jens Kuske <jenskuske-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=20
> > + *=20
> > + * This file is dual-licensed: you can use it either under the terms=
=20
> > + * of the GPL or the X11 license, at your option. Note that this dual=
=20
> > + * licensing only applies to this file, and not this project as a=20
> > + * whole.=20
> > + *=20
> > + *=C2=A0 a) This file is free software; you can redistribute it and/or=
=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 modify it under the terms of the GNU Genera=
l Public License as=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 published by the Free Software Foundation; =
either version 2 of the=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 License, or (at your option) any later vers=
ion.=20
> > + *=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 This file is distributed in the hope that i=
t will be useful,=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 but WITHOUT ANY WARRANTY; without even the =
implied warranty of=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE.=C2=A0 See the=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 GNU General Public License for more details=
.=20
> > + *=20
> > + * Or, alternatively,=20
> > + *=20
> > + *=C2=A0 b) Permission is hereby granted, free of charge, to any perso=
n=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 obtaining a copy of this software and assoc=
iated documentation=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 files (the "Software"), to deal in the Soft=
ware without=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 restriction, including without limitation t=
he rights to use,=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 copy, modify, merge, publish, distribute, s=
ublicense, and/or=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 sell copies of the Software, and to permit =
persons to whom the=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 Software is furnished to do so, subject to =
the following=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 conditions:=20
> > + *=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 The above copyright notice and this permiss=
ion notice shall be=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 included in all copies or substantial porti=
ons of the Software.=20
> > + *=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT W=
ARRANTY OF ANY KIND,=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMIT=
ED TO THE WARRANTIES=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 OF MERCHANTABILITY, FITNESS FOR A PARTICULA=
R PURPOSE AND=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTH=
ORS OR COPYRIGHT=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR=
 OTHER LIABILITY,=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 WHETHER IN AN ACTION OF CONTRACT, TORT OR O=
THERWISE, ARISING=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 FROM, OUT OF OR IN CONNECTION WITH THE SOFT=
WARE OR THE USE OR=20
> > + *=C2=A0=C2=A0=C2=A0=C2=A0 OTHER DEALINGS IN THE SOFTWARE.=20
> > + */=20
> > +=20
> > +#include <dt-bindings/clock/sunxi-h3-h5-ccu.h>=20
> > +#include <dt-bindings/interrupt-controller/arm-gic.h>=20
> > +#include <dt-bindings/pinctrl/sun4i-a10.h>=20
> > +#include <dt-bindings/reset/sunxi-h3-h5-ccu.h>=20
> > +=20
> > +/ {=20
> > + #address-cells =3D <1>;=20
> > + #size-cells =3D <1>;=20
> > +=20
> > + clocks {=20
> > + #address-cells =3D <1>;=20
> > + #size-cells =3D <1>;=20
> > + ranges;=20
> > +=20
> > + osc24M: osc24M_clk {=20
> > + #clock-cells =3D <0>;=20
> > + compatible =3D "fixed-clock";=20
> > + clock-frequency =3D <24000000>;=20
> > + clock-output-names =3D "osc24M";=20
> > + };=20
> > +=20
> > + osc32k: osc32k_clk {=20
> > + #clock-cells =3D <0>;=20
> > + compatible =3D "fixed-clock";=20
> > + clock-frequency =3D <32768>;=20
> > + clock-output-names =3D "osc32k";=20
> > + };=20
> > +=20
> > + apb0: apb0_clk {=20
> > + compatible =3D "fixed-factor-clock";=20
> > + #clock-cells =3D <0>;=20
> > + clock-div =3D <1>;=20
> > + clock-mult =3D <1>;=20
> > + clocks =3D <&osc24M>;=20
> > + clock-output-names =3D "apb0";=20
> > + };=20
> > +=20
> > + apb0_gates: clk@01f01428 {=20
> > + compatible =3D "allwinner,sun8i-h3-apb0-gates-clk",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0 "allwinner,sun4i-a10-gates-clk";=20
> > + reg =3D <0x01f01428 0x4>;=20
> > + #clock-cells =3D <1>;=20
> > + clocks =3D <&apb0>;=20
> > + clock-indices =3D <0>, <1>;=20
> > + clock-output-names =3D "apb0_pio", "apb0_ir";=20
> > + };=20
> > +=20
> > + ir_clk: ir_clk@01f01454 {=20
> > + compatible =3D "allwinner,sun4i-a10-mod0-clk";=20
> > + reg =3D <0x01f01454 0x4>;=20
> > + #clock-cells =3D <0>;=20
> > + clocks =3D <&osc32k>, <&osc24M>;=20
> > + clock-output-names =3D "ir";=20
> > + };=20
> > + };=20
> > +=20
> > + soc {=20
> > + compatible =3D "simple-bus";=20
> > + #address-cells =3D <1>;=20
> > + #size-cells =3D <1>;=20
> > + ranges;=20
> > +=20
> > + dma: dma-controller@01c02000 {=20
> > + compatible =3D "allwinner,sun8i-h3-dma";=20
> > + reg =3D <0x01c02000 0x1000>;=20
> > + interrupts =3D <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_DMA>;=20
> > + resets =3D <&ccu RST_BUS_DMA>;=20
> > + #dma-cells =3D <1>;=20
> > + };=20
> > +=20
> > + mmc0: mmc@01c0f000 {=20
> > + /* compatible and clocks are in per SoC .dtsi file */=20
> > + reg =3D <0x01c0f000 0x1000>;=20
> > + resets =3D <&ccu RST_BUS_MMC0>;=20
> > + reset-names =3D "ahb";=20
> > + interrupts =3D <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;=20
> > + status =3D "disabled";=20
> > + #address-cells =3D <1>;=20
> > + #size-cells =3D <0>;=20
> > + };=20
> > +=20
> > + mmc1: mmc@01c10000 {=20
> > + /* compatible and clocks are in per SoC .dtsi file */=20
> > + reg =3D <0x01c10000 0x1000>;=20
> > + resets =3D <&ccu RST_BUS_MMC1>;=20
> > + reset-names =3D "ahb";=20
> > + interrupts =3D <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;=20
> > + status =3D "disabled";=20
> > + #address-cells =3D <1>;=20
> > + #size-cells =3D <0>;=20
> > + };=20
> > +=20
> > + mmc2: mmc@01c11000 {=20
> > + /* compatible and clocks are in per SoC .dtsi file */=20
> > + reg =3D <0x01c11000 0x1000>;=20
> > + resets =3D <&ccu RST_BUS_MMC2>;=20
> > + reset-names =3D "ahb";=20
> > + interrupts =3D <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;=20
> > + status =3D "disabled";=20
> > + #address-cells =3D <1>;=20
> > + #size-cells =3D <0>;=20
> > + };=20
> > +=20
> > + usbphy: phy@01c19400 {=20
> > + compatible =3D "allwinner,sun8i-h3-usb-phy";=20
> > + reg =3D <0x01c19400 0x2c>,=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x01c1a800 0x4>,=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x01c1b800 0x4>,=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x01c1c800 0x4>,=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 <0x01c1d800 0x4>;=20
> > + reg-names =3D "phy_ctrl",=20
> > + =C2=A0=C2=A0=C2=A0 "pmu0",=20
> > + =C2=A0=C2=A0=C2=A0 "pmu1",=20
> > + =C2=A0=C2=A0=C2=A0 "pmu2",=20
> > + =C2=A0=C2=A0=C2=A0 "pmu3";=20
> > + clocks =3D <&ccu CLK_USB_PHY0>,=20
> > + <&ccu CLK_USB_PHY1>,=20
> > + <&ccu CLK_USB_PHY2>,=20
> > + <&ccu CLK_USB_PHY3>;=20
> > + clock-names =3D "usb0_phy",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "usb1_phy",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "usb2_phy",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "usb3_phy";=20
> > + resets =3D <&ccu RST_USB_PHY0>,=20
> > + <&ccu RST_USB_PHY1>,=20
> > + <&ccu RST_USB_PHY2>,=20
> > + <&ccu RST_USB_PHY3>;=20
> > + reset-names =3D "usb0_reset",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "usb1_reset",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "usb2_reset",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "usb3_reset";=20
> > + status =3D "disabled";=20
> > + #phy-cells =3D <1>;=20
> > + };=20
> > +=20
> > + ehci1: usb@01c1b000 {=20
> > + compatible =3D "allwinner,sun8i-h3-ehci", "generic-ehci";=20
> > + reg =3D <0x01c1b000 0x100>;=20
> > + interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_EHCI1>, <&ccu CLK_BUS_OHCI1>;=20
> > + resets =3D <&ccu RST_BUS_EHCI1>, <&ccu RST_BUS_OHCI1>;=20
> > + phys =3D <&usbphy 1>;=20
> > + phy-names =3D "usb";=20
> > + status =3D "disabled";=20
> > + };=20
> > +=20
> > + ohci1: usb@01c1b400 {=20
> > + compatible =3D "allwinner,sun8i-h3-ohci", "generic-ohci";=20
> > + reg =3D <0x01c1b400 0x100>;=20
> > + interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_EHCI1>, <&ccu CLK_BUS_OHCI1>,=20
> > + <&ccu CLK_USB_OHCI1>;=20
> > + resets =3D <&ccu RST_BUS_EHCI1>, <&ccu RST_BUS_OHCI1>;=20
> > + phys =3D <&usbphy 1>;=20
> > + phy-names =3D "usb";=20
> > + status =3D "disabled";=20
> > + };=20
> > +=20
> > + ehci2: usb@01c1c000 {=20
> > + compatible =3D "allwinner,sun8i-h3-ehci", "generic-ehci";=20
> > + reg =3D <0x01c1c000 0x100>;=20
> > + interrupts =3D <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_EHCI2>, <&ccu CLK_BUS_OHCI2>;=20
> > + resets =3D <&ccu RST_BUS_EHCI2>, <&ccu RST_BUS_OHCI2>;=20
> > + phys =3D <&usbphy 2>;=20
> > + phy-names =3D "usb";=20
> > + status =3D "disabled";=20
> > + };=20
> > +=20
> > + ohci2: usb@01c1c400 {=20
> > + compatible =3D "allwinner,sun8i-h3-ohci", "generic-ohci";=20
> > + reg =3D <0x01c1c400 0x100>;=20
> > + interrupts =3D <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_EHCI2>, <&ccu CLK_BUS_OHCI2>,=20
> > + <&ccu CLK_USB_OHCI2>;=20
> > + resets =3D <&ccu RST_BUS_EHCI2>, <&ccu RST_BUS_OHCI2>;=20
> > + phys =3D <&usbphy 2>;=20
> > + phy-names =3D "usb";=20
> > + status =3D "disabled";=20
> > + };=20
> > +=20
> > + ehci3: usb@01c1d000 {=20
> > + compatible =3D "allwinner,sun8i-h3-ehci", "generic-ehci";=20
> > + reg =3D <0x01c1d000 0x100>;=20
> > + interrupts =3D <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_EHCI3>, <&ccu CLK_BUS_OHCI3>;=20
> > + resets =3D <&ccu RST_BUS_EHCI3>, <&ccu RST_BUS_OHCI3>;=20
> > + phys =3D <&usbphy 3>;=20
> > + phy-names =3D "usb";=20
> > + status =3D "disabled";=20
> > + };=20
> > +=20
> > + ohci3: usb@01c1d400 {=20
> > + compatible =3D "allwinner,sun8i-h3-ohci", "generic-ohci";=20
> > + reg =3D <0x01c1d400 0x100>;=20
> > + interrupts =3D <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_EHCI3>, <&ccu CLK_BUS_OHCI3>,=20
> > + <&ccu CLK_USB_OHCI3>;=20
> > + resets =3D <&ccu RST_BUS_EHCI3>, <&ccu RST_BUS_OHCI3>;=20
> > + phys =3D <&usbphy 3>;=20
> > + phy-names =3D "usb";=20
> > + status =3D "disabled";=20
> > + };=20
> > +=20
> > + ccu: clock@01c20000 {=20
> > + /* compatible is in per SoC .dtsi file */=20
> > + reg =3D <0x01c20000 0x400>;=20
> > + clocks =3D <&osc24M>, <&osc32k>;=20
> > + clock-names =3D "hosc", "losc";=20
> > + #clock-cells =3D <1>;=20
> > + #reset-cells =3D <1>;=20
> > + };=20
> > +=20
> > + pio: pinctrl@01c20800 {=20
> > + /* compatible is in per SoC .dtsi file */=20
> > + reg =3D <0x01c20800 0x400>;=20
> > + interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0 <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;=20
> > + clock-names =3D "apb", "hosc", "losc";=20
> > + gpio-controller;=20
> > + #gpio-cells =3D <3>;=20
> > + interrupt-controller;=20
> > + #interrupt-cells =3D <3>;=20
> > +=20
> > + i2c0_pins: i2c0 {=20
> > + pins =3D "PA11", "PA12";=20
> > + function =3D "i2c0";=20
> > + };=20
> > +=20
> > + i2c1_pins: i2c1 {=20
> > + pins =3D "PA18", "PA19";=20
> > + function =3D "i2c1";=20
> > + };=20
> > +=20
> > + i2c2_pins: i2c2 {=20
> > + pins =3D "PE12", "PE13";=20
> > + function =3D "i2c2";=20
> > + };=20
> > +=20
> > + mmc0_pins_a: mmc0@0 {=20
> > + pins =3D "PF0", "PF1", "PF2", "PF3",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "PF4", "PF5";=20
> > + function =3D "mmc0";=20
> > + drive-strength =3D <30>;=20
> > + bias-pull-up;=20
> > + };=20
> > +=20
> > + mmc0_cd_pin: mmc0_cd_pin@0 {=20
> > + pins =3D "PF6";=20
> > + function =3D "gpio_in";=20
> > + bias-pull-up;=20
> > + };=20
> > +=20
> > + mmc1_pins_a: mmc1@0 {=20
> > + pins =3D "PG0", "PG1", "PG2", "PG3",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "PG4", "PG5";=20
> > + function =3D "mmc1";=20
> > + drive-strength =3D <30>;=20
> > + bias-pull-up;=20
> > + };=20
> > +=20
> > + mmc2_8bit_pins: mmc2_8bit {=20
> > + pins =3D "PC5", "PC6", "PC8",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "PC9", "PC10", "PC11",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "PC12", "PC13", "PC14",=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "PC15", "PC16";=20
> > + function =3D "mmc2";=20
> > + drive-strength =3D <30>;=20
> > + bias-pull-up;=20
> > + };=20
> > +=20
> > + spi0_pins: spi0 {=20
> > + pins =3D "PC0", "PC1", "PC2", "PC3";=20
> > + function =3D "spi0";=20
> > + };=20
> > +=20
> > + spi1_pins: spi1 {=20
> > + pins =3D "PA15", "PA16", "PA14", "PA13";=20
> > + function =3D "spi1";=20
> > + };=20
> > +=20
> > + uart0_pins_a: uart0@0 {=20
> > + pins =3D "PA4", "PA5";=20
> > + function =3D "uart0";=20
> > + };=20
> > +=20
> > + uart1_pins: uart1 {=20
> > + pins =3D "PG6", "PG7";=20
> > + function =3D "uart1";=20
> > + };=20
> > +=20
> > + uart1_rts_cts_pins: uart1_rts_cts {=20
> > + pins =3D "PG8", "PG9";=20
> > + function =3D "uart1";=20
> > + };=20
> > +=20
> > + uart2_pins: uart2 {=20
> > + pins =3D "PA0", "PA1";=20
> > + function =3D "uart2";=20
> > + };=20
> > +=20
> > + uart3_pins: uart3 {=20
> > + pins =3D "PA13", "PA14";=20
> > + function =3D "uart3";=20
> > + };=20
> > + };=20
> > +=20
> > + timer@01c20c00 {=20
> > + compatible =3D "allwinner,sun4i-a10-timer";=20
> > + reg =3D <0x01c20c00 0xa0>;=20
> > + interrupts =3D <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0 <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&osc24M>;=20
> > + };=20
> > +=20
> > + spi0: spi@01c68000 {=20
> > + compatible =3D "allwinner,sun8i-h3-spi";=20
> > + reg =3D <0x01c68000 0x1000>;=20
> > + interrupts =3D <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;=20
> > + clock-names =3D "ahb", "mod";=20
> > + dmas =3D <&dma 23>, <&dma 23>;=20
> > + dma-names =3D "rx", "tx";=20
> > + pinctrl-names =3D "default";=20
> > + pinctrl-0 =3D <&spi0_pins>;=20
> > + resets =3D <&ccu RST_BUS_SPI0>;=20
> > + status =3D "disabled";=20
> > + #address-cells =3D <1>;=20
> > + #size-cells =3D <0>;=20
> > + };=20
> > +=20
> > + spi1: spi@01c69000 {=20
> > + compatible =3D "allwinner,sun8i-h3-spi";=20
> > + reg =3D <0x01c69000 0x1000>;=20
> > + interrupts =3D <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_SPI1>, <&ccu CLK_SPI1>;=20
> > + clock-names =3D "ahb", "mod";=20
> > + dmas =3D <&dma 24>, <&dma 24>;=20
> > + dma-names =3D "rx", "tx";=20
> > + pinctrl-names =3D "default";=20
> > + pinctrl-0 =3D <&spi1_pins>;=20
> > + resets =3D <&ccu RST_BUS_SPI1>;=20
> > + status =3D "disabled";=20
> > + #address-cells =3D <1>;=20
> > + #size-cells =3D <0>;=20
> > + };=20
> > +=20
> > + wdt0: watchdog@01c20ca0 {=20
> > + compatible =3D "allwinner,sun6i-a31-wdt";=20
> > + reg =3D <0x01c20ca0 0x20>;=20
> > + interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;=20
> > + };=20
> > +=20
> > + pwm: pwm@01c21400 {=20
> > + compatible =3D "allwinner,sun8i-h3-pwm";=20
> > + reg =3D <0x01c21400 0x8>;=20
> > + clocks =3D <&osc24M>;=20
> > + #pwm-cells =3D <3>;=20
> > + status =3D "disabled";=20
> > + };=20
> > +=20
> > + codec: codec@01c22c00 {=20
> > + #sound-dai-cells =3D <0>;=20
> > + compatible =3D "allwinner,sun8i-h3-codec";=20
> > + reg =3D <0x01c22c00 0x400>;=20
> > + interrupts =3D <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_CODEC>, <&ccu CLK_AC_DIG>;=20
> > + clock-names =3D "apb", "codec";=20
> > + resets =3D <&ccu RST_BUS_CODEC>;=20
> > + dmas =3D <&dma 15>, <&dma 15>;=20
> > + dma-names =3D "rx", "tx";=20
> > + allwinner,codec-analog-controls =3D <&codec_analog>;=20
> > + status =3D "disabled";=20
> > + };=20
> > +=20
> > + uart0: serial@01c28000 {=20
> > + compatible =3D "snps,dw-apb-uart";=20
> > + reg =3D <0x01c28000 0x400>;=20
> > + interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;=20
> > + reg-shift =3D <2>;=20
> > + reg-io-width =3D <4>;=20
> > + clocks =3D <&ccu CLK_BUS_UART0>;=20
> > + resets =3D <&ccu RST_BUS_UART0>;=20
> > + dmas =3D <&dma 6>, <&dma 6>;=20
> > + dma-names =3D "rx", "tx";=20
> > + status =3D "disabled";=20
> > + };=20
> > +=20
> > + uart1: serial@01c28400 {=20
> > + compatible =3D "snps,dw-apb-uart";=20
> > + reg =3D <0x01c28400 0x400>;=20
> > + interrupts =3D <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;=20
> > + reg-shift =3D <2>;=20
> > + reg-io-width =3D <4>;=20
> > + clocks =3D <&ccu CLK_BUS_UART1>;=20
> > + resets =3D <&ccu RST_BUS_UART1>;=20
> > + dmas =3D <&dma 7>, <&dma 7>;=20
> > + dma-names =3D "rx", "tx";=20
> > + status =3D "disabled";=20
> > + };=20
> > +=20
> > + uart2: serial@01c28800 {=20
> > + compatible =3D "snps,dw-apb-uart";=20
> > + reg =3D <0x01c28800 0x400>;=20
> > + interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;=20
> > + reg-shift =3D <2>;=20
> > + reg-io-width =3D <4>;=20
> > + clocks =3D <&ccu CLK_BUS_UART2>;=20
> > + resets =3D <&ccu RST_BUS_UART2>;=20
> > + dmas =3D <&dma 8>, <&dma 8>;=20
> > + dma-names =3D "rx", "tx";=20
> > + status =3D "disabled";=20
> > + };=20
> > +=20
> > + uart3: serial@01c28c00 {=20
> > + compatible =3D "snps,dw-apb-uart";=20
> > + reg =3D <0x01c28c00 0x400>;=20
> > + interrupts =3D <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;=20
> > + reg-shift =3D <2>;=20
> > + reg-io-width =3D <4>;=20
> > + clocks =3D <&ccu CLK_BUS_UART3>;=20
> > + resets =3D <&ccu RST_BUS_UART3>;=20
> > + dmas =3D <&dma 9>, <&dma 9>;=20
> > + dma-names =3D "rx", "tx";=20
> > + status =3D "disabled";=20
> > + };=20
> > +=20
> > + i2c0: i2c@01c2ac00 {=20
> > + compatible =3D "allwinner,sun6i-a31-i2c";=20
> > + reg =3D <0x01c2ac00 0x400>;=20
> > + interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_I2C0>;=20
> > + resets =3D <&ccu RST_BUS_I2C0>;=20
> > + pinctrl-names =3D "default";=20
> > + pinctrl-0 =3D <&i2c0_pins>;=20
> > + status =3D "disabled";=20
> > + #address-cells =3D <1>;=20
> > + #size-cells =3D <0>;=20
> > + };=20
> > +=20
> > + i2c1: i2c@01c2b000 {=20
> > + compatible =3D "allwinner,sun6i-a31-i2c";=20
> > + reg =3D <0x01c2b000 0x400>;=20
> > + interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_I2C1>;=20
> > + resets =3D <&ccu RST_BUS_I2C1>;=20
> > + pinctrl-names =3D "default";=20
> > + pinctrl-0 =3D <&i2c1_pins>;=20
> > + status =3D "disabled";=20
> > + #address-cells =3D <1>;=20
> > + #size-cells =3D <0>;=20
> > + };=20
> > +=20
> > + i2c2: i2c@01c2b400 {=20
> > + compatible =3D "allwinner,sun6i-a31-i2c";=20
> > + reg =3D <0x01c2b000 0x400>;=20
> > + interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&ccu CLK_BUS_I2C2>;=20
> > + resets =3D <&ccu RST_BUS_I2C2>;=20
> > + pinctrl-names =3D "default";=20
> > + pinctrl-0 =3D <&i2c2_pins>;=20
> > + status =3D "disabled";=20
> > + #address-cells =3D <1>;=20
> > + #size-cells =3D <0>;=20
> > + };=20
> > +=20
> > + rtc: rtc@01f00000 {=20
> > + compatible =3D "allwinner,sun6i-a31-rtc";=20
> > + reg =3D <0x01f00000 0x54>;=20
> > + interrupts =3D <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,=20
> > + =C2=A0=C2=A0=C2=A0=C2=A0 <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;=20
> > + };=20
> > +=20
> > + apb0_reset: reset@01f014b0 {=20
> > + reg =3D <0x01f014b0 0x4>;=20
> > + compatible =3D "allwinner,sun6i-a31-clock-reset";=20
> > + #reset-cells =3D <1>;=20
> > + };=20
> > +=20
> > + codec_analog: codec-analog@01f015c0 {=20
> > + compatible =3D "allwinner,sun8i-h3-codec-analog";=20
> > + reg =3D <0x01f015c0 0x4>;=20
> > + };=20
> > +=20
> > + ir: ir@01f02000 {=20
> > + compatible =3D "allwinner,sun5i-a13-ir";=20
> > + clocks =3D <&apb0_gates 1>, <&ir_clk>;=20
> > + clock-names =3D "apb", "ir";=20
> > + resets =3D <&apb0_reset 1>;=20
> > + interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;=20
> > + reg =3D <0x01f02000 0x40>;=20
> > + status =3D "disabled";=20
> > + };=20
> > +=20
> > + r_pio: pinctrl@01f02c00 {=20
> > + compatible =3D "allwinner,sun8i-h3-r-pinctrl";=20
> > + reg =3D <0x01f02c00 0x400>;=20
> > + interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;=20
> > + clocks =3D <&apb0_gates 0>, <&osc24M>, <&osc32k>;=20
> > + clock-names =3D "apb", "hosc", "losc";=20
> > + resets =3D <&apb0_reset 0>;=20
> > + gpio-controller;=20
> > + #gpio-cells =3D <3>;=20
> > + interrupt-controller;=20
> > + #interrupt-cells =3D <3>;=20
> > +=20
> > + ir_pins_a: ir@0 {=20
> > + pins =3D "PL11";=20
> > + function =3D "s_cir_rx";=20
> > + };=20
> > + };=20
> > + };=20
> > +};=20
> >=20
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
