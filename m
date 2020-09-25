Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFE1C4363D
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:03:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E77020759
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mGadWylJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sVLJdXvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E77020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9396C18AE;
	Fri, 25 Sep 2020 18:02:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9396C18AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601049806;
	bh=zLnMeg7VnJGUcGjhwq/5nFZUEbcDedsvnPhjnL16H+A=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mGadWylJTQWcgSeCgIGmxTP9uuurrUPlnAr9WAO3HK4oR2LhsIk5q/R6bfy3jw0PI
	 40+HKEJcOJQJjz9iRGgn7rLR8wFkI07boYGYfaaP2d5/MFX+Db55+9fzqAkFPvqs00
	 bX425bEb662nWKJ8AsTO0JwmfmYkLctycMy9P/0E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20D43F80171;
	Fri, 25 Sep 2020 18:02:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8E52F801EB; Fri, 25 Sep 2020 18:02:34 +0200 (CEST)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C0FBF800F6
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 18:02:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C0FBF800F6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="sVLJdXvN"
Received: by mail-io1-xd41.google.com with SMTP id q4so3309267iop.5
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 09:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KKM36HMFNo7IvqfCBLe5UvX13jWEuh671Vjt/sAVWGU=;
 b=sVLJdXvNc4vI/tTRzJH1n5umDfoQzc0lsxFSySSDfM9g8sfMF5bGtV3YOz+Mq/yTg4
 mYfcO/hDl7+K7I1RppX5dH3wOKDaTFqUPdQKU1USHqHhuZvVZbj3nhzZazC7ljqr4AlM
 GdlaWb5cSbBxU6iq0y28UrZceThjvQPmG7di6bcrCYiIIAFjPeOHRGTrcggy82+Br2qc
 pO9SSfO2nxkYF86cfQ3NVBcx6W+y8z2+LeCKIg2IjlcHcpesTx4STeu9RltEEOvgaG4h
 oNdbnMlPqiqt4flmlon3yktUtP8FabrmBXTYKLGv3bQWD+UpGzCfP4/D6QMEp89fwKBC
 i4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KKM36HMFNo7IvqfCBLe5UvX13jWEuh671Vjt/sAVWGU=;
 b=KhjWeZtxfxFCVxk2na2GpMdKD+WTmvOB/8ugdn4V9GLJHiLjtJKwBEQaC7carayFkD
 2++jMQPFTeoiqGr4A8Ylf6fwUxC7mFGPpQlHV2LrxK6H32GtppKKDRKz+R1q+xm1Ca52
 UrfvfUHSVemqITc1Z4jo82H39B508zRgT0cn0iUoww6o+kLsGWfuwx5m5G+BeL+tbfg5
 FWlv6NOaT61xsM58BPPMxdeEkRa0WVm9Y/4IGhG9PDmICU0noq46eH8fiheqyxmjPvH+
 306Z0EiF9u88g/0Sr+iuGu9GBL9wZCnbtXI9r0aeERUDWHRwB5oKiSyd25LNB4aEKhJd
 Ckmg==
X-Gm-Message-State: AOAM532YwiNRELUdLFAmiOEFUyKebNgzK8767qqsbHwQLFORb6nto4mj
 21KkpY6m9edu6rH4KwvLcOEGvg==
X-Google-Smtp-Source: ABdhPJw116LnPqm4dNs1MVsCzNLg8V45rQtN1gWgLkN5mnf5844SsTjgU2eBKcngEh17i/akpuiSGA==
X-Received: by 2002:a02:1004:: with SMTP id 4mr411804jay.127.1601049745262;
 Fri, 25 Sep 2020 09:02:25 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net.
 [73.185.129.58])
 by smtp.googlemail.com with ESMTPSA id c12sm1720817ili.48.2020.09.25.09.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 09:02:24 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH 3/3] [PATCH] staging: greybus: __u8 is
 sufficient for snd_ctl_elem_type_t and snd_ctl_elem_iface_t
To: Coiby Xu <coiby.xu@gmail.com>, David Laight <David.Laight@aculab.com>
References: <20200924102039.43895-1-coiby.xu@gmail.com>
 <20200924102039.43895-3-coiby.xu@gmail.com>
 <0175c477851243baa8a92177667d6312@AcuMS.aculab.com>
 <20200925141125.vfm5sjnsfvxo2ras@Rk>
From: Alex Elder <elder@linaro.org>
Message-ID: <160c222d-79e4-c5f0-344f-1a69821db039@linaro.org>
Date: Fri, 25 Sep 2020 11:02:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200925141125.vfm5sjnsfvxo2ras@Rk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Alex Elder <elder@kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Johan Hovold <johan@kernel.org>,
 "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>
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

On 9/25/20 9:11 AM, Coiby Xu wrote:
> On Thu, Sep 24, 2020 at 10:54:50AM +0000, David Laight wrote:
>> From: Coiby Xu
>>> Sent: 24 September 2020 11:21
>>> Use __8 to replace int and remove the unnecessary __bitwise type 
>>> attribute.
>>>
>>> Found by sparse,
>> ...
>>> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
>>> index 535a7229e1d9..8e71a95644ab 100644
>>> --- a/include/uapi/sound/asound.h
>>> +++ b/include/uapi/sound/asound.h
>>> @@ -950,7 +950,7 @@ struct snd_ctl_card_info {
>>>      unsigned char components[128];    /* card components / fine 
>>> identification, delimited with one
>>> space (AC97 etc..) */
>>>  };
>>>
>>> -typedef int __bitwise snd_ctl_elem_type_t;
>>> +typedef __u8 snd_ctl_elem_type_t;
>>>  #define    SNDRV_CTL_ELEM_TYPE_NONE    ((__force 
>>> snd_ctl_elem_type_t) 0) /* invalid */
>>>  #define    SNDRV_CTL_ELEM_TYPE_BOOLEAN    ((__force 
>>> snd_ctl_elem_type_t) 1) /* boolean type */
>>>  #define    SNDRV_CTL_ELEM_TYPE_INTEGER    ((__force 
>>> snd_ctl_elem_type_t) 2) /* integer type */
>>
>> WTF is all that about anyway??
>> What is wrong with:
>> #define    SNDRV_CTL_ELEM_TYPE_NONE    0u /* invalid */
> 
> I'm sorry I don't quite understand you. Are you suggesting 
> SNDRV_CTL_ELEM_TYPE_NONE
> isn't needed in the first place?

I think David is asking why it's defined the way it is,
and I'd guess it's to have the compiler issue an error
if you attempt to assign one of these values to a variable
or field of the wrong type.

No, you should not attempt to change this.

					-Alex
>>     David
>>
>> -
>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, 
>> MK1 1PT, UK
>> Registration No: 1397386 (Wales)
>>
> 
> -- 
> Best regards,
> Coiby
> _______________________________________________
> greybus-dev mailing list
> greybus-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/greybus-dev

