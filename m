From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: Applied "ASoC: samsung: s3c2412: Handle return value of
 clk_prepare_enable." to the asoc tree
Date: Wed, 26 Jul 2017 17:46:42 +0200
Message-ID: <20170726154642.GB2577@kozik-book>
References: <1500977674-27960-2-git-send-email-arvind.yadav.cs@gmail.com>
 <E1daN7g-0003Ze-AF@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1daN7g-0003Ze-AF@debutante>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>, perex@perex.cz, tiwai@suse.com, sbkim73@samsung.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 26, 2017 at 03:17:12PM +0100, Mark Brown wrote:
> The patch
> 
>    ASoC: samsung: s3c2412: Handle return value of clk_prepare_enable.
> 
> has been applied to the asoc tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
> From d2d2c0a0f0e230e9650e778d0d5c7ed6d1bcffb0 Mon Sep 17 00:00:00 2001
> From: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Date: Tue, 25 Jul 2017 15:44:28 +0530
> Subject: [PATCH] ASoC: samsung: s3c2412: Handle return value of
>  clk_prepare_enable.
> 
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/samsung/s3c2412-i2s.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
> index 0a4718207e6e..bcd1cbdeac93 100644
> --- a/sound/soc/samsung/s3c2412-i2s.c
> +++ b/sound/soc/samsung/s3c2412-i2s.c
> @@ -71,7 +71,9 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
>  	/* Set MPLL as the source for IIS CLK */
>  
>  	clk_set_parent(s3c2412_i2s.iis_cclk, clk_get(NULL, "mpll"));
> -	clk_prepare_enable(s3c2412_i2s.iis_cclk);
> +	ret = clk_prepare_enable(s3c2412_i2s.iis_cclk);
> +	if (ret)
> +		return ret;

Mark, this is the patch still discussed. It does not handle the error
correctly. I think it should be dropped.

Best regards,
Krzysztof
