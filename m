From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: [PATCH] ASoC: Convert wm8731 to a new-style	i2c
 driver (testers wanted)
Date: Mon, 01 Sep 2008 15:54:53 +0200
Message-ID: <48BBF42D.5010901@atmel.com>
References: <20080826182437.4c5e2f3e@hyperion.delvare>	<20080826192043.GA3812@roarinelk.homelinux.net>	<20080826193728.GD3461@sirena.org.uk>	<20080828172540.GA21551@roarinelk.homelinux.net>	<20080828193754.6f8f6594@hyperion.delvare>
	<20080828184251.GA21868@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C8562441F
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 15:55:41 +0200 (CEST)
In-Reply-To: <20080828184251.GA21868@roarinelk.homelinux.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: alsa-devel@alsa-project.org, Dmitry Baryshkov <dbaryshkov@gmail.com>, Eric Miao <eric.miao@marvell.com>, Jean Delvare <khali@linux-fr.org>, Richard Purdie <rpurdie@rpsys.net>, Andrew Victor <linux@maxim.org.za>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Manuel,
>  
> diff --git a/sound/soc/pxa/corgi.c b/sound/soc/pxa/corgi.c
> index 72b7a51..4837bdb 100644
> --- a/sound/soc/pxa/corgi.c
> +++ b/sound/soc/pxa/corgi.c
> @@ -328,18 +328,11 @@ static struct snd_soc_machine snd_soc_machine_corgi = {
>  	.num_links = 1,
>  };
>  
> -/* corgi audio private data */
> -static struct wm8731_setup_data corgi_wm8731_setup = {
> -	.i2c_bus = 0,
> -	.i2c_address = 0x1b,
> -};
> -
>  /* corgi audio subsystem */
>  static struct snd_soc_device corgi_snd_devdata = {
>  	.machine = &snd_soc_machine_corgi,
>  	.platform = &pxa2xx_soc_platform,
>  	.codec_dev = &soc_codec_dev_wm8731,
> -	.codec_data = &corgi_wm8731_setup,
>  };
>  
>  static struct platform_device *corgi_snd_device;
> diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
> index f84f7d8..a6adb46 100644
> --- a/sound/soc/pxa/poodle.c
> +++ b/sound/soc/pxa/poodle.c
> @@ -282,18 +282,11 @@ static struct snd_soc_machine snd_soc_machine_poodle = {
>  	.num_links = 1,
>  };
>  
> -/* poodle audio private data */
> -static struct wm8731_setup_data poodle_wm8731_setup = {
> -	.i2c_bus = 0,
> -	.i2c_address = 0x1b,
> -};
> -
>  /* poodle audio subsystem */
>  static struct snd_soc_device poodle_snd_devdata = {
>  	.machine = &snd_soc_machine_poodle,
>  	.platform = &pxa2xx_soc_platform,
>  	.codec_dev = &soc_codec_dev_wm8731,
> -	.codec_data = &poodle_wm8731_setup,
>  };
>  
>  static struct platform_device *poodle_snd_device;

Shouldn't it be the same for the file sound/soc/at91/eti_b1_wm8731.c ??

Regards,
Sedji
