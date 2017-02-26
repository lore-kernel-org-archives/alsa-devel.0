From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: dwc: remove 'out of memory' message
Date: Sun, 26 Feb 2017 17:03:22 +0900
Message-ID: <9da9efc3-cd9b-70a5-a764-e8be32e67d13@sakamocchi.jp>
References: <20170225110323.7506-1-michelcatalin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 23275266ADE
 for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2017 09:03:30 +0100 (CET)
In-Reply-To: <20170225110323.7506-1-michelcatalin@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mihai Burduselu <michelcatalin@gmail.com>, tiwai@suse.com, perex@perex.cz
Cc: Jose.Abreu@synopsys.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org, s.nawrocki@samsung.com, colin.king@canonical.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Feb 25 2017 20:03, Mihai Burduselu wrote:
> Reported by checkpatch.pl
> Signed-off-by: Mihai Burduselu <michelcatalin@gmail.com>
> ---
>  sound/soc/dwc/designware_i2s.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
> index 9c46e4112026..6479768cc6a1 100644
> --- a/sound/soc/dwc/designware_i2s.c
> +++ b/sound/soc/dwc/designware_i2s.c
> @@ -611,10 +611,8 @@ static int dw_i2s_probe(struct platform_device *pdev)
>  	const char *clk_id;
>
>  	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> -	if (!dev) {
> -		dev_warn(&pdev->dev, "kzalloc fail\n");
> +	if (!dev)

The line for 'dev_warn()' should be kept.

>  		return -ENOMEM;
> -	}
>
>  	dw_i2s_dai = devm_kzalloc(&pdev->dev, sizeof(*dw_i2s_dai), GFP_KERNEL);
>  	if (!dw_i2s_dai)


Regards

Takashi Sakamoto
