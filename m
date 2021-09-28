Return-Path: <SRS0=duqq=OS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B8CC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 09:33:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4658E60F9B
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 09:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4658E60F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F0861683;
	Tue, 28 Sep 2021 11:32:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F0861683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632821594;
	bh=CeeBjPLmDhsbsDe5t+NyYdEAG9lwgzx7So70FtdTfwE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UgP6sdf0akR/hHBtwnJZ4ezwZvx03Dff7d4G4y183zxL3zAUs059DkJ5v1b/U3nBZ
	 XU4v32I6gLyxJ1CKu0atRMkb8KM9igFLQEPR1EwpHHfGyzraGdzyd6oVb6rhL8QefV
	 TVH7x4ot0efVTYTXBB15+s704NLEwYcs7R2NexII=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4FE8EF804D1;
	Tue, 28 Sep 2021 11:31:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5C5DF804D2; Tue, 28 Sep 2021 11:31:48 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5239F80161
 for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2021 11:31:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5239F80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="EVAposAl"
Received: by mail-wm1-x32b.google.com with SMTP id
 205-20020a1c01d6000000b0030cd17ffcf8so1623869wmb.3
 for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2021 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OwbUNyzcDhkwRSM1z2XoHupYIfFeEC2bQD7N4nxDnQI=;
 b=EVAposAl80ZKcHtNjhQdjPLaK/iPtYQJNEU9lD7v0mx28zoKyokeEm46SnRbr9QOzN
 TFoNEeYelyP65KO4umRfV+xvDtG/92nimh2HBdxWav4B0aTPBgmTKBVFdcN0fztRyuTZ
 ebKADg9iKeOBPGZYkNM7FwoknT46lSwA7jAd6C0wGwWYoMRJ+hIGV3Kk0jasNAjuMOWl
 Ska5rPRHdbZT+4MNrPNUQqZd7h/wfTJCWoOmGtpbBiW2a6KY9QOOGjkpcrCjJzMxjuuw
 Paf6XKjYl0m4Yd/Ygwthxvoj+AYD0X/7U/xcTQrJdB3mi+nu8KRao8qxVZh5otuK1i88
 vH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OwbUNyzcDhkwRSM1z2XoHupYIfFeEC2bQD7N4nxDnQI=;
 b=Zuk/uRgUq3MI4j/UPSlTUVqPSDKKtryFQm4qwl0kkrVXecW/v7doD9LF4hpyZuwN4J
 Lp6YNCJVfNzDHK3XeRMnag8WdAiJAn9vuInTp3a30QQXMIt7r0MC2xH4UBESNKz0JtZ+
 JJwgDHwcvWHGDppUIHVDO1oV3qk6/+3tiP5BXpjqt/iI7p9Uu9sBQNe6wlBSmxvftH3Z
 nWxRjhuDMhYKX7pIzVtUe9cTYHji+j74vkNOdIwmP+pY+HdQez3hHKHiwpShzoSmw+Bi
 4hNpZBFjr0YC96cydwRJB/GdvBwGN02KdNOcmu67A5TD171VL8hBdNMi34uvki/gHJH7
 Tw/Q==
X-Gm-Message-State: AOAM531shjh6XojeTwsF/E0bDa/inMM+uBKuZMyjb7ugM1+l15x7GF6j
 neLaAgB6AfTZN3bXX/exrixg8w==
X-Google-Smtp-Source: ABdhPJyEiC7SUOkX7FnTCnCShBLCrawdHIIVTgRGxAiarcKJeDd5A6vU0oKIJrW3TZBqsBfAnipACA==
X-Received: by 2002:a05:600c:22d6:: with SMTP id
 22mr3717036wmg.17.1632821500931; 
 Tue, 28 Sep 2021 02:31:40 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id s85sm2188425wme.20.2021.09.28.02.31.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Sep 2021 02:31:40 -0700 (PDT)
Subject: Re: [PATCH v8 15/22] ASoC: qdsp6: audioreach: add q6apm support
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, bjorn.andersson@linaro.org,
 broonie@kernel.org, robh@kernel.org
References: <20210927135559.738-1-srinivas.kandagatla@linaro.org>
 <20210927135559.738-16-srinivas.kandagatla@linaro.org>
 <f5cad020-9d36-d700-df14-95e72a8357fd@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2d2fb4b8-2c79-ac52-5215-db66a7a4866e@linaro.org>
Date: Tue, 28 Sep 2021 10:31:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f5cad020-9d36-d700-df14-95e72a8357fd@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com
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



On 28/09/2021 09:23, Amadeusz Sławiński wrote:
> On 9/27/2021 3:55 PM, Srinivas Kandagatla wrote:
>> Add support to q6apm (Audio Process Manager) component which is
>> core Audioreach service running in the DSP.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
> 
> (...)
> 
>> +++ b/sound/soc/qcom/qdsp6/q6apm.c
>> @@ -0,0 +1,597 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2020, Linaro Limited
>> +
>> +#include <dt-bindings/soc/qcom,gpr.h>
>> +#include <linux/delay.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/sched.h>
>> +#include <linux/slab.h>
>> +#include <linux/soc/qcom/apr.h>
>> +#include <linux/wait.h>
>> +#include <sound/soc.h>
>> +#include <sound/soc-dapm.h>
>> +#include <sound/pcm.h>
>> +#include "audioreach.h"
>> +#include "q6apm.h"
>> +
>> +/* Graph Management */
>> +struct apm_graph_mgmt_cmd {
>> +    struct apm_module_param_data param_data;
>> +    uint32_t num_sub_graphs;
>> +    uint32_t sub_graph_id_list[];
>> +} __packed;
>> +
>> +#define APM_GRAPH_MGMT_PSIZE(n) ALIGN(sizeof(struct 
>> apm_graph_mgmt_cmd) + \
>> +                      n * sizeof(uint32_t), 8)
> 
> Possible struct_size again

Yes, we could use struct_size here.

> 
>> +
>> +int q6apm_send_cmd_sync(struct q6apm *apm, struct gpr_pkt *pkt,    
>> uint32_t rsp_opcode)
> 
> There seems to be 'tab' in argument list?

That's true, in vi I could not spot this by just looking.
> 
>> +{
>> +    gpr_device_t *gdev = apm->gdev;
>> +
>> +    return audioreach_send_cmd_sync(&gdev->dev, gdev, &apm->result, 
>> &apm->lock,
>> +                    NULL, &apm->wait, pkt, rsp_opcode);
>> +}
>> +
> 
> (...)
