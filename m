From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl-sai: convert to use regmap API for
 Freeacale SAI
Date: Thu, 23 Jan 2014 08:11:02 -0200
Message-ID: <CAOMZO5ATVkcORZBMbNzu2F-dyJxjzgjkRgezj2vGM9v7cyfy1w@mail.gmail.com>
References: <1390463283-7545-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390463283-7545-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <Guangyu.Chen@freescale.com>, Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 23, 2014 at 5:48 AM, Xiubo Li <Li.Xiubo@freescale.com> wrote:

>  static int fsl_sai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
>                 int clk_id, unsigned int freq, int dir)
>  {
> -       struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
>         int ret;
>
>         if (dir == SND_SOC_CLOCK_IN)
>                 return 0;
>
> -       ret = clk_prepare_enable(sai->clk);
> -       if (ret)
> -               return ret;

The clock related change seems unrelated to the usage of regmap, right?

>  static int fsl_sai_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
>  {
> -       struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
>         int ret;
>
> -       ret = clk_prepare_enable(sai->clk);
> -       if (ret)
> -               return ret;

Same here.

Regards,

Fabio Estevam
