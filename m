Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F033C6FD1D
	for <alsa-devel@archiver.kernel.org>; Sat,  1 Apr 2023 10:10:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDA5D1F7;
	Sat,  1 Apr 2023 12:09:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDA5D1F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1680343825;
	bh=+BphKayV/0vc+eYUYaASEcitYabRQK53GPHDz61rqbU=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=maDsx1oIkg/tvHdXnjYHf0wXFvZ0+4LMcItDARpck5YcFPcAuLZKFNrl1CGD4c5i7
	 J6Xv76iMnMHbHfy/iNXrATu+aliclQFVe1IOygSCq5Ip2iWQ8rWPcGnbvwj/gvurBt
	 4RxPv8VXKN4ECSNX7hNoOusgG2/xjmpfgYJ7h/pk=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C163F80272;
	Sat,  1 Apr 2023 12:09:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 64ED9F80249; Sat,  1 Apr 2023 11:47:04 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1517BF80249
	for <alsa-devel@alsa-project.org>; Sat,  1 Apr 2023 11:45:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1517BF80249
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=DB4GBhII
Received: by mail-wr1-x430.google.com with SMTP id l27so24724815wrb.2
        for <alsa-devel@alsa-project.org>;
 Sat, 01 Apr 2023 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680342309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enLSXvC9cOIGUaRnMgYw4KnAx/zsnnPatWKBKRZeUhs=;
        b=DB4GBhIICc4dXx4AUyVmnX90Z5uhn16tnAF6/gW4OPxZ2Qh97CQpD2rmfa5kKZIfTa
         EwIleDu1NJTSBMjTbKSsSe4M0pQ8p9aBmZq/c0wLa5kkSR13wWYC2lj2LjsoPXnZKlwY
         +IhMIPdZV321uCwG8WERPBl5WTy5Fw6UeGb6OC3zsaYNVL3j6ruY75uBxQAk0qUZJhEj
         iMLGa/i9gXeZFbWtIYPD7o9mPTa/p6zjYmsRbZ165W4EFjkKOGP9xQM3ei1vySrfkZsS
         15P/YeZzn3+Jvcz+UuaMPr6CzyhilvbjmKDhRldVXoB8b21RxTWrdDspWcS/jOALG7vf
         jZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680342309;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enLSXvC9cOIGUaRnMgYw4KnAx/zsnnPatWKBKRZeUhs=;
        b=rTnBL5PtPV9DExSH0SkHMz/y3EZzMgZ1r4bVEijbN98LKtNvFN4RnlStC3jH1nW3PZ
         T7KtYF2RGBvDlcpNgX2d5pw4jFeneeyZoA7WQZ5jB3AhuquIPYAAN1JJM6D//3HObB75
         9J0YzHSDSMw+TvnT8/T5Djbw0SMccEYmhxuVZ3AHWyOuVG7neX+cOCObOc5e/wpxa9c7
         sPkcrdjHnKEl/SUXF1JIPaXDEnP4EtnT8JGytJQ6NPE+ulLooTgdQqna5mDTjAfJ0YI6
         2/p+pOJAvSDh5v9MUo7RlMfiu8v4x3HiTz/LCToHjJ5BVfQNLPadOdTAjq556n+9qrqD
         4XSw==
X-Gm-Message-State: AAQBX9eXwwfp5sMF4OaYBMB3EYxLHG0L5feKcdn7Z9EkqwswNqqseHae
	OU4HpZ3iPgOaglVuIFAmjwt2sg==
X-Google-Smtp-Source: 
 AKy350bdhrPXteAy14H6wTreJILApVyTmS/XDg66OMR/3heapL9ZmGdi17szArp0VJxBbQMcJI/m9A==
X-Received: by 2002:adf:e644:0:b0:2c5:4c9f:cf3b with SMTP id
 b4-20020adfe644000000b002c54c9fcf3bmr9084520wrn.7.1680342309583;
        Sat, 01 Apr 2023 02:45:09 -0700 (PDT)
Received: from [172.50.14.32] (5-226-109-132.static.ip.netia.com.pl.
 [5.226.109.132])
        by smtp.gmail.com with ESMTPSA id
 s11-20020a5d424b000000b002e5f6f8fc4fsm3877194wrr.100.2023.04.01.02.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 02:45:09 -0700 (PDT)
Message-ID: <1d08d7a7-0682-cd05-f2a1-2b458a2eb25d@linaro.org>
Date: Sat, 1 Apr 2023 11:45:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] ASoC: dt-bindings: maxim,max98371: DT schema
 improvement
Content-Language: en-US
To: =?UTF-8?Q?Andr=c3=a9_Morishita?= <andremorishita@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 anish kumar <yesanishhere@gmail.com>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230331020527.482991-1-andremorishita@gmail.com>
 <20230401035756.856752-1-andremorishita@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230401035756.856752-1-andremorishita@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VIBYVABPR23OCK77BHSAQJFHBMHNN2NN
X-Message-ID-Hash: VIBYVABPR23OCK77BHSAQJFHBMHNN2NN
X-MailFrom: krzysztof.kozlowski@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: mairacanal@riseup.net, dri-devel@lists.freedesktop.org,
 daniel.baluta@nxp.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VIBYVABPR23OCK77BHSAQJFHBMHNN2NN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 01/04/2023 05:57, André Morishita wrote:
> Improve Maxim Integrated MAX98371 audio codec bindings DT schema conversion

Your patch changed much more than your commit log is saying. I don't
understand why. Previous subject was better than this, I only commented
on missing prefix.

Commit msg now is unspecific and misses full stop. I don't understand/

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets.

> 
> Signed-off-by: André Morishita <andremorishita@gmail.com>
> ---
> Changes in v2
> - Generic node names - codec (Krzysztof)
> - Drop label max98371 (Krzysztof)
> - Add sound-dai-cells in example (Krzysztof)


Best regards,
Krzysztof

