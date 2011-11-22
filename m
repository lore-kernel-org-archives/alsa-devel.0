From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: Remove conditional I2C usage from
 tlv320aic3x driver
Date: Tue, 22 Nov 2011 10:06:44 +0200
Message-ID: <1321949204.2079.8.camel@puukko.homenet-68>
References: <1321899300-6624-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id A8F95103949
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 09:06:52 +0100 (CET)
In-Reply-To: <1321899300-6624-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-11-21 at 18:15 +0000, Mark Brown wrote:
> The driver only supports I2C so doesn't need to do things conditionally.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/tlv320aic3x.c |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
> index 14cb553..2e2bf18 100644
> --- a/sound/soc/codecs/tlv320aic3x.c
> +++ b/sound/soc/codecs/tlv320aic3x.c
> @@ -1481,7 +1481,6 @@ static struct snd_soc_codec_driver soc_codec_dev_aic3x = {
>  	.resume = aic3x_resume,
>  };
>  
> -#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)

Yeah, these have been here just from the beginning and nobody haven't
added SPI support so worth to remove.

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
