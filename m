Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A244BCFD2FD
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Oct 2024 09:20:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ECEE3E64;
	Fri, 11 Oct 2024 11:20:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ECEE3E64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1728638455;
	bh=XUm6bQyZ0tbdlWRN3PYXICagCOOgTGNn0bclhgi+vPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XI2jFaaWmXSHYIgxWIQE64bDODemWCrPb5WmAqoGuYntcc3G9xQwgYvbEaz9vl04H
	 XgazwPgvVNKxmwiRAa01PHdZzmtzSeYH7OaVI5XKdIQhXm5cJoECEA4WQkD1c+oYQ1
	 wWTQDF/RzUiCAIB2ag5t5BO0p+h6GtqZBIdLAFnU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D272F80623; Fri, 11 Oct 2024 11:19:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5ECE6F80617;
	Fri, 11 Oct 2024 11:19:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40DC0F80528; Tue,  8 Oct 2024 22:59:58 +0200 (CEST)
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E7C7F80104
	for <alsa-devel@alsa-project.org>; Tue,  8 Oct 2024 22:59:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E7C7F80104
Authentication-Results: alsa1.perex.cz;
	dkim=pass (4096-bit key,
 unprotected) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.a=rsa-sha256
 header.s=key header.b=nnTS5asH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1728421195; bh=XUm6bQyZ0tbdlWRN3PYXICagCOOgTGNn0bclhgi+vPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nnTS5asHFY7Rdlen4jlP6K8yqvtMbMckPdS/OBfccB3JUdhBySggZ2DUFB/d2EdIF
	 YMQnoDr1l6gvBNuJtWnrJcNeWz1Tb97tAeG0yLnPMbabFVXFydWUruCA/V8U7Gso6d
	 K4InpxXcyIjIJLfip261qk+Tw1BcTzR+tYBcj6tmuunQ8QAw/J+lM5k9PzGA7LcfJG
	 W7d5kr0Kf5Yq2iKTYDcEmZpr/K/ObcGNxpgRqQaOyNkA3Uhh4Kkp+BFZSFHmri6MhL
	 a3Upm3w8GvHp0birg27krQqQyBGXluoiDjA2gId55ORGfbaMW72VtCpIIDeof6KWQk
	 slrcOba79hVaVkqPaelSDjDg/pMt/HqO9uCKA1rJIv1g6MwzPxmTgCmV7HFgul6rGy
	 TlUn1Q44zxWRWq7JL4M3LLriAQC5xUuhhss3Fup+IyRff+k/3PXj034ZNVQSyWsGmR
	 to6HFPrwRhw2QBqw1vttjxKoYJCH19MhWy+OFZWCxbhteIc9XpdBWPWsdV7eS9uA8r
	 MaR6FJVn5xHsYpwMCZpSPt3xT6A8hXpulqsyIZc8RwVOGP2UZq7R9R2J4vRUGlkdOv
	 wTMxHkFXzosTdLtqDy2d3Fi7BXT5pjWHDxSNOdnu2PvLSqTZn0jWa+5TIw/zhOcEAE
	 aoKARUu6EynyZt4NzjGvozoU=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl
 [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 023C118D984;
	Tue,  8 Oct 2024 22:59:54 +0200 (CEST)
Message-ID: <a5ad3f88-b4bb-41ad-97c0-1511d205a785@ijzerbout.nl>
Date: Tue, 8 Oct 2024 22:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: rt-sdw-common: Common functions for Realtek
 soundwire driver
To: Jack Yu <jack.yu@realtek.com>, "broonie@kernel.org" <broonie@kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>, "Flove(HsinFu)" <flove@realtek.com>,
 Oder Chiou <oder_chiou@realtek.com>, =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?=
 <shumingf@realtek.com>, =?UTF-8?B?RGVyZWsgW+aWueW+t+e+qV0=?=
 <derek.fang@realtek.com>
References: <959e8dcb075948459be4463f6a4ca6ee@realtek.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <959e8dcb075948459be4463f6a4ca6ee@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: kees@ijzerbout.nl
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: XGKE6FJ7KWXGP7AP2IR5KK3XMWEWW4XE
X-Message-ID-Hash: XGKE6FJ7KWXGP7AP2IR5KK3XMWEWW4XE
X-Mailman-Approved-At: Fri, 11 Oct 2024 09:19:26 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XGKE6FJ7KWXGP7AP2IR5KK3XMWEWW4XE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Op 01-10-2024 om 11:16 schreef Jack Yu:
> This is the first version of common functions for Realtek
> soundwire codec driver.
>
> Signed-off-by: Jack Yu <jack.yu@realtek.com>
> ---
>   sound/soc/codecs/Kconfig         |   5 +
>   sound/soc/codecs/Makefile        |   2 +
>   sound/soc/codecs/rt-sdw-common.c | 238 +++++++++++++++++++++++++++++++
>   sound/soc/codecs/rt-sdw-common.h |  66 +++++++++
>   4 files changed, 311 insertions(+)
>   create mode 100644 sound/soc/codecs/rt-sdw-common.c
>   create mode 100644 sound/soc/codecs/rt-sdw-common.h
>
> [...]
> +/**
> + * rt_sdca_headset_detect - Headset jack type detection.
> + *
> + * @map: map for setting.
> + * @entity_id: SDCA entity ID.
> + *
> + * A headset jack type will be returned, a negative errno will
> + * be returned in error cases.
> + */
> +int rt_sdca_headset_detect(struct regmap *map, unsigned int entity_id)
> +{
> +	unsigned int det_mode, jack_type;
> +	int ret;
> +
> +	/* get detected_mode */
> +	ret = regmap_read(map, SDW_SDCA_CTL(SDCA_NUM_JACK_CODEC, entity_id,
> +			RT_SDCA_CTL_DETECTED_MODE, 0), &det_mode);
> +
> +	if (ret < 0)
> +		goto io_error;
> +
> +	switch (det_mode) {
> +	case 0x00:
> +		jack_type = 0;
> +		break;
> +	case 0x03:
> +		jack_type = SND_JACK_HEADPHONE;
> +		break;
> +	case 0x05:
> +		jack_type = SND_JACK_HEADSET;
> +		break;
There is no default case. So, variable jack_type can remain 
uninitialized and then used for the return value.
Perhaps you can combine "case 0x00" with "default".
> +	}
> +
> +	/* write selected_mode */
> +	if (det_mode) {
> +		ret = regmap_write(map, SDW_SDCA_CTL(SDCA_NUM_JACK_CODEC, entity_id,
> +				RT_SDCA_CTL_SELECTED_MODE, 0), det_mode);
> +		if (ret < 0)
> +			goto io_error;
> +	}
> +
> +	return jack_type;
>
