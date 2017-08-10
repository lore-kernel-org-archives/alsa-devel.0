From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] ASoC: samsung: i2s: Null pointer dereference on
 samsung_i2s_remove
Date: Thu, 10 Aug 2017 18:23:48 +0200
Message-ID: <152db371-4fe3-0c49-64c9-200fd3ebfbc8@samsung.com>
References: <CGME20170810155722epcas3p231f6d4733d933b10461db96d9065674a@epcas3p2.samsung.com>
        <1502380599-13535-1-git-send-email-vasilyev@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1502380599-13535-1-git-send-email-vasilyev@ispras.ru>
Content-language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vasilyev <vasilyev@ispras.ru>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: alsa-devel@alsa-project.org

On 08/10/2017 05:56 PM, Anton Vasilyev wrote:
> If (quirks & QUIRK_SEC_DAI == 0) then samsung_i2s_probe() doesn't allocate
> sec_dai and pri_dai->sec_dai remains Null, but samsung_i2s_remove()
> permorms pri_dai->sec_dai dereference in any case.

s/permorms/performs

> The patch adds sec_dai check on Null before derefence at
> samsung_i2s_remove().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
>   sound/soc/samsung/i2s.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index af3ba4d..6beeea8 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -1382,7 +1382,8 @@ static int samsung_i2s_remove(struct platform_device *pdev)
>   	sec_dai = pri_dai->sec_dai;
>   
>   	pri_dai->sec_dai = NULL;
> -	sec_dai->pri_dai = NULL;

Thanks for the patch.  AFAICS above 4 lines could be removed altogether
since pri_dai and sec_dai is being allocated with devm_kzalloc().
So initializing in remove() is meaningless as afterwards the data will
not be used any more.  The memory will be just freed by the devres code.

> +	if (sec_dai)
> +		sec_dai->pri_dai = NULL;

-- 
Regards,
Sylwester
