From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH 2/2] ASoC: pcm1792a: Add DAPM support
Date: Fri, 23 Aug 2013 17:16:48 +0200
Message-ID: <20130823151648.GA32473@panicking>
References: <1376415048-6029-1-git-send-email-broonie@kernel.org>
 <1376415048-6029-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 868CB26559C
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 17:16:53 +0200 (CEST)
Received: by mail-wi0-f180.google.com with SMTP id l12so624047wiv.13
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 08:16:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1376415048-6029-2-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark

On Tue, Aug 13, 2013 at 06:30:48PM +0100, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Provide DAPM for the device, ensuring operation with DAPM required by the
> core and making it easier to hook up external hardware to it.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  sound/soc/codecs/pcm1792a.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/sound/soc/codecs/pcm1792a.c b/sound/soc/codecs/pcm1792a.c
> index c57d3a5..2a8eccf 100644
> --- a/sound/soc/codecs/pcm1792a.c
> +++ b/sound/soc/codecs/pcm1792a.c
> @@ -154,6 +154,20 @@ static const struct snd_kcontrol_new pcm1792a_controls[] = {
>  			 pcm1792a_dac_tlv),
>  };
>  
> +static const struct snd_soc_dapm_widget pcm1792a_dapm_widgets[] = {
> +SND_SOC_DAPM_OUTPUT("IOUTL+"),
> +SND_SOC_DAPM_OUTPUT("IOUTL-"),
> +SND_SOC_DAPM_OUTPUT("IOUTR+"),
> +SND_SOC_DAPM_OUTPUT("IOUTR-"),
> +};
> +

I'm working on support pcm1795 and pcm1796 too. They are registers compatible
but different sample rate support. So the idea is three patches?

- rename pcm1792a to pcm179x (is it possible?)
- add three different dai for pcm1792a, pcm1795 and pcm1796
- use of_device_id data pointer to select the correct dai

Michael

> +static const struct snd_soc_dapm_route pcm1792a_dapm_routes[] = {
> +	{ "IOUTL+", NULL, "Playback" },
> +	{ "IOUTL-", NULL, "Playback" },
> +	{ "IOUTR+", NULL, "Playback" },
> +	{ "IOUTR-", NULL, "Playback" },
> +};
> +
>  static struct snd_soc_dai_driver pcm1792a_dai = {
>  	.name = "pcm1792a-hifi",
>  	.playback = {
> @@ -184,6 +198,10 @@ static const struct regmap_config pcm1792a_regmap = {
>  static struct snd_soc_codec_driver soc_codec_dev_pcm1792a = {
>  	.controls		= pcm1792a_controls,
>  	.num_controls		= ARRAY_SIZE(pcm1792a_controls),
> +	.dapm_widgets		= pcm1792a_dapm_widgets,
> +	.num_dapm_widgets	= ARRAY_SIZE(pcm1792a_dapm_widgets),
> +	.dapm_routes		= pcm1792a_dapm_routes,
> +	.num_dapm_routes	= ARRAY_SIZE(pcm1792a_dapm_routes),
>  };
>  
>  static int pcm1792a_spi_probe(struct spi_device *spi)
> -- 
> 1.8.4.rc2
> 
