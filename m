From: Cezary Rojewski <cezary.rojewski@intel.com>
Subject: Re: [PATCH v2] ASoC: madera: Read device tree
 configuration
Date: Tue, 23 Jul 2019 00:07:32 +0200
Message-ID: <7a6ca46b-9ca7-6c91-6aa9-d1be785c64c5@intel.com>
References: <20190722135209.30302-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CA17F800F5
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 00:07:39 +0200 (CEST)
In-Reply-To: <20190722135209.30302-1-ckeepax@opensource.cirrus.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 2019-07-22 15:52, Charles Keepax wrote:
> +static void madera_prop_get_inmode(struct madera_priv *priv)
> +{
> +	struct madera *madera = priv->madera;
> +	struct madera_codec_pdata *pdata = &madera->pdata.codec;
> +	u32 tmp[MADERA_MAX_INPUT * MADERA_MAX_MUXED_CHANNELS];
> +	int n, i, in_idx, ch_idx;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(pdata->inmode) != MADERA_MAX_INPUT);
> +	BUILD_BUG_ON(ARRAY_SIZE(pdata->inmode[0]) != MADERA_MAX_MUXED_CHANNELS);
> +
> +	n = madera_get_variable_u32_array(madera->dev, "cirrus,inmode",
> +					  tmp, ARRAY_SIZE(tmp),
> +					  MADERA_MAX_MUXED_CHANNELS);
> +	if (n < 0)
> +		return;
> +
> +	in_idx = 0;
> +	ch_idx = 0;
> +	for (i = 0; i < n; ++i) {
> +		pdata->inmode[in_idx][ch_idx] = tmp[i];
> +
> +		if (++ch_idx == MADERA_MAX_MUXED_CHANNELS) {
> +			ch_idx = 0;
> +			++in_idx;
> +		}
> +	}
> +}
> +
> +static void madera_prop_get_pdata(struct madera_priv *priv)
> +{
> +	struct madera *madera = priv->madera;
> +	struct madera_codec_pdata *pdata = &madera->pdata.codec;
> +	u32 out_mono[ARRAY_SIZE(pdata->out_mono)];
> +	int i, n;
> +
> +	madera_prop_get_inmode(priv);
> +
> +	n = madera_get_variable_u32_array(madera->dev, "cirrus,out-mono",
> +					  out_mono, ARRAY_SIZE(out_mono), 1);
> +	if (n > 0)
> +		for (i = 0; i < n; ++i)
> +			pdata->out_mono[i] = !!out_mono[i];
> +
> +	madera_get_variable_u32_array(madera->dev,
> +				      "cirrus,max-channels-clocked",
> +				      pdata->max_channels_clocked,
> +				      ARRAY_SIZE(pdata->max_channels_clocked),
> +				      1);
> +
> +	madera_get_variable_u32_array(madera->dev, "cirrus,pdm-fmt",
> +				      pdata->pdm_fmt,
> +				      ARRAY_SIZE(pdata->pdm_fmt), 1);
> +
> +	madera_get_variable_u32_array(madera->dev, "cirrus,pdm-mute",
> +				      pdata->pdm_mute,
> +				      ARRAY_SIZE(pdata->pdm_mute), 1);
> +
> +	madera_get_variable_u32_array(madera->dev, "cirrus,dmic-ref",
> +				      pdata->dmic_ref,
> +				      ARRAY_SIZE(pdata->dmic_ref), 1);

Hmm, madera_get_variable_u32_array calls are not permissive within 
madera_prop_get_inmode yet here they are. Is this intentional?

> +}
> +
>   int madera_core_init(struct madera_priv *priv)
>   {
>   	int i;
> @@ -308,6 +402,9 @@ int madera_core_init(struct madera_priv *priv)
>   	BUILD_BUG_ON(!madera_mixer_texts[MADERA_NUM_MIXER_INPUTS - 1]);
>   	BUILD_BUG_ON(!madera_mixer_values[MADERA_NUM_MIXER_INPUTS - 1]);
>   
> +	if (!dev_get_platdata(priv->madera->dev))
> +		madera_prop_get_pdata(priv);
> +
>   	mutex_init(&priv->rate_lock);
>   
>   	for (i = 0; i < MADERA_MAX_HP_OUTPUT; i++)
> 
