Return-Path: <SRS0=lIjM=CS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB08C433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:55:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44563206D4
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GmnVA3J0";
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBm0xnkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44563206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8227616B9;
	Wed,  9 Sep 2020 17:54:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8227616B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599666931;
	bh=zGcwYa7WmxwZvtZiabyacTqP4TcgAJk8UnSuFgh3/BY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GmnVA3J0T0MSoUGnjyVO30MJMLkrgwmjY9TiNPEMOl2iD7Udme9WMWXT3iJ6yeA2R
	 jWxNHQMvHguEXles8ea/u5FSL8rUvm/zXi4Si/NPhLl+w37ecTdu1m/VafSIL2TDnB
	 gSczj923stPDBJUpK0q90ZwtON3LdATXv1TBGzQ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02206F8021C;
	Wed,  9 Sep 2020 17:54:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F1EBF800FD; Wed,  9 Sep 2020 17:54:38 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF572F800FD
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2020 17:54:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF572F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="dBm0xnkW"
Received: by mail-wr1-x443.google.com with SMTP id o5so3477564wrn.13
 for <alsa-devel@alsa-project.org>; Wed, 09 Sep 2020 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2KwC1soUieCawn1nIPhLKGt7LneIuKVZR9+LdYfWklM=;
 b=dBm0xnkWVpqH6ODHdpQSx2DeKIzeJGA1w2yMKbh6GF2LVvFhlbhCauzIhhZoE4gS6C
 k3zZzuc8OBQmChF5c+sW7rMUhvhrpN27gchgLAyBcGOAYwaWNFNodXwzp4KAqt1lhUsd
 aLQAAsRFsHBl3+aV3AXJ9kHn4vO+sLvfSb8dQ2uOy+mNcQBJew/zMNuUDHTGQgyHQ9r7
 o9AJ6mAeTXsZnY9FbnmJwCvMveoPVTo6rYXyoRrYzpfCMkzMXwyco/Hy3BeKoYJEb4Ht
 2tpRFhOHqWTBpsEnBjFv6lscEdC+u3J+tdM1YPh0aaBiROWo2+txbt6KRphkMIid0aHx
 Kf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2KwC1soUieCawn1nIPhLKGt7LneIuKVZR9+LdYfWklM=;
 b=PzXmDv4XnutX0jnyt/nPmNf52tFgz5OEUWIAFaXK17beKaYjz4e70eyrmosQKa7Mjl
 67DmmKB4EqD5IyBhsb/WiXnasw7rFeLX6v9q7CbICg1Jok3anAV/gAAGRyIg1My/tRe9
 jaFH0Ba/SmNCqG6J549cAvEmiKNrtqd6Ixssu70WpicK5+eexAZBUfQRihXx0tfhkSbs
 8GFBSYAv5t8Q2sVzJ2O2mJunX1oM4lHQRWnPoFEFOmW8qrz7nDW8BsulMBw7EMjIZA/u
 wXmLT+PuyFPp95Gezl0FNZ8I8n6g7rtKJZCcUa1buelv4hj4+mZ17Izv9995ZkSlMj0e
 JjHQ==
X-Gm-Message-State: AOAM531aDGPF5bcTh5mOxLD86++5XV2HUY/rYiaFUPRssl0X9W3GUi/8
 u+juIEiGsgrzCaXy4Lds7HWANw==
X-Google-Smtp-Source: ABdhPJzq+ecLQ0dlN96maN6DMHvtC/xXYGjZzpuEZOeizDN86+41jWyowwzDlPXLmxO3f9962+5L0A==
X-Received: by 2002:a5d:61c7:: with SMTP id q7mr4577740wrv.343.1599666864443; 
 Wed, 09 Sep 2020 08:54:24 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id v9sm4822740wru.37.2020.09.09.08.54.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Sep 2020 08:54:23 -0700 (PDT)
Subject: Re: [PATCH] soundwire: bus: add enumerated slave to device list
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 vkoul@kernel.org, yung-chuan.liao@linux.intel.com
References: <20200909082711.11670-1-srinivas.kandagatla@linaro.org>
 <80081c70-9137-c9f0-9813-8166275ef7af@linux.intel.com>
 <ab107351-dbde-7f6d-c588-11572aed5d2d@linaro.org>
 <4cdcda10-bdc6-211f-d279-e74f57684b79@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d0c71a83-9dc1-83c3-5cb1-d8fb7dc7f809@linaro.org>
Date: Wed, 9 Sep 2020 16:54:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4cdcda10-bdc6-211f-d279-e74f57684b79@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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



On 09/09/2020 15:39, Pierre-Louis Bossart wrote:
> 
>>>> Currently slave devices are only added either from device tree or acpi
>>>> entries. However lets say, there is wrong or no entry of a slave device
>>>> in DT that is enumerated, then there is no way for user to know all
>>>> the enumerated devices on the bus.
>>>
>>> Sorry Srinivas, I don't understand your point.
>>>
>>> The sysfs entries will include all devices that are described in 
>>> platform firmware (be it DT or ACPI).
>>
>> yes that is true, but it will not include all the enumerated devices 
>> on the bus!
>>
>> In my case on a new board I was trying to figure out what devices are 
>> on the bus even before even adding any device tree entries!
> 
> We've seen this before but dynamic debug provides all the information 
> you need. see e.g. the logs from 
> https://sof-ci.01.org/linuxpr/PR2425/build4447/devicetest/
> 
> jf-cml-rvp-sdw-1 kernel: [  289.751974] soundwire sdw-master-0: Slave 
> attached, programming device number
> jf-cml-rvp-sdw-1 kernel: [  289.752121] soundwire sdw-master-0: SDW 
> Slave Addr: 10025d070000 <<< HERE

Yes, I have noticed this too! This will be printed for every call to 
sdw_extract_slave_id()!

...
> 
> Now I get your point but
> a) you already have a dynamic debug trace to list all devices
> b) adding 'undeclared' devices would make things quite murky and is only 
> half of the solution. We already struggle because we already have 
> 'ghost' devices in sysfs that are not physically present, and no way to 
> differentiate between the two. If we did add those entries, then we'd 
> need two new sysfs attributes such as
> 'declared' and 'enumerated'.

I totally agree with you on dealing with the undeclared devices, which 
is unnecessary mess!
May be we could make the enumerated devices discovery bit more verbose!

--srini
