Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740ACC4725D
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Jan 2024 07:46:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E3781F1;
	Fri, 19 Jan 2024 08:46:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E3781F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705650390;
	bh=Q4LIJG2y70z4o4cUYu3Cup/EpTdk2M6eRV1q2WORKVY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=j/7htLCIe1TKpj+dL8WcByB4Yn5rtcnmEan7/nSM+cMQyKgCRxr1xI33DdJLwyBIO
	 OHZi0Q+9o+z3xm0jGFqPBja48CuYiiR6nuB99X6Bu9xeBn2xM6c4IPFsB/pf9eNOvd
	 J5Hp5qrazdxLDzkeQwT/P6g8pSD2DzehidEzQS+U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33ECCF8028D; Fri, 19 Jan 2024 08:45:56 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2F40F80587;
	Fri, 19 Jan 2024 08:45:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29700F80074; Fri, 19 Jan 2024 08:45:51 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C89BDF80074
	for <alsa-devel@alsa-project.org>; Fri, 19 Jan 2024 08:45:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C89BDF80074
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SzcaiG12
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e490c2115so9372355e9.0
        for <alsa-devel@alsa-project.org>;
 Thu, 18 Jan 2024 23:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705650347; x=1706255147;
 darn=alsa-project.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axlxMn3mKxrZ+z0NjINZroTLytSc1sa1mWx0FPrBc1I=;
        b=SzcaiG12yThEIZjhhMfVhL13ghLHs25Tu9qZUari8zUoP0z6dw8axP+U6Yv2s6lc18
         RFm5I1ZuhPwcx02KLJANt7PQnPAoZq7DIkVdHeVHWICkwnEZDvb610nzydFu29QAkKGJ
         uKkdKx6Bg6rwGbxye9UDXwofl8r9vy3Uskf2SB9FIf0xkg5Q7yOmulPpaKTCUU09xzpk
         oUfTzfDbbUzy8TSkygRKAJtj7UApBPCTOvDtRNRGGhqfGK6IMoxuOuCweTmF3PsMC3cO
         XXQ2HnJZ7jf1ItGidqtvFIEPW8LarXBA5kUBx4XLsjQ3IsanDfnWP7cdXvPq8tx/rGSb
         eDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705650347; x=1706255147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axlxMn3mKxrZ+z0NjINZroTLytSc1sa1mWx0FPrBc1I=;
        b=n+Kf35KSwdihlaEJIt0uxhOFRmJJop0CZgMvUaCuMY4zWhgfA2w2SvV4gy0kOfqQu5
         jxAfEydThH+iaAcjIHpUcZ1W8WQAtpSX+Su86ODXp1LhCa/L2z3L7AXnR6qxtP4qXaQ9
         XG/HQruS5BxUeK0Okhn45jfUWQIop7VbqtSp/NRB/53gB0a1zpVOreHILZWAii5cX02c
         jWKL+YJGsSVAfGJTTaegyCkLdN3RY2f1CS6hrBiylDe51Nvw7uZCH4Aavhid3/v2RMo+
         QuSuBCi0btdraDRQgHjkC0nOpAIHnqIzg05F9hav0LFoa6uq18jKWM/YypWkunlfllPz
         Gfow==
X-Gm-Message-State: AOJu0YzmnCcefLHWEEGvR38uUkS04FblBNOrO4nlgpMVmURSjK/gAS9M
	XBzm6lJzJFn+G1assz9pFVGXBobC9huJUTln6cxXt2MG+B+yCw4cqZqAiR93ujE=
X-Google-Smtp-Source: 
 AGHT+IFDofa/AFb3zEbQS9BWqodcUqjTtN/sp/WtGUkdrc4wTm5faoFC+sDHVcwObz4Ml2d7rzEcEA==
X-Received: by 2002:a05:600c:4248:b0:40e:4380:c8e5 with SMTP id
 r8-20020a05600c424800b0040e4380c8e5mr261612wmm.49.1705650346897;
        Thu, 18 Jan 2024 23:45:46 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id
 i6-20020adfb646000000b00337bc2176f6sm5800237wre.81.2024.01.18.23.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 23:45:46 -0800 (PST)
Message-ID: <6d8f77e2-7257-4a6c-96de-fd3f1c821b51@linaro.org>
Date: Fri, 19 Jan 2024 07:45:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] ASoC: codecs: lpass-wsa-macro: fix compander
 volume hack
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-5-johan+linaro@kernel.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240118165811.13672-5-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: QBKU5MY52Q3LUXZ5PO7JBUMWA2YWUI6Z
X-Message-ID-Hash: QBKU5MY52Q3LUXZ5PO7JBUMWA2YWUI6Z
X-MailFrom: srinivas.kandagatla@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QBKU5MY52Q3LUXZ5PO7JBUMWA2YWUI6Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 18/01/2024 16:58, Johan Hovold wrote:
> The LPASS WSA macro codec driver is updating the digital gain settings
> behind the back of user space on DAPM events if companding has been
> enabled.
> 
> As compander control is exported to user space, this can result in the
> digital gain setting being incremented (or decremented) every time the
> sound server is started and the codec suspended depending on what the
> UCM configuration looks like.
> 
> Soon enough playback will become distorted (or too quiet).
> 
> This is specifically a problem on the Lenovo ThinkPad X13s as this
> bypasses the limit for the digital gain setting that has been set by the
> machine driver.
> 
> Fix this by simply dropping the compander gain offset hack. If someone
> cares about modelling the impact of the compander setting this can
> possibly be done by exporting it as a volume control later.
> 
> Note that the volume registers still need to be written after enabling
> clocks in order for any prior updates to take effect.
> 
> Fixes: 2c4066e5d428 ("ASoC: codecs: lpass-wsa-macro: add dapm widgets and route")
> Cc: stable@vger.kernel.org      # 5.11
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   sound/soc/codecs/lpass-wsa-macro.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
> index 7e21cec3c2fb..6ce309980cd1 100644
> --- a/sound/soc/codecs/lpass-wsa-macro.c
> +++ b/sound/soc/codecs/lpass-wsa-macro.c
> @@ -1584,7 +1584,6 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
>   	u16 gain_reg;
>   	u16 reg;
>   	int val;
> -	int offset_val = 0;

TBH, as discussed in my previous review we should just remove 
spkr_gain_offset and associated code path.


--srini

>   	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
>   
>   	if (w->shift == WSA_MACRO_COMP1) {
> @@ -1623,10 +1622,8 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
>   					CDC_WSA_RX1_RX_PATH_MIX_SEC0,
>   					CDC_WSA_RX_PGA_HALF_DB_MASK,
>   					CDC_WSA_RX_PGA_HALF_DB_ENABLE);
> -			offset_val = -2;
>   		}
>   		val = snd_soc_component_read(component, gain_reg);
> -		val += offset_val;
>   		snd_soc_component_write(component, gain_reg, val);
>   		wsa_macro_config_ear_spkr_gain(component, wsa,
>   						event, gain_reg);
> @@ -1654,10 +1651,6 @@ static int wsa_macro_enable_interpolator(struct snd_soc_dapm_widget *w,
>   					CDC_WSA_RX1_RX_PATH_MIX_SEC0,
>   					CDC_WSA_RX_PGA_HALF_DB_MASK,
>   					CDC_WSA_RX_PGA_HALF_DB_DISABLE);
> -			offset_val = 2;
> -			val = snd_soc_component_read(component, gain_reg);
> -			val += offset_val;
> -			snd_soc_component_write(component, gain_reg, val);
>   		}
>   		wsa_macro_config_ear_spkr_gain(component, wsa,
>   						event, gain_reg);
