From: Fabio Estevam <festevam@gmail.com>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Sun, 1 Nov 2015 18:31:33 -0200
Message-ID: <CAOMZO5AXbMgJUgVHA2954NfvYEfX5eaWzTwprpgL1krCJ-Ut6w@mail.gmail.com>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 28A19260523
 for <alsa-devel@alsa-project.org>; Sun,  1 Nov 2015 21:31:35 +0100 (CET)
Received: by igbhv6 with SMTP id hv6so42332845igb.0
 for <alsa-devel@alsa-project.org>; Sun, 01 Nov 2015 12:31:34 -0800 (PST)
In-Reply-To: <5634870A.4080206@tekno-soft.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Roberto,

On Sat, Oct 31, 2015 at 7:16 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:

>> Since you are using single FIFO configuration, which SDMA script
>> are you using? This should reflects in the Device Tree. As far as
>> I learned, FSL 3.14 is using number 22 for SSIs which is the one
>> for Dual FIFO Mode.
>
> No! Currently is 1. Here the Freescale's v3.14.28 GA imx6sx.dtsi entry
>
>                 ssi1: ssi@02028000 {
>                     compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
>                     reg = <0x02028000 0x4000>;
>                     interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
>                     clocks = <&clks IMX6SX_CLK_SSI1_IPG>,
>                          <&clks IMX6SX_CLK_SSI1>;
>                     clock-names = "ipg", "baud";
>                     dmas = <&sdma 37 1 0>, <&sdma 38 1 0>;
>                     dma-names = "rx", "tx";
>                     status = "disabled";
>                 };

Take a look at imx_3.14.38_6ul_ga branch; It does use 22 in the dmas nodes:
http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/boot/dts/imx6sx.dtsi?h=imx_3.14.38_6ul_ga

However, this list is only about mainline kernel, so please run all
your tests with mainline instead of FSL 3.14.
