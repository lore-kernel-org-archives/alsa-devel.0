From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Select DMA driver for Samsung DAIs
Date: Tue, 21 Sep 2010 14:07:02 +0100
Message-ID: <1285074422.3089.43.camel@odin>
References: <1285011508-8750-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D915A1038B2
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Sep 2010 15:07:06 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 28so5393074wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2010 06:07:06 -0700 (PDT)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-09-20 at 20:38 +0100, Mark Brown wrote:
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
>  
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

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
