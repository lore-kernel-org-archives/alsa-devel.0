From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH V2 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Date: Thu, 11 Apr 2019 14:15:28 +0300
Message-ID: <CAEnQRZAQk1w79uqFCBCkFy=4_FQvxetfPsS10c+AMddJpc1VNg@mail.gmail.com>
References: <cover.1554975348.git.shengjiu.wang@nxp.com> <a04859bff36ba26cb4cb51ff092a3f2e2eca455d.1554975348.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a04859bff36ba26cb4cb51ff092a3f2e2eca455d.1554975348.git.shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Shengjiu,

Mostly looking good. See few comments inline:

<snip>

> +/*
> + * Select the pre-processing and post-processing options
> + *
> + * Fsin: input sample rate
> + * Fsout: output sample rate
> + * pre_proc: return value for pre-processing option
> + * post_proc: return value for post-processing option
> + */
> +static int fsl_asrc_sel_proc(int Fsin, int Fsout, int *pre_proc, int *post_proc)

Lets be naming consistent here: Fsin -> fs_in, Fsout -> fs_out.

> +{
> +       bool det_out_op2_cond;
> +       bool det_out_op0_cond;
> +
> +       /* Codition for selection of post-processing */
> +       det_out_op2_cond = (((Fsin * 15 > Fsout * 16) & (Fsout < 56000)) |
> +                                       ((Fsin > 56000) & (Fsout < 56000)));
Remove outer parenthesis. Also should here be a logical or (||)
instead of bitwise or (|)?
Same for && vs &.

> +       det_out_op0_cond = (Fsin * 23 < Fsout * 8);

Remove outer parenthesis.
> +
> +       /*
> +        * unsupported case: Tsout>16.125*Tsin, and Tsout>8.125*Tsin.
> +        * Tsout>16.125*Tsin -> Fsin * 8 > 129 * Fsout
> +        * Tsout>8.125*Tsin  -> Fsin * 8 > 65 * Fsout
> +        * Tsout>4.125*Tsin  -> Fsin * 8 > 33 * Fsout
> +        * Tsout>1.875*Tsin  -> Fsin * 8 > 15 * Fsout
> +        */
> +       if (Fsin * 8 > 129 * Fsout)
> +               *pre_proc = 5;
> +       else if (Fsin * 8 > 65 * Fsout)
> +               *pre_proc = 4;
> +       else if (Fsin * 8 > 33 * Fsout)
> +               *pre_proc = 2;
> +       else if (Fsin * 8 > 15 * Fsout) {
> +               if (Fsin > 152000)
> +                       *pre_proc = 2;
> +               else
> +                       *pre_proc = 1;
> +       } else if (Fsin < 76000)
> +               *pre_proc = 0;
> +       else if (Fsin > 152000)
> +               *pre_proc = 2;
> +       else
> +               *pre_proc = 1;
> +
> +       if (det_out_op2_cond)
> +               *post_proc = 2;
> +       else if (det_out_op0_cond)
> +               *post_proc = 0;
> +       else
> +               *post_proc = 1;
> +
> +       /* unsupported options */
> +       if (*pre_proc == 4 || *pre_proc == 5)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  /**
>   * Request ASRC pair
>   *
> @@ -239,8 +278,10 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>         u32 inrate, outrate, indiv, outdiv;
>         u32 clk_index[2], div[2];
>         int in, out, channels;
> +       int pre_proc, post_proc;
>         struct clk *clk;
>         bool ideal;
> +       int ret;
>
>         if (!config) {
>                 pair_err("invalid pair config\n");
> @@ -289,6 +330,12 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>                 return -EINVAL;
>         }
>
> +       ret = fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
> +       if (ret) {
> +               pair_err("No supported pre-processing options\n");
> +               return ret;
> +       }
> +
>         /* Validate input and output clock sources */
>         clk_index[IN] = clk_map[IN][config->inclk];
>         clk_index[OUT] = clk_map[OUT][config->outclk];
> @@ -380,8 +427,8 @@ static int fsl_asrc_config_pair(struct fsl_asrc_pair *pair)
>         /* Apply configurations for pre- and post-processing */
>         regmap_update_bits(asrc_priv->regmap, REG_ASRCFG,
>                            ASRCFG_PREMODi_MASK(index) | ASRCFG_POSTMODi_MASK(index),
> -                          ASRCFG_PREMOD(index, process_option[in][out][0]) |
> -                          ASRCFG_POSTMOD(index, process_option[in][out][1]));
> +                          ASRCFG_PREMOD(index, pre_proc) |
> +                          ASRCFG_POSTMOD(index, post_proc));
>
>         return fsl_asrc_set_ideal_ratio(pair, inrate, outrate);
>  }
> --
> 1.9.1
>
