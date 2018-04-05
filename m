From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: adau17x1: Do not reload dsp-fw
 if samplerate has not changed
Date: Thu, 5 Apr 2018 17:33:34 +0200
Message-ID: <e7fe74d3-681c-3cd4-55e3-47605c006285@metafoo.de>
References: <20180403080535.6109-1-robertr@axis.com>
 <20180403080535.6109-2-robertr@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BBEE267627
 for <alsa-devel@alsa-project.org>; Thu,  5 Apr 2018 17:33:36 +0200 (CEST)
In-Reply-To: <20180403080535.6109-2-robertr@axis.com>
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
> Reloading fw causes an audiable popping sound, we can avoid this
> by not reloading if the samplerate is the same as before.
> 

Seems like a sensible idea thanks.

> Signed-off-by: Danny Smith <dannys@axis.com>
> ---
>  sound/soc/codecs/adau17x1.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
> index 5636b9522462..3c28b7191ecd 100644
> --- a/sound/soc/codecs/adau17x1.c
> +++ b/sound/soc/codecs/adau17x1.c
> @@ -840,25 +840,34 @@ int adau17x1_setup_firmware(struct adau *adau, unsigned int rate)
>  	int ret;
>  	int dspsr, dsp_run;
>  
> -	ret = regmap_read(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, &dspsr);
> -	if (ret)
> -		return ret;
> +	/* Check if sample rate is the same as before. If it is there is no
> +	 * point in performing the below steps as the call to
> +	 * sigmadsp_setup(...) will return directly when it finds the sample
> +	 * rate to be the same as before. By checking this we can prevent an
> +	 * audiable popping noise which occours when toggling DSP_RUN.
> +	 */
> +	if (adau->sigmadsp->current_samplerate != rate) {

I think in order to avoid all that re-indention you could just

	if (adau->sigmadsp->current_samplerate == rate)
		return 0;

[...]
