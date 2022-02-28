Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FA7C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Feb 2022 14:22:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AF2A1703;
	Mon, 28 Feb 2022 15:21:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AF2A1703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646058152;
	bh=+UR+XouQSXztc8/uYbzuzDBHcJPXC/5FXbOw6evj4dQ=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dDI7VOslOH8rXPmBjemtsSle51aM4mOFLAbooFdQ61+m4fXbmUatAL8JmB8dQIhnz
	 pCT+wJWj6GncKs6uSn5hvGGE4GuGwsZDiKe/0q/UFJpmSGsbuqrBkxDs1oyzmNB2pU
	 ZD6jfhyEVbIQgREVCpixtbLhAqLx6+OcSW2brXLM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06436F80128;
	Mon, 28 Feb 2022 15:21:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF52EF8013C; Mon, 28 Feb 2022 15:21:40 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64F07F80125
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 15:21:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64F07F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="wCw1bXU6"
Received: by mail-wm1-x333.google.com with SMTP id
 p184-20020a1c29c1000000b0037f76d8b484so6124393wmp.5
 for <alsa-devel@alsa-project.org>; Mon, 28 Feb 2022 06:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=1m78nP9MPOTO37Tbcq5yI1vtpVIuvuvJ5OfyBvjoqkg=;
 b=wCw1bXU6AAkC+gFr+q2QzxfOyv6q/twq01W/I9vw843fCB/xWP3nxw/gY7kNP1AkO+
 1wHuPbkKsHxu4I74DcMm4Sehoa7kJq/EbymTAlP7osXbqTYQD4L/9wBwBiWSTGyqQHO7
 14beVV4RiGKnINIQEQ6ZvhGifoK94CnWy8tCHYnRDX9FaU4QXBObc6cvofs3bKtu/i63
 kROCnuxAqjFKSRFg2Xc/48atydjLGF6aceSdxtpcnDnuNEFUw9QTCDHG7yskeHBsKsv7
 112qFrjOVI/Ca3Bis5kjbvMEU9C/a5V2fwqXJx0sI1pM4AHNrl9dKixM/cVOycOdYbA3
 Cokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=1m78nP9MPOTO37Tbcq5yI1vtpVIuvuvJ5OfyBvjoqkg=;
 b=lBwoatJ+ezVCD9Y3iqqzzRJVMyXESsS1BoYvXIlvbE0pK4LYaQuzYaX16+CHdhyocA
 u47+ydRkztZFl7R3IoiXGa+FPdJcn6Z2Tw0KBOzRRoxkg/d3KOsEaHzRjowwc203obE9
 d3lqzskjrnFS8VxOLeAcLOLYzIzjPFJRoNe5tDY4NYJp34rBRgDXD36Ej1wrlOATRQvF
 W9voQp+67BnIsTu1im93mVPd5LAmu8koOuS3xFdmkai/uX9aRqYFWLRoE77l6uL0vzVk
 VxizcBklCMhftRfNwMf+HSsfKA+vJQarQoKm9fYcH0kIvUivSAaJrDSfg4vejj5GUS6R
 1euw==
X-Gm-Message-State: AOAM5307i2b0patAAAL74YYQ04BFr7vWAkKyTOGNsLfwGH/TmqMwSG53
 +OAvAmFgBh4ou7EAAjr/zWdEXj/vn7Vfsg==
X-Google-Smtp-Source: ABdhPJzHJSlUWIjmaXDwkIUbazIKOklj7/OQCNP7ZG75E9gOJkTqR6bqM8iew35ergN06xRfXjOBYA==
X-Received: by 2002:a05:600c:418b:b0:380:e493:660a with SMTP id
 p11-20020a05600c418b00b00380e493660amr13352509wmh.189.1646058096132; 
 Mon, 28 Feb 2022 06:21:36 -0800 (PST)
Received: from [192.168.86.34]
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.googlemail.com with ESMTPSA id
 l5-20020adff485000000b001e322a6ba79sm10848450wro.86.2022.02.28.06.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Feb 2022 06:21:35 -0800 (PST)
Message-ID: <39abefa3-9f41-8688-964c-5e6d04084ab0@linaro.org>
Date: Mon, 28 Feb 2022 14:21:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] ASoC: codecs: wsa881x: add runtime pm support
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <20220225180716.13462-1-srinivas.kandagatla@linaro.org>
 <YhzPFJabTS5UZd7v@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <YhzPFJabTS5UZd7v@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 tiwai@suse.com, quic_srivasam@quicinc.com
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



On 28/02/2022 13:33, Mark Brown wrote:
> On Fri, Feb 25, 2022 at 06:07:16PM +0000, Srinivas Kandagatla wrote:
>> WSA SoundWire Controller does not support Clock stop and performs a soft reset
>> on suspend  resume path. Its recommended that WSA881x codecs connected to this
>> are also reset using a hard reset during suspend resume.
>>
>> So this codec driver performs a hard reset during suspend resume cycle.
>> ---
> 
> You've not provided a Signed-off-by for this so I can't do anything with
> it, please see Documentation/process/submitting-patches.rst for details
> on what this is and why it's important.
Hm..
Am not sure why was this missing in first place.. Let me resend a new 
version with proper sign off.

--srini
