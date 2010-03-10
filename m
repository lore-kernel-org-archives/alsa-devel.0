From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 1/4] From
	75fe4b02234f6476e72827508f11f1035d7aaf68 Mon Sep 17 00:00:00
	2001 From: Haojian Zhuang <haojian.zhuang@marvell.com> Date: Wed,
	10 Mar 2010 06:32:43 -0500 Subject: [PATCH] [ARM] mmp: support ssp in
	pxa168 Support ssp in pxa168. Th
Date: Wed, 10 Mar 2010 08:07:49 -0500
Message-ID: <771cded01003100507r59d9f46m5334a53d81e0b690@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BB0D51038FE
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 14:07:50 +0100 (CET)
Received: by pwj10 with SMTP id 10so3943031pwj.38
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 05:07:49 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Eric Miao <eric.y.miao@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Discard this patch. I'm sorry on it.

Thanks
Haojian

On Wed, Mar 10, 2010 at 8:05 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From 75fe4b02234f6476e72827508f11f1035d7aaf68 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 10 Mar 2010 06:32:43 -0500
> Subject: [PATCH] [ARM] mmp: support ssp in pxa168
>
> Support ssp in pxa168. The basic function of SSP is same as pxa, but clock
> source and IRQ is changed.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
> =A0arch/arm/mach-mmp/include/mach/irqs.h =A0 =A0 =A0| =A0 10 +-
> =A0arch/arm/mach-mmp/include/mach/pxa168.h =A0 =A0| =A0 21 ++++
> =A0arch/arm/mach-mmp/include/mach/regs-apbc.h | =A0 10 +-
> =A0arch/arm/mach-mmp/include/mach/regs-mpmu.h | =A0 48 ++++++++++
> =A0arch/arm/mach-mmp/include/mach/regs-ssp.h =A0| =A0141 ++++++++++++++++=
++++++++++++
> =A0arch/arm/mach-mmp/pxa168.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 15 +++
> =A0arch/arm/plat-pxa/include/plat/ssp.h =A0 =A0 =A0 | =A0 =A02 +
> =A0arch/arm/plat-pxa/ssp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
=A01 +
> =A08 files changed, 238 insertions(+), 10 deletions(-)
> =A0create mode 100644 arch/arm/mach-mmp/include/mach/regs-mpmu.h
> =A0create mode 100644 arch/arm/mach-mmp/include/mach/regs-ssp.h
>
> diff --git a/arch/arm/mach-mmp/include/mach/irqs.h
> b/arch/arm/mach-mmp/include/mach/irqs.h
> index 0270119..b379cde 100644
> --- a/arch/arm/mach-mmp/include/mach/irqs.h
> +++ b/arch/arm/mach-mmp/include/mach/irqs.h
> @@ -5,10 +5,10 @@
> =A0* Interrupt numbers for PXA168
> =A0*/
> =A0#define IRQ_PXA168_NONE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(-1)
> -#define IRQ_PXA168_SSP3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
> -#define IRQ_PXA168_SSP2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> -#define IRQ_PXA168_SSP1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
> -#define IRQ_PXA168_SSP0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03
> +#define IRQ_PXA168_SSP4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
> +#define IRQ_PXA168_SSP3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
> +#define IRQ_PXA168_SSP2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02
> +#define IRQ_PXA168_SSP1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03
> =A0#define IRQ_PXA168_PMIC_INT =A0 =A0 =A0 =A0 =A0 =A04
> =A0#define IRQ_PXA168_RTC_INT =A0 =A0 =A0 =A0 =A0 =A0 5
> =A0#define IRQ_PXA168_RTC_ALARM =A0 =A0 =A0 =A0 =A0 6
> @@ -20,7 +20,7 @@
> =A0#define IRQ_PXA168_TIMER2 =A0 =A0 =A0 =A0 =A0 =A0 =A014
> =A0#define IRQ_PXA168_TIMER3 =A0 =A0 =A0 =A0 =A0 =A0 =A015
> =A0#define IRQ_PXA168_CMU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 16
> -#define IRQ_PXA168_SSP4 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A017
> +#define IRQ_PXA168_SSP5 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A017
> =A0#define IRQ_PXA168_MSP_WAKEUP =A0 =A0 =A0 =A0 =A019
> =A0#define IRQ_PXA168_CF_WAKEUP =A0 =A0 =A0 =A0 =A0 20
> =A0#define IRQ_PXA168_XD_WAKEUP =A0 =A0 =A0 =A0 =A0 21
> diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h
> b/arch/arm/mach-mmp/include/mach/pxa168.h
> index 3ad612c..3b2bd5d 100644
> --- a/arch/arm/mach-mmp/include/mach/pxa168.h
> +++ b/arch/arm/mach-mmp/include/mach/pxa168.h
> @@ -14,6 +14,11 @@ extern struct pxa_device_desc pxa168_device_pwm1;
> =A0extern struct pxa_device_desc pxa168_device_pwm2;
> =A0extern struct pxa_device_desc pxa168_device_pwm3;
> =A0extern struct pxa_device_desc pxa168_device_pwm4;
> +extern struct pxa_device_desc pxa168_device_ssp1;
> +extern struct pxa_device_desc pxa168_device_ssp2;
> +extern struct pxa_device_desc pxa168_device_ssp3;
> +extern struct pxa_device_desc pxa168_device_ssp4;
> +extern struct pxa_device_desc pxa168_device_ssp5;
> =A0extern struct pxa_device_desc pxa168_device_nand;
>
> =A0static inline int pxa168_add_uart(int id)
> @@ -67,6 +72,22 @@ static inline int pxa168_add_pwm(int id)
> =A0 =A0 =A0 =A0return pxa_register_device(d, NULL, 0);
> =A0}
>
> +static inline int pxa168_add_ssp(int id)
> +{
> + =A0 =A0 =A0 struct pxa_device_desc *d =3D NULL;
> +
> + =A0 =A0 =A0 switch (id) {
> + =A0 =A0 =A0 case 1: d =3D &pxa168_device_ssp1; break;
> + =A0 =A0 =A0 case 2: d =3D &pxa168_device_ssp2; break;
> + =A0 =A0 =A0 case 3: d =3D &pxa168_device_ssp3; break;
> + =A0 =A0 =A0 case 4: d =3D &pxa168_device_ssp4; break;
> + =A0 =A0 =A0 case 5: d =3D &pxa168_device_ssp5; break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return pxa_register_device(d, NULL, 0);
> +}
> +
> =A0static inline int pxa168_add_nand(struct pxa3xx_nand_platform_data *in=
fo)
> =A0{
> =A0 =A0 =A0 =A0return pxa_register_device(&pxa168_device_nand, info, size=
of(*info));
> diff --git a/arch/arm/mach-mmp/include/mach/regs-apbc.h
> b/arch/arm/mach-mmp/include/mach/regs-apbc.h
> index 712af03..1a96585 100644
> --- a/arch/arm/mach-mmp/include/mach/regs-apbc.h
> +++ b/arch/arm/mach-mmp/include/mach/regs-apbc.h
> @@ -26,8 +26,6 @@
> =A0#define APBC_PXA168_PWM2 =A0 =A0 =A0 APBC_REG(0x010)
> =A0#define APBC_PXA168_PWM3 =A0 =A0 =A0 APBC_REG(0x014)
> =A0#define APBC_PXA168_PWM4 =A0 =A0 =A0 APBC_REG(0x018)
> -#define APBC_PXA168_SSP1 =A0 =A0 =A0 APBC_REG(0x01c)
> -#define APBC_PXA168_SSP2 =A0 =A0 =A0 APBC_REG(0x020)
> =A0#define APBC_PXA168_RTC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0APBC_REG(0x028)
> =A0#define APBC_PXA168_TWSI0 =A0 =A0 =A0APBC_REG(0x02c)
> =A0#define APBC_PXA168_KPC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0APBC_REG(0x030)
> @@ -35,14 +33,16 @@
> =A0#define APBC_PXA168_AIB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0APBC_REG(0x03c)
> =A0#define APBC_PXA168_SW_JTAG =A0 =A0APBC_REG(0x040)
> =A0#define APBC_PXA168_ONEWIRE =A0 =A0APBC_REG(0x048)
> -#define APBC_PXA168_SSP3 =A0 =A0 =A0 APBC_REG(0x04c)
> =A0#define APBC_PXA168_ASFAR =A0 =A0 =A0APBC_REG(0x050)
> =A0#define APBC_PXA168_ASSAR =A0 =A0 =A0APBC_REG(0x054)
> -#define APBC_PXA168_SSP4 =A0 =A0 =A0 APBC_REG(0x058)
> -#define APBC_PXA168_SSP5 =A0 =A0 =A0 APBC_REG(0x05c)
> =A0#define APBC_PXA168_TWSI1 =A0 =A0 =A0APBC_REG(0x06c)
> =A0#define APBC_PXA168_UART3 =A0 =A0 =A0APBC_REG(0x070)
> =A0#define APBC_PXA168_AC97 =A0 =A0 =A0 APBC_REG(0x084)
> +#define APBC_PXA168_SSP1 =A0 =A0 =A0 APBC_REG(0x81c)
> +#define APBC_PXA168_SSP2 =A0 =A0 =A0 APBC_REG(0x820)
> +#define APBC_PXA168_SSP3 =A0 =A0 =A0 APBC_REG(0x84c)
> +#define APBC_PXA168_SSP4 =A0 =A0 =A0 APBC_REG(0x858)
> +#define APBC_PXA168_SSP5 =A0 =A0 =A0 APBC_REG(0x85c)
>
> =A0/*
> =A0* APB Clock register offsets for PXA910
> diff --git a/arch/arm/mach-mmp/include/mach/regs-mpmu.h
> b/arch/arm/mach-mmp/include/mach/regs-mpmu.h
> new file mode 100644
> index 0000000..0d57236
> --- /dev/null
> +++ b/arch/arm/mach-mmp/include/mach/regs-mpmu.h
> @@ -0,0 +1,48 @@
> +/*
> + * linux/arch/arm/mach-mmp/include/mach/regs-mpmu.h
> + *
> + * =A0 Main Power Management Unit
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __ASM_MACH_REGS_MPMU_H
> +#define __ASM_MACH_REGS_MPMU_H
> +
> +#include <mach/addr-map.h>
> +
> +#define MPMU_VIRT_BASE (APB_VIRT_BASE + 0x50000)
> +#define MPMU_REG(off) =A0(MPMU_VIRT_BASE + (off))
> +
> +#define MPMU_CPCR =A0 =A0 =A0MPMU_REG(0x0000)
> +#define MPMU_FCCR =A0 =A0 =A0MPMU_REG(0x0008)
> +#define MPMU_POCR =A0 =A0 =A0MPMU_REG(0x000c)
> +#define MPMU_POSR =A0 =A0 =A0MPMU_REG(0x0010)
> +#define MPMU_SUCCR =A0 =A0 MPMU_REG(0x0014)
> +#define MPMU_VRCR =A0 =A0 =A0MPMU_REG(0x0018)
> +#define MPMU_OHCR =A0 =A0 =A0MPMU_REG(0x001c)
> +#define MPMU_GPCR =A0 =A0 =A0MPMU_REG(0x0030)
> +#define MPMU_PLL2CR =A0 =A0MPMU_REG(0x0034)
> +#define MPMU_SCCR =A0 =A0 =A0MPMU_REG(0x0038)
> +#define MPMU_CWUCRM =A0 =A0MPMU_REG(0x004c)
> +#define MPMU_PLL1_REG1 MPMU_REG(0x0050)
> +#define MPMU_PLL1_REG2 MPMU_REG(0x0054)
> +#define MPMU_PLL1_SSC =A0MPMU_REG(0x0058)
> +#define MPMU_PLL2_REG1 MPMU_REG(0x0060)
> +#define MPMU_PLL2_REG2 MPMU_REG(0x0064)
> +#define MPMU_PLL2_SSC =A0MPMU_REG(0x0068)
> +#define MPMU_TS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MPMU_REG(0x0080)
> +#define MPMU_WDTPCR =A0 =A0MPMU_REG(0x0200)
> +#define MPMU_APCR =A0 =A0 =A0MPMU_REG(0x1000)
> +#define MPMU_APSR =A0 =A0 =A0MPMU_REG(0x1004)
> +#define MPMU_APRR =A0 =A0 =A0MPMU_REG(0x1020)
> +#define MPMU_ACGR =A0 =A0 =A0MPMU_REG(0x1024)
> +#define MPMU_ARSR =A0 =A0 =A0MPMU_REG(0x1028)
> +#define MPMU_AWUCRS =A0 =A0MPMU_REG(0x1048)
> +#define MPMU_AWUCRM =A0 =A0MPMU_REG(0x104c)
> +#define MPMU_ASYSDR =A0 =A0MPMU_REG(0x1050)
> +#define MPMU_ASSPDR =A0 =A0MPMU_REG(0x1054)
> +
> +#endif /* __ASM_MACH_REGS_APMU_H */
> diff --git a/arch/arm/mach-mmp/include/mach/regs-ssp.h
> b/arch/arm/mach-mmp/include/mach/regs-ssp.h
> new file mode 100644
> index 0000000..7e16eeb
> --- /dev/null
> +++ b/arch/arm/mach-mmp/include/mach/regs-ssp.h
> @@ -0,0 +1,141 @@
> +#ifndef __ASM_ARCH_REGS_SSP_H
> +#define __ASM_ARCH_REGS_SSP_H
> +
> +/*
> + * SSP Serial Port Registers
> + */
> +
> +#define SSCR0 =A0 =A0 =A0 =A0 =A0(0x00) =A0/* SSP Control Register 0 */
> +#define SSCR1 =A0 =A0 =A0 =A0 =A0(0x04) =A0/* SSP Control Register 1 */
> +#define SSSR =A0 =A0 =A0 =A0 =A0 (0x08) =A0/* SSP Status Register */
> +#define SSITR =A0 =A0 =A0 =A0 =A0(0x0C) =A0/* SSP Interrupt Test Registe=
r */
> +#define SSDR =A0 =A0 =A0 =A0 =A0 (0x10) =A0/* SSP Data Write/Data Read R=
egister */
> +
> +#define SSTO =A0 =A0 =A0 =A0 =A0 (0x28) =A0/* SSP Time Out Register */
> +#define SSPSP =A0 =A0 =A0 =A0 =A0(0x2C) =A0/* SSP Programmable Serial Pr=
otocol */
> +#define SSTSA =A0 =A0 =A0 =A0 =A0(0x30) =A0/* SSP Tx Timeslot Active */
> +#define SSRSA =A0 =A0 =A0 =A0 =A0(0x34) =A0/* SSP Rx Timeslot Active */
> +#define SSTSS =A0 =A0 =A0 =A0 =A0(0x38) =A0/* SSP Timeslot Status */
> +
> +#if defined(CONFIG_CPU_PXA910)
> +#define SSACD =A0 =A0 =A0 =A0 =A0(0x3C) =A0/* SSP Audio Clock Divider */
> +#define SSACDD =A0 =A0 =A0 =A0 (0x40) =A0/* SSP Audio Clock Dither Divid=
er */
> +#endif
> +
> +/* Common bits first */
> +#define SSCR0_DSS_MASK (0x0000000f) =A0 =A0/* Data Size Select (mask) */
> +#define SSCR0_DSS(x) =A0((x) - 1) =A0 =A0 =A0 =A0/* Data Size Select [4.=
.16] */
> +#define SSCR0_FRF =A0 =A0 =A0(0x3 << 4) =A0 =A0 =A0/* FRame Format (mask=
) */
> +#define SSCR0_Motorola (0x0 << 4) =A0 =A0 =A0/* Motorola's Serial Periph=
eral
> Interface (SPI) */
> +#define SSCR0_TI =A0 =A0 =A0 (0x1 << 4) =A0 =A0 =A0/* Texas Instruments'=
 Synchronous Serial
> Protocol (SSP) */
> +#define SSCR0_National (0x2 << 4) =A0 =A0 =A0/* National Microwire */
> +#define SSCR0_PSP =A0 =A0 =A0(0x3 << 4) =A0 =A0 =A0/* Programmable Seria=
l Protocol (PSP) */
> +#define SSCR0_ECS =A0 =A0 =A0(1 << 6) =A0 =A0 =A0 =A0/* External clock s=
elect */
> +#define SSCR0_SSE =A0 =A0 =A0(1 << 7) =A0 =A0 =A0 =A0/* Synchronous Seri=
al Port Enable */
> +
> +#define SSCR0_SCR =A0 =A0 =A0(0xfff << 8) =A0 =A0/* Serial Clock Rate (m=
ask) */
> +#define SSCR0_SerClkDiv(x) (((x) - 1) << 8) /* Divisor [1..4096] */
> +
> +#define SSCR0_EDSS =A0 =A0 (1 << 20) =A0 =A0 =A0 /* Extended data size s=
elect */
> +#define SSCR0_NCS =A0 =A0 =A0(1 << 21) =A0 =A0 =A0 /* Network clock sele=
ct */
> +#define SSCR0_RIM =A0 =A0 =A0(1 << 22) =A0 =A0 =A0 /* Receive FIFO overr=
run interrupt mask */
> +#define SSCR0_TIM =A0 =A0 =A0(1 << 23) =A0 =A0 =A0 /* Transmit FIFO unde=
rrun interrupt mask */
> +#define SSCR0_FRDC =A0 =A0 (0x7 << 24) =A0 =A0 /* Frame rate divider con=
trol (mask) */
> +#define SSCR0_SlotsPerFrm(x) (((x) - 1) << 24) /* Time slots per
> frame [1..8] */
> +#define SSCR0_FPCKE =A0 =A0(1 << 29) =A0 =A0 =A0 /* FIFO packing enable =
*/
> +#define SSCR0_ACS =A0 =A0 =A0(1 << 30) =A0 =A0 =A0 /* Audio clock select=
 */
> +#define SSCR0_MOD =A0 =A0 =A0(1 << 31) =A0 =A0 =A0 /* Mode (normal or ne=
twork) */
> +
> +#if defined(CONFIG_CPU_PXA168) || defined(CONFIG_CPU_PXA910)
> +#define SSCR0_MODE_52M (1 << 27) =A0 =A0 =A0 /* 52Mbps Mode */
> +#endif
> +
> +#define SSCR1_RIE =A0 =A0 =A0(1 << 0) =A0 =A0 =A0 =A0/* Receive FIFO Int=
errupt Enable */
> +#define SSCR1_TIE =A0 =A0 =A0(1 << 1) =A0 =A0 =A0 =A0/* Transmit FIFO In=
terrupt Enable */
> +#define SSCR1_LBM =A0 =A0 =A0(1 << 2) =A0 =A0 =A0 =A0/* Loop-Back Mode */
> +#define SSCR1_SPO =A0 =A0 =A0(1 << 3) =A0 =A0 =A0 =A0/* Motorola SPI SSP=
SCLK polarity setting */
> +#define SSCR1_SPH =A0 =A0 =A0(1 << 4) =A0 =A0 =A0 =A0/* Motorola SPI SSP=
SCLK phase setting */
> +#define SSCR1_TFT_MASK (0xf << 6) =A0 =A0 =A0/* Transmit FIFO Threshold =
(mask) */
> +#define SSCR1_TFT(x) =A0 (((x) - 1) << 6) /* level [1..16] */
> +#define SSCR1_RFT_MASK (0xf << 10) =A0 =A0 /* Receive FIFO Threshold (ma=
sk) */
> +#define SSCR1_RFT(x) =A0 (((x) - 1) << 10) /* level [1..16] */
> +#define SSCR1_EFWR =A0 =A0 (1 << 14) =A0 =A0 =A0 /* Enable FIFO Write/re=
ad */
> +#define SSCR1_STRF =A0 =A0 (1 << 15) =A0 =A0 =A0 /* Select FIFO for EFWR=
 */
> +#define SSCR1_IFS =A0 =A0 =A0(1 << 16) =A0 =A0 =A0 /* Invert Frame Signa=
l */
> +#define SSCR1_PINTE =A0 =A0(1 << 18) =A0 =A0 =A0 /* Peripheral Trailing =
Byte Interrupt Enable */
> +#define SSCR1_TINTE =A0 =A0(1 << 19) =A0 =A0 =A0 /* Receiver Timeout Int=
errupt Enable */
> +#define SSCR1_RSRE =A0 =A0 (1 << 20) =A0 =A0 =A0 /* Receive Service Requ=
est Enable */
> +#define SSCR1_TSRE =A0 =A0 (1 << 21) =A0 =A0 =A0 /* Transmit Service Req=
uest Enable */
> +#define SSCR1_TRAIL =A0 =A0(1 << 22) =A0 =A0 =A0 /* Trailing Byte */
> +#define SSCR1_RWOT =A0 =A0 (1 << 23) =A0 =A0 =A0 /* Receive Without Tran=
smit */
> +#define SSCR1_SFRMDIR =A0(1 << 24) =A0 =A0 =A0 /* SSP Frame (SSPSFRMx) D=
irection */
> +#define SSCR1_SCLKDIR =A0(1 << 25) =A0 =A0 =A0 /* SSP Serial Bit Rate Cl=
ock
> (SSPSCLKx) Direction */
> +#define SSCR1_ECRB =A0 =A0 (1 << 26) =A0 =A0 =A0 /* Enable Clock Request=
 B */
> +#define SSCR1_ECRA =A0 =A0 (1 << 27) =A0 =A0 =A0 /* Enable Clock Request=
 A */
> +#define SSCR1_SCFR =A0 =A0 (1 << 28) =A0 =A0 =A0 /* Slave Clock Free Run=
ning */
> +#define SSCR1_EBCEI =A0 =A0(1 << 29) =A0 =A0 =A0 /* Enable Bit Count Err=
or Interrupt */
> +#define SSCR1_TTE =A0 =A0 =A0(1 << 30) =A0 =A0 =A0 /* TxD Three-state En=
able */
> +#define SSCR1_TTELP =A0 =A0(1 << 31) =A0 =A0 =A0 /* TxD Three-state Enab=
le On Last Phase */
> +
> +#if defined(CONFIG_CPU_PXA910)
> +#define SSCR1_MWDS =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0/* Microwire Transmit=
 Data Size */
> +#endif
> +
> +#define SSSR_TNF =A0 =A0 =A0 (1 << 2) =A0 =A0 =A0 =A0/* Transmit FIFO No=
t Full */
> +#define SSSR_RNE =A0 =A0 =A0 (1 << 3) =A0 =A0 =A0 =A0/* Receive FIFO Not=
 Empty */
> +#define SSSR_BSY =A0 =A0 =A0 (1 << 4) =A0 =A0 =A0 =A0/* SSP Busy */
> +#define SSSR_TFS =A0 =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0/* Transmit FIFO Se=
rvice Request */
> +#define SSSR_RFS =A0 =A0 =A0 (1 << 6) =A0 =A0 =A0 =A0/* Receive FIFO Ser=
vice Request */
> +#define SSSR_ROR =A0 =A0 =A0 (1 << 7) =A0 =A0 =A0 =A0/* Receive FIFO Ove=
rrun */
> +#define SSSR_TFL_MASK =A0(0xf << 8) =A0 =A0 =A0/* Transmit FIFO Level (m=
ask) */
> +#define SSSR_TFL(x) =A0 =A0((x) << 8)
> +#define SSSR_RFL_MASK =A0(0xf << 12) =A0 =A0 /* Receive FIFO Level */
> +#define SSSR_RFL(x) =A0 =A0((x) << 12)
> +#define SSSR_PINT =A0 =A0 =A0(1 << 18) =A0 =A0 =A0 /* Peripheral Trailin=
g Byte Interrupt */
> +#define SSSR_TINT =A0 =A0 =A0(1 << 19) =A0 =A0 =A0 /* Receiver Timeout I=
nterrupt */
> +#define SSSR_EOC =A0 =A0 =A0 (1 << 20) =A0 =A0 =A0 /* End of Chain */
> +#define SSSR_TUR =A0 =A0 =A0 (1 << 21) =A0 =A0 =A0 /* Transmit FIFO Unde=
rrun */
> +#define SSSR_CSS =A0 =A0 =A0 (1 << 22) =A0 =A0 =A0 /* Clock Synchronisat=
ion Status */
> +#define SSSR_BCE =A0 =A0 =A0 (1 << 23) =A0 =A0 =A0 /* Bit Count Error */
> +#define SSSR_TX_OSS =A0 =A0(1 << 30) =A0 =A0 =A0 /* Tx FIFO Odd Sample S=
tatus */
> +#define SSSR_OSS =A0 =A0 =A0 (1 << 31) =A0 =A0 =A0 /* Odd Sample Status =
*/
> +
> +#define SSITR_TTFS =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0/* Test Tx FIFO Servi=
ce Request */
> +#define SSITR_TRFS =A0 =A0 (1 << 6) =A0 =A0 =A0 =A0/* Test Rx FIFO Servi=
ce Request */
> +#define SSITR_TROR =A0 =A0 (1 << 7) =A0 =A0 =A0 =A0/* Test Rx FIFO Overr=
un */
> +
> +#define SSPSP_SCMODE_MASK =A0 =A0 =A0(0x3) =A0 =A0 =A0 =A0 =A0 /* Serial=
 Bit Rate Clock Mode */
> +#define SSPSP_SCMODE(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((x) << 0)
> +#define SSPSP_SFRMP =A0 =A0 =A0 =A0 =A0 =A0(1 << 2) =A0 =A0 =A0 =A0/* Se=
rial Frame Polarity */
> +#define SSPSP_ETDS =A0 =A0 =A0 =A0 =A0 =A0 (1 << 3) =A0 =A0 =A0 =A0/* En=
d of Transfer data State */
> +#define SSPSP_STRTDLY_MASK =A0 =A0 (0x7 << 4) =A0 =A0 =A0/* Start Delay =
*/
> +#define SSPSP_STRTDLY(x) =A0 =A0 =A0 ((x) << 4)
> +#define SSPSP_DMYSTRT_MASK =A0 =A0 (0x3 << 7) =A0 =A0 =A0/* Dummy Start =
*/
> +#define SSPSP_DMYSTRT(x) =A0 =A0 =A0 ((x) << 7)
> +#define SSPSP_SFRMDLY_MASK =A0 =A0 (0x7f << 9) =A0 =A0 /* Serial Frame D=
elay */
> +#define SSPSP_SFRMDLY(x) =A0 =A0 =A0 ((x) << 9)
> +#define SSPSP_SFRMWDTH_MASK =A0 =A0(0x3f << 16) =A0 =A0/* Serial Frame W=
idth */
> +#define SSPSP_SFRMWDTH(x) =A0 =A0 =A0((x) << 16)
> +#define SSPSP_DMYSTOP_MASK =A0 =A0 (0x3 << 23) =A0 =A0 /* Dummy Stop */
> +#define SSPSP_DMYSTOP(x) =A0 =A0 =A0 ((x) << 23)
> +#define SSPSP_FSRT =A0 =A0 =A0 =A0 =A0 =A0 (1 << 25) =A0 =A0 =A0 /* Fram=
e Sync Relative Timing */
> +#define SSPSP_EDMYSTRT_MASK =A0 =A0(0x3 << 26) =A0 =A0 /* Extended Dummy=
 Start */
> +#define SSPSP_EDMYSTRT(x) =A0 =A0 =A0((x) << 26)
> +#define SSPSP_EDMYSTOP_MASK =A0 =A0(0x7 << 28) =A0 =A0 /* Extended Dummy=
 Stop */
> +#define SSPSP_EDMYSTOP(x) =A0 =A0 =A0((x) << 28)
> +#define SSPSP_TIMING_MASK =A0 =A0 =A0(SSPSP_STRTDLY_MASK | SSPSP_DMYSTRT=
_MASK \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SSPSP_SFR=
MDLY_MASK | SSPSP_SFRMWDTH_MASK \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SSPSP_DMY=
STOP_MASK | SSPSP_EDMYSTRT_MASK \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SSPSP_EDM=
YSTOP_MASK | SSPSP_FSRT)
> +
> +
> +#if defined(CONFIG_CPU_PXA910)
> +#define SSACD_SCDB =A0 =A0 =A0 =A0 =A0 =A0 (1 << 3) =A0 =A0 =A0 =A0/* SS=
PSYSCLK Divider Bypass */
> +#define SSACD_ACPS(x) =A0 =A0 =A0 =A0 =A0((x) << 4) =A0 =A0 =A0/* Audio =
clock PLL select */
> +#define SSACD_ACDS(x) =A0 =A0 =A0 =A0 =A0((x) << 0) =A0 =A0 =A0/* Audio =
clock divider select */
> +#define SSACD_SCDX8 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =A0 =A0 =A0 =A0/* SY=
SCLK division ratio select */
> +#endif
> +
> +
> +#endif /* __ASM_ARCH_REGS_SSP_H */
> +
> diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
> index 37dbdde..5f1a4dd 100644
> --- a/arch/arm/mach-mmp/pxa168.c
> +++ b/arch/arm/mach-mmp/pxa168.c
> @@ -72,6 +72,11 @@ static APBC_CLK(pwm1, PXA168_PWM1, 1, 13000000);
> =A0static APBC_CLK(pwm2, PXA168_PWM2, 1, 13000000);
> =A0static APBC_CLK(pwm3, PXA168_PWM3, 1, 13000000);
> =A0static APBC_CLK(pwm4, PXA168_PWM4, 1, 13000000);
> +static APBC_CLK(ssp1, PXA168_SSP1, 4, 0);
> +static APBC_CLK(ssp2, PXA168_SSP2, 4, 0);
> +static APBC_CLK(ssp3, PXA168_SSP3, 4, 0);
> +static APBC_CLK(ssp4, PXA168_SSP4, 4, 0);
> +static APBC_CLK(ssp5, PXA168_SSP5, 4, 0);
>
> =A0static APMU_CLK(nand, NAND, 0x01db, 208000000);
>
> @@ -85,6 +90,11 @@ static struct clk_lookup pxa168_clkregs[] =3D {
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_pwm2, "pxa168-pwm.1", NULL),
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_pwm3, "pxa168-pwm.2", NULL),
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_pwm4, "pxa168-pwm.3", NULL),
> + =A0 =A0 =A0 INIT_CLKREG(&clk_ssp1, "pxa168-ssp.0", NULL),
> + =A0 =A0 =A0 INIT_CLKREG(&clk_ssp2, "pxa168-ssp.1", NULL),
> + =A0 =A0 =A0 INIT_CLKREG(&clk_ssp3, "pxa168-ssp.2", NULL),
> + =A0 =A0 =A0 INIT_CLKREG(&clk_ssp4, "pxa168-ssp.3", NULL),
> + =A0 =A0 =A0 INIT_CLKREG(&clk_ssp5, "pxa168-ssp.4", NULL),
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
> =A0};
>
> @@ -132,3 +142,8 @@ PXA168_DEVICE(pwm2, "pxa168-pwm", 1, NONE,
> 0xd401a400, 0x10);
> =A0PXA168_DEVICE(pwm3, "pxa168-pwm", 2, NONE, 0xd401a800, 0x10);
> =A0PXA168_DEVICE(pwm4, "pxa168-pwm", 3, NONE, 0xd401ac00, 0x10);
> =A0PXA168_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
> +PXA168_DEVICE(ssp1, "pxa168-ssp", 0, SSP1, 0xd401b000, 0x40, 52, 53);
> +PXA168_DEVICE(ssp2, "pxa168-ssp", 1, SSP2, 0xd401c000, 0x40, 54, 55);
> +PXA168_DEVICE(ssp3, "pxa168-ssp", 2, SSP3, 0xd401f000, 0x40, 56, 57);
> +PXA168_DEVICE(ssp4, "pxa168-ssp", 3, SSP4, 0xd4020000, 0x40, 58, 59);
> +PXA168_DEVICE(ssp5, "pxa168-ssp", 4, SSP5, 0xd4021000, 0x40, 60, 61);
> diff --git a/arch/arm/plat-pxa/include/plat/ssp.h
> b/arch/arm/plat-pxa/include/plat/ssp.h
> index fc83ba7..06cffae 100644
> --- a/arch/arm/plat-pxa/include/plat/ssp.h
> +++ b/arch/arm/plat-pxa/include/plat/ssp.h
> @@ -14,6 +14,7 @@
> =A0* =A0 =A0 =A0 PXA26x =A0 =A0 SSP, NSSP, ASSP
> =A0* =A0 =A0 =A0 PXA27x =A0 =A0 SSP1, SSP2, SSP3
> =A0* =A0 =A0 =A0 PXA3xx =A0 =A0 SSP1, SSP2, SSP3, SSP4
> + * =A0 =A0 =A0 PXA168 =A0 =A0 SSP1, SSP2, SSP3, SSP4, SSP5
> =A0*/
>
> =A0#ifndef __ASM_PLAT_SSP_H
> @@ -27,6 +28,7 @@ enum pxa_ssp_type {
> =A0 =A0 =A0 =A0PXA25x_SSP, =A0/* pxa 210, 250, 255, 26x */
> =A0 =A0 =A0 =A0PXA25x_NSSP, /* pxa 255, 26x (including ASSP) */
> =A0 =A0 =A0 =A0PXA27x_SSP,
> + =A0 =A0 =A0 PXA168_SSP,
> =A0};
>
> =A0struct ssp_device {
> diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
> index d4a7673..4dc2ee6 100644
> --- a/arch/arm/plat-pxa/ssp.c
> +++ b/arch/arm/plat-pxa/ssp.c
> @@ -465,6 +465,7 @@ static const struct platform_device_id ssp_id_table[]=
 =3D {
> =A0 =A0 =A0 =A0{ "pxa25x-ssp", =A0 =A0 =A0 =A0 PXA25x_SSP },
> =A0 =A0 =A0 =A0{ "pxa25x-nssp", =A0 =A0 =A0 =A0PXA25x_NSSP },
> =A0 =A0 =A0 =A0{ "pxa27x-ssp", =A0 =A0 =A0 =A0 PXA27x_SSP },
> + =A0 =A0 =A0 { "pxa168-ssp", =A0 =A0 =A0 =A0 PXA168_SSP },
> =A0 =A0 =A0 =A0{ },
> =A0};
>
> --
> 1.5.6.5
>
