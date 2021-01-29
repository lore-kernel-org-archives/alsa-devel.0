Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1AAC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 13:33:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E4C564E03
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 13:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4C564E03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00FA01667;
	Fri, 29 Jan 2021 14:32:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00FA01667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611927220;
	bh=8qwNHFwHfHafAKCBo8+MGz+sH41bPtjSESYkC/GzEc8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i2RbMpga1J9GxNXCscMC4a5dGANGWSZDmf3mXKs0dVtieuQ2bny/iIZM32kR6L9Re
	 9B3GONZPdU1AYlAYy05ldzydcgirmn7TVryTCF9om7Gn/QIqyM8+H9M9QpFa0nRruD
	 y+e72U1VFeA/ir/HnK5TIsiJkCptFxJMRysOtKXs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 80545F80218;
	Fri, 29 Jan 2021 14:32:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2559F80259; Fri, 29 Jan 2021 14:32:47 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64511F80130
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 14:32:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64511F80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="fYLsXeD4"
Received: by mail-wr1-x429.google.com with SMTP id z6so8801998wrq.10
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 05:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wkXN05PMuyuv94MoTGDwGgnOlR5IzVJlpoZdHxfn6Ms=;
 b=fYLsXeD4JwtaDEpYcJgQuvzhWYPyiKPSdeWhzjk3am6OgbGqRdSPoPNIXnpEJXdRrN
 8dU5QLWrFKlr0pMJhbQHt5mRpGdSyftdbUuDIHrEGJ+vIQUoeoZYZ6X3ouueVagmc+6v
 3QcD5G498t16ync067cIxA9UGEH0o+roSZ9apvFc0Szkw8QQXoXkFyhc1Sm/qrBpJgpz
 A6B8s28Oyif5UghH9j3pCXGszu4HuaBP6ic5+BNEVvbLN2c9/Nb+rK4wafcr1q8D9r5T
 NDE8yKLOuNgAjCwjW9anJb4ZoypA8A8hcGj0AtDBC4TOu6wtUqfjacA9AVbUYPPwT15u
 6WYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wkXN05PMuyuv94MoTGDwGgnOlR5IzVJlpoZdHxfn6Ms=;
 b=Q/qfmP+CnoaERige8dxFYFF0YOxVmAEE7Re6J790BaMXjtRWSWqjClHq0tjixw2h+l
 KdpHUirZsDFmP3zIebW+vSDx2zGSwxlYLk1TVLuCpNt/+j0eyFgPF9UkrHt46uC+EoSc
 N3qRxoHy4zcpMyISQbEzAE0nN4of2agHF24FGaZakjAdbr4uC9XYNQEVYnP932NYkHkx
 zBU2hHa85nlUrFqpaIBYr1f74pMVnlX9qTLAOuGc/2jZIvJbwmvgmpmW0SATC/8jpJQo
 yceFWbZjlFNKcXFiBHvHW2igFxA+fURibcaZTNDAwFNL0a9TODbHp7NyJReqvI8WAxYQ
 QG6A==
X-Gm-Message-State: AOAM533RlZf5qpQ9jxiZPECTJg9gDBhd1DpFAmWZi+HWFZrAaOJmmgGE
 +2XEZL/ST+rH1xM762GiyiTMjw==
X-Google-Smtp-Source: ABdhPJxdxhLZa2feusGGtQfIlx5palcM4oQ6teT0uy22CgzcZG4nQXqxRdU+FB6N58PJ3KdPJYWa7Q==
X-Received: by 2002:adf:e9cf:: with SMTP id l15mr4496313wrn.317.1611927160657; 
 Fri, 29 Jan 2021 05:32:40 -0800 (PST)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id h18sm12081875wru.65.2021.01.29.05.32.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 Jan 2021 05:32:39 -0800 (PST)
Subject: Re: [PATCH 2/7] ASoC: codec: lpass-rx-macro: add support for lpass rx
 macro
To: Mark Brown <broonie@kernel.org>
References: <20210128141929.26573-1-srinivas.kandagatla@linaro.org>
 <20210128141929.26573-3-srinivas.kandagatla@linaro.org>
 <20210128160718.GE4537@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <2e1888d9-2ea6-67df-f61f-34062bf7aeee@linaro.org>
Date: Fri, 29 Jan 2021 13:32:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210128160718.GE4537@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org
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

Thanks Mark for quick review,

On 28/01/2021 16:07, Mark Brown wrote:
> On Thu, Jan 28, 2021 at 02:19:24PM +0000, Srinivas Kandagatla wrote:
> 
>>   snd-soc-lpass-wsa-macro-objs := lpass-wsa-macro.o
>>   snd-soc-lpass-va-macro-objs := lpass-va-macro.o
>> +snd-soc-lpass-rx-macro-objs := lpass-rx-macro.o
> 
> Please keep things sorted.
> 
>> @@ -0,0 +1,2020 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
>> + */
> 
> Please make the entire comment a C++ one so things look more
> intentional.
Will fix this in next version!

> 
>> +static const char *const rx_macro_ear_mode_text[] = {"OFF", "ON"};
>> +static const struct soc_enum rx_macro_ear_mode_enum =
>> +	SOC_ENUM_SINGLE_EXT(2, rx_macro_ear_mode_text);
> 
> On/off controls should be standard Switch controls.

I agree!
> 
>> +		if (rx->rx_mclk_users == 0) {
>> +			regcache_mark_dirty(regmap);
>> +			regcache_sync(regmap);
> 
> I'd expect this to be joined up with whatever caused the register state
> to become invalid, this looks like it's inviting bugs.  This also seems
> to have only one caller...

Few lines below we are moving the digital clock from OFF to ON which 
will change the state of registers. There are two callers, one from DAPM 
RX CLK widget and other from soundwire clock gate! We will potentially 
enter this path when we are resuming from clk pause state!

> 
>> +	SOC_ENUM_EXT("RX_HPH HD2 Mode", rx_macro_hph_hd2_mode_enum,
>> +		rx_macro_get_hph_hd2_mode, rx_macro_put_hph_hd2_mode),
>> +
>> +	SOC_ENUM_EXT("RX_HPH_PWR_MODE", rx_macro_hph_pwr_mode_enum,
>> +		rx_macro_get_hph_pwr_mode, rx_macro_put_hph_pwr_mode),
> 
> The naming seems a bit random here.

Will try to clean this up in next spin!

> 
>> +static int rx_swrm_clock(struct rx_macro *rx, bool enable)
>> +{
> 
>> +static int swclk_gate_enable(struct clk_hw *hw)
>> +{
>> +	return rx_swrm_clock(to_rx_macro(hw), true);
>> +}
>> +
>> +static void swclk_gate_disable(struct clk_hw *hw)
>> +{
>> +	rx_swrm_clock(to_rx_macro(hw), false);
>> +}
> 
> This all seems very redundant and like it'll get in the way of grepping
> for users.  It would be better to just inline the operation into the clk
> API functions.

Sure!

--srini
> 
