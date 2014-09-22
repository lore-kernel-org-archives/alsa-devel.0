From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Allow to describe
 master or slave mode
Date: Mon, 22 Sep 2014 07:44:19 +0200
Message-ID: <CAOf5uwkdSgxUiY2pPTRG1oWTqBUHGDzNGxuq-hB-fHh95QPMBA@mail.gmail.com>
References: <1411360854-16891-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A083265011
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 07:44:22 +0200 (CEST)
Received: by mail-we0-f176.google.com with SMTP id w61so1423660wes.21
 for <alsa-devel@alsa-project.org>; Sun, 21 Sep 2014 22:44:20 -0700 (PDT)
In-Reply-To: <1411360854-16891-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi

Il 22/set/2014 06:41 "Fabio Estevam" <festevam@gmail.com> ha scritto:
>
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Provide a mechanism to describe whether the system runs in master or
slave mode.
>
> In order to keep compatibilty with existing dtb's let slave mode be
default one.
>
> Tested on a imx6q-sabresd board in both modes.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-asoc-card.txt |  5 +++++
>  sound/soc/fsl/fsl-asoc-card.c                             | 15
++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> index a96774c..1bbc828 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> @@ -59,6 +59,10 @@ Optional properties:
>    - audio-asrc         : The phandle of ASRC. It can be absent if
there's no
>                           need to add ASRC support via DPCM.
>
> +  - audio-cpu-mode     : The operating mode for the audio cpu interface.
> +                         "slave" - audio clock comes from the external
codec
> +                         "master" -audio clock is generated from the
audio cpu
> +
>  Example:
>  sound-cs42888 {
>         compatible = "fsl,imx-audio-cs42888";
> @@ -66,6 +70,7 @@ sound-cs42888 {
>         audio-cpu = <&esai>;
>         audio-asrc = <&asrc>;
>         audio-codec = <&cs42888>;
> +       audio-cpu-mode = "master";
>         audio-routing =
>                 "Line Out Jack", "AOUT1L",
>                 "Line Out Jack", "AOUT1R",
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 007c772..bd903cc 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -393,6 +393,7 @@ static int fsl_asoc_card_probe(struct platform_device
*pdev)
>         struct clk *codec_clk;
>         u32 width;
>         int ret;
> +       const char *mode;
>
>         priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
> @@ -441,6 +442,17 @@ static int fsl_asoc_card_probe(struct
platform_device *pdev)
>         /* Assign a default DAI format, and allow each card to overwrite
it */
>         priv->dai_fmt = DAI_FMT_BASE;
>
> +       mode = of_get_property(np, "audio-cpu-mode", NULL);
> +       if (mode) {
> +               if (!strcmp(mode, "master"))
> +                       priv->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
> +               else if (!strcmp(mode, "slave"))
> +                       priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
> +       } else {
> +               /* Assign slave mode by default */
> +               priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
> +       }
> +

If mode has no error path, what is the clocking in error scenario?

if (mode && is_master)
     set_master
else
     set_slave

Michael

>         /* Diversify the card configurations */
>         if (of_device_is_compatible(np, "fsl,imx-audio-cs42888")) {
>                 priv->card.set_bias_level = NULL;
> @@ -448,16 +460,13 @@ static int fsl_asoc_card_probe(struct
platform_device *pdev)
>                 priv->cpu_priv.sysclk_freq[RX] =
priv->codec_priv.mclk_freq;
>                 priv->cpu_priv.sysclk_dir[TX] = SND_SOC_CLOCK_OUT;
>                 priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
> -               priv->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
>         } else if (of_device_is_compatible(np, "fsl,imx-audio-sgtl5000"))
{
>                 priv->codec_priv.mclk_id = SGTL5000_SYSCLK;
> -               priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
>         } else if (of_device_is_compatible(np, "fsl,imx-audio-wm8962")) {
>                 priv->card.set_bias_level = fsl_asoc_card_set_bias_level;
>                 priv->codec_priv.mclk_id = WM8962_SYSCLK_MCLK;
>                 priv->codec_priv.fll_id = WM8962_SYSCLK_FLL;
>                 priv->codec_priv.pll_id = WM8962_FLL;
> -               priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
>         } else {
>                 dev_err(&pdev->dev, "unknown Device Tree compatible\n");
>                 return -EINVAL;
> --
> 1.9.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
