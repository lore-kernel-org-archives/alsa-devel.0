From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: imx-audmix: fix object reference leaks in probe
Date: Tue, 9 Apr 2019 13:08:47 +0300
Message-ID: <CAEnQRZDQRTy+D0ntbTh2OCPfBM_N=yFP-k_JXmF7p-5vsku-ig@mail.gmail.com>
References: <1554798876-20653-1-git-send-email-viorel.suman@nxp.com> <1554798876-20653-3-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554798876-20653-3-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Julia Lawall <Julia.Lawall@lip6.fr>, Viorel Suman <viorel.suman@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.inf>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 9, 2019 at 11:36 AM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Release the reference to the underlying device taken
> by of_find_device_by_node() call.
>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Please add here the Reported-by tag pointing to Julia.

> ---
>  sound/soc/fsl/imx-audmix.c | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
> index 7983bd3..7c24095 100644
> --- a/sound/soc/fsl/imx-audmix.c
> +++ b/sound/soc/fsl/imx-audmix.c
> @@ -20,10 +20,7 @@
>  #include "fsl_audmix.h"
>
>  struct imx_audmix {
> -       struct platform_device *pdev;
>         struct snd_soc_card card;
> -       struct platform_device *audmix_pdev;
> -       struct platform_device *out_pdev;

I am not sure why are you removing these members here. It doesn't seem to match
with patch description. If these are needed to simplify the code please do it in
another patch.

This patch should only fix one problem and that is the refleak.

thanks,
Daniel.
