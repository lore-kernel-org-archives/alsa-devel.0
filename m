From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [PATCH] ASoC: Ensure output PGA is enabled for
	line outputs in wm_hubs
Date: Sun, 15 May 2011 13:36:22 +0100
Message-ID: <201105151336.22324.gineera@aspect135.co.uk>
References: <1305434515-26515-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip08ir2.opaltelecom.net (out1.ip08ir2.opaltelecom.net
	[62.24.128.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E2EC10380A
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 14:30:45 +0200 (CEST)
In-Reply-To: <1305434515-26515-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sunday 15 May 2011 05:41, Mark Brown wrote:
> Also fix a left/right typo while we're at it.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm_hubs.c |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/codecs/wm_hubs.c b/sound/soc/codecs/wm_hubs.c
> index 4005e9a..7d674ee 100644
> --- a/sound/soc/codecs/wm_hubs.c
> +++ b/sound/soc/codecs/wm_hubs.c
> @@ -787,17 +787,17 @@ static const struct snd_soc_dapm_route
> analogue_routes[] = { static const struct snd_soc_dapm_route
> lineout1_diff_routes[] = { { "LINEOUT1 Mixer", "IN1L Switch", "IN1L PGA" },
>  	{ "LINEOUT1 Mixer", "IN1R Switch", "IN1R PGA" },
> -	{ "LINEOUT1 Mixer", "Output Switch", "Left Output Mixer" },
> +	{ "LINEOUT1 Mixer", "Output Switch", "Left Output PGA" },
>
>  	{ "LINEOUT1N Driver", NULL, "LINEOUT1 Mixer" },
>  	{ "LINEOUT1P Driver", NULL, "LINEOUT1 Mixer" },
>  };
>
>  static const struct snd_soc_dapm_route lineout1_se_routes[] = {
> -	{ "LINEOUT1N Mixer", "Left Output Switch", "Left Output Mixer" },
> -	{ "LINEOUT1N Mixer", "Right Output Switch", "Left Output Mixer" },
> +	{ "LINEOUT1N Mixer", "Left Output Switch", "Left Output PGA" },
> +	{ "LINEOUT1N Mixer", "Right Output Switch", "Right Output PGA" },
>
> -	{ "LINEOUT1P Mixer", "Left Output Switch", "Left Output Mixer" },
> +	{ "LINEOUT1P Mixer", "Left Output Switch", "Left Output PGA" },
>
>  	{ "LINEOUT1N Driver", NULL, "LINEOUT1N Mixer" },
>  	{ "LINEOUT1P Driver", NULL, "LINEOUT1P Mixer" },
> @@ -806,17 +806,17 @@ static const struct snd_soc_dapm_route
> lineout1_se_routes[] = { static const struct snd_soc_dapm_route
> lineout2_diff_routes[] = { { "LINEOUT2 Mixer", "IN2L Switch", "IN2L PGA" },
>  	{ "LINEOUT2 Mixer", "IN2R Switch", "IN2R PGA" },
> -	{ "LINEOUT2 Mixer", "Output Switch", "Right Output Mixer" },
> +	{ "LINEOUT2 Mixer", "Output Switch", "Right Output PGA" },
>
>  	{ "LINEOUT2N Driver", NULL, "LINEOUT2 Mixer" },
>  	{ "LINEOUT2P Driver", NULL, "LINEOUT2 Mixer" },
>  };
>
>  static const struct snd_soc_dapm_route lineout2_se_routes[] = {
> -	{ "LINEOUT2N Mixer", "Left Output Switch", "Left Output Mixer" },
> -	{ "LINEOUT2N Mixer", "Right Output Switch", "Left Output Mixer" },
> +	{ "LINEOUT2N Mixer", "Left Output Switch", "Left Output PGA" },
> +	{ "LINEOUT2N Mixer", "Right Output Switch", "Left Output PGA" },

Is this also left/right typo?

>
> -	{ "LINEOUT2P Mixer", "Right Output Switch", "Right Output Mixer" },
> +	{ "LINEOUT2P Mixer", "Right Output Switch", "Right Output PGA" },
>
>  	{ "LINEOUT2N Driver", NULL, "LINEOUT2N Mixer" },
>  	{ "LINEOUT2P Driver", NULL, "LINEOUT2P Mixer" },


Alan
