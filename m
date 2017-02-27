From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/1] ASoC: Add AU1761 audio codec as
 selectable option
Date: Mon, 27 Feb 2017 12:33:23 +0100
Message-ID: <3e3bc465-0b9a-161f-a3f2-b26149276411@metafoo.de>
References: <1487970034-6003-1-git-send-email-me>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1487970034-6003-1-git-send-email-me>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: me@rockwellcollins.com, patch@alsa-project.org
Cc: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/24/2017 10:00 PM, me@rockwellcollins.com wrote:
> From: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>
> 
> This commit adds the ADI AU1761 audio codec as a selectable option
> in the kernel config.  Currently the driver can only be selected
> for ADI blackfin devices or if SND_SOC_ALL_CODECS is enabled.
> 
> Signed-off-by: Bryce Ferguson <bryce.ferguson@rockwellcollins.com>

Looks good, makes sense.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

But you need to send the patch to the ASoC maintainers Mark
(<broonie@kernel.org>) and Liam (girdwood@gmail.com) to get it applied. The
patch should be send to the maintainers and with the mailinglist on CC.

- Lars

> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index e49e9da..43539c3b 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -303,12 +303,14 @@ config SND_SOC_ADAU1761
>  	select SND_SOC_ADAU17X1
>  
>  config SND_SOC_ADAU1761_I2C
> -	tristate
> +	tristate "Analog Devices AU1761 CODEC - I2C"
> +	depends on I2C
>  	select SND_SOC_ADAU1761
>  	select REGMAP_I2C
>  
>  config SND_SOC_ADAU1761_SPI
> -	tristate
> +	tristate "Analog Devices AU1761 CODEC - SPI"
> +	depends on SPI
>  	select SND_SOC_ADAU1761
>  	select REGMAP_SPI
>  
> 
