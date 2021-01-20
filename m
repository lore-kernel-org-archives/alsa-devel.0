Return-Path: <SRS0=/R4B=GX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE42CC433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 21:39:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C61F23443
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Jan 2021 21:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C61F23443
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FBEC17C5;
	Wed, 20 Jan 2021 22:38:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FBEC17C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611178762;
	bh=Ba9JtSf1XDiZYyXLiTsW8XaDM1kl+22UaiEglovxFK0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=haukeaffO2TXzMqx6GO6gK0I2s8u5iLSSdw7mEbNqpx5gMgfTWRiHDZ6w1RDhMbz6
	 ike/8EERU4y12Ddz5xEqeF+nwn0oBAmM0o1/mFWnpZ6Trz6leVXUJCSbyMlH2RZ2eC
	 BHqouWeHjPuJPVmtesIq+wXSX0Es6iJva8PcDVG0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CCC49F80137;
	Wed, 20 Jan 2021 22:38:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 539E2F8016E; Wed, 20 Jan 2021 22:38:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87FA8F80137
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 22:38:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87FA8F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="M2u400wV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611178702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHm8nVKL9Fr4wu0oxgE+9L7CgPJ7wuqXCFrUdbbeNXo=;
 b=M2u400wVsNoMJZvd/czGSJYiKff0cki5LJRmrwjqup9ydWdBl42VGB73awNGLd9bmTG2Jy
 d5QqMZoZcXvwKJR4dTA6/g93r2UR4r+Fv97oW2cgHe7ytXMZABAhzTzhRL2gz2Y6eS8WPv
 ldV2juBpqF6UcAOMwyvVNvYYQq0DrSY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-yBiKPMviM7q65po_oDt7TQ-1; Wed, 20 Jan 2021 16:38:20 -0500
X-MC-Unique: yBiKPMviM7q65po_oDt7TQ-1
Received: by mail-ed1-f69.google.com with SMTP id g6so18320edw.13
 for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2021 13:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pHm8nVKL9Fr4wu0oxgE+9L7CgPJ7wuqXCFrUdbbeNXo=;
 b=UFgvU88Puj2DZw7/ifvIuE5HCqbAkvhGhWtVgHIUrE/6lB59BWKlfH0ktvF4/GgfBh
 odqWjXI8WC41jw8uqb2gyEEYycVyV6k7pL46DoVoULxJYh4uUl8fe6PSPXXTqlTn1Q0c
 ebUQKbJdBDhbk0SxrHMlqVY6HF95LxzsWn0/D9ryn6U+UnQ7F5yl+7WG4/DK0nLJNmtI
 WdwmyEPwXMBknBQxxwxrWL6H4Q6esAEBBdMDAq4rzTgZyMMEw16cYhsvw7RKkdhnnyJ7
 skOVh0yJimsvPsAPtQcpxbFP18zXsVIBQQThquhwijPrdQSVjAvvm1MvG90awzQgt9v0
 TQYQ==
X-Gm-Message-State: AOAM531ZIMeGYmScuZLUg72mDovYtdaNtB662Ejt17RcCxHcstzhJrdB
 pykpoeXXMkwVpl1laHNZAmq66G96t7p4NZ0oXxZ8NmrVxcw55djSMvEgQw23XvbUixVSOo8g92W
 sgcvUi45x3F0CctPIbMrnf2o=
X-Received: by 2002:a05:6402:1c0b:: with SMTP id
 ck11mr8848952edb.35.1611178698937; 
 Wed, 20 Jan 2021 13:38:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyC/ocWNIlZZBmymqhSrfoTNVxWmqEy5lrlXs0dgY1fwLV2Z2ltM1tFi4s7WBAkCG47K1QxnQ==
X-Received: by 2002:a05:6402:1c0b:: with SMTP id
 ck11mr8848941edb.35.1611178698798; 
 Wed, 20 Jan 2021 13:38:18 -0800 (PST)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
 by smtp.gmail.com with ESMTPSA id z2sm1419474ejd.44.2021.01.20.13.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Jan 2021 13:38:18 -0800 (PST)
Subject: Re: [PATCH v3 3/5] mfd: arizona: Add support for ACPI enumeration of
 WM5102 connected over SPI
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20210117212252.206115-1-hdegoede@redhat.com>
 <20210117212252.206115-4-hdegoede@redhat.com>
 <20210118130227.GI4455@sirena.org.uk>
 <5ccf48f4-45dc-3a30-3d6a-cce066f01270@redhat.com>
 <20210118133449.GL4455@sirena.org.uk>
 <a1ea81b6-8aff-274c-f1b2-a06a27650b25@redhat.com>
 <CAHp75VeCSOxJr1qMoXj04hnXnZiXdG4PAQ9oaKJNHWXaTqCrVQ@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <b96ec08f-32e5-1c0b-df07-c5c47e5c4b81@redhat.com>
Date: Wed, 20 Jan 2021 22:38:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeCSOxJr1qMoXj04hnXnZiXdG4PAQ9oaKJNHWXaTqCrVQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Christian Hartmann <cornogle@googlemail.com>,
 ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
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

Hi,

On 1/20/21 8:59 PM, Andy Shevchenko wrote:
> On Wed, Jan 20, 2021 at 9:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 1/18/21 2:34 PM, Mark Brown wrote:
>>> On Mon, Jan 18, 2021 at 02:13:50PM +0100, Hans de Goede wrote:
>>>
>>>> More in general I'm not aware of any (recent-ish) x86 GPIO controllers
>>>> not being able to do active low interrupts. In theory we could hit this
>>>> code path on ARM devices using ACPI enumeration, but I don't think it
>>>> is likely we will see a combination of ARM + ACPI enumeration +
>>>> WM5102 + GPIO controller not capable of active-low interrupts.
>>>
>>> I've not seen this issue on any ARM based systems.
>>>
>>>> This overriding of the flags definitely is necessary on the Lenovo
>>>> devices in question. I could add a
>>>> "if (dmi_name_in_vendors("LENOVO"))" guard around it, but that
>>>> seems unnecessary.
>>>
>>> Possibly just an update to the comment to make it clear that some
>>> firmwares might legitimately set the flag?
>>
>> Ok, I've extended the comment above the override of the irq-flags with
>> the following paragraph for v4 of this patch-set:
>>
>>          * Note theoretically it is possible that some boards are not capable
>>          * of handling active low level interrupts. In that case setting the
>>          * flag to IRQF_TRIGGER_FALLING would not be a bug (and we would need
>>          * to work around this) but sofar all known usages of IRQF_TRIGGER_FALLING
> 
> so far
> 
>>          * are a bug in the boards DSDT.
> 
> board's
> 

Thank you for the quick review, I've fixed both spelling errors for the upcoming v4.

Regards,

Hans

