From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: spear: Remove redundant message
Date: Sun, 26 Feb 2017 17:05:02 +0900
Message-ID: <2dcacbcf-c4b1-fd44-90ca-a15c47980657@sakamocchi.jp>
References: <1488018810-11973-1-git-send-email-despotovici.mihai@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488018810-11973-1-git-send-email-despotovici.mihai@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dspmihai <despotovici.mihai@gmail.com>, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Feb 25 2017 19:33, dspmihai wrote:
> This was reported by checkpatch.pl
>
> Signed-off-by: Despotovici Mihai <despotovici.mihai@gmail.com>
> ---
>  sound/soc/spear/spdif_in.c  | 4 +---
>  sound/soc/spear/spdif_out.c | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/spear/spdif_in.c b/sound/soc/spear/spdif_in.c
> index 977a078..0f3b1a8 100644
> --- a/sound/soc/spear/spdif_in.c
> +++ b/sound/soc/spear/spdif_in.c
> @@ -216,10 +216,8 @@ static int spdif_in_probe(struct platform_device *pdev)
>  		return -EINVAL;
>
>  	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
> -	if (!host) {
> -		dev_warn(&pdev->dev, "kzalloc fail\n");
> +	if (!host)

The line for dev_warn() should be kept.

>  		return -ENOMEM;
> -	}
>
>  	host->io_base = io_base;
>  	host->irq = platform_get_irq(pdev, 0);
> diff --git a/sound/soc/spear/spdif_out.c b/sound/soc/spear/spdif_out.c
> index 0a72d52..58d5843 100644
> --- a/sound/soc/spear/spdif_out.c
> +++ b/sound/soc/spear/spdif_out.c
> @@ -282,10 +282,8 @@ static int spdif_out_probe(struct platform_device *pdev)
>  	int ret;
>
>  	host = devm_kzalloc(&pdev->dev, sizeof(*host), GFP_KERNEL);
> -	if (!host) {
> -		dev_warn(&pdev->dev, "kzalloc fail\n");
> +	if (!host)

Ditto.

>  		return -ENOMEM;
> -	}
>
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	host->io_base = devm_ioremap_resource(&pdev->dev, res);

Takashi Sakamoto
