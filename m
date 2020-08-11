Return-Path: <SRS0=37Wv=BV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA01C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:17:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F3620768
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nKviaNk1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SATSNvRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F3620768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CEE7810E;
	Tue, 11 Aug 2020 13:17:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CEE7810E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597144670;
	bh=A3p9+G5zJXV1JlMo/YZprkNoaFh7Dk1h67GItQJ7rmI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nKviaNk1dyKUYgMVvgnaEZF1u9JfUYu911OwePOP30zf6B4mLEEu5JaUeYe2BZLJn
	 wCK+xoSttzPFzN6bUwhBx5y6xR5g3TGW95jY3E8YbwRpTuRAPr4E99lDqMPTOPOLtZ
	 DoP0kuJC3NkcULCzvZnnlwgJrSchq7UDX/9ftZzE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E02AF8014C;
	Tue, 11 Aug 2020 13:17:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBCDBF8015B; Tue, 11 Aug 2020 13:16:58 +0200 (CEST)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 07F8AF80118
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 13:16:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 07F8AF80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="SATSNvRF"
Received: by mail-ed1-x542.google.com with SMTP id ba10so8765976edb.3
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2020 04:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6cufjOFrT/hcspnN5aAafTE/4pFcFv+P9DAHTf0Alws=;
 b=SATSNvRFgruxKUzD1yxGTGH+w8XpGtxSqpnYC97tFqgvs27XA4hgyY3OPtsy65a/ip
 XU+sYFd0BpCB4dDedbItsxRYNDin7SE/FiWOvMjE2ij2a8NJCfpfLxoFXTvrPBvo0ycF
 QxJ8wm5WDamdoXUT+N1c3MFzyK3om2H3xOLqqCF4l8yfjsu3GIQ8trgq2Gk3nfvJ3xdw
 R7D4tRi8gCQ4TZc1F37UPcsYyqWUw6tBErctFtEq8si0A8UyP+iHkiwTNhhe4bP10Rk7
 nzPgZz+fnX5oBuyzgvKF+n7uGHzjCZTFxbAtAD3D7wA1OUcej+bIOfqr49fgO85BsrqZ
 CXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6cufjOFrT/hcspnN5aAafTE/4pFcFv+P9DAHTf0Alws=;
 b=Ly6u+IEebtakYRzponHhoWUTIy9ukdCH3o1ifkF3rzTXvPtHtiPOVv34Q80SSWoO85
 2cKsMKHZRCuebbYWXoU+RtuXamOBY+hw56dliy08Rjceasb40z4MeY/WC/NEleTUuDst
 XJIlAFTEAP3/uyaGNizEe1HunIxaQrnf0w8Xr8R21KD3qbZCynikDgZkQfv2yfulyZ6U
 pj0pJAlgLu4SPaUxuCdu/D3A+QjBTh8ZQcrOykRy8wF8+ocZ1QKA9Az1ZbX71gIpYT9C
 +Y1NdASqjZHMGdF3yRaQf/Utyh4PU9Lsr2HwlpbmQ8CH50GjvV17lGPJgy4rCpShLVEO
 +cfg==
X-Gm-Message-State: AOAM533fORSTNn5TGum0tEEu+CDcx2YYOfzaz1i9iYO5e13ZEMbOECFm
 a/U/H78IC6rLh81QC3UIEdPSFA==
X-Google-Smtp-Source: ABdhPJz486z2bZFpt1XUVZO12LzbgOKzz74hODxz1NU+0tiv1qSPZYMBXRqHUusPMC0lIUDz8INZkQ==
X-Received: by 2002:aa7:dd94:: with SMTP id g20mr24838626edv.238.1597144607755; 
 Tue, 11 Aug 2020 04:16:47 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id u4sm14245784edy.18.2020.08.11.04.16.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Aug 2020 04:16:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] ASoC: q6afe-dai: add dummy register read function
To: Stephan Gerhold <stephan@gerhold.net>
References: <20200811102552.26975-1-srinivas.kandagatla@linaro.org>
 <20200811110409.GA1481@gerhold.net>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <002fa321-93ca-07a6-abc2-bd1d7433f98b@linaro.org>
Date: Tue, 11 Aug 2020 12:16:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200811110409.GA1481@gerhold.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com,
 linux-kernel@vger.kernel.org, broonie@kernel.org, john.stultz@linaro.org
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



On 11/08/2020 12:04, Stephan Gerhold wrote:
> On Tue, Aug 11, 2020 at 11:25:51AM +0100, Srinivas Kandagatla wrote:
>> Most of the DAPM widgets for DSP ASoC components reuse reg field
>> of the widgets for its internal calculations, however these are not
>> real registers. So read/writes to these numbers are not really
>> valid. However ASoC core will read these registers to get default
>> state during startup.
>>
> 
> Actually q6afe-dai does not seem to make use of the register number.
> The DAPM widgets all look like
> 
>    SND_SOC_DAPM_AIF_IN("HDMI_RX",  NULL,   0,    0,     0,      0),
>                    /* (wname,    stname, wchan, wreg, wshift, winvert)
> 
> Wouldn't it be better to replace wreg = 0 with SND_SOC_NOPM in this case
> so the read/write won't happen at all?
That should work, let me try that!

--srini
> 
> q6routing on the other hand does make use of wreg, so this would not
> work there...
> 
> Also: If I remember correctly the ASoC core will also attempt to write
> to these "registers" when starting to play some audio, so you might also
> need to implement component->write().

> 
> Stephan
> 
