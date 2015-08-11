From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 1/4] ASoC: fsl_sai: Add driver suspend
 and resume to support MEGA Fast
Date: Tue, 11 Aug 2015 12:29:13 -0700
Message-ID: <20150811192912.GA54337@Asurada-CZ80>
References: <6fa4e6ebf1f34f5d637324c9f62e68b03037568c.1438928296.git.zidan.wang@freescale.com>
 <20150811091220.GA3008@Asurada-CZ80>
 <CAOMZO5Bs223E-gypxNM_GA6qrOc8yXO=yMH7UTCCU5VV_EbVOQ@mail.gmail.com>
 <20150811093448.GC28723@shlinux2>
 <CAOMZO5DPButcf=XbsPLLn6DF4oZKapjhg0OfktMjKf4hAAgpdQ@mail.gmail.com>
 <20150811095014.GD28723@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id A9DED26056B
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 21:29:50 +0200 (CEST)
Received: by pabyb7 with SMTP id yb7so136408269pab.0
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 12:29:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150811095014.GD28723@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.com, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 11, 2015 at 05:50:15PM +0800, Zidan Wang wrote:
> On Tue, Aug 11, 2015 at 07:46:40AM -0300, Fabio Estevam wrote:
> > On Tue, Aug 11, 2015 at 6:34 AM, Zidan Wang <zidan.wang@freescale.com> wrote:
> > 
> > > I have sent the SDMA remap patch to community, but have no response now. I can share the patch for you.

I've sent a similar patch a few months ago. And got comment from Sascha:
https://lkml.org/lkml/2015/4/27/87

I haven't got time to move forward though...

> > 
> > Please share the link to your patch, thanks.
> 
> https://patchwork.kernel.org/patch/6850431/
> 
> The other patch i can't find the link:
> diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
> index e391d63..73b28a1 100644
> --- a/arch/arm/boot/dts/imx6sx.dtsi
> +++ b/arch/arm/boot/dts/imx6sx.dtsi
> @@ -934,7 +934,7 @@
>                                          <&clks 0>, <&clks 0>;
>                                 clock-names = "bus", "mclk1", "mclk2", "mclk3";
>                                 dma-names = "rx", "tx";
> -                               dmas = <&sdma 31 23 0>, <&sdma 32 23 0>;
> +                               dmas = <&sdma 31 24 0>, <&sdma 32 24 0>;
>                                 dma-source = <&gpr 0 15 0 16>;
>                                 status = "disabled";
>                         };
> 
> 
