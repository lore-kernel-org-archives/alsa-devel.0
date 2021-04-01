Return-Path: <SRS0=rMx/=I6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F776C433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 16:50:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8403F61390
	for <alsa-devel@archiver.kernel.org>; Thu,  1 Apr 2021 16:50:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8403F61390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2F0A116B6;
	Thu,  1 Apr 2021 18:49:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2F0A116B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617295845;
	bh=vxTVJTwXdLfGpOZ/I0OGhb7tzVdQXski1BZ2JRe9dBo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sMIdVEvu/16KaA6BSs+EpoqXxrUPoKhczXhsh1vePx7WS5B7QHEhqaa8bITOEaBcU
	 5QAhVDWz6nsDzAMDqDno7UCQQY/1WIHIL5wiYdYf6aHy3u4l29TZ6g3N+yX/pnEEF9
	 NLgKuyHTB2H54M7T9Q2qkIisqZuYkzP+qnU/Jclg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B658BF80240;
	Thu,  1 Apr 2021 18:49:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CC02F8026B; Thu,  1 Apr 2021 18:49:53 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0C04F8013C
 for <alsa-devel@alsa-project.org>; Thu,  1 Apr 2021 18:49:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0C04F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="RBWZRmBR"
Received: by mail-ej1-x630.google.com with SMTP id hq27so3835847ejc.9
 for <alsa-devel@alsa-project.org>; Thu, 01 Apr 2021 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZITJn9OwOFdWnyw6/5K8hXI6be2iHs737Z1KKpoKKTI=;
 b=RBWZRmBRgVRFL5dFTOkdMQ1amg4cZOhsWLoORTkHUV3924VD5q/OAsOJes34QFkgXc
 pCW2Ckhu1f+1u5WYI86oBJSnZBu6qxA64D4gQ19nMWvjafrJQvgWHB4D5rtdaLoWbRSE
 2A6aiCrnSc69/8pwpVGjCRS7YPjkNP65/5VyD88Qh+Jwj1EX4Cp1730m43LughZTty46
 1yzzGN0462AQTyj3rxtDzM4/6ZKKdBS2UQUhoPCEHDLwbYNC0q4Eo0JZw+FsqxgHwtNp
 KFbRo7rRXfHjmRxOYWmj1ybPOPWfRTBrfKjoDOLktq2Tba3yeiQRlFSxvFk/GGsm4ilq
 0h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZITJn9OwOFdWnyw6/5K8hXI6be2iHs737Z1KKpoKKTI=;
 b=aUTfuk0uXH0v9hFWsfGP7/XGC3eZ8QtqKBpfSpwLjpGpTc2tTwgEtwUtyXiyRTTid5
 TGjf0L0B2hFTnGmiamlb8TmwpcMvhrTpl7YL4Q6eCCGp/dSbtykilEGdGAkVk9XJuhA9
 H89O80Qs4Tq1mRCLmrIy3g0PNRsE6mRa/PItePptb8zGuVCj1eAWnfyq8TZ2ddn5a3Rw
 8MK9WuuYbBF08ofrnj3HD0GOGTrqknA/DD1XS8YyFR3FBECgladvKERYVY6XgVkKjsKb
 MsIenS93zWPJm/CMYPyXZ9NelsVk3qGS125p6TfrB/hm9/i6FHGS5rYRQjG6XxH+0w+j
 YC/g==
X-Gm-Message-State: AOAM531Q4kHpw3bFZDEtoRKcHKEpvpapQiZJlTFCCkdTYVJchuwTE/N1
 V03hL8pJdX2UV7NWfkfzkgJ/ag==
X-Google-Smtp-Source: ABdhPJwX4MhXvSaIufRpbKrM41cxH8YiLeSdEhYocoua6E1USCwXSegShln1t3assMXdbLazajeadQ==
X-Received: by 2002:a17:906:5383:: with SMTP id
 g3mr10148080ejo.185.1617295787833; 
 Thu, 01 Apr 2021 09:49:47 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id j25sm3800692edy.9.2021.04.01.09.49.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Apr 2021 09:49:47 -0700 (PDT)
Subject: Re: [PATCH v2] soundwire: qcom: wait for fifo space to be available
 before read/write
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 vkoul@kernel.org
References: <20210401090058.24041-1-srinivas.kandagatla@linaro.org>
 <e1bcc85d-b583-2c9a-18e5-634994cc2916@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <41911806-e4ce-44e2-d187-a1a27406ed34@linaro.org>
Date: Thu, 1 Apr 2021 17:49:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e1bcc85d-b583-2c9a-18e5-634994cc2916@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sanyog.r.kale@intel.com,
 yung-chuan.liao@linux.intel.com
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



On 01/04/2021 15:36, Pierre-Louis Bossart wrote:
> 
> 
> On 4/1/21 4:00 AM, Srinivas Kandagatla wrote:
>> If we write registers very fast we can endup in a situation where some
>> of the writes will be dropped without any notice.
>>
>> So wait for the fifo space to be available before reading/writing the
>> soundwire registers.
> 
> Out of curiosity, do you actually need to do a check in the read case as 
> well?

Yes, This is just to make sure the read command is finished and fifo is 
ready with data.

If not we will be reading quickly an empty fifo!

> 
> The commit message talks about writes getting dropped, is the opposite 
> also a problem?

Its highly likely, for safety I have added support for both write and 
read waits in this patch.


--srini
> 
