Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AFCC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 10:26:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD35D64E9A
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 10:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD35D64E9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B164A83B;
	Mon,  8 Feb 2021 11:25:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B164A83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612779960;
	bh=qs5iDT/RRGmofav4c3s8NPAknjkwYxeQRjxSgVBIGZM=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XzqUa3lI0J9WFjfT5oMDvXTDzbePygyc7H3NJ84iVMuFN3fFFgMCJXmsxDfGqHhpO
	 Xer1VkI8uSMG96SSMGkeq6jk1vuCUXKSQq+CDT0tNQ/rpsFrJEGevA7s5Lupmcq10z
	 z+zhwldhrAZcuZlqeXSEOZyw5gkZrvdZsadLp7fQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44141F80114;
	Mon,  8 Feb 2021 11:25:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E6CCF8022B; Mon,  8 Feb 2021 11:25:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7963DF80114
 for <alsa-devel@alsa-project.org>; Mon,  8 Feb 2021 11:24:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7963DF80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="hgAGGhnx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612779898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ep4ZsjYRuAXPwh82Ub4Ux0DkmS5bLtXhjC3zgbz/ZBE=;
 b=hgAGGhnx4e9cO7dP/kMy+lnPd+o9FEt9aQcAEuUMUm/NvjOKPPm2xWiH48zQxInQvSzg3Z
 XdnhPBDIie9TJxx2tABtFHt2zWiho4Unl75vfJCyngTBlJLyj1JqXwsMhPFpytPlCPWwF2
 ylZH/uBr6jAVtSS9dVkT7YOxR6LAlPM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-UN4Ugs7nNxifCx6USo9zJA-1; Mon, 08 Feb 2021 05:24:56 -0500
X-MC-Unique: UN4Ugs7nNxifCx6USo9zJA-1
Received: by mail-ed1-f69.google.com with SMTP id w23so12856954edr.15
 for <alsa-devel@alsa-project.org>; Mon, 08 Feb 2021 02:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ep4ZsjYRuAXPwh82Ub4Ux0DkmS5bLtXhjC3zgbz/ZBE=;
 b=d2mdprnG4yJKi0V6p9j/U1cnM7KJK26o3OziaUmx1fZO724V4ctxX1ugzh4r8Rt377
 bHnXCWc9OSTO88AOUNlGdE0EcAwS/JJKQiOa+pSHzY+ZT6wMQJU8yGU+/t9QMDViunhW
 qV71V2Fjnaa6DC7Suzxdf3YRqcAe/cl72Wm4Ilt8fbMsSMpOF5/BTZhadPGaJfVOw3Fq
 N1duYyGxeemOsd1FQPSIW4v7hwH/mbeBPyx21ZeAJ6f1DVMHp++4+D4u/7ZjIJDpg6F2
 HagI72KJ7en2g0ZCi5J1T2wqxP+QokytPivNw1LfI7wxWh0GsWK+rXNGJxXqHgvcHsmO
 heXg==
X-Gm-Message-State: AOAM532Sc91Ckly3gvhAbzpBXAV05uTgkGMzECAngQwAjlaz9pnZqDFn
 dXi9YjEd0E4xps/yL2zeY/d/xNPqSC4dvLSyGui1cnzkoKb0nREhhlrSd6cCHJj6p4tnE1s+kHS
 A+BqZBeN/WpymPJ4hm1Qw2Fbse8crALazYndafCFUOvcssJzc43pU6aSnIQ99DPdRrz2M49AJ2X
 w=
X-Received: by 2002:a17:906:b047:: with SMTP id
 bj7mr16359144ejb.335.1612779894994; 
 Mon, 08 Feb 2021 02:24:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx8W+BdOooPWe2s3wXt/qWHFAB/rW920UtlUxbt0+2539/5yGY1P/Vw108RdrrJFJEZ/OTo3A==
X-Received: by 2002:a17:906:b047:: with SMTP id
 bj7mr16359127ejb.335.1612779894817; 
 Mon, 08 Feb 2021 02:24:54 -0800 (PST)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
 by smtp.gmail.com with ESMTPSA id n5sm9214228edw.7.2021.02.08.02.24.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 02:24:54 -0800 (PST)
Subject: Re: [PATCH 1/2] ALSA: hda: intel-dsp-config: Add FLAG_BYT_FIRST /
 _SECOND defines
To: Takashi Iwai <tiwai@suse.de>
References: <20210208093800.62099-1-hdegoede@redhat.com>
 <s5ha6sezxil.wl-tiwai@suse.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <5d6241f2-8df2-8de2-b437-804566e62e25@redhat.com>
Date: Mon, 8 Feb 2021 11:24:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <s5ha6sezxil.wl-tiwai@suse.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
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

On 2/8/21 11:04 AM, Takashi Iwai wrote:
> On Mon, 08 Feb 2021 10:37:59 +0100,
> Hans de Goede wrote:
>>
>> Instead of hardcording the SST driver having the highest prio, add
>> FLAG_BYT_FIRST and FLAG_BYT_SECOND defines, which get set like this
>> when both drivers are enabled:
>>
>> 	#define FLAG_BYT_FIRST               FLAG_SST
>> 	#define FLAG_BYT_SECOND              FLAG_SOF
>>
>> And when only 1 driver is enabled then FLAG_BYT_FIRST gets set to
>> the flag for that driver.
>>
>> This is a preparation patch for making which driver is preferred
>> configurable through Kconfig.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> I find the idea is fine, but the ifdef conditions become too complex
> after this change.  It took minutes to check whether the ifdef changes
> are really correct for me :)

I understand but...

> So, it'd be appreciated if this can be re-designed and simplified...

This was actually the cleanest which I could come up with, well maybe not the
cleanest, but the most "do not repeat yourself" option.

The alternative would be something like this:

static const struct config_entry acpi_config_table[] = {
/* BayTrail */
#ifdef CONFIG_SND_INTEL_BYT_PREFER_SOF /* implies both drivers are enabled */
        {
                .flags = FLAG_SOF,
                .acpi_hid = "80860F28",
        },
        {
                .flags = FLAG_SST,
                .acpi_hid = "80860F28",
        },
#else
#if IS_ENABLED(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI)
        {
                .flags = FLAG_SST,
                .acpi_hid = "80860F28",
        },
#endif
#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL
        {
                .flags = FLAG_SOF,
                .acpi_hid = "80860F28",
        },
#endif
#endif

With the same thing repeating for the Cherry Trail case, now that
I actually have written this out I guess it is not too bad, but it
does mean repeating all the BYT/CHT entries once, visually
leading to 4 extra entries (but the #ifdef #else #endif
will always include only 2/4 for each of BYT and CHT.

If you like this better I can do a v2 with this approach, that
would also reduce the set to a single patch.

Regards,

Hans



