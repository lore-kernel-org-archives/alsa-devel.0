From: Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH] ASoC: cygnus: remove redundant assignment to pointer
 'res'
Date: Thu, 8 Mar 2018 12:15:22 -0800
Message-ID: <576fbe04-bef0-171d-a1eb-40c6cbb2874e@broadcom.com>
References: <20180308133249.22032-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308133249.22032-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Lori Hikichi <lori.hikichi@broadcom.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Looks good.


On 18-03-08 05:32 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer res is being initialized with a value that is never read
> and re-assigned immediately after, hence the initialization is redundant
> and can be removed.
>
> Cleans up clang warning:
> sound/soc/bcm/cygnus-ssp.c:1284:19: warning: Value stored to 'res'
> during its initialization is never read
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
> ---
>   sound/soc/bcm/cygnus-ssp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
> index abafadc0b534..b733f1446353 100644
> --- a/sound/soc/bcm/cygnus-ssp.c
> +++ b/sound/soc/bcm/cygnus-ssp.c
> @@ -1281,7 +1281,7 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct device_node *child_node;
> -	struct resource *res = pdev->resource;
> +	struct resource *res;
>   	struct cygnus_audio *cygaud;
>   	int err = -EINVAL;
>   	int node_count;
