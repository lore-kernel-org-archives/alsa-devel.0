Return-Path: <SRS0=lC1U=7X=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B60C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:37:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F385320760
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JLSvTSH1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hm1CJi+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F385320760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8D0F815E5;
	Wed, 10 Jun 2020 12:36:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8D0F815E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591785465;
	bh=lZG2sU1yDUp56t7ph8SErjKT77qM+C17Fw7pK91p0vA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JLSvTSH1MX9V/Rf8vaz/VVUKMXZksK77EJeu378yl/YfszhBtcmXM0cf4Gkal9WuW
	 3Pi/s1MnJMRNdeFpwIKPFqFPwyQGF/6SRcVBZ+oJuSnRMmWw07zYuT2B/5ML/Y6Ue/
	 hSlqeVdDNvwoiRv4e3pQK+W3pgNOdbo+/kThnue8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14BF1F800E0;
	Wed, 10 Jun 2020 12:36:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D5E1FF8021C; Wed, 10 Jun 2020 12:36:53 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C5159F80058
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2020 12:36:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5159F80058
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="Hm1CJi+k"
Received: by mail-wm1-x342.google.com with SMTP id j198so4333969wmj.0
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2020 03:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ct74x8QzTMiVHLIqtse4haJrkCu8RNQLYYWYvUjLwLQ=;
 b=Hm1CJi+kEcbRVQFtpTOZN8udhh8/3hHFsmWU8cKKb7GgkBWdzplDWxbxca7QPhiQOP
 yobx7OEX2ZL5XTjutp86nlWL5aIdX0DnOO9baFragUdKi/Pz2r9ThbZjpPT4Qpx4mNHR
 kq7wGhBzR7XaruQKWlIYVoirXRCylhmMSMntHMX2gZqavRGqOXoIgMVd1oVXlBGYbFin
 LvvUEDQy+f7Vidlgd8+19JawnPA6bz0cAKJoSvGmnRstw5iPZvs9eXnnkCMSvVtWxPk2
 p1OJZfmhfCBnzlfMp31/+4epi1DOa/f0jxOAREiEw+mGS4ciRpsah7V5xwPBDpXnu7KB
 nxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ct74x8QzTMiVHLIqtse4haJrkCu8RNQLYYWYvUjLwLQ=;
 b=FvJ7w3hhuzEQVXAidopbpSnDGD8C935pWIK+npynQ5ijSIM/fOLrsVQlo7f37OIT0j
 idzdsEAjhL7cfa4kSbiHt2Gg7u3aicvMPHp34c9fO8WV6yO0hAzPaXT9jnHReQRMYFSp
 3A+k0oubZoepbGIkUDq460tgfo3hQN7TqM7rt7pOKzE8cmJB4qGPpu6/EgMuc87m/C6i
 OuA7mgbtJ1X6SE/GNmj8dzSJ0Lxxv0+6DK7Sw73MpmI4krN8P4olm+YbWwf42mSgF58W
 RHub0QN95jWNhnAe/zOe92hSRBNirZ5aJnpBrfsxOXXRR/dwcsSvfaZbT8MUm4vyDnLk
 xtDA==
X-Gm-Message-State: AOAM532JdFlTiJaTwOHgpIQ9B9b0/aMDjlE1gE9+t96ZbhouWhWCYc6I
 enNF5s8R5Q68p86mm/ZW12LBlQ==
X-Google-Smtp-Source: ABdhPJz7r8bS7kNganx4qUD7P1fKicq2Q1nsivL8aGH8+2HEDFcVBi5XCoyamjLXo6DhqnROBkY57Q==
X-Received: by 2002:a1c:2506:: with SMTP id l6mr2605714wml.34.1591785405839;
 Wed, 10 Jun 2020 03:36:45 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id h27sm8781671wrb.18.2020.06.10.03.36.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jun 2020 03:36:45 -0700 (PDT)
Subject: Re: [PATCH 4/5] soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
To: Jonathan Marek <jonathan@marek.ca>, alsa-devel@alsa-project.org
References: <20200608204347.19685-1-jonathan@marek.ca>
 <20200608204347.19685-5-jonathan@marek.ca>
 <f3eabdb9-da43-9502-352a-1696babc114d@linaro.org>
 <dc8f59c6-2fa9-f3a3-6d77-2d03a6d2776b@marek.ca>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <29a216a7-a76f-a4de-b62d-3043e7e25c18@linaro.org>
Date: Wed, 10 Jun 2020 11:36:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dc8f59c6-2fa9-f3a3-6d77-2d03a6d2776b@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Andy Gross <agross@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>
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



On 09/06/2020 12:33, Jonathan Marek wrote:
> On 6/9/20 5:52 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 08/06/2020 21:43, Jonathan Marek wrote:
>>> The driver may be used without slimbus, so don't depend on slimbus.
>>>
>>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>>> ---
>>>   drivers/soundwire/Kconfig | 1 -
>>>   drivers/soundwire/qcom.c  | 5 +++++
>>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
>>> index fa2b4ab92ed9..d121cf739090 100644
>>> --- a/drivers/soundwire/Kconfig
>>> +++ b/drivers/soundwire/Kconfig
>>> @@ -33,7 +33,6 @@ config SOUNDWIRE_INTEL
>>>   config SOUNDWIRE_QCOM
>>>       tristate "Qualcomm SoundWire Master driver"
>>> -    depends on SLIMBUS
>>>       depends on SND_SOC
>>
>> Why not move this to imply SLIMBUS this will give more flexibility!
>>
>>
> 
> If you mean to change it to "select SLIMBUS", I'd prefer not to, because 
> this would increase code size unnecessarily in my kernel.

imply is week select, which means that this driver can be built without 
SLIMBus selected. So removing reference to slimbus_bus is necessary in 
this case.

On the other hand, SLIMBus is going to be used sm8250 for BT audio, so 
this would not be unnecessary. Also mostly these are build as modules, 
so not sure why kernel size will increase here!

Am not 100% sure if SLIMBus will be kept on all SoCs, but keeping 
depends or imply in place would enforce or spell out some level of 
dependency on this.

> 
>>>       help
>>>         SoundWire Qualcomm Master driver.
>>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>>> index 14334442615f..ac81c64768ea 100644
>>> --- a/drivers/soundwire/qcom.c
>>> +++ b/drivers/soundwire/qcom.c
>>> @@ -769,13 +769,18 @@ static int qcom_swrm_probe(struct 
>>> platform_device *pdev)
>>>       if (!ctrl)
>>>           return -ENOMEM;
>>> +#ifdef CONFIG_SLIMBUS
>>>       if (dev->parent->bus == &slimbus_bus) {
>>> +#else
>>> +    if (false) {
>>> +#endif
>>
>> May be you can do bit more cleanup here, which could endup like:
>>
>>
>> ctrl->regmap = dev_get_regmap(dev->parent, NULL);
>> if (!ctrl->regmap) {
>>      res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>      if (res) {
>>          ctrl->mmio = devm_ioremap_resource(dev, res);
>>          if (IS_ERR(ctrl->mmio)) {
>>              dev_err(dev, "No valid mem resource found\n");
>>              return PTR_ERR(ctrl->mmio);
>>          }
>>
>>          ctrl->reg_read = qcom_swrm_cpu_reg_read;
>>          ctrl->reg_write = qcom_swrm_cpu_reg_write;
>>      } else {
>>          dev_err(dev, "No valid slim resource found\n");
>>          return -EINVAL;
>>      }
>> } else {
>>      ctrl->reg_read = qcom_swrm_ahb_reg_read;
>>      ctrl->reg_write = qcom_swrm_ahb_reg_write;
>> }
>>
>>
>>
>> thanks,
>> srini
> 
> I don't think this is better, it feels more obfuscated, and I think its 
> possible we may end up with the mmio sdw having a parent with a regmap. 
> (it is not how I did things up in my upstream stack, but in downstream 
> the sdw nodes are inside the "macro" codec nodes)
> 
> I understand the '#ifdef CONFIG_SLIMBUS'/'dev->parent->bus == 
> &slimbus_bus' is ugly, but at least its clear what's going on. Unless 
> you have a better suggestion?

Other suggestion I had in my mind was to use compatible strings to get 
reg_read, reg_write callbacks + some flags like (if_type) populated. 
This can help looking up resources correctly.

Thanks,
srini

> 
>>>           ctrl->reg_read = qcom_swrm_ahb_reg_read;
>>>           ctrl->reg_write = qcom_swrm_ahb_reg_write;
>>>           ctrl->regmap = dev_get_regmap(dev->parent, NULL);
>>>           if (!ctrl->regmap)
>>>               return -EINVAL;
>>>       } else {
>>> +
>>>           res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>           ctrl->reg_read = qcom_swrm_cpu_reg_read;
>>>
