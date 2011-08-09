From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Fix binding of WM8750 on Jive
Date: Tue, 9 Aug 2011 13:27:33 +0100
Message-ID: <4E4127B5.20000@ti.com>
References: <1312360658-27908-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id F2F9E1038DF
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 14:27:36 +0200 (CEST)
In-Reply-To: <1312360658-27908-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 03/08/11 09:37, Mark Brown wrote:
> The I2C address is misformatted and would never match.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>

>  sound/soc/samsung/jive_wm8750.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/samsung/jive_wm8750.c b/sound/soc/samsung/jive_wm8750.c
> index 3b53ad5..14eb6ea 100644
> --- a/sound/soc/samsung/jive_wm8750.c
> +++ b/sound/soc/samsung/jive_wm8750.c
> @@ -131,7 +131,7 @@ static struct snd_soc_dai_link jive_dai = {
>  	.cpu_dai_name	= "s3c2412-i2s",
>  	.codec_dai_name = "wm8750-hifi",
>  	.platform_name	= "samsung-audio",
> -	.codec_name	= "wm8750-codec.0-0x1a",
> +	.codec_name	= "wm8750-codec.0-001a",
>  	.init		= jive_wm8750_init,
>  	.ops		= &jive_ops,
>  };
