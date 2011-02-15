From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] ASoC: omap: rx51: Use gpio_request_one
 to configure tvout_sel gpio
Date: Tue, 15 Feb 2011 21:54:41 +0000
Message-ID: <1297806881.3337.90.camel@odin>
References: <1297696822-32174-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D7FF10386E
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 22:54:44 +0100 (CET)
Received: by wwe15 with SMTP id 15so661840wwe.20
	for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2011 13:54:44 -0800 (PST)
In-Reply-To: <1297696822-32174-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-02-14 at 17:20 +0200, Jarkko Nikula wrote:
> Just slight cleanup to be sync with upcoming change.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
>  sound/soc/omap/rx51.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
> index 2d7d411..9411969 100644
> --- a/sound/soc/omap/rx51.c
> +++ b/sound/soc/omap/rx51.c
> @@ -394,10 +394,10 @@ static int __init rx51_soc_init(void)
>  	if (!machine_is_nokia_rx51())
>  		return -ENODEV;
>  
> -	err = gpio_request(RX51_TVOUT_SEL_GPIO, "tvout_sel");
> +	err = gpio_request_one(RX51_TVOUT_SEL_GPIO,
> +			       GPIOF_DIR_OUT | GPIOF_INIT_LOW, "tvout_sel");
>  	if (err)
>  		goto err_gpio_tvout_sel;
> -	gpio_direction_output(RX51_TVOUT_SEL_GPIO, 0);
>  
>  	rx51_snd_device = platform_device_alloc("soc-audio", -1);
>  	if (!rx51_snd_device) {

All applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
