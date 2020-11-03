Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA82EC2D0A3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:33:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D87A422226
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="N49jfOB4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ibxvv73c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87A422226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51DF117C7;
	Tue,  3 Nov 2020 13:32:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51DF117C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604406826;
	bh=SwP8ntDbf4cFl5D/TL51U+gR/3UBnNGFfHsGfDBtyWw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N49jfOB4rVV2wmrL5ndUm3wzrZGpbN74I0dHm7tVEw/Y2qoQg6g70pmq+Ioqf34ri
	 d/jh/zqO2HoZPayNpLE6xKbnetlyIa41TlFr+hFEQ+EtHw64A33mDqNL/lE5T2HMhK
	 /QtG8Y5xPBi/ISP1Y6t7TpDmXkjnoj3584l/LDmA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F189F804BD;
	Tue,  3 Nov 2020 13:31:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8AA42F804C1; Tue,  3 Nov 2020 13:31:47 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 178A4F804B4
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2020 13:31:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 178A4F804B4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ibxvv73c"
Received: by mail-wm1-x341.google.com with SMTP id c9so11026048wml.5
 for <alsa-devel@alsa-project.org>; Tue, 03 Nov 2020 04:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=y5g02yisg2YY1sLEpz7UaUSABGGShGErCKYZaVBWDik=;
 b=ibxvv73cNC5BoJrVRc/HNlTXGT5LdQH6Xdd4KchdNSvNos3JpctjDBkt/IueeM+QaF
 c8Rzba0GgkPkcHNEBWeK5vW0wgJIxe430Pna4cVNyWK5CMTqjhlPeSWRYDTlqiNboOdc
 JaxC8ZkLZGhjDQZq8tdbM4ZLTX4hkTjQLXvzTcx447SSpxJ0Gq3A4YDD/bGiMWndOSo1
 MPuAEclfe7MHpHu0k+8518NsTKWOXc1+AeFGcZeGT3jv5bqvl72Qk2jwZtHmphdX7rXH
 r+SMWQJEJqvblpCkcwZK7qLkMJiNnc6iQN1Bx201q43Ka28PbwhuZmJz8OlOkDXY1K2N
 +B7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y5g02yisg2YY1sLEpz7UaUSABGGShGErCKYZaVBWDik=;
 b=DwjrKpRsbctxrgVrzod9dsW+HGhz9+3BxKm4+RlR4+efWPSWyiKSkq+P+t3D34//R1
 V5LIBV/6gSEAwjebK5qslX+EstYJYiXdFkWSXbRweaODIr2g86F6USZaqEPa6f9j0ZEs
 lnHUHg5LsBeb0Trex+4LImeKtu7NKjJsV5rySl4jiUwZCKQLf8KJx75Ak3OkvHxchlD0
 uHDQHqcZf4fStpvZQGC0TpqNDyzqBllKQ87pVO3dA3cWyNWlCSp+OGKHLsnSACgFziHq
 1oSsv/zk58NUiJwNo3QcRrg+hQULI10j/sFyqIR6sz/5AVVfyU0PR/zUrL9AKQzNo8M2
 qbHQ==
X-Gm-Message-State: AOAM532I7UZp1Z8gOw4SWmOkOTnqLgVkkswAvT032v89++pJn37dxpeg
 Z4sVsKzWSeIW2pYhXwoAeaW1XA==
X-Google-Smtp-Source: ABdhPJyoDx75NM2nei8klPiV6Zbdy71+3ncC5yA+p6RbdzsnUy2pt1TXTtGiX+SMswnf4kmnfXwTHg==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr3580057wmf.185.1604406702958; 
 Tue, 03 Nov 2020 04:31:42 -0800 (PST)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id v6sm25922279wrb.53.2020.11.03.04.31.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Nov 2020 04:31:42 -0800 (PST)
Subject: Re: [PATCH v2 2/6] ASoC: codecs: lpass-wsa-macro: Add support to WSA
 Macro
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
References: <20201029110829.16425-1-srinivas.kandagatla@linaro.org>
 <20201029110829.16425-3-srinivas.kandagatla@linaro.org>
 <13987e14-0bd9-9659-b574-d3b7446bb789@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <0bce847c-6437-9d12-6d54-d9ee99c7e896@linaro.org>
Date: Tue, 3 Nov 2020 12:31:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <13987e14-0bd9-9659-b574-d3b7446bb789@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org
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



On 29/10/2020 15:47, Pierre-Louis Bossart wrote:
>> +static void wsa_macro_mclk_enable(struct wsa_macro *wsa, bool 
>> mclk_enable)
>> +{
>> +    struct regmap *regmap = wsa->regmap;
>> +
>> +    if (mclk_enable) {
>> +        if (wsa->wsa_mclk_users == 0) {
>> +            regcache_mark_dirty(regmap);
>> +            regcache_sync_region(regmap, 0x0, WSA_MAX_OFFSET);
> 
> I am not a regcache/regmap expert but the sequence seems odd. I could be 
> wrong, but one would typically sync *after* doing changes, no?

In this code path the MCLK is going from OFF to ON state, so the 
registers would be put in reset state, so we need to sync them with 
current cache state!

--srini

