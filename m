Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC311C52D7D
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Aug 2024 08:24:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A42723CE;
	Thu, 15 Aug 2024 10:24:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A42723CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723710279;
	bh=IZLPCVzb3kPUDGJIg69Ehm8qFNzjVH6IUeurAwjF0EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=R/oFgoHj6cXhUfIfkb42pyhueOVrqNygZVM9NsIV0nGd0J8NBR+LYx/8q9cIT2HHI
	 bodUyvw7nITF8wfJsVEMbudIxZ7PYTZCV98by+RjIFU/sydIN9b4QbQCHDHyZsFajb
	 YjMVZf8+qZUg65fV8gmkgf5okUZpPpvwu9bpSZ3Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC87EF80600; Thu, 15 Aug 2024 10:23:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 98373F805F9;
	Thu, 15 Aug 2024 10:23:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 462E2F800B0; Tue,  6 Aug 2024 13:39:47 +0200 (CEST)
Received: from hosting3.qishost.com (signalogic.com [209.150.126.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 17BBFF800B0
	for <alsa-devel@alsa-project.org>; Tue,  6 Aug 2024 13:39:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17BBFF800B0
Received: from hosting3.qishost.com (localhost [IPv6:::1])
	by hosting3.qishost.com (Postfix) with ESMTPSA id 7702F45A59;
	Tue,  6 Aug 2024 07:39:36 -0400 (EDT)
Authentication-Results: hosting3.qishost.com;
        spf=pass (sender IP is ::1) smtp.mailfrom=jbrower@signalogic.com
 smtp.helo=hosting3.qishost.com
Received-SPF: pass (hosting3.qishost.com: connection is authenticated)
Received: from c-76-132-49-220.hsd1.ca.comcast.net
 (c-76-132-49-220.hsd1.ca.comcast.net [76.132.49.220]) by
 webmail.signalogic.com (Horde Framework) with HTTP; Tue, 06 Aug 2024
 11:39:36 +0000
Date: Tue, 06 Aug 2024 11:39:36 +0000
Message-ID: 
 <20240806113936.Horde.vcDWoEx08a51SUfvt56nQ2p@webmail.signalogic.com>
From: Jeff Brower <jbrower@signalogic.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, perex@perex.cz,
 tiwai@suse.com, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, nicoleotsuka@gmail.com, lgirdwood@gmail.com,
 broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 1/6] ALSA: compress: add Sample Rate Converter codec
 support
References: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
 <1722940003-20126-2-git-send-email-shengjiu.wang@nxp.com>
 <e89a56bf-c377-43d8-bba8-6a09e571ed64@linux.intel.com>
In-Reply-To: <e89a56bf-c377-43d8-bba8-6a09e571ed64@linux.intel.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-MailFrom: jbrower@signalogic.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: XIOPRYRMN36KEF3UIR7TF7FN2USRAPH5
X-Message-ID-Hash: XIOPRYRMN36KEF3UIR7TF7FN2USRAPH5
X-Mailman-Approved-At: Thu, 15 Aug 2024 08:20:34 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XIOPRYRMN36KEF3UIR7TF7FN2USRAPH5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

All-

"The sample rate converter is not an encoder ..."

Indeed, an encoder creates a compressed bitstream from audio data  
(typically linear PCM samples), normally for transmission of some  
type. A sample rate converter generates audio data from audio data,  
and is normally applied prior to an encoder because it can only accept  
a limited range of sample rates.

-Jeff

Quoting Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>:

> On 8/6/24 12:26, Shengjiu Wang wrote:
>> Add Sample Rate Converter(SRC) codec support, define the output
>> format and rate for SRC.
>>
>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>> ---
>>  include/uapi/sound/compress_offload.h | 2 ++
>>  include/uapi/sound/compress_params.h  | 9 ++++++++-
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/sound/compress_offload.h  
>> b/include/uapi/sound/compress_offload.h
>> index 98772b0cbcb7..8b2b72f94e26 100644
>> --- a/include/uapi/sound/compress_offload.h
>> +++ b/include/uapi/sound/compress_offload.h
>> @@ -112,10 +112,12 @@ struct snd_compr_codec_caps {
>>   * end of the track
>>   * @SNDRV_COMPRESS_ENCODER_DELAY: no of samples inserted by the  
>> encoder at the
>>   * beginning of the track
>> + * @SNDRV_COMPRESS_SRC_RATIO_MOD: Resampling Ratio Modifier for  
>> sample rate converter
>>   */
>>  enum sndrv_compress_encoder {
>>  	SNDRV_COMPRESS_ENCODER_PADDING = 1,
>>  	SNDRV_COMPRESS_ENCODER_DELAY = 2,
>> +	SNDRV_COMPRESS_SRC_RATIO_MOD = 3,
>>  };
>
> this sounds wrong to me. The sample rate converter is not an "encoder",
> and the properties for padding/delay are totally specific to an encoder
> function.
>
> The other point is that I am not sure how standard this ratio_mod
> parameter is. This could be totally specific to a specific
> implementation, and another ASRC might have different parameters.
>
>>
>>  /**
>> diff --git a/include/uapi/sound/compress_params.h  
>> b/include/uapi/sound/compress_params.h
>> index ddc77322d571..0843773ea6b4 100644
>> --- a/include/uapi/sound/compress_params.h
>> +++ b/include/uapi/sound/compress_params.h
>> @@ -43,7 +43,8 @@
>>  #define SND_AUDIOCODEC_BESPOKE               ((__u32) 0x0000000E)
>>  #define SND_AUDIOCODEC_ALAC                  ((__u32) 0x0000000F)
>>  #define SND_AUDIOCODEC_APE                   ((__u32) 0x00000010)
>> -#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_APE
>> +#define SND_AUDIOCODEC_SRC                   ((__u32) 0x00000011)
>> +#define SND_AUDIOCODEC_MAX                   SND_AUDIOCODEC_SRC
>
> I am not sure this is wise to change such definitions?
>>
>>  /*
>>   * Profile and modes are listed with bit masks. This allows for a
>> @@ -324,6 +325,11 @@ struct snd_dec_ape {
>>  	__u32 seek_table_present;
>>  } __attribute__((packed, aligned(4)));
>>
>> +struct snd_dec_src {
>> +	__u32 format_out;
>> +	__u32 rate_out;
>> +} __attribute__((packed, aligned(4)));
>
> Again I am not sure how standard those parameters are, and even if they
> were if their representation is reusable.
>
> And the compressed API has a good split between encoders and decoders, I
> am not sure how an SRC can be classified as either.
>
>>  union snd_codec_options {
>>  	struct snd_enc_wma wma;
>>  	struct snd_enc_vorbis vorbis;
>> @@ -334,6 +340,7 @@ union snd_codec_options {
>>  	struct snd_dec_wma wma_d;
>>  	struct snd_dec_alac alac_d;
>>  	struct snd_dec_ape ape_d;
>> +	struct snd_dec_src src;
>>  } __attribute__((packed, aligned(4)));
>>
>>  /** struct snd_codec_desc - description of codec capabilities



