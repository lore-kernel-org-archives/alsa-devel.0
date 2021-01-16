Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BD3C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 08:04:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B604223E8
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 08:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B604223E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00CCE17F7;
	Mon, 18 Jan 2021 09:03:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00CCE17F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610957079;
	bh=rOoCe9k7WI3U/907c5Ij7qR3va689lnKu5S00ROi5GY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F+4NVAIEF+nF7qk1l8jTPA849ObC+iKXYbpCocgFypGkTArVvROBJ2/zyWa+mvLVW
	 JY1HGntK0mM0e2RAXc4lDrSVMoMnF105zUq5sL5YFLq0Ip0mlHBxvRBumP+rVRY/Uq
	 0gsPHQxde0KD/KmdL9B9Fh4gqxFdKSH4oNJNo/4E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B5A1F804C2;
	Mon, 18 Jan 2021 09:02:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98259F8025E; Sat, 16 Jan 2021 16:10:25 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B60F9F8010B
 for <alsa-devel@alsa-project.org>; Sat, 16 Jan 2021 16:10:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B60F9F8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="TAKZGD1o"
Received: by mail-pl1-x632.google.com with SMTP id x12so6211684plr.10
 for <alsa-devel@alsa-project.org>; Sat, 16 Jan 2021 07:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=XVfRC3VS1iJhQ2u3rXKF8OukI6C4/RaKCNwIeoBnNA8=;
 b=TAKZGD1onxE+hqw2liMiAR6pLAy2OjUK6G6N0Iidv5+wyIrqq6OfaTex58tm9r6+vk
 zSvUuS8DOWFmwLGjS2vakEq7mSSb8Fq7cw1sySU2K0eUItU1a/9KVo8oCk1o3QpwFlCc
 Egcy6UnFsYM0RSTkRFL+OcymaaSjAO/3klT/VAYStQlabJbGIuuzlmDLR34X2NNYf35Y
 qLFgIAV8aX9J8JYWSSX8oDN9dQ/XcGJAo28V9dcwPV5vVFkNNueb9pUxrQ3KDeL2bSjX
 K7Ek8sWxMv7eHvuhcUAV1Bq7qkOWznHWiZdSyQPIMR53FNKXZfi4NQVaGr9j9dV93H9q
 +vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=XVfRC3VS1iJhQ2u3rXKF8OukI6C4/RaKCNwIeoBnNA8=;
 b=kM/HDjjeSw/3LonryiFEhifMnh+5WIH3xtdTwYg2EvCDY1efaPPierZA+898NyXc8r
 Q+9aDIWn2o7hafA5uqa4vrr4jvcdEOYuMy0bv7/BWu6hJa8f8ap3/+3EwSi53XYO6t8i
 I+nod1lSF8ZEPKu3LuFAn3A32Z9s2HMop+HOphCY5Y3GqW2187RDQ/xig5pbg/5FjGcW
 ojFsVtUBtd13k5GNe44K9vxr/qFyAGE3j1mSB9UabgQE5ietSotzq+DtBQDryolpzGQj
 KvdHwIiPeC6UvOT1Hil792yPzrqBecUKgjt0dGfFrWKlBtEAeXtA69e6DZ8KK1xEKK5R
 Eebw==
X-Gm-Message-State: AOAM530iC3DWYPe+3rzrjoPcElZlCsiplz1AwmihwbMXWACuSnJjmAm6
 VoOB93CmCxvNu9x848Tjugw=
X-Google-Smtp-Source: ABdhPJzzJXE8U3cCbdWQMpki+05Mne2wHUEjtbfMSLerP6XdOZocWIyN/QPq8DEDMPKCHW0rIFYQqQ==
X-Received: by 2002:a17:90a:d70e:: with SMTP id
 y14mr16163154pju.9.1610809818836; 
 Sat, 16 Jan 2021 07:10:18 -0800 (PST)
Received: from [0.0.0.0] (n218250008152.netvigator.com. [218.250.8.152])
 by smtp.gmail.com with ESMTPSA id n195sm11391438pfd.169.2021.01.16.07.10.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Jan 2021 07:10:18 -0800 (PST)
Subject: Re: [PATCH v3 1/3] platform/x86: dell-privacy: Add support for Dell
 hardware privacy
To: Randy Dunlap <rdunlap@infradead.org>, Perry Yuan <Perry.Yuan@dell.com>,
 oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com, hdegoede@redhat.com,
 mgross@linux.intel.com
References: <20210112171723.19484-1-Perry_Yuan@Dell.com>
 <cc83351b-a19a-9a3e-d511-4553cf4d7ef0@infradead.org>
From: Perry Yuan <perry979106@gmail.com>
Message-ID: <578023b1-ae22-f21a-3969-62f06557baf1@gmail.com>
Date: Sat, 16 Jan 2021 23:10:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <cc83351b-a19a-9a3e-d511-4553cf4d7ef0@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 18 Jan 2021 09:02:51 +0100
Cc: alsa-devel@alsa-project.org, Mario.Limonciello@dell.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 platform-driver-x86@vger.kernel.org, broonie@kernel.org
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

On 2021/1/13 1:39, Randy Dunlap wrote:

> On 1/12/21 9:17 AM, Perry Yuan wrote:
>> +config DELL_PRIVACY
>> +	tristate "Dell Hardware Privacy Support"
>> +	depends on ACPI
>> +	depends on ACPI_WMI
>> +	depends on INPUT
>> +	depends on DELL_LAPTOP
>> +	depends on LEDS_TRIGGER_AUDIO
>> +	select DELL_WMI
>> +	help
>> +	This driver provides support for the "Dell Hardware Privacy" feature
>> +	of Dell laptops.
>> +	Support for a micmute and camera mute privacy will be provided as
>> +	hardware button Ctrl+F4 and Ctrl+F9 hotkey
> 	End above with a period '.' please.
>
>> +
>> +	To compile this driver as a module, choose M here: the module will
>> +	be called dell_privacy.
> Please follow coding-style for Kconfig files:
>
> from Documentation/process/coding-style.rst, section 10):
>
> For all of the Kconfig* configuration files throughout the source tree,
> the indentation is somewhat different.  Lines under a ``config`` definition
> are indented with one tab, while help text is indented an additional two
> spaces.
>
>
> thanks.

Thanks for your review feedback.

I will fix this in V4 patch.

