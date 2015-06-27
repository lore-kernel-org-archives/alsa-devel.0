From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: fix AC'97 mode
Date: Sat, 27 Jun 2015 20:09:30 -0300
Message-ID: <CAOMZO5AkwGkj-Qmv6k+A7aV=SeuoPD1Mcc-hBFtuLSs2iaBSJA@mail.gmail.com>
References: <558F28E1.7040204@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <558F28E1.7040204@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 27, 2015 at 7:51 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

> +
> +       ret = clk_prepare_enable(fsl_ac97_data->clk);
> +       if (ret) {
> +               pr_err("ac97 read clk_prepare_enable failed: %d\n",
> +                       ret);
> +               return -1;

'return ret' would be better here.

Thanks
