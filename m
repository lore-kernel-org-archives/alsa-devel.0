From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: bf5xx-ad73311: Fix prototype for
	bf5xx_probe
Date: Thu, 15 Sep 2011 19:05:53 +0100
Message-ID: <1316109954.3333.1.camel@odin>
References: <1316055896.3496.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id ECEC5103B1D
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 20:05:59 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 21so2726679wyh.10
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 11:05:57 -0700 (PDT)
In-Reply-To: <1316055896.3496.8.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Cliff Cai <Cliff.Cai@analog.com>, Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-09-15 at 11:04 +0800, Axel Lin wrote:
> Fix below build warning:
> sound/soc/blackfin/bf5xx-ad73311.c: warning: initialization from incompatible pointer type
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/blackfin/bf5xx-ad73311.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
> index 732a247..b94eb7e 100644
> --- a/sound/soc/blackfin/bf5xx-ad73311.c
> +++ b/sound/soc/blackfin/bf5xx-ad73311.c
> @@ -128,7 +128,7 @@ static int snd_ad73311_configure(void)
>  	return 0;
>  }
>  
> -static int bf5xx_probe(struct platform_device *pdev)
> +static int bf5xx_probe(struct snd_soc_card *card)
>  {
>  	int err;
>  	if (gpio_request(GPIO_SE, "AD73311_SE")) {

Acked-by: Liam Girdwood <lrg@ti.com>
