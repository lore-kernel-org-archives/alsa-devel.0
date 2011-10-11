From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Writing register default value for the reset
	register
Date: Tue, 11 Oct 2011 13:33:05 +0100
Message-ID: <20111011123305.GA2899@opensource.wolfsonmicro.com>
References: <1318326900.3526.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1318326900.3526.2.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 11, 2011 at 05:55:00PM +0800, Axel Lin wrote:
> The WM8983 can be reset by performing a write of any value to
> the software reset register.
> To avoid writing to the software reset register while resume,
> we should write the same value in wm8983_reg_defs to software
> reset register in wm8983_probe().
> The write to the reset register is suppressed by the cache
> restore code when it skips writes of default registers.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/codecs/wm8983.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8983.c b/sound/soc/codecs/wm8983.c
> index 17f04ec..93ee284 100644
> --- a/sound/soc/codecs/wm8983.c
> +++ b/sound/soc/codecs/wm8983.c
> @@ -1007,7 +1007,7 @@ static int wm8983_probe(struct snd_soc_codec *codec)
>  		return ret;
>  	}
>  
> -	ret = snd_soc_write(codec, WM8983_SOFTWARE_RESET, 0x8983);
> +	ret = snd_soc_write(codec, WM8983_SOFTWARE_RESET, 0);
>  	if (ret < 0) {
>  		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
>  		return ret;

We should probably just handle the reset register specially during
resume.

Thanks,
Dimitris
