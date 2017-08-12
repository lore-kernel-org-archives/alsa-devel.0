From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3] ASoC: samsung: i2s: Null pointer dereference on
 samsung_i2s_remove
Date: Sat, 12 Aug 2017 09:10:51 +0200
Message-ID: <20170812071051.vslbtrgn732v7hvr@kozik-lap>
References: <1502456783-2047-1-git-send-email-vasilyev@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502456783-2047-1-git-send-email-vasilyev@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vasilyev <vasilyev@ispras.ru>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 11, 2017 at 04:06:23PM +0300, Anton Vasilyev wrote:
> If (quirks & QUIRK_SEC_DAI == 0) then samsung_i2s_probe() doesn't allocate
> sec_dai and pri_dai->sec_dai remains Null, but samsung_i2s_remove()
> performs pri_dai->sec_dai dereference in any case.
> 
> The patch adds sec_dai check on Null before derefence at
> samsung_i2s_remove().

No, I think this patch does not any check.

Best regards,
Krzysztof


> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
> v2: Drop initialization of sec_dai by NULL at samsung_i2s_remove
> as Sylwester Nawrocki suggest.
> ---
> v3: Fix typo in the comment
> ---
>  sound/soc/samsung/i2s.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index af3ba4d..6f896e3 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -1376,13 +1376,9 @@ static int samsung_i2s_probe(struct platform_device *pdev)
>  
>  static int samsung_i2s_remove(struct platform_device *pdev)
>  {
> -	struct i2s_dai *pri_dai, *sec_dai;
> +	struct i2s_dai *pri_dai;
>  
>  	pri_dai = dev_get_drvdata(&pdev->dev);
> -	sec_dai = pri_dai->sec_dai;
> -
> -	pri_dai->sec_dai = NULL;
> -	sec_dai->pri_dai = NULL;
>  
>  	pm_runtime_get_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> -- 
> 2.7.4
> 
