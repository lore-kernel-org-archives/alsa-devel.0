Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C30C47082
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 14:42:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF706105A
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 14:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF706105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF446166C;
	Mon,  7 Jun 2021 16:41:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF446166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623076917;
	bh=j3JhOHNd7qoB1rWJvpT5yifOBnhjRB6wft0v35DnGo0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BorqYQbPEXcHGMBgqIu2rpPYca3B2sNdq7MV1wbRvfeJv932bVVlbugXh6n6+Bsfw
	 v3bWEa6pkF8CocfMlrgBFaK9bski8AsbTHR84W6yPnoYIHyRtbxRi5zIm4rijLobjs
	 W1Yr1PPjv7xgJ+R++TY+cI9i4tvyVoqbH2sr6Qyg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 683E6F8020D;
	Mon,  7 Jun 2021 16:41:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 415C4F80212; Mon,  7 Jun 2021 16:41:05 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12030F800AF
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 16:40:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12030F800AF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="uQJ9OAJa"
Received: by mail-wm1-x330.google.com with SMTP id
 b145-20020a1c80970000b029019c8c824054so12900059wmd.5
 for <alsa-devel@alsa-project.org>; Mon, 07 Jun 2021 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OanpAfND50o1dtOzFQ1uSP2e8yQNH4AzvgQsBBlGBrA=;
 b=uQJ9OAJanRGB1kRgTXmIYqXPwQoEiX7wLKiK81ZLuFs1BTTN0bDKmqCzycDKI3gGTX
 zELPFYOfOemiWFhRX7g2Pd7LiRwyqQziB+XyFAQDPhfNBMDJYASfHoIbKIXZwwOLjHiJ
 6IUek7BCi8KZGUpvmwjdpPV+Zydto/c5OMaUosJlWpSJz4rbzrLhLXuoFkkmJXVlNDQE
 SS1yyuBOD/CkpCeKBvLWGyIJ0IRybIKidPOoNObuKJ5odcEzboGHBdXreVpG8khVg755
 oLqkp4OS1N1O5xwrV3+3tnYSJ+XdwPKb/n4S2u9CROxtGpdiMpdIL5bbrMnHYgquaGU4
 ziEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OanpAfND50o1dtOzFQ1uSP2e8yQNH4AzvgQsBBlGBrA=;
 b=DFC0A5XmTkmfY8uyXzsoBgTTdBeaGONApKJTI9ZxaKblAC5zF6TAHw2Ua+QGnzqTbY
 SHTllaVebYShSMI8SYkcS6ZZqNkHfqvYhs8P3+Bbky+l0vClsTUTLKYhRydDyG7dMvfh
 CyJmYGLmkTtFOd2VymqYvNxtKW7WPQHUznaw711oEOI0QrmYvHhloPSBJ3HVroUyAxjy
 UjrrQVPGg9QeKTLGknfG6sX/IExCgvxuR8Ksvk4lVxfwGzgQFqpSpnIdW290nYk3oYsr
 bQX59ZN+qD2Bb7sXYkdW/sXQqyedA6lnZ+/QGwPrhqFDMlVyUv79yNtNSIzNVGVqMCeh
 7EIQ==
X-Gm-Message-State: AOAM530mKL2ulGlkjzg4Y2IpZCE9cZ+gn2c6wrvM2tNf/xNZIUPHMUXl
 PjuVlnMhkLMS5h1lZDdMhC8SL+YrfOuusg==
X-Google-Smtp-Source: ABdhPJxrV6ZcLlyr4Izk3kkTTKCNzsD6F5NxkuJOvl7H2horOfgkoceHmJe64gHWYKLZtAt2vBYqng==
X-Received: by 2002:a1c:dcd7:: with SMTP id
 t206mr16849147wmg.121.1623076857193; 
 Mon, 07 Jun 2021 07:40:57 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id t4sm16503190wru.53.2021.06.07.07.40.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 07 Jun 2021 07:40:56 -0700 (PDT)
Subject: Re: [PATCH 0/4] ASoC: qdsp6: Add Quinary MI2S ports support
To: Gabriel David <ultracoolguy@disroot.org>, broonie@kernel.org
References: <20210605022206.13226-1-ultracoolguy@disroot.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <e26e4fd5-26b3-04b9-ff3b-2adc9cefaf71@linaro.org>
Date: Mon, 7 Jun 2021 15:40:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210605022206.13226-1-ultracoolguy@disroot.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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



On 05/06/2021 03:22, Gabriel David wrote:
> Various devices(such as the Motorola Moto G7 Power, codename ocean) use
> the Quinary MI2S ports for reproducing audio. Add support to them in
> kernel.
> 
> Signed-off-by: Gabriel David <ultracoolguy@disroot.org>
> 
> Gabriel David (4):
>    ASoC: q6afe: dt-bindings: Add QUIN_MI2S_RX/TX
>    ASoC: qdsp6: q6afe: Add Quinary MI2S ports
>    ASoC: qdsp6: q6afe-dai: Add Quinary MI2S ports
>    ASoC: qdsp6: q6routing: Add Quinary MI2S ports
> 
>   include/dt-bindings/sound/qcom,q6afe.h |  2 ++
>   sound/soc/qcom/qdsp6/q6afe-dai.c       | 41 ++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6afe.c           |  8 +++++
>   sound/soc/qcom/qdsp6/q6afe.h           |  2 +-
>   sound/soc/qcom/qdsp6/q6routing.c       | 11 +++++++
>   5 files changed, 63 insertions(+), 1 deletion(-)
> ---
LGTM,

for series:

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini

> As a warning, I'm currently the only tester of these patches. If that's
> gonna be a problem then I understand.
> 
> --
> 2.31.1
> 
