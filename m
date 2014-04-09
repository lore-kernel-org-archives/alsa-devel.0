From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: core: Fix Sparse incompatible types warning
Date: Wed, 09 Apr 2014 12:57:35 +0200
Message-ID: <5345279F.6070005@metafoo.de>
References: <1397028108-10976-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397028108-10976-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 04/09/2014 09:21 AM, Krzysztof Kozlowski wrote:
> Fix following Sparse warning:
> sound/soc/soc-core.c:252:20: error: incompatible types in comparison expression (different type sizes)
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>   sound/soc/soc-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 051c006281f5..41f6178249df 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -249,7 +249,7 @@ static ssize_t codec_reg_write_file(struct file *file,
>   	struct snd_soc_codec *codec = file->private_data;
>   	int ret;
>
> -	buf_size = min(count, (sizeof(buf)-1));
> +	buf_size = min(count, (size_t)(sizeof(buf)-1));

But shouldn't the type of sizeof already be size_t?
