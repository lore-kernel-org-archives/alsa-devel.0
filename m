From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: adau17x1: Handling of DSP_RUN
 register during fw setup
Date: Thu, 5 Apr 2018 17:44:47 +0200
Message-ID: <4650baa5-d205-2b99-0222-1b08592afe9c@metafoo.de>
References: <20180403080535.6109-1-robertr@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C73C2267627
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 17:44:49 +0200 (CEST)
In-Reply-To: <20180403080535.6109-1-robertr@axis.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Rosengren <robert.rosengren@axis.com>, alsa-devel@alsa-project.org
Cc: Danny Smith <dannys@axis.com>
List-Id: alsa-devel@alsa-project.org

On 04/03/2018 10:05 AM, Robert Rosengren wrote:
> From: Danny Smith <dannys@axis.com>
> 
> DSP_RUN needs to be disabled during firmware write otherwise
> we can end up with undefined behavior if writing to a dsp which
> is already running firmware.
> 

Good point, thanks.

I believe there is a possible (but rare under normal circumstances) race
condition here though, where DAPM could run at the same time and
enable/disable the DSP while the firmware is being loaded.

To avoid this the firmware load sequence should be encapsulated in
snd_soc_dapm_mutex_lock()/snd_soc_dapm_mutex_unlock().

Pass struct snd_soc_component instead of struct adau to this function and
then use snd_soc_component_get_dapm() to get the DAPM context.

For the next version of the patches please also add the ASoC maintainers to
the reciver list since they have to apply the patch. The maintainers are:

Liam Girdwood <lgirdwood@gmail.com>
Mark Brown <broonie@kernel.org>


> Signed-off-by: Danny Smith <dannys@axis.com>
> ---
>  sound/soc/codecs/adau17x1.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
> index 80c2a06285bb..5636b9522462 100644
> --- a/sound/soc/codecs/adau17x1.c
> +++ b/sound/soc/codecs/adau17x1.c
> @@ -838,14 +838,19 @@ EXPORT_SYMBOL_GPL(adau17x1_volatile_register);
>  int adau17x1_setup_firmware(struct adau *adau, unsigned int rate)
>  {
>  	int ret;
> -	int dspsr;
> +	int dspsr, dsp_run;
>  
>  	ret = regmap_read(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, &dspsr);
>  	if (ret)
>  		return ret;
>  
> +	ret = regmap_read(adau->regmap, ADAU17X1_DSP_RUN, &dsp_run);
> +	if (ret)
> +		return ret;
> +
>  	regmap_write(adau->regmap, ADAU17X1_DSP_ENABLE, 1);
>  	regmap_write(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, 0xf);
> +	regmap_write(adau->regmap, ADAU17X1_DSP_RUN, 0);
>  
>  	ret = sigmadsp_setup(adau->sigmadsp, rate);
>  	if (ret) {
> @@ -853,6 +858,7 @@ int adau17x1_setup_firmware(struct adau *adau, unsigned int rate)
>  		return ret;
>  	}
>  	regmap_write(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, dspsr);
> +	regmap_write(adau->regmap, ADAU17X1_DSP_RUN, dsp_run);
>  
>  	return 0;
>  }
> 
