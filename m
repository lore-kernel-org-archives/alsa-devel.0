From: Fabio Estevam <festevam@gmail.com>
Subject: Re: iMX6UL EVK with kernel 4.6
Date: Mon, 2 May 2016 10:17:08 -0300
Message-ID: <CAOMZO5DKeAN2bBOHz+yc0JtLpDeQdh+fhz2_SR-3FsDkgJR-Bw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
 [209.85.223.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 83ADC260421
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 15:17:09 +0200 (CEST)
Received: by mail-io0-f171.google.com with SMTP id u185so195279599iod.3
 for <alsa-devel@alsa-project.org>; Mon, 02 May 2016 06:17:09 -0700 (PDT)
In-Reply-To: <CAOMZO5Bjg6b4prxMDsJPceYGMv3kL+0fQ4Acm8bjAa=Ey728+g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <brain@jikos.cz>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

Hi Petr,

On Mon, May 2, 2016 at 9:43 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Ok, managed to unmute these options in alsamixer and now I get audio
> with NXP 3.14 kernel.
>
> Will try with mainline now.

I can get audio with mainline now, but it plays with an incorrect pitch.

Here is a quick hack to allow MCLK to be driven:

--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -22,9 +22,12 @@ static void __init imx6ul_enet_clk_init(void)
        struct regmap *gpr;

        gpr = syscon_regmap_lookup_by_compatible("fsl,imx6ul-iomuxc-gpr");
-       if (!IS_ERR(gpr))
+       if (!IS_ERR(gpr)) {
                regmap_update_bits(gpr, IOMUXC_GPR1, IMX6UL_GPR1_ENET_CLK_DIR,
                                   IMX6UL_GPR1_ENET_CLK_OUTPUT);
+               regmap_update_bits(gpr, IOMUXC_GPR1, (1 << 20), (1 << 20));
+
+       }
        else
                pr_err("failed to find fsl,imx6ul-iomux-gpr regmap\n");

As next steps we need:

1. Fix the sound pitch

2. Find a proper way to enable MCLK.

Let me know if you get any progress so that we can upstream audio on this board.
