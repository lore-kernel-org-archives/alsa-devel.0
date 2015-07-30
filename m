From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/6] ASoC: fsl_ssi: enable IPG clock during AC'97 reg access
Date: Thu, 30 Jul 2015 12:20:00 -0300
Message-ID: <CAOMZO5DJhCXr0oxY7q4TKs0AVS4nW6tDq4EHSGQHOZwf95YWWw@mail.gmail.com>
References: <55BA35A6.5050609@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55BA35A6.5050609@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Maciej,

On Thu, Jul 30, 2015 at 11:33 AM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

>  static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
> @@ -1151,6 +1160,14 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
>         unsigned short val = -1;
>         u32 reg_val;
>         unsigned int lreg;
> +       int ret;
> +
> +       ret = clk_prepare_enable(fsl_ac97_data->clk);
> +       if (ret) {
> +               pr_err("ac97 read clk_prepare_enable failed: %d\n",
> +                       ret);
> +               return -1;

return ret, please.
