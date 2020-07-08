Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07201C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 09:46:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88CDC20771
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 09:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="To6Se+nB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fpjx3n8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CDC20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 153691678;
	Wed,  8 Jul 2020 11:45:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 153691678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594201578;
	bh=w0YrqsKzW2LRSvCKdn6bK7913y97WBv2dp2y/rH8GqA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=To6Se+nB5yEiJekMvXX1mBBV2Awu9nDQnmqfwq4caqxVeVsA3OKlbn/ugwujpX+2d
	 i9VpdSoV7uI++OgFd/R/b61p2kteMzguVgj8syxnIggGTbQho93ksgOLruY8J7aAar
	 03b6Al8v6SixwCPX6Ofid0/Ir9SHmYmG9FkixEZ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A1A9CF80161;
	Wed,  8 Jul 2020 11:44:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D25D5F8015D; Wed,  8 Jul 2020 11:44:32 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 857F3F8011F
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 11:44:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 857F3F8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Fpjx3n8Z"
Received: by mail-wr1-x444.google.com with SMTP id q5so48118811wru.6
 for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2020 02:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7Jns/yX+3aClnQNyC+2ax+ymiJLw8nGPUIjOZoROxiY=;
 b=Fpjx3n8ZM6TtASQQ3MqccK2166U6UtGHVdKdKpM3ddmRW6w37DoBJGZeWy3playtH6
 XMn4zZPaScEpr/td03Xw+MaTulQdOgQz1sXzldnbiLDhXcQiOsS0RGVFQe6SZDzeeqGq
 vfArGvSMPUBdeBTY0OkzS32iiNEAnprj2fXz4EoyuqeSL08SBbp84UpDl/ENkgNBihxC
 Gd9R0zJmsL6dmFREtzOW8xeg+yoUxlnaYF+KyjfUs/3EnYuVToJ+WO0oAoecIoSQXscS
 irB3j5n875UM7DbOon8DS4aGeQzoTG/zw6U+uwJW3wYd8Ne6/Y3YbtC9e1DsKmqC/cuK
 XGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7Jns/yX+3aClnQNyC+2ax+ymiJLw8nGPUIjOZoROxiY=;
 b=FRCp7Izaa35dMqTHKuVI/VsAQ16DOkTxm4HropGSc6e//BYt+HJk6SRlNui1rSDqfg
 dekmE3aX1mCKflIX1IL2CX2WZRyVyrWp65pulAXObJsmwsRmoQCiL0Z0oFxBrZJaGbQJ
 GLgRnr9qc0gUeRKIGrgieFl8IStaFZmzMjcka7rbDkrHEqqNun4IZXvrTgmdRjNAP2IL
 3KiEQZUV5WPIyeNZrUdo8ABR5/CC6dfk2E3VEar2VPFP5/Pu/v6DaAgfcmfvlgu82H1w
 BJ9rEl/xGI50L02mUso2X2Xr24cb0bCkDAERAsz5U5qHF9JHbGBdTLo1frxYi7UnMOxk
 eZWg==
X-Gm-Message-State: AOAM530dntPSMfSkNsGGauaFq2wxjmAi6g4eTMnuaBKqk2WcCHDKJve5
 N3YbI4/3stLhzoJmL8NhrB0I7Q==
X-Google-Smtp-Source: ABdhPJyOe8hm51EM8jb8HvCuyASFEnECIqcU4tIDM0/F7Tr+eWobQ0z+voWarZPRT+sExqYKK2NL2w==
X-Received: by 2002:adf:ef89:: with SMTP id d9mr61277066wro.124.1594201461254; 
 Wed, 08 Jul 2020 02:44:21 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id y77sm5640094wmd.36.2020.07.08.02.44.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Jul 2020 02:44:20 -0700 (PDT)
Subject: Re: [PATCH 03/11] ASoC: q6asm: make commands specific to streams
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-4-srinivas.kandagatla@linaro.org>
 <9ff595b4-1093-36c8-f27f-f097e24657a0@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4eedae20-903f-77c6-c6e9-fbf3db209bcf@linaro.org>
Date: Wed, 8 Jul 2020 10:44:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9ff595b4-1093-36c8-f27f-f097e24657a0@linux.intel.com>
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

Thanks Pierre for quick review,

On 07/07/2020 17:52, Pierre-Louis Bossart wrote:
> 
> 
> 
>> @@ -184,8 +186,8 @@ static void event_handler(uint32_t opcode, 
>> uint32_t token,
>>       switch (opcode) {
>>       case ASM_CLIENT_EVENT_CMD_RUN_DONE:
>>           if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> -            q6asm_write_async(prtd->audio_client,
>> -                   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
>> +            q6asm_write_async(prtd->audio_client, prtd->stream_id,
>> +                   prtd->pcm_count, 0, 0, 0);
> 
> sound/soc/qcom/qdsp6/q6asm.h:#define NO_TIMESTAMP    0xFF00
> 
> is the change on the previous line intentional?

May be not!

Plan is that the users of these apis will send flags directly instead of 
boiler plating this!

This change should go as part of next patch("[PATCH 04/11] ASoC: q6asm: 
use flags directly from asm-dai") which would make it much clear!

thanks,
srini
