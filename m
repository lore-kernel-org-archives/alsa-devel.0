Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C0DC433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Oct 2022 16:31:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 000993A46;
	Wed, 26 Oct 2022 18:30:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 000993A46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666801897;
	bh=pibIx4rslMV8+9bmARvw8NUGgdQsWAYSvJSYqkEuwB0=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A8m7pW1k+lcU9A3sY1AOK2l6glOK5CePIcHJZK4APLG3+A+cd7Dai3A5LYsyd9wiu
	 PBXn3Uf96QYaqikrCsOBJeVmhBX0fUfUrOl55Ne2HvMLW5zGt6eP08yKDXqdseW1Xw
	 PN3DhAjkT/1EKiPlH09eYpcsfvUXh7FJu0oOq+s0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84AD5F8016C;
	Wed, 26 Oct 2022 18:30:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFB86F80271; Wed, 26 Oct 2022 18:30:45 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7B07F8016C
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2022 18:30:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7B07F8016C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="yqzLVshf"
Received: by mail-qt1-x831.google.com with SMTP id x3so3323062qtj.12
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2022 09:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MEWQjBfFk/Zdt39bZHeZ/2md1LrkK3njfqHpxKjRhAc=;
 b=yqzLVshfBATMpUgpsZffV9q/DTVkozyc3MVPu0gQrxYNwaQoIlOBMP3undJwlntfQV
 iIUShn7/vowA/imGuvjeNBaZCF2nCVMXMmWTtWyz1HJvJQfhUJWhVluO63kXZA0fh0Z5
 zx9EWrtX07jf8kileGgS3lA/8HoUGRTUB6uSQilStct9QNe2YMn5rK0uX04qME2WX2wN
 0wAk9XMrfehHvMiT28xCEdrLelhIwsFc+e3VEKDsR5ygYdoZi0pA9YrSEaO+0S4goza/
 gWDz19FJ6OAvQTfc9CEP0M4YymLpPq3FOpPGjKOjluGq30VM7hx2UTUwmQ0YIQlOAbHm
 lgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MEWQjBfFk/Zdt39bZHeZ/2md1LrkK3njfqHpxKjRhAc=;
 b=6jpUXicdG6bjxxH1NAb79rdgRT1wltdyKFJ5zLvNuYPddiH/bCH1ciKU7sAZ3ibXmw
 B8DCmB42B/LzwfAtiDnMHAj0RCPi1rHygIjSfvEyIrnQAGWQL3aFDnBZwCljlnbhFkJM
 kMDI2KI+t72sK2KRmm67ixE8CyalIsqkukyWZrn++PakvFYwbKpaK3NLsCUvwRGp4stn
 zLJW1lQW8j9U0/IIVPVMbKKN9cRcQQ5NygwGS4Q0vev2q+gUtAcD5b1O63rQu2gNm/VO
 fdUej08sIgl7+4b0ekoYOurhKmNPwTDYNGfDE+dnC/ptYBa7e9ofsOI++2Jx5QE1oFYA
 3Y7A==
X-Gm-Message-State: ACrzQf3Yovll4gAacyOm3IAmePhqq9Iid2aIOdpLqPK9nRyFjv8IFb4A
 FERcdPLMg9IfB5k0fcwCAsHR9g==
X-Google-Smtp-Source: AMsMyM4X5+5ss5R8dZPK0IxY6Megf9eWUoPQKvis6PymkL1smThD/yQ3JgibJaReN/eJFwt8FGLSwQ==
X-Received: by 2002:ac8:5a42:0:b0:39d:136e:8a43 with SMTP id
 o2-20020ac85a42000000b0039d136e8a43mr27254584qta.372.1666801837499; 
 Wed, 26 Oct 2022 09:30:37 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a05622a110a00b0039cb9ef50b5sm3444073qty.26.2022.10.26.09.30.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Oct 2022 09:30:36 -0700 (PDT)
Message-ID: <3169d47b-35e4-7e49-875c-631a66350613@linaro.org>
Date: Wed, 26 Oct 2022 12:30:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/5] slimbus: stream: add checks for invalid
 unprepare/disable usage
Content-Language: en-US
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20220923155740.422411-1-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220923155740.422411-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, linux-kernel@vger.kernel.org,
 Andy Gross <agross@kernel.org>
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

On 23/09/2022 11:57, Krzysztof Kozlowski wrote:
> slim_disable_stream() and slim_stream_unprepare() are exported, so add
> sanity checks preventing unmatched/invalid calls.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/slimbus/stream.c | 6 ++++++


Hi Srini,

Any comments on these patches? Can they be picked up?

Best regards,
Krzysztof

