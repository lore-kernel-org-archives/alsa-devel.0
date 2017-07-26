From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 01/11] ASoC: samsung: s3c2412: Handle return value of
 clk_prepare_enable.
Date: Wed, 26 Jul 2017 17:45:07 +0200
Message-ID: <20170726154507.GA2577@kozik-book>
References: <84c0014d4dbd466f52c45d8efbd2c1080d8174fb.1501047400.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <84c0014d4dbd466f52c45d8efbd2c1080d8174fb.1501047400.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, sbkim73@samsung.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 26, 2017 at 11:15:25AM +0530, Arvind Yadav wrote:
> clk_prepare_enable() can fail here and we must check its return value.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> Chnage in v2 :
>              Error handling for things done in s3c_i2sv2_probe().
> 
>  sound/soc/samsung/s3c2412-i2s.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
> index 0a47182..0b96927 100644
> --- a/sound/soc/samsung/s3c2412-i2s.c
> +++ b/sound/soc/samsung/s3c2412-i2s.c
> @@ -65,13 +65,16 @@ static int s3c2412_i2s_probe(struct snd_soc_dai *dai)
>  	s3c2412_i2s.iis_cclk = devm_clk_get(dai->dev, "i2sclk");
>  	if (IS_ERR(s3c2412_i2s.iis_cclk)) {
>  		pr_err("failed to get i2sclk clock\n");
> -		return PTR_ERR(s3c2412_i2s.iis_cclk);
> +		ret = PTR_ERR(s3c2412_i2s.iis_cclk);
> +		goto err;

No, this is kind of messy and error-prone. I think that each unit should
rather clean by itself. You should not touch s3c_i2sv2 stuff directly.

Instead define a s3c_i2sv2_cleanup() (or remove() to match the
convention?) and call it here on error-paths.

Best regards,
Krzysztof
