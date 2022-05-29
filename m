Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91EDEC433F5
	for <alsa-devel@archiver.kernel.org>; Sun, 29 May 2022 08:07:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BBAD218D9;
	Sun, 29 May 2022 10:06:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BBAD218D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1653811635;
	bh=dAH1EppH5R9S0C5QKSxATmkCdSzgQV2UzNiW7L8brmM=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NANZBh4ROFf9RFK9MMyQVrgAA7y/NAXX4UUavM3ex08LYcZaBJ25swdYxPNWsCE0a
	 BkL6ft7/QV2vMfOo/BCTx6rH/fynwuEjj+M4EqTO0FPgOX0Uh2DIz3jLndCsobOhFZ
	 rM4CTqtw2P0GHpGsP7yWIsya9W4i86YmfcYXWM3g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E50FF80245;
	Sun, 29 May 2022 10:06:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 560BCF800DE; Sun, 29 May 2022 10:06:23 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A365BF800DE
 for <alsa-devel@alsa-project.org>; Sun, 29 May 2022 10:06:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A365BF800DE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="zK97chyQ"
Received: by mail-ej1-x633.google.com with SMTP id me2so2675835ejb.9
 for <alsa-devel@alsa-project.org>; Sun, 29 May 2022 01:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :references:from:in-reply-to:content-transfer-encoding;
 bh=hQYyH1NuQCxodBSw7bWH/zqxL4qVmJndxBzPT88yQB4=;
 b=zK97chyQl8Zw0vTKRZg+NP7DyTXvJW4ZGtJmUCyHTZbs/UgyCwhpOk0whyyWkH4e2E
 LIt4VprENlnBrKz/nwjdqjiTluUmtnoYnwlTjNl2FzVeD86xec7VSyCh+ALTI4zEy3Ht
 cFPCDDX6ZAykzxccShnKKpc22cohMHAMWhkfvyarUDoljJ2F6Stxt4YjLoa52/nZJt/z
 kIfaiir+c5IDF1pbvDld2ve6u7rHPOrAlzLg/Vnr+W+eYx48gF9o5K2FwL51FFGI26bQ
 31epBhkXZmtxGPXgWMqem5R8DoT+WUhBgUD1TYkeYvRdlyNTl5pKH2nP9HRd+xB9pHSb
 1ZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=hQYyH1NuQCxodBSw7bWH/zqxL4qVmJndxBzPT88yQB4=;
 b=6U8W2oPXbkddZf+/vSt/Nu8oe/REvGW91c3dCIMSbVJD9Qjf6HjXnBQ9kP9y+l1fYq
 jIql0KJGhZKEa8+tvZ3FAYNkO7Wj4uMTbbk3tU2CLqW0x7FUm5EQvB4kMIeC81rmGAqo
 unbJnMkNjQuIbgcJkSDCvp5T0VWB6bZbojxKtmN8zOHG9bN1UIfUovkdqVMhtDO9/P8/
 xqc8IPM7kZPjDWxULuZMSvy+dPCz9gkzi7DBg9FeaZEIdsFdKaJ7T93AHwlxbZTB8qGH
 h0p9oO9NO0EFkyy1n0CZ5V8opNoRN8Icas1uRHRpHhXenCAqO2alvQMKTBXD3CytApWy
 UaCA==
X-Gm-Message-State: AOAM530y/7vTaN8hTX8LK5xfpFZqBlWgMEKoiRk+zwHXdZ9ZIC3Epr5Z
 2OsvXm+iJGkKN7rXeNmnWg9Yrw==
X-Google-Smtp-Source: ABdhPJz3blndANSWk63eUvimaJRxk9h98saxwAdGFo6awH/GR+XpuYweVafdECGQDkyC3kfOjzSWQA==
X-Received: by 2002:a17:907:6d24:b0:6fe:c407:d956 with SMTP id
 sa36-20020a1709076d2400b006fec407d956mr32749932ejc.33.1653811577490; 
 Sun, 29 May 2022 01:06:17 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch.
 [188.155.176.92]) by smtp.gmail.com with ESMTPSA id
 s25-20020a508d19000000b0042dd05edeedsm91547eds.17.2022.05.29.01.06.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 May 2022 01:06:17 -0700 (PDT)
Message-ID: <2bcf706b-10d5-9369-ff8a-2a3263f9fa70@linaro.org>
Date: Sun, 29 May 2022 10:06:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ASoC: samsung: i2s: Check before clk_unregister() not
 needed
Content-Language: en-US
To: Yihao Han <hanyihao@vivo.com>, Sylwester Nawrocki
 <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
References: <20220527065412.3677-1-hanyihao@vivo.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220527065412.3677-1-hanyihao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 27/05/2022 08:54, Yihao Han wrote:
> clk_unregister() already checks the clk ptr using
> !clk || WARN_ON_ONCE(IS_ERR(clk)) so there is no need to check it
> again before calling it.
> 

No, this explanation does not make sense. clk_unregister() warns and
this code is not equivalent.



Best regards,
Krzysztof
