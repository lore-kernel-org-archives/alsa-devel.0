From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Mon, 2 Nov 2015 10:57:38 +0100
Message-ID: <56373392.6010901@tekno-soft.it>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
 <CAOMZO5AXbMgJUgVHA2954NfvYEfX5eaWzTwprpgL1krCJ-Ut6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id C0D3226070C
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 10:57:57 +0100 (CET)
In-Reply-To: <CAOMZO5AXbMgJUgVHA2954NfvYEfX5eaWzTwprpgL1krCJ-Ut6w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 11/01/2015 09:31 PM, Fabio Estevam wrote:

Hi Fabio,

> Hi Roberto,
>
> On Sat, Oct 31, 2015 at 7:16 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>
>>> Since you are using single FIFO configuration, which SDMA script
>>> are you using? This should reflects in the Device Tree. As far as
>>> I learned, FSL 3.14 is using number 22 for SSIs which is the one
>>> for Dual FIFO Mode.
>> No! Currently is 1. Here the Freescale's v3.14.28 GA imx6sx.dtsi entry
>>
>>                 ssi1: ssi@02028000 {
>>                     compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
>>                     reg = <0x02028000 0x4000>;
>>                     interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
>>                     clocks = <&clks IMX6SX_CLK_SSI1_IPG>,
>>                          <&clks IMX6SX_CLK_SSI1>;
>>                     clock-names = "ipg", "baud";
>>                     dmas = <&sdma 37 1 0>, <&sdma 38 1 0>;
>>                     dma-names = "rx", "tx";
>>                     status = "disabled";
>>                 };
> Take a look at imx_3.14.38_6ul_ga branch; It does use 22 in the dmas nodes:
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/arch/arm/boot/dts/imx6sx.dtsi?h=imx_3.14.38_6ul_ga
>
> However, this list is only about mainline kernel, so please run all
> your tests with mainline instead of FSL 3.14.
>

Ok! I'm doing that right now.
