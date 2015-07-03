From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl-ssi: Fix bitclock calculation for
 master mode
Date: Fri, 3 Jul 2015 10:44:05 -0700
Message-ID: <20150703174404.GA9468@Asurada>
References: <1435919976-1667-1-git-send-email-jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435919976-1667-1-git-send-email-jbe@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Borleis <jbe@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 03, 2015 at 12:39:36PM +0200, Juergen Borleis wrote:
> According to the datasheet 'pm', 'psr' and 'div2' should never be all 0.
> Since commit 541b03ad6cfe ("ASoC: fsl_ssi: Fix the incorrect limitation of
> the bit clock rate") this can happen, because for some bitclock rates
> 'pm' = 0 seems to be a valid choice but does not work due to hardware
> restrictions. This results into a bad hardware behaviour (slow audio for
> example). Feature tested on a i.MX25.
> 
> Signed-off-by: Juergen Borleis <jbe@pengutronix.de>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you!

> ---
>  sound/soc/fsl/fsl_ssi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> index c7647e0..c0b940e 100644
> --- a/sound/soc/fsl/fsl_ssi.c
> +++ b/sound/soc/fsl/fsl_ssi.c
> @@ -633,7 +633,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
>  		sub *= 100000;
>  		do_div(sub, freq);
>  
> -		if (sub < savesub) {
> +		if (sub < savesub && !(i == 0 && psr == 0 && div2 == 0)) {
>  			baudrate = tmprate;
>  			savesub = sub;
>  			pm = i;
> -- 
> 2.1.4
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
