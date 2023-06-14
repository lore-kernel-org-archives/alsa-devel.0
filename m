Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E4EEB64D9
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jun 2023 11:57:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C238A823;
	Wed, 14 Jun 2023 13:56:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C238A823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686743818;
	bh=iCiU+SBqbvdNEdnvfQoYYRtDSvHHfH1+xDfAe2e2L8w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qDZ/Jnhmwm9V7pulAxIos29Z0x84pOX9iI47nFkoH/0FarCm3SXkJGib6l+5iTNbp
	 559AMPW/he5iDSqqgBD58MffyNAkBStGJdBacN3sJ7MAPG9KRy8QCV+vnx2q+84Og8
	 UvOnrzhEBIB8ZNbjvY3l8O7y44PRGZv85aEudwsw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40474F80149; Wed, 14 Jun 2023 13:55:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C2A76F80149;
	Wed, 14 Jun 2023 13:55:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 595D8F80149; Wed, 14 Jun 2023 13:55:41 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5D236F800BA
	for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2023 13:55:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D236F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IOwIuW/a
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f6370ddd27so8436363e87.0
        for <alsa-devel@alsa-project.org>;
 Wed, 14 Jun 2023 04:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686743735; x=1689335735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ykv/GwV2w/s1XOWDjj7UvX/0sKbvp29mJL9R2dK69wc=;
        b=IOwIuW/a1zAfPZaRWrd646FOcfeyRubilQTZrt+HFVhmIYBiDZ4AV1pos3rO2n3or+
         Ls88VyeCX2rUUHKLZDeBMpv4117TCTdvjlA90Kjtp4XC2+gLpkcBIRqMtD8dfPkXI0iw
         AEbh07I264SrfU/dVYkN6nN1liKLNvYBi8acMrRosd4Ekj0yaodPJIVvlGoupeoccd/L
         qTbs/reSnSG5eZP7qT6BwCKoxsJjupzk7eMIjxWd09D9Crfl6D9fwhnDT6EumsLwVcYV
         WPhXagWGygY6SeMPtjxg/MdNwflXiF6dbJaV8RJe8aO3Hw901Dnz9b7YINVdLHFWDC5L
         QbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686743735; x=1689335735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ykv/GwV2w/s1XOWDjj7UvX/0sKbvp29mJL9R2dK69wc=;
        b=UFjIkjNgZ9rroSZa0+Sx6JaZFQlhrO1zG5ELBvwbUkYkl3uv06WVRd5kxoLwOvUewF
         WsnCgNeGsLK1vlms0RsKkNuTWQ9WmQmsFt5miqhLsDK9DpPGpvbkDB38cI9ZrMWWUklO
         KslUm06N4KvAXJgIQ04im4FEGQHULvrP+dt/xBNi1EssV79Dq5apdq2zIS3ns4hCbwtX
         EM/o3eSXjfa0E/qYOf8KN+KgblbBG7kljP2fyv27a20l14jl1/JuntSZeafHxgDN81Qc
         C9O/uxDk2A4AciTc0ZilVgo6SQkLd6amul0aj5FJc2GsnCVWaTroTJZ+EDaVS+pNQZ5K
         JeiA==
X-Gm-Message-State: AC+VfDxkhPDgbsCdFFeZG2qhbXU3dZbMdZQe6h36/ZrynRcb58zQtE7K
	6xjOtwjKfmQYtPLshkwksKhtwQ==
X-Google-Smtp-Source: 
 ACHHUZ7UIgwPnNgtVg8gTMmxTLbVJ6LtLPWnod6cj64WHWT1Ri75+jSp2Zz2YTYWMn4FC16sclFpjw==
X-Received: by 2002:a05:6512:2f5:b0:4f6:7e3:ac87 with SMTP id
 m21-20020a05651202f500b004f607e3ac87mr9216669lfq.14.1686743734996;
        Wed, 14 Jun 2023 04:55:34 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id
 ja15-20020a05600c556f00b003f61177faffsm6547045wmb.0.2023.06.14.04.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 04:55:34 -0700 (PDT)
Message-ID: <5e9e525a-690d-38ce-d80f-da433d4062fd@linaro.org>
Date: Wed, 14 Jun 2023 12:55:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ALSA: compress: allow setting codec params after next
 track
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: vkoul@kernel.org, broonie@kernel.org, tiwai@suse.com, corbet@lwn.net,
 alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_plai@quicinc.com, quic_mohs@quicinc.com
References: <20230609150416.24525-1-srinivas.kandagatla@linaro.org>
 <87edmebk2w.wl-tiwai@suse.de>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <87edmebk2w.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: 2MKJZGXOTFSLNJ46VRDRXP6RET2QZKVX
X-Message-ID-Hash: 2MKJZGXOTFSLNJ46VRDRXP6RET2QZKVX
X-MailFrom: srinivas.kandagatla@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2MKJZGXOTFSLNJ46VRDRXP6RET2QZKVX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Thanks Takashi for review,

On 14/06/2023 08:04, Takashi Iwai wrote:
> On Fri, 09 Jun 2023 17:04:16 +0200,
> Srinivas Kandagatla wrote:
>>
>> For gapless playback it is possible that each track can have different
>> codec profile with same decoder, for example we have WMA album,
>> we may have different tracks as WMA v9, WMA v10 and so on
>>
>> Or if DSP's like QDSP have abililty to switch decoders on single stream
>> for each track, then this call could be used to set new codec parameters.
>>
>> Existing code does not allow to change this profile while doing gapless
>> playback.
>>
>> Reuse existing SNDRV_COMPRESS_SET_PARAMS to set this new track params along
>> some additional checks to enforce proper state machine.
>>
>> With this new changes now the user can call SNDRV_COMPRESS_SET_PARAMS
>> anytime after setting next track and additional check in write should
>> also ensure that params are set before writing new data.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>> Changes since v1/RFC:
>> 	- removed introduction of new IOCTL, as suggested.
>> 	- update the state-machine doc.
>>
>>   .../sound/designs/compress-offload.rst        | 52 +++++++++----------
>>   sound/core/compress_offload.c                 | 10 ++--
>>   2 files changed, 33 insertions(+), 29 deletions(-)
>>
>> diff --git a/Documentation/sound/designs/compress-offload.rst b/Documentation/sound/designs/compress-offload.rst
>> index 935f325dbc77..205cadcabe70 100644
>> --- a/Documentation/sound/designs/compress-offload.rst
>> +++ b/Documentation/sound/designs/compress-offload.rst
>> @@ -256,32 +256,32 @@ Gapless Playback SM
>>   For Gapless, we move from running state to partial drain and back, along
>>   with setting of meta_data and signalling for next track ::
>>   
>> -
>> -                                        +----------+
>> -                compr_drain_notify()    |          |
>> -              +------------------------>|  RUNNING |
>> -              |                         |          |
>> -              |                         +----------+
>> -              |                              |
>> -              |                              |
>> -              |                              | compr_next_track()
>> -              |                              |
>> -              |                              V
>> -              |                         +----------+
>> -              |                         |          |
>> -              |                         |NEXT_TRACK|
>> -              |                         |          |
>> -              |                         +----------+
>> -              |                              |
>> -              |                              |
>> -              |                              | compr_partial_drain()
>> -              |                              |
>> -              |                              V
>> -              |                         +----------+
>> -              |                         |          |
>> -              +------------------------ | PARTIAL_ |
>> -                                        |  DRAIN   |
>> -                                        +----------+
>> +                            +----------+
>> +     compr_drain_notify()   |          | compr_set_params() iff next-track set.
>> +  +------------------------>|  RUNNING |----------------------+
>> +  |                         |          |                      |
>> +  |                         +----------+                      |
>> +  |                              |                            |
>> +  |                              |                            |
>> +  |                              | compr_next_track()         |
>> +  |                              |                            V
>> +  |                              V                            |
>> +  |                         +----------+                      |
>> +  |                         |          |                      |
>> +  |                         |NEXT_TRACK|                      |
>> +  |                         |          |                      |
>> +  |                         +----------+                      |
>> +  |                              |                            |
>> +  |                              +----------------------------+
>> +  |                              |
>> +  |                              | compr_partial_drain()
>> +  |                              |
>> +  |                              V
>> +  |                         +----------+
>> +  |                         |          |
>> +  +------------------------ | PARTIAL_ |
>> +                            |  DRAIN   |
>> +                            +----------+
>>   
>>   Not supported
>>   =============
>> diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
>> index 243acad89fd3..fe67228e74b3 100644
>> --- a/sound/core/compress_offload.c
>> +++ b/sound/core/compress_offload.c
>> @@ -294,6 +294,9 @@ static ssize_t snd_compr_write(struct file *f, const char __user *buf,
>>   	case SNDRV_PCM_STATE_SETUP:
>>   	case SNDRV_PCM_STATE_PREPARED:
>>   	case SNDRV_PCM_STATE_RUNNING:
>> +		/* Make sure next track params are set before writing new data */
>> +		if (stream->next_track)
>> +			return -EPERM;
> 
> Hm, does this logic correctly match with the comment above?
Yes I agree, it bit confusing and also going to break the partial drain 
path.
> Also, this misses the mutex unlock.

Thinking about this again, Its not required have this check here to 
start with.

Something like below works, I can send this as v3, if this looks fine.

------------------------->cut<----------------------------------

diff --git a/Documentation/sound/designs/compress-offload.rst 
b/Documentation/sound/designs/compress-offload.rst
index 935f325dbc77..655624f77092 100644
--- a/Documentation/sound/designs/compress-offload.rst
+++ b/Documentation/sound/designs/compress-offload.rst
@@ -268,11 +268,12 @@ with setting of meta_data and signalling for next 
track ::
                |                              |
                |                              V
                |                         +----------+
-              |                         |          |
-              |                         |NEXT_TRACK|
-              |                         |          |
-              |                         +----------+
-              |                              |
+              |    compr_set_params()   |          |
+              |             +-----------|NEXT_TRACK|
+              |             |           |          |
+              |             |           +--+-------+
+              |             |              | |
+              |             +--------------+ |
                |                              |
                |                              | compr_partial_drain()
                |                              |
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 243acad89fd3..30f73097447b 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -589,7 +589,7 @@ snd_compr_set_params(struct snd_compr_stream 
*stream, unsigned long arg)
         struct snd_compr_params *params;
         int retval;

-       if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
+       if (stream->runtime->state == SNDRV_PCM_STATE_OPEN || 
stream->next_track) {
                 /*
                  * we should allow parameter change only when stream 
has been
                  * opened not in other cases
@@ -612,6 +612,9 @@ snd_compr_set_params(struct snd_compr_stream 
*stream, unsigned long arg)
                 if (retval)
                         goto out;

+               if (stream->next_track)
+                       goto out;
+
                 stream->metadata_set = false;
                 stream->next_track = false;
------------------------->cut<----------------------------------

> 
> 
> thanks,
> 
> Takashi
