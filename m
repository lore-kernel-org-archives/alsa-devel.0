From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH -next] ASoC: fsl_micfil: Remove set but not used variable 'osr'
Date: Wed, 17 Apr 2019 18:25:11 +0300
Message-ID: <CAEnQRZAug2kQoFTN6W47URBKwHcU5Zmmy=04smOtMomuzz6_TA@mail.gmail.com>
References: <20190417150915.37968-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417150915.37968-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yue Haibing <yuehaibing@huawei.com>
Cc: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, Linux-ALSA <alsa-devel@alsa-project.org>, Cosmin-Gabriel Samoila <gabrielcsmo@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Yue,

Looks good to me. Just one question for Cosmin:

On Wed, Apr 17, 2019 at 6:10 PM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> sound/soc/fsl/fsl_micfil.c: In function 'get_clk_div':
> sound/soc/fsl/fsl_micfil.c:154:6: warning: variable 'osr' set but not used [-Wunused-but-set-variable]
>
> It is never used since introduction in
> commit 47a70e6fc9a8 ("ASoC: Add MICFIL SoC Digital Audio Interface driver.")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/fsl/fsl_micfil.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
> index 40c07e7..f7f2d29 100644
> --- a/sound/soc/fsl/fsl_micfil.c
> +++ b/sound/soc/fsl/fsl_micfil.c
> @@ -151,12 +151,9 @@ static inline int get_clk_div(struct fsl_micfil *micfil,
>  {
>         u32 ctrl2_reg;
>         long mclk_rate;
> -       int osr;
>         int clk_div;
>
>         regmap_read(micfil->regmap, REG_MICFIL_CTRL2, &ctrl2_reg);

I noticed now that we also read ctrl2_reg without using it. Is this as intended?

> -       osr = 16 - ((ctrl2_reg & MICFIL_CTRL2_CICOSR_MASK)
> -                   >> MICFIL_CTRL2_CICOSR_SHIFT);
>
>         mclk_rate = clk_get_rate(micfil->mclk);
>
> --
> 2.7.4
>
>
