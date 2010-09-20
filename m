From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Prototype s3c64xx_i2s_get_clock()
Date: Mon, 20 Sep 2010 18:42:17 +0100
Message-ID: <1285004537.3048.85.camel@odin>
References: <1285003485-13801-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B990E1037E3
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Sep 2010 19:42:20 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1841522ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Sep 2010 10:42:20 -0700 (PDT)
In-Reply-To: <1285003485-13801-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Mon, 2010-09-20 at 18:24 +0100, Mark Brown wrote:
> So machine drivers can see the declaration.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/s3c24xx/s3c64xx-i2s.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.h b/sound/soc/s3c24xx/s3c64xx-i2s.h
> index 19bd444..de4075d 100644
> --- a/sound/soc/s3c24xx/s3c64xx-i2s.h
> +++ b/sound/soc/s3c24xx/s3c64xx-i2s.h
> @@ -36,5 +36,6 @@ struct clk;
>  	(SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |\
>  	 SNDRV_PCM_FMTBIT_S24_LE)
>  
> +struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai);
>  
>  #endif /* __SND_SOC_S3C24XX_S3C64XX_I2S_H */

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
