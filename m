From: Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH] ASoC: max98988: add I2C dependency
Date: Wed, 10 Oct 2018 14:05:39 +0200
Message-ID: <20181010120539.ija2n7chqrtx2fdh@pengutronix.de>
References: <20181010083758.2874864-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F8B62678AB
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2018 14:05:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20181010083758.2874864-1-arnd@arndb.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Arnd,

On 18-10-10 10:37, Arnd Bergmann wrote:
> max98988 only builds with I2C support enabled, otherwise we get a build error:
> 
> sound/soc/codecs/max98088.c:1789:1: error: data definition has no type or storage class [-Werror]
>  module_i2c_driver(max98088_i2c_driver);
>  ^~~~~~~~~~~~~~~~~
> sound/soc/codecs/max98088.c:1789:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
> sound/soc/codecs/max98088.c:1789:1: error: parameter names (without types) in function declaration [-Werror]
> sound/soc/codecs/max98088.c:1780:26: error: 'max98088_i2c_driver' defined but not used [-Werror=unused-variable]
> 
> Fixes: 24ae67c58250 ("ASoC: max98988: make it selectable")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for covering the issue.

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Regrads,
Marco

> ---
>  sound/soc/codecs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 3c6bd6019b92..774d38310875 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -641,6 +641,7 @@ config SND_SOC_LM49453
>  
>  config SND_SOC_MAX98088
>  	tristate "Maxim MAX98088/9 Low-Power, Stereo Audio Codec"
> +	depends on I2C
>  
>  config SND_SOC_MAX98090
>         tristate
> -- 
> 2.18.0
> 
> 
