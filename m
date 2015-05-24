From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel] [PATCH trivial] ASoC: fsl_esai: Spelling
 s/specifially/specifically/
Date: Sat, 23 May 2015 23:41:31 -0700
Message-ID: <20150524064130.GA2144@Asurada>
References: <1432209738-20877-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432209738-20877-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Timur Tabi <timur@tabi.org>, Takashi Iwai <tiwai@suse.de>, Jiri Kosina <trivial@kernel.org>, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 21, 2015 at 02:02:18PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>


Thank you

> ---
>  sound/soc/fsl/fsl_esai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index 5c7597191e3ffc68..45eee131c47d43cd 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -517,7 +517,7 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,
>  	u32 bclk, mask, val;
>  	int ret;
>  
> -	/* Override slot_width if being specifially set */
> +	/* Override slot_width if being specifically set */
>  	if (esai_priv->slot_width)
>  		slot_width = esai_priv->slot_width;
>  
> -- 
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
