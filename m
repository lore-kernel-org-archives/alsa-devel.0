From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: sgtl5000: Fix the cache handling
Date: Fri, 23 May 2014 10:36:20 +0200
Message-ID: <537F0884.3050605@metafoo.de>
References: <1400821880-20939-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-176.synserver.de (smtp-out-181.synserver.de
 [212.40.185.181])
 by alsa0.perex.cz (Postfix) with ESMTP id CD366265677
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 10:38:11 +0200 (CEST)
In-Reply-To: <1400821880-20939-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org

[...]
> @@ -1075,7 +1079,6 @@ static int sgtl5000_suspend(struct snd_soc_codec *codec)
>    */
>   static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
>   {
> -	u16 *cache = codec->reg_cache;
>   	u16 reg;
>
>   	/* restore regular registers */
> @@ -1089,12 +1092,12 @@ static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
>   			reg == SGTL5000_CHIP_REF_CTRL)
>   			continue;
>
> -		snd_soc_write(codec, reg, cache[reg]);
> +		snd_soc_write(codec, reg, snd_soc_read(codec, reg));
>   	}
>
>   	/* restore dap registers */
>   	for (reg = SGTL5000_DAP_REG_OFFSET; reg < SGTL5000_MAX_REG_OFFSET; reg += 2)
> -		snd_soc_write(codec, reg, cache[reg]);
> +		snd_soc_write(codec, reg, snd_soc_read(codec, reg));
>
>   	/*
>   	 * restore these regs according to the power setting sequence in
> @@ -1110,29 +1113,32 @@ static int sgtl5000_restore_regs(struct snd_soc_codec *codec)
>   	 *    prefer to resotre it after SGTL5000_CHIP_ANA_POWER restored
>   	 */
>   	snd_soc_write(codec, SGTL5000_CHIP_LINREG_CTRL,
> -			cache[SGTL5000_CHIP_LINREG_CTRL]);
> +			snd_soc_read(codec, SGTL5000_CHIP_LINREG_CTRL));
>
>   	snd_soc_write(codec, SGTL5000_CHIP_ANA_POWER,
> -			cache[SGTL5000_CHIP_ANA_POWER]);
> +			snd_soc_read(codec, SGTL5000_CHIP_ANA_POWER));
>
>   	snd_soc_write(codec, SGTL5000_CHIP_CLK_CTRL,
> -			cache[SGTL5000_CHIP_CLK_CTRL]);
> +			snd_soc_read(codec, SGTL5000_CHIP_CLK_CTRL));
>
>   	snd_soc_write(codec, SGTL5000_CHIP_REF_CTRL,
> -			cache[SGTL5000_CHIP_REF_CTRL]);
> +			snd_soc_read(codec, SGTL5000_CHIP_REF_CTRL));
>
>   	snd_soc_write(codec, SGTL5000_CHIP_LINE_OUT_CTRL,
> -			cache[SGTL5000_CHIP_LINE_OUT_CTRL]);
> +			snd_soc_read(codec, SGTL5000_CHIP_LINE_OUT_CTRL));
>   	return 0;
>   }
>
>   static int sgtl5000_resume(struct snd_soc_codec *codec)
>   {
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
>   	/* Bring the codec back up to standby to enable regulators */
>   	sgtl5000_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
>
>   	/* Restore registers by cached in memory */
>   	sgtl5000_restore_regs(codec);
> +
> +	regcache_cache_only(sgtl5000->regmap, false);

That doesn't make too much sense, if regmap is in cache only mode 
snd_soc_read() will read from the cache and snd_soc_write() will write to the 
cache and nothing else happens. So you read from the cache only to write the 
same value back.
