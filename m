From: Petr Kulhavy <brain@jikos.cz>
Subject: Re: iMX6UL EVK with kernel 4.6
Date: Mon, 2 May 2016 21:30:46 +0200
Message-ID: <4cc213b7-8e4e-c47c-1ac9-57a3bf1b91b7@jikos.cz>
References: <50f27095-3304-03fa-7209-3f05baccb346@jikos.cz>
 <CAOMZO5BU2--_CV8FUsvkkesKGLW9NcnDPNvxC7UnK5vWwgDqVQ@mail.gmail.com>
 <CAOMZO5BGDnECdRFU6XFws9poNyF-yGJbv=io43mQgcqO4L-fbw@mail.gmail.com>
 <0721dbbe-a122-6be3-743f-669672b2c83f@jikos.cz>
 <CAOMZO5BM-EM0s5zWUmbRMkzV11Az9D+KLmQJ7dgv_RvKX9mihg@mail.gmail.com>
 <e163b954-0c4b-b859-0e15-ea113d2f5ddd@jikos.cz>
 <CAOMZO5Am7xQS556TpX5Xjk5s19CjMzH=+roY7jPhmRD25fiEvQ@mail.gmail.com>
 <3bede708-4c7c-dfae-fb26-c20a42289836@jikos.cz>
 <CAOMZO5CbtgcencL7UTk8HUmJwEd7HuLDSNNGuLA0UUn5Grxdig@mail.gmail.com>
 <CAOMZO5Bjg6b4prxMDsJPceYGMv3kL+0fQ4Acm8bjAa=Ey728+g@mail.gmail.com>
 <CAOMZO5DKeAN2bBOHz+yc0JtLpDeQdh+fhz2_SR-3FsDkgJR-Bw@mail.gmail.com>
Reply-To: brain@jikos.cz
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep26.mx.upcmail.net (fep26.mx.upcmail.net [62.179.121.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 50D5F260438
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 21:30:48 +0200 (CEST)
Received: from edge04.upcmail.net ([192.168.13.239]) by viefep26-int.chello.at
 (InterMail vM.8.01.05.18 201-2260-151-151-20140610) with ESMTP
 id <20160502193047.MGNZ8108.viefep26-int.chello.at@edge04.upcmail.net>
 for <alsa-devel@alsa-project.org>; Mon, 2 May 2016 21:30:47 +0200
In-Reply-To: <CAOMZO5DKeAN2bBOHz+yc0JtLpDeQdh+fhz2_SR-3FsDkgJR-Bw@mail.gmail.com>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On 02/05/16 15:17, Fabio Estevam wrote:
> Hi Petr,
>
> I can get audio with mainline now, but it plays with an incorrect pitch.
>
> Here is a quick hack to allow MCLK to be driven:
>
> --- a/arch/arm/mach-imx/mach-imx6ul.c
> +++ b/arch/arm/mach-imx/mach-imx6ul.c
> @@ -22,9 +22,12 @@ static void __init imx6ul_enet_clk_init(void)
>          struct regmap *gpr;
>
>          gpr = syscon_regmap_lookup_by_compatible("fsl,imx6ul-iomuxc-gpr");
> -       if (!IS_ERR(gpr))
> +       if (!IS_ERR(gpr)) {
>                  regmap_update_bits(gpr, IOMUXC_GPR1, IMX6UL_GPR1_ENET_CLK_DIR,
>                                     IMX6UL_GPR1_ENET_CLK_OUTPUT);
> +               regmap_update_bits(gpr, IOMUXC_GPR1, (1 << 20), (1 << 20));
> +
> +       }
>          else
>                  pr_err("failed to find fsl,imx6ul-iomux-gpr regmap\n");
Cool, now my board plays too! Thanks!
> As next steps we need:
>
> 1. Fix the sound pitch
Mine plays at the correct speed. For the correct speed the clock 
assignment from the Freescale DTS needs to be copied, so that the SAI2 
clock generates 12.288MHz.
Below are the relevant nodes from my DTS:

&clks {
         assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
         assigned-clock-rates = <786432000>;
};

&sai2 {
         pinctrl-names = "default";
         pinctrl-0 = <&pinctrl_sai2>;

         assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
                           <&clks IMX6UL_CLK_SAI2>;
         assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
         assigned-clock-rates = <0>, <12288000>;

         status = "okay";
};

> 2. Find a proper way to enable MCLK.
>

I would tend to put the control of the SAIx_MCLK_DIR into the SAI driver 
and if needed add an extra boolean property like "enable-mclk-output".
Leaving it independent makes not much sense, for binding to the 
clock/pinmux it's too generic and the Freescale solution with a gpr phandle
isn't very lucky either as it forces the use of the fsl soundcard and 
doesn't allow e.g. the simple-audio-card.

But let's see what else the Freescale or ALSA developers suggest.

Cheers
Petr
