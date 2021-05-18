Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9DDC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 20:17:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABEA61154
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 20:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABEA61154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEDFE16C0;
	Tue, 18 May 2021 22:16:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEDFE16C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621369067;
	bh=LglsXpjPNgY2jOG6iwAi06uTaBn4jEtsHTPIhLmhl54=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rFjWZfoino7KkeCtg/EKmXk0H/UQS4g+MBYmbU61avVdgl+jXJinWY6kjx+cw1cUN
	 6YJUIKKtC8uUYvEDbNV8/ecSQKKoqAzti2qSrORz0sA6AI33iQsCV6JeIdSutkki99
	 xGtGO8x52yLlWG4Ob3Td3aD5CrpzlnV1MMYh6eGI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 645AAF80139;
	Tue, 18 May 2021 22:16:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5397EF80217; Tue, 18 May 2021 22:16:56 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1E15F80139
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 22:16:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1E15F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="QY8KI5Sk"
Received: by mail-lf1-x12a.google.com with SMTP id m11so15784395lfg.3
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 13:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ui4HvF4u1ZthW3m3DADtHzNkQGkWW15sCYUwiAwHHtM=;
 b=QY8KI5SkijQDHWUSh6NjCZVWCit3PJKggENgPaultVTQGTHvJFpwd+6MgITaEiH3XV
 Yo65zXFEZ1rIwaYayWBbHc0hY4xYJZZUS+BdjpA6YgfIx6XaKDqJ3APS74Zl4ZwDOWRj
 WUWBx4qR7xH0Ty1UeOmvhNR5IDFEPjz5RIiPyLYiRrO8LNEytcMQsv8QAFfAOJ++lyGb
 Okx13wNQ2O8tP/7zXRJtRKl2g9p9PoPRxQz2VNnXkdBcCE2wNBX2Aqod3Q8nqVZNtb2V
 mt/kUQAuF6ucW3VvCqEu/ZhQV+2CpcCym8Qm5eVAzf7LGI5wzj4fi3sSadLFX81IGbh6
 u6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ui4HvF4u1ZthW3m3DADtHzNkQGkWW15sCYUwiAwHHtM=;
 b=MSveqHr1btZ/ty7/JDBkPgDdUMvSPtz/2sYeGYdCGL1XKYyxtc9oiSp7B1aoqeiGbC
 /TZTHmKPWtRKIanqLSZ7zhWfTkAkc3H8jSpaXfU1IfeP7GQ2kfvLN31kNcbtE/e14Rx3
 Zap/peZ1iNObfUbi3ehyGtDqhQaxuqDeXHCl8GzpHBDdyAft3wWP/VIEwznZaqgEeWDb
 y2h5fGv+kv8cK8fxLxj6Yg3YDtKJnYO2LCrH/M2RBcHA74pj6/nR4AhEY5ivfz6mEn0W
 oheI2we24fDvtIG5oKwstxGy13SkuifibxyFYPf2rIMyJEmAZHNmKzd7rqFwPL/7Hdvn
 TuTQ==
X-Gm-Message-State: AOAM532gqQsXQFVLvUEqREPLU6guwUX12ItJRR877mo3I0L5imo7RcFd
 /Op7mFrknmjw/H0fIt6yfGE=
X-Google-Smtp-Source: ABdhPJwumgr0EHheLLwl9qxBxvMiocUPyDDh+EIaQhWDXKIyelERgEZBrtVFTFIX3dxFZ1qMGk2Zhg==
X-Received: by 2002:a05:6512:acc:: with SMTP id
 n12mr5558086lfu.9.1621369009646; 
 Tue, 18 May 2021 13:16:49 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-91.dynamic.spd-mgts.ru.
 [109.252.193.91])
 by smtp.googlemail.com with ESMTPSA id a6sm3434048ljp.76.2021.05.18.13.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 13:16:49 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] ASoC: tegra: Unify ASoC machine drivers
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>
References: <20210518001356.19227-1-digetx@gmail.com>
 <20210518001356.19227-3-digetx@gmail.com>
 <20210518180949.GA949047@robh.at.kernel.org>
 <20210518183455.GE4358@sirena.org.uk>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b924f76a-56dd-5ca3-229d-293f7ff1e81a@gmail.com>
Date: Tue, 18 May 2021 23:16:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518183455.GE4358@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ion Agorria <ion@agorria.com>,
 linux-tegra@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Frank Rowand <frowand.list@gmail.com>
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

18.05.2021 21:34, Mark Brown пишет:
> On Tue, May 18, 2021 at 01:09:49PM -0500, Rob Herring wrote:
>> On Tue, May 18, 2021 at 03:13:56AM +0300, Dmitry Osipenko wrote:
> 
>>> Squash all machine drivers into a single-universal one. This reduces
>>> code duplication, eases addition of a new drivers and upgrades older
>>> code to a modern Linux kernel APIs.
> 
>> Nice, I never understood why each codec needed it's own machine driver 
>> (and typically in turn compatible string).
> 
> It's generally the clocking configuration, things with fancy clock trees
> don't play so nicely with generic systems where we want to configure
> them at runtime, or things with complex routing in the CPU where we
> only recently started getting bindings that were functional enough to
> use.  Tegra is fairly complex internally.
> 

This is true, but still it's more optimal to use flags in a single
common driver for the minor differences rather than to duplicate 90% of
the code. In practice majority of tegra boards are derived from the same
reference design, thus the h/w configurations are mostly the same.
