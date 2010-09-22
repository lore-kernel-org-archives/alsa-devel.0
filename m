From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH] ASoC: Select DMA driver for Samsung DAIs
Date: Wed, 22 Sep 2010 09:10:48 +0300
Message-ID: <201009220910.49066.anarsoul@gmail.com>
References: <1285011508-8750-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F5DA1037F1
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Sep 2010 08:12:01 +0200 (CEST)
Received: by eye27 with SMTP id 27so44625eye.38
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2010 23:12:00 -0700 (PDT)
In-Reply-To: <1285011508-8750-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 20 of September 2010 22:38:28 Mark Brown wrote:
> Kconfig got smart enough to do dependencies through selects so let's make
> use of that.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/s3c24xx/Kconfig |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
> index 7d8235d..1142d3e 100644
> --- a/sound/soc/s3c24xx/Kconfig
> +++ b/sound/soc/s3c24xx/Kconfig
> @@ -10,6 +10,7 @@ config SND_S3C24XX_SOC
>  config SND_S3C24XX_SOC_I2S
>  	tristate
>  	select S3C2410_DMA
> +	select SND_S3C_SOC_PCM

SND_S3C_SOC_PCM is not necessary for SND_S3C24XX_SOC, actually it works fine 
without it on my rx1950 (s3c2442-based)

>  config SND_S3C_I2SV2_SOC
>  	tristate
> @@ -18,16 +19,19 @@ config SND_S3C2412_SOC_I2S
>  	tristate
>  	select SND_S3C_I2SV2_SOC
>  	select S3C2410_DMA
> +	select SND_S3C_SOC_PCM
> 
>  config SND_S3C64XX_SOC_I2S
>  	tristate
>  	select SND_S3C_I2SV2_SOC
>  	select S3C64XX_DMA
> +	select SND_S3C_SOC_PCM
> 
>  config SND_S3C64XX_SOC_I2S_V4
>  	tristate
>  	select SND_S3C_I2SV2_SOC
>  	select S3C64XX_DMA
> +	select SND_S3C_SOC_PCM
> 
>  config SND_S3C_SOC_PCM
>  	tristate

Regards
Vasily
