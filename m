From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
Date: Sun, 21 Apr 2019 10:26:40 +0300
Message-ID: <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
References: <20190420154038.14576-1-daniel.baluta@nxp.com> <20190421053749.GA5552@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190421053749.GA5552@Asurada>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

Thanks for review!

On Sun, Apr 21, 2019 at 8:39 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> By following the pattern of previous Subjects:
> ASoC: fsl_sai: Fix clock Source for mclk0

I see. Will fix in v2.

>
> On Sat, Apr 20, 2019 at 03:41:04PM +0000, Daniel Baluta wrote:
> > SAI provide multiple master clock source options selectable
> > via bit MSEL of TCR2/RCR2.
> >
> > All possible master clock sources are stored in sai->mclk_clk
> > array. Current implementation assumes that MCLK0 source is always
> > busclk, but this is wrong!
> >
> > For example, on i.MX8QM we have:
> >
> > 00b - Bus Clock selected.
> > 01b - Master Clock (MCLK) 1 option selected.
> > 10b - Master Clock (MCLK) 2 option selected.
> > 11b - Master Clock (MCLK) 3 option selected.
> >
> > while on i.MX6SX we have:
> >
> > 00b - Master Clock (MCLK) 1 option selected.
> > 01b - Master Clock (MCLK) 1 option selected.
> > 10b - Master Clock (MCLK) 2 option selected.
> > 11b - Master Clock (MCLK) 3 option selected.
> >
> > So, this patch will read mclk0 source clock from device tree.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index d2a4dc744fd7..faa8de87ff83 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -829,8 +829,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
> >               sai->bus_clk = NULL;
> >       }
> >
> > -     sai->mclk_clk[0] = sai->bus_clk;
> > -     for (i = 1; i < FSL_SAI_MCLK_MAX; i++) {
> > +     for (i = 0; i < FSL_SAI_MCLK_MAX; i++) {
> >               sprintf(tmp, "mclk%d", i);
>
> Firstly, according to your commit message, neither imx8qm nor
> imx6sx has an "mclk0" clock in the clock list. Either of them
> starts with "mclk1". So, before you change the driver, I don't
> think it's even a right thing to define an "mclk0" in the DT.

>From what I understand mclk0 means option 00b of MSEL bits which is:
* busclk for i.MX8
* mclk1 for i.MX6/7.

Adding a mclk0 in the DT and making it point to the correct option
(busclk or mclk1) does no harm as the driver doesn't yet parse mclk0.

I have already sent a patch to add mclk0 to imx6/7 DTS here:

https://lkml.org/lkml/2019/4/20/56

So, even if the DT change gets accepted first there shouldn't pe any
problem, as the driver won't parse mclk0 string yet.

Even if the current patch gets accepted first it shouldn't be any problem
also as the probe will try to find "mclk0" in the DT and will just print a
warning and move on looking for mclk1, mclk2...

>
> >               sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
> >               if (IS_ERR(sai->mclk_clk[i])) {
>
> Secondly, this would break existing DT bindings of imx6sx and
> imx7 platforms as they both have clock-names defined in DTB:
>         clock-names = "bus", "mclk1", "mclk2", "mclk3";
> Since there's no "mclk0", the entire probe() would error-out.

Not exactly. The probe won't error-out. It will just print a warning message

dev_err(&pdev->dev, "failed to get mclk%d clock: %ld\n"

and move on.

The functionality, will still be the same.

> And mainline has a DT backward-compatible policy, which means
> you can't just rename the "bus" in the DTBs but would have to
> support them, not to mention "mclk0" is still questionable.

My patch doesn't rename "bus" in the DTB. "bus" clock stays there. It just
adds another clock "mclk0".

In my opinion, the current implementation of fsl_sai has a bug for imx6/7.

Currently, fsl_sai.c driver does:

       sai->mclk_clk[0] = sai->bus_clk;

is wrong, because on imx6/7 mclk_clk[0] should point to the same clk
as mclk_clk[1]


>
> So the right way to fix it is, in my option, to differentiate
> the mclk_clk[0] clock source name with the compatible string.
> Then you can get the clock name and simply do:
> -       sai->mclk_clk[0] = sai->bus_clk;
> +       sai->mclk_clk[0] = devm_clk_get(&pdev->dev, tmp);
> +       if (IS_ERR(sai->mclk_clk[0)) {
> +               /* error-out*/
> +       }

My approach is to add mclk0 in the DT and make it point to:
* busclk for i.MX8
* mclk1 for i.MX6/7.

So, here it is how the DT nodes will look like:

$ arch/arm/boot/dts/imx6sx.dtsi

clocks = <&clks IMX6SX_CLK_SAI1_IPG>,
   <&clks IMX6SX_CLK_SAI1>,
    <&clks IMX6SX_CLK_SAI1>,
    <&clks 0>, <&clks 0>;
clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";

$ arch/arm64/boot/dts/freescale/fsl-imx8mq.dtsi
clocks = <&clk IMX8MQ_CLK_SAI2_IPG>,
             <&clk  IMX8MQ_CLK_SAI2_IPG>,
             <&clk IMX8MQ_CLK_SAI2_ROOT>,
             <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";

This approach makes busclk/mclk0 handling generic and avoids the looking
for compatible strings.

thanks,
Daniel.
