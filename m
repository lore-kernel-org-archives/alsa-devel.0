Return-Path: <SRS0=RAD+=JT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0DBC433B4
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Apr 2021 09:41:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5916661445
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Apr 2021 09:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5916661445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5AAE11661;
	Thu, 22 Apr 2021 11:40:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5AAE11661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619084459;
	bh=/CIzmQ65+xwASidHABAH4/IK9Xw1qsTf8f+9gYpItCM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OTtHodmjfWiIKAML0MlAzAnP8t+NnOThlHwaLwqN9IWaVwu2/p/gH9qEyKB/RYEZr
	 e7i7bWAV1fiAT4iI93w4c+5DNqr4sqSZZYPfczXSy5Qe5reH+99khHbDYP5dEiY5L1
	 ujZAH6znQ2XVODHTzcV8tr0dSI9un6rneqmIP8lw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3845F80168;
	Thu, 22 Apr 2021 11:40:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ABA88F80253; Thu, 22 Apr 2021 11:40:06 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B55BDF800AE
 for <alsa-devel@alsa-project.org>; Thu, 22 Apr 2021 11:39:53 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 31329A0040;
 Thu, 22 Apr 2021 11:39:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 31329A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1619084392; bh=PaNTQMsn6bMhdUD1PBlmKZIeGTHyRAbcddDSXS5T/cA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=U5A9OWZFgxpNvi1TA6iYd7K/LxrQNhb9gWOrKI/vwsnSl8Bw9C2T+ugic7zEBvepq
 rBUAqkrWscLknqFCtqD5nIglwn+ys8lM29jXq6il1dgL8HpG5r7wu+fTlh00Fi3LM0
 KOexzO59/FQrxp4pF8kucaV+ZNH50ztpHVVnqBV4=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu, 22 Apr 2021 11:39:42 +0200 (CEST)
Subject: Re: [PATCH v3] ASoC: rt711-sdca: change capture switch controls
To: shumingf@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
References: <20210422090825.2912-1-shumingf@realtek.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <90f856b8-2446-679e-3cfa-196787094153@perex.cz>
Date: Thu, 22 Apr 2021 11:39:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210422090825.2912-1-shumingf@realtek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, libin.yang@intel.com, derek.fang@realtek.com,
 flove@realtek.com
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dne 22. 04. 21 v 11:08 shumingf@realtek.com napsal(a):
> From: Shuming Fan <shumingf@realtek.com>
> 
> The DAPM event and mixer control could mute/unmute the capture directly.
> That will be confused that capture still works if the user settings is unmute before the capture.
> Therefore, this patch uses the variables to record the capture switch status of DAPM and mixer.
> 
> Signed-off-by: Shuming Fan <shumingf@realtek.com>
> ---
>  sound/soc/codecs/rt711-sdca.c | 208 +++++++++++++++++++++++++++-------
>  sound/soc/codecs/rt711-sdca.h |   2 +
>  2 files changed, 167 insertions(+), 43 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt711-sdca.c b/sound/soc/codecs/rt711-sdca.c
> index bfb7f1c8ec8f..3ab9048b4ea3 100644
> --- a/sound/soc/codecs/rt711-sdca.c
> +++ b/sound/soc/codecs/rt711-sdca.c
> @@ -642,6 +642,154 @@ static int rt711_sdca_set_gain_get(struct snd_kcontrol *kcontrol,
>  	return 0;
>  }
>  
> +static int rt711_sdca_set_fu0f_capture_ctl(struct rt711_sdca_priv *rt711)
> +{
> +	int err;
> +
> +	if (rt711->fu0f_dapm_mute) {
> +		err = regmap_write(rt711->regmap,
> +			SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU0F,
> +			RT711_SDCA_CTL_FU_MUTE, CH_L), 0x01);
> +		if (err < 0)
> +			return err;
> +		err = regmap_write(rt711->regmap,
> +			SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU0F,
> +			RT711_SDCA_CTL_FU_MUTE, CH_R), 0x01);
> +		if (err < 0)
> +			return err;

Is possible to set both channels RT711_SDCA_CTL_FU_MUTE in one write ?

Something like:

  regmap_write(rt711->regmap,
		SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU0F,
			RT711_SDCA_CTL_FU_MUTE, CH_R|CH_L), 0x01);

Anyway, this function can be recoded like (far more readable):

  ch_l = (rt711->fu0f_dapm_mute || rt711->fu0f_mixer_l_mute) ? 0x01 : 0x00;
  ch_r = (rt711->fu0f_dapm_mute || rt711->fu0f_mixer_r_mute) ? 0x01 : 0x00:
  regmap_write(rt711->regmap,
		SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU0F,
			RT711_SDCA_CTL_FU_MUTE, CH_L), ch_l);
  regmap_write(rt711->regmap,
		SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU0F,
			RT711_SDCA_CTL_FU_MUTE, CH_R), ch_r);

... just add error checking ...

Or ideally, if both mute bits can be set together (one regmap_write):

  ch_l = (rt711->fu0f_dapm_mute || rt711->fu0f_mixer_l_mute) ? 0x01 : 0x00;
  ch_r = (rt711->fu0f_dapm_mute || rt711->fu0f_mixer_r_mute) ? 0x01 : 0x00:
  regmap_write(rt711->regmap,
		SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU0F,
		  RT711_SDCA_CTL_FU_MUTE, CH_L|CH_R), ch_l | (ch_r << 1));

> +
> +static int rt711_sdca_set_fu1e_capture_ctl(struct rt711_sdca_priv *rt711)

Same comments as for rt711_sdca_set_fu0f_capture_ctl().

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
