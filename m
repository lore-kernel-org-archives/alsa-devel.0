From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: rockchip: i2s: Remove unnecessary
 'out of memory' message
Date: Sun, 26 Feb 2017 17:04:16 +0900
Message-ID: <ef03f4f4-ad76-8441-87b1-fe637f53977e@sakamocchi.jp>
References: <20170225101834.28232-1-mihai.dumitru2201@stud.acs.upb.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id A9137266C6A
 for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2017 09:04:19 +0100 (CET)
In-Reply-To: <20170225101834.28232-1-mihai.dumitru2201@stud.acs.upb.ro>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mihai-Valentin DUMITRU <mihai.dumitru2201@gmail.com>, perex@perex.cz, tiwai@suse.com, heiko@sntech.de
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, broonie@kernel.org, Mihai-Valentin DUMITRU <mihai.dumitru2201@stud.acs.upb.ro>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Feb 25 2017 19:18, Mihai-Valentin DUMITRU wrote:
> This was reported by checkpatch.pl
>
> Signed-off-by: Mihai-Valentin DUMITRU <mihai.dumitru2201@gmail.com>
> ---
>  sound/soc/rockchip/rockchip_i2s.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
> index 974915cb4c4f..d02a1045fc0b 100644
> --- a/sound/soc/rockchip/rockchip_i2s.c
> +++ b/sound/soc/rockchip/rockchip_i2s.c
> @@ -551,10 +551,8 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
>  	int val;
>
>  	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
> -	if (!i2s) {
> -		dev_err(&pdev->dev, "Can't allocate rk_i2s_dev\n");
> +	if (!i2s)

The line for dev_warn() should be kept.

>  		return -ENOMEM;
> -	}
>
>  	i2s->dev = &pdev->dev;


Regards

Takashi Sakamoto
