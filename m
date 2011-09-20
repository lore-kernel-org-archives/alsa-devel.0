From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [ASoC] 88pm860x - Incorporate the marvell errata
 regarding Audio Power-up Delay.
Date: Tue, 20 Sep 2011 12:34:59 +0100
Message-ID: <20110920113459.GC14609@sirena.org.uk>
References: <4E735811.2060002@novero.com> <20110917133206.GB3798@sirena.org.uk>
	<4E7729A3.4070102@novero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E91EA103A00
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 13:34:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E7729A3.4070102@novero.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com
Cc: "Bas Vermeulen (CentricTSolve/Bochum)" <ext-Bas.Vermeulen@novero.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 19, 2011 at 01:38:11PM +0200, Bas Vermeulen wrote:

> This patch implements the audio power-up delay errata for the
> 88PM8607, meaning the codec will actually be reset.

Adding Liam to this one too.

> From 55d78799fc7e492f582bc7feb4cb3251e8ef895d Mon Sep 17 00:00:00 2001
> From: Bas Vermeulen <bas.vermeulen@novero.com>
> Date: Mon, 19 Sep 2011 13:09:10 +0200
> Subject: [PATCH 2/2] [ASoC] 88pm860x-codec - reset the codec correctly
> 
> Reset the codec according to the Audio power-up delay errata for the 88PM8607.
> 
> Signed-off-by: Bas Vermeulen <bas.vermeulen@novero.com>
> ---
>  sound/soc/codecs/88pm860x-codec.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
> index 0198dbb..df7b4a0 100644
> --- a/sound/soc/codecs/88pm860x-codec.c
> +++ b/sound/soc/codecs/88pm860x-codec.c
> @@ -1179,6 +1179,9 @@ static int pm860x_set_bias_level(struct snd_soc_codec *codec,
>  	case SND_SOC_BIAS_STANDBY:
>  		if (codec->dapm.bias_level == SND_SOC_BIAS_OFF) {
>  			/* Enable Audio PLL & Audio section */
> +			data = AUDIO_PLL | AUDIO_SECTION_ON;
> +			pm860x_reg_write(codec->control_data, REG_MISC2, data);
> +			udelay(300);
>  			data = AUDIO_PLL | AUDIO_SECTION_RESET
>  				| AUDIO_SECTION_ON;
>  			pm860x_reg_write(codec->control_data, REG_MISC2, data);
> -- 
> 1.7.0.4
> 

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
