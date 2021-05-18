Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC1EC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 20:13:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A0A61154
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 20:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A0A61154
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C7D116EF;
	Tue, 18 May 2021 22:12:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C7D116EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621368778;
	bh=b06L1AsWNfTocsJzxPxXvGi++Qpn7Pb1rta033VqC2k=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lcPOdkVf+0h6xcLKfitpckvCUWL4fzohesNyVD5zeETY9Cd+S2O0KxULA7XpWT6Xr
	 /sb4IyCXCJSLgidXmWKfiIFC+rTiE2AsxyEjjSDAuxsJLu8Q36LGulibFQJoIaEwjE
	 s4clUHRIDNVaYuVlWaxKBp1eAKFzupnNX+3BkCgE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAD50F801DB;
	Tue, 18 May 2021 22:12:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60A2DF80229; Tue, 18 May 2021 22:12:06 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE20EF801DB
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 22:11:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE20EF801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="q/4iatmr"
Received: by mail-lf1-x135.google.com with SMTP id i9so15729557lfe.13
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eqnKON75MC7wmOo09rQx8YXcKOuSxztzztMBXxXm75A=;
 b=q/4iatmrOgeg1PWQq7qdnEK93Mf5xlYSKZsJTH9Tv5UkG27MQ2EvSilQhDzJJGkfSi
 zPoez1JT5MkXAXfF0TdJOXl9jMMmFNB97v85pIW3kRiiRl4RNREjCBeEFUO9nJRxx+N4
 P8Ulebw30vk7rxv3h4sOPXKF0KbLZ95zWbbmwKTMouPL0dnM/QJ1IdbOC6U/fIfVv79m
 Of0LbTJI7C6ZeIEQRGejGtzZhBuc0nFI3f4ZJnGhm05EPZZ5aj8SaWGaQkCaSBTsVylx
 V+PAiPdj2EqK5ZnOuFa48ZTvVxCS93rB4vKwHpiYGWyhe/OaDNDiOvYxFSw8SRTXdQPG
 DF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eqnKON75MC7wmOo09rQx8YXcKOuSxztzztMBXxXm75A=;
 b=leLA748bj3T7JpwzQyZpLYFiN60AM1NWaA3W4I0ZK6HZhhAsohiuaHXYLNqLY9srpf
 5DZL1DxrEKrbwoMs+dQHuScCH00QJWDmVYOM5yAciWVdr0cVzDdq31cjP1abFBT3871q
 Y7CM3DXpocu5S0GCJEsF4Nfv/jPnomlSRtzfFKNj9y4f/Cjgcdz65UzbcJNC3i9ZGl/u
 DpuolECq3m85Nx0Gk+xIgJAiecJmC5UmuVK7+3+v75/LTtRk7ldYjuxhJperZOJ82bwZ
 HBTgt9Sm18JRQcd1DUcTpd29LjucRGu5P3ecyvAoi2p1/FaAfyqIDrESeZFesGgBwigx
 iR/A==
X-Gm-Message-State: AOAM533zcaydgf8dMb0kw8v20EbKKXHliP3PKSXtzExbSoue4Epfju10
 nwdrV8xgAPcI9dfot+qu44I=
X-Google-Smtp-Source: ABdhPJx6fBKAk+vMXzaeJUMIPe/E1mlIHljaim+HQDVwv3IcRiDuJXXqx9U0k27vviVxgdudscSDPw==
X-Received: by 2002:a05:6512:33c4:: with SMTP id
 d4mr5533905lfg.536.1621368717835; 
 Tue, 18 May 2021 13:11:57 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-91.dynamic.spd-mgts.ru.
 [109.252.193.91])
 by smtp.googlemail.com with ESMTPSA id r17sm3431037ljp.40.2021.05.18.13.11.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 13:11:57 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] ASoC: tegra: Unify ASoC machine drivers
To: Rob Herring <robh@kernel.org>
References: <20210518001356.19227-1-digetx@gmail.com>
 <20210518001356.19227-3-digetx@gmail.com>
 <20210518180949.GA949047@robh.at.kernel.org>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <95f62f68-b081-2f98-1f88-f39e52c49bfe@gmail.com>
Date: Tue, 18 May 2021 23:11:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518180949.GA949047@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Ion Agorria <ion@agorria.com>, linux-tegra@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, Frank Rowand <frowand.list@gmail.com>
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

18.05.2021 21:09, Rob Herring пишет:
>> +static const char * const tegra_active_low_hp_compats[] = {
>> +	"ad,tegra-audio-plutux",
>> +	"ad,tegra-audio-wm8903-medcom-wide",
>> +	"ad,tegra-audio-wm8903-tec",
>> +	"nvidia,tegra-audio-wm8903-cardhu",
>> +	"nvidia,tegra-audio-wm8903-harmony",
>> +	"nvidia,tegra-audio-wm8903-picasso",
>> +	"nvidia,tegra-audio-wm8903-seaboard",
>> +	"nvidia,tegra-audio-wm8903-ventana",
>> +	NULL,
> I think this list should be added to the main match table below with 
> data having a flag for active low HP. Then you only match once, don't 
> need the exported function and the next difference is much easier to 
> add.
> 

Thank you for the suggestion. You're right that these compats will take
precedence.

I'm also now thinking that it should be okay to assume that the GPIO is
active-low by default. I haven't seen tegra boards with the active-high
configuration.

I'll remove the use of the exported function in v2.
