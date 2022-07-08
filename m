Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7531FC43334
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Jul 2022 08:32:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E98F6851;
	Fri,  8 Jul 2022 10:31:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E98F6851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657269152;
	bh=o1ukuyMUUhT5En9piHqgPLIyA9Gkp96vtKSK8CxAZkg=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OufHj65wBgvZKIDhCQvltLj3Q5t1jOTAcjPEKd0qZHcpbQa8jalFEZRKVlyDkEDUr
	 4r/YJ8Mgf8nw7qUI6/GBLGXFc5+hm/vvzLO+PT7LY5BUXUpxMZjL0o0qww2RdHx2L7
	 OS7p2KOvD29jUNuSNTpkwGw4q4BMNwSUF7fHJDWc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7417AF80166;
	Fri,  8 Jul 2022 10:31:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D9FCF80167; Fri,  8 Jul 2022 10:31:39 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 472C8F800E9
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2022 10:31:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 472C8F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="aL6MgsiJ"
Received: by mail-wm1-x32e.google.com with SMTP id l68so11982792wml.3
 for <alsa-devel@alsa-project.org>; Fri, 08 Jul 2022 01:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=MyRaFzhjqcNBVZD47Ut9Twqd7PbjC5/SGO8XyMm3TdM=;
 b=aL6MgsiJFva0/jzPejqBoUaUG7x/t5ZgAxpJqRL1QKZuxzUxn9Afp5Ko14FiLN9PE9
 a2wUGWWvuXnJD5FvXI/msoZBer8vxx8pvBzJlMKmXJnIZGgIyXY4D553BJPjC16Rc4MG
 6rcImoxyBjl3495eitWp0jQhz4CrXBykJOv6nz/TP29rohlDC2Ur9WSAKH6eT9DxujLo
 6bSnsBXVflGXFxZyFX6ruPUlCD/rsAL6ktJHhdbUqv5yKDYpkmJ2eR7sjVj/4z0PFTF1
 TlnFwpJyjsCRCsnQd2Rxouq8s6WJubGfX/DCwzAN5Okpb0HKHggFmyFCg0GHyh6rIeLB
 6UWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=MyRaFzhjqcNBVZD47Ut9Twqd7PbjC5/SGO8XyMm3TdM=;
 b=TqAhBxMbArzSZOeAGzwIq/CK6GpAGtxjz9T8DgT19cc9wjtMr5q5MGj64LZVmpaZO2
 eaizXTX6MCZKJMdwQXkaPt3oC7tdaZ1/7zPRlH5kJe+2NPHQi6iFhpil6tXnPC0+0oXh
 tuAe+8CzHua5kfN2ptN9mV+ut/GFaHHmFBiq6X/vubXnZPeVDVYx/5/CcG0bI6nNhRgT
 reTVQtlky1KGqZG0Ztj+HIu4Odn4RvQtZLFrvuNb8zALlGkkixazNL2qe/dxkXy8pl3o
 QunImtdAHpBQJF5u7To2JUa6q4YHaok1LBomDI5opfrJtUJV8OetNhcU9Df5H07EtD2F
 OySQ==
X-Gm-Message-State: AJIora82setKxKso4lax02+lKQABI1PuDaOK9RqP6zBwFc+ewGS5guok
 tSaMf8qdU0qT/UEU6vHB/O/m6w==
X-Google-Smtp-Source: AGRyM1s5318my24PAbEiJxQJ7TqgKi4PAo4dP3mvkgoTKfnFFwRbsPk+5EE5/1t487coMv7NSLlbdQ==
X-Received: by 2002:a05:600c:c5:b0:3a0:3ef3:838a with SMTP id
 u5-20020a05600c00c500b003a03ef3838amr9470854wmm.50.1657269094001; 
 Fri, 08 Jul 2022 01:31:34 -0700 (PDT)
Received: from [192.168.86.238]
 (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
 by smtp.googlemail.com with ESMTPSA id
 bk12-20020a0560001d8c00b0021d7050ace4sm128939wrb.77.2022.07.08.01.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Jul 2022 01:31:33 -0700 (PDT)
Message-ID: <747099de-504a-daed-6d45-34bf0e379562@linaro.org>
Date: Fri, 8 Jul 2022 09:31:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [bug report] soundwire: qcom: Check device status before reading
 devid
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <Ysfl7lzEyRVuQ+Dg@kili>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Ysfl7lzEyRVuQ+Dg@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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

Hi Dan,

On 08/07/2022 09:08, Dan Carpenter wrote:
> Hello Srinivas Kandagatla,
> 
> The patch aa1262ca6695: "soundwire: qcom: Check device status before
> reading devid" from Jul 6, 2022, leads to the following Smatch static
> checker warning:
> 
> 	drivers/soundwire/qcom.c:484 qcom_swrm_enumerate()
> 	error: buffer overflow 'ctrl->status' 11 <= 11
> 
> drivers/soundwire/qcom.c
>      471 static int qcom_swrm_enumerate(struct sdw_bus *bus)
>      472 {
>      473         struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
>      474         struct sdw_slave *slave, *_s;
>      475         struct sdw_slave_id id;
>      476         u32 val1, val2;
>      477         bool found;
>      478         u64 addr;
>      479         int i;
>      480         char *buf1 = (char *)&val1, *buf2 = (char *)&val2;
>      481
>      482         for (i = 1; i <= SDW_MAX_DEVICES; i++) {
>                       ^^^^^
> This a loop that starts from 1 instead of 0.  I looked at the
> surrounding context and it seems like it should be a normal loop that
> starts at 0 and goes to < SDW_MAX_DEVICES.
> 

In SoundWire world device id 0 is special one and used for enumerating 
the SoundWire devices.

Only addresses from 1-11 are valid devids that can be assigned to 
devices by the host/controller.

This part of the code is reading the devids assigned by the hw 
auto-enumeration, So the loop start from 1 is correct here.


> (Or possibly the other loops are buggy as well).

Atleast this code is fine, but I see other places where are starting 
from 0 which could be fixed but the SoundWire core will ignore the 
status for devid 0.

--srini
> 
>      483                 /* do not continue if the status is Not Present  */
> --> 484                 if (!ctrl->status[i])
> 
> So this is off by one and reads one element beyond the end of the loop.
> 
>      485                         continue;
>      486
>      487                 /*SCP_Devid5 - Devid 4*/
>      488                 ctrl->reg_read(ctrl, SWRM_ENUMERATOR_SLAVE_DEV_ID_1(i), &val1);
>      489
>      490                 /*SCP_Devid3 - DevId 2 Devid 1 Devid 0*/
>      491                 ctrl->reg_read(ctrl, SWRM_ENUMERATOR_SLAVE_DEV_ID_2(i), &val2);
>      492
>      493                 if (!val1 && !val2)
>      494                         break;
>      495
>      496                 addr = buf2[1] | (buf2[0] << 8) | (buf1[3] << 16) |
>      497                         ((u64)buf1[2] << 24) | ((u64)buf1[1] << 32) |
>      498                         ((u64)buf1[0] << 40);
>      499
>      500                 sdw_extract_slave_id(bus, addr, &id);
>      501                 found = false;
>      502                 /* Now compare with entries */
>      503                 list_for_each_entry_safe(slave, _s, &bus->slaves, node) {
>      504                         if (sdw_compare_devid(slave, id) == 0) {
>      505                                 qcom_swrm_set_slave_dev_num(bus, slave, i);
>      506                                 found = true;
>      507                                 break;
>      508                         }
>      509                 }
>      510
>      511                 if (!found) {
>      512                         qcom_swrm_set_slave_dev_num(bus, NULL, i);
>      513                         sdw_slave_add(bus, &id, NULL);
>      514                 }
>      515         }
>      516
>      517         complete(&ctrl->enumeration);
>      518         return 0;
>      519 }
> 
> regards,
> dan carpenter
