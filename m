Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6B8C433E4
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:01:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0302A2077D
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="s9atIbxw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4C+ZODB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0302A2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8927D1672;
	Wed, 22 Jul 2020 11:00:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8927D1672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595408508;
	bh=K/tzu5vEt4uPOfC643ppNtixEt60LWkTOaMEncmlyAw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s9atIbxwvjmlvyE2/tn5/hFI9MTMIc8Qp5AyqGsQJ7hI6T+/4nCRt9XniYFqhbGY4
	 5gcQm9q4admqAVuz+Zq9cliKfk6KEo0zwiv3jpYNTTP+OW0nNgQVuXKIDwBYRHCkYy
	 9/dToeIuqbRdfivooqBAyvhEWtlnp++L8WQPuf0Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9182EF802BE;
	Wed, 22 Jul 2020 11:00:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 722EBF802C2; Wed, 22 Jul 2020 11:00:09 +0200 (CEST)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7160AF80087
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 11:00:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7160AF80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="M4C+ZODB"
Received: by mail-wr1-x442.google.com with SMTP id f2so1099130wrp.7
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 02:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vEurh4VLUZ8RQchp/nZukq9HgvAFG/riRsef7JlAm2g=;
 b=M4C+ZODBdCX7zNkJ/IbfXpaaNE2kidJCTZUSur0UicCWZAkzLX1G06l9y+CKC5eVvR
 rsgIuelUOYK2MQkfN8g3TX7hXt7EYdc7UGzFKYL9P0uw8j4UnVJaupRah9W3Zu0lW2s8
 lG6JTPuc2B/j9eM33DuEXX1eiK85Q6wh07wDLhFRga8Sleg/RMNUbRJDhzYfdoxjejWA
 C806h4znm9hB1t1QSWRqX093eMydW44pFwwnbD5+TybK3V86JDrP/ZX+HwsqhxQUXqKy
 11SGBDcoYQn66zdF6U0T+G66WAiW98e1IUOuK8S/y9edFAJoXUFAiKfJ/SmfWYE/0JGG
 Cnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vEurh4VLUZ8RQchp/nZukq9HgvAFG/riRsef7JlAm2g=;
 b=CaWQBkYdiu7vSoUCNWeRGEuQGCvAFZs1/mrFD0nyi5GF04uhSRlJmAACLBlsC/eI7M
 T9gj46hHC6HwDT1jcWi1qn1O2oTMn/49pPXYaMASu1UgUNpnanXF+9K8I9hXhoUylJmy
 VjBShSxO58bqgCYe0nKlOWmaw3cBKNf1/6UU18o0xgv/cQPTFfHUGGaE9EfZ0EUAg/Bw
 2KyqdXcaCXSdJW54kpiUK5bOvRNLGTh/vXAq7A/NKPwefLvONb0Qg+oNvuLB+cfHUlf3
 SN+ooCN03m3x6jTK2A19p4w1codQEkfu9YxRZfFNBq1GHa+CLM6zFmRLfb4Npq2s0iCb
 YyNA==
X-Gm-Message-State: AOAM532N/QuD5LOtDG3aRB2JQndFZd6IkR5L2fnKfoTNh3thfaK9EAWp
 F7KuYVipJYRVnJjiibSjCcQ5tA==
X-Google-Smtp-Source: ABdhPJzcngyS0WMyfwBqxzzteoncRL6n3m7nbTadp0pXZyIDMhEKrztRiYPDtfC+9R8Fg3A+bYA6xg==
X-Received: by 2002:a5d:4283:: with SMTP id k3mr29734493wrq.322.1595408400486; 
 Wed, 22 Jul 2020 02:00:00 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id f9sm40793497wru.47.2020.07.22.01.59.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Jul 2020 01:59:59 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/6] ALSA: compress: add new ioctl for setting
 codec parameters
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <20200721170007.4554-3-srinivas.kandagatla@linaro.org>
 <ee2dc239-c1a7-f48f-c6f0-ec6e61ccdda6@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9bbfebf9-9a70-46e3-1808-413d04aa6b2c@linaro.org>
Date: Wed, 22 Jul 2020 09:59:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ee2dc239-c1a7-f48f-c6f0-ec6e61ccdda6@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
 vkoul@kernel.org
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



On 21/07/2020 21:05, Pierre-Louis Bossart wrote:
> 
> 
> On 7/21/20 12:00 PM, Srinivas Kandagatla wrote:
>> For gapless playback it is possible that each track can have different
>> codec profile with same decoder, for example we have WMA album,
>> we may have different tracks as WMA v9, WMA v10 and so on
>>
>> Or if DSP's like QDSP have abililty to switch decoders on single stream
> 
> ability
> 
>> for each track, then this call could be used to set new codec parameters.
>>
>> Existing code does not allow to change this profile while doing gapless
>> playback.
>>
>> This patch adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL to allow
>> userspace to set this new parameters required for new codec profile.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../sound/designs/compress-offload.rst        |  6 ++++
>>   include/sound/compress_driver.h               |  5 +++
>>   include/uapi/sound/compress_offload.h         |  1 +
>>   sound/core/compress_offload.c                 | 34 +++++++++++++++++++
>>   4 files changed, 46 insertions(+)
>>
>> diff --git a/Documentation/sound/designs/compress-offload.rst 
>> b/Documentation/sound/designs/compress-offload.rst
>> index 935f325dbc77..305ccc7bfdd9 100644
>> --- a/Documentation/sound/designs/compress-offload.rst
>> +++ b/Documentation/sound/designs/compress-offload.rst
>> @@ -128,6 +128,12 @@ set_params
>>     cases decoders will ignore other fields, while encoders will strictly
>>     comply to the settings
>> +set_codec_params
>> +  This routine is very much simillar to set_params but exculding stream
> 
> typos: similar, excluding
> 
>> +  information. Only codec related information is set as part of this.
>> +  It is used in gapless playback where its required to change decoder
>> +  or its parameters for next track. This is optional.
>> +
>>   get_params
>>     This routines returns the actual settings used by the DSP. Changes to
>>     the settings should remain the exception.
>> diff --git a/include/sound/compress_driver.h 
>> b/include/sound/compress_driver.h
>> index 70cbc5095e72..d9c00bcfce9b 100644
>> --- a/include/sound/compress_driver.h
>> +++ b/include/sound/compress_driver.h
>> @@ -93,6 +93,9 @@ struct snd_compr_stream {
>>    * @set_params: Sets the compressed stream parameters, mandatory
>>    * This can be called in during stream creation only to set codec 
>> params
>>    * and the stream properties
>> + * @set_codec_params: Sets the compressed stream codec parameters, 
>> Optional
>> + * This can be called in during gapless next track codec change only 
>> to set
>> + * codec params
> 
> Would it be clearer if this was called set_next_codec_params()? or 
> set_next_track_codec_params()?
> 
> Having set_params() and set_codec_params() is a bit confusing since the 
> semantic difference is not captured in the callback name.

set_next_track_codec_params seems more sensible as its next track params.
Will change this in next version!

--srini

> 
