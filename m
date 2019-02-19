From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: fix sysclk_df type
Date: Tue, 19 Feb 2019 11:01:22 -0800
Message-ID: <20190219190121.GB13373@Asurada-Nvidia.nvidia.com>
References: <1550503474-18865-1-git-send-email-viorel.suman@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550503474-18865-1-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Viorel Suman <viorel.suman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2019 at 03:25:00PM +0000, Viorel Suman wrote:
> According to RM SPDIF STC SYSCLK_DF field is 9-bit wide, values
> being in 0..511 range. Use a proper type to handle sysclk_df.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_spdif.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index a26686e..4842e6d 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -96,7 +96,7 @@ struct fsl_spdif_priv {
>  	bool dpll_locked;
>  	u32 txrate[SPDIF_TXRATE_MAX];
>  	u8 txclk_df[SPDIF_TXRATE_MAX];
> -	u8 sysclk_df[SPDIF_TXRATE_MAX];
> +	u16 sysclk_df[SPDIF_TXRATE_MAX];
>  	u8 txclk_src[SPDIF_TXRATE_MAX];
>  	u8 rxclk_src;
>  	struct clk *txclk[SPDIF_TXRATE_MAX];
> @@ -376,7 +376,8 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
>  	struct platform_device *pdev = spdif_priv->pdev;
>  	unsigned long csfs = 0;
>  	u32 stc, mask, rate;
> -	u8 clk, txclk_df, sysclk_df;
> +	u16 sysclk_df;
> +	u8 clk, txclk_df;
>  	int ret;
>  
>  	switch (sample_rate) {
> @@ -1109,8 +1110,9 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
>  	static const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
>  	bool is_sysclk = clk_is_match(clk, spdif_priv->sysclk);
>  	u64 rate_ideal, rate_actual, sub;
> -	u32 sysclk_dfmin, sysclk_dfmax;
> -	u32 txclk_df, sysclk_df, arate;
> +	u32 arate;
> +	u16 sysclk_dfmin, sysclk_dfmax, sysclk_df;
> +	u8 txclk_df;
>  
>  	/* The sysclk has an extra divisor [2, 512] */
>  	sysclk_dfmin = is_sysclk ? 2 : 1;
> -- 
> 2.7.4
> 
