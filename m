From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [ASoC] 88pm860x - Allow independent use of I2S
 capture and playback
Date: Tue, 20 Sep 2011 12:34:20 +0100
Message-ID: <20110920113420.GB14609@sirena.org.uk>
References: <4E735811.2060002@novero.com> <20110917133206.GB3798@sirena.org.uk>
	<4E77291D.10107@novero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C9941039F8
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 13:34:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E77291D.10107@novero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bas Vermeulen <Bas.Vermeulen@novero.com>, lrg@ti.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 19, 2011 at 01:35:57PM +0200, Bas Vermeulen wrote:
> Attached is a patch to turn the I2S clock on for both of I2S capture
> and playback instead of just playback.

Please follow the process in SubmittingPatches - CC maintainers (I've
added Liam), don't send as attachments and use subject lines which match
up with the standard for the subsystem.

> From a02c4f024daeae6f0708467bc1adbe20bc7458bb Mon Sep 17 00:00:00 2001
> From: Bas Vermeulen <bas.vermeulen@novero.com>
> Date: Mon, 19 Sep 2011 12:57:09 +0200
> Subject: [PATCH 1/2] [ASoC] 88pm860x-codec - Allow independent use of both I2S playback and capture
> 
> Introduce a I2S CLK supply so playback and capture can operate independently.
> 
> Signed-off-by: Bas Vermeulen <bas.vermeulen@novero.com>
> ---
>  sound/soc/codecs/88pm860x-codec.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
> index 1924157..0198dbb 100644
> --- a/sound/soc/codecs/88pm860x-codec.c
> +++ b/sound/soc/codecs/88pm860x-codec.c
> @@ -772,11 +772,12 @@ static const struct snd_soc_dapm_widget pm860x_dapm_widgets[] = {
>  
>  
>  	SND_SOC_DAPM_AIF_IN("I2S DIN", "I2S Playback", 0,
> -			    PM860X_DAC_EN_2, 0, 0),
> +			    SND_SOC_NOPM, 0, 0),
>  	SND_SOC_DAPM_AIF_IN("I2S DIN1", "I2S Playback", 0,
> -			    PM860X_DAC_EN_2, 0, 0),
> +			    SND_SOC_NOPM, 0, 0),
>  	SND_SOC_DAPM_AIF_OUT("I2S DOUT", "I2S Capture", 0,
>  			     PM860X_I2S_IFACE_3, 5, 1),
> +	SND_SOC_DAPM_SUPPLY("I2S CLK", PM860X_DAC_EN_2, 0, 0, NULL, 0),
>  	SND_SOC_DAPM_MUX("I2S Mic Mux", SND_SOC_NOPM, 0, 0, &i2s_mic_mux),
>  	SND_SOC_DAPM_MUX("ADC Left Mux", SND_SOC_NOPM, 0, 0, &adcl_mux),
>  	SND_SOC_DAPM_MUX("ADC Right Mux", SND_SOC_NOPM, 0, 0, &adcr_mux),
> @@ -868,6 +869,11 @@ static const struct snd_soc_dapm_route audio_map[] = {
>  	{"Left ADC", NULL, "Left ADC MOD"},
>  	{"Right ADC", NULL, "Right ADC MOD"},
>  
> +	/* I2S Clock */
> +	{"I2S DIN", NULL, "I2S CLK"},
> +	{"I2S DIN1", NULL, "I2S CLK"},
> +	{"I2S DOUT", NULL, "I2S CLK"},
> +
>  	/* PCM/AIF1 Inputs */
>  	{"PCM SDO", NULL, "ADC Left Mux"},
>  	{"PCM SDO", NULL, "ADCR EC Mux"},
> -- 
> 1.7.0.4
> 

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
