From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: neo1973_gta02_wm8753: fix wrong
 parameter for snd_soc_register_dai and snd_soc_unregister_dai
Date: Thu, 25 Nov 2010 10:48:05 +0000
Message-ID: <1290682085.3302.15.camel@odin>
References: <1290675056.1928.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 94F92103C13
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 11:48:08 +0100 (CET)
Received: by wyi11 with SMTP id 11so748184wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 02:48:08 -0800 (PST)
In-Reply-To: <1290675056.1928.1.camel@mola>
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
Cc: Graeme Gregory <graeme@openmoko.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-25 at 16:50 +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  sound/soc/samsung/neo1973_gta02_wm8753.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/samsung/neo1973_gta02_wm8753.c b/sound/soc/samsung/neo1973_gta02_wm8753.c
> index 920e8d1..8c65b63 100644
> --- a/sound/soc/samsung/neo1973_gta02_wm8753.c
> +++ b/sound/soc/samsung/neo1973_gta02_wm8753.c
> @@ -438,7 +438,7 @@ static int __init neo1973_gta02_init(void)
>  		return -ENOMEM;
>  
>  	/* register bluetooth DAI here */
> -	ret = snd_soc_register_dai(&neo1973_gta02_snd_device->dev, -1, &bt_dai);
> +	ret = snd_soc_register_dai(&neo1973_gta02_snd_device->dev, &bt_dai);
>  	if (ret) {
>  		platform_device_put(neo1973_gta02_snd_device);
>  		return ret;
> @@ -491,7 +491,7 @@ module_init(neo1973_gta02_init);
>  
>  static void __exit neo1973_gta02_exit(void)
>  {
> -	snd_soc_unregister_dai(&neo1973_gta02_snd_device->dev, -1);
> +	snd_soc_unregister_dai(&neo1973_gta02_snd_device->dev);
>  	platform_device_unregister(neo1973_gta02_snd_device);
>  	gpio_free(GTA02_GPIO_HP_IN);
>  	gpio_free(GTA02_GPIO_AMP_SHUT);

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
