Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD475ECAAA1
	for <alsa-devel@archiver.kernel.org>; Thu, 27 Oct 2022 16:46:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6E0C2E87;
	Thu, 27 Oct 2022 18:45:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6E0C2E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666889200;
	bh=VmVs8oee7uezsu337NX6Xxjz0Xi2WW/4N2HgP6BRToU=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qS/1RQ0D4386dp7QMd9fcIfPubGnZoeeLtaFjfTELQ+OurpgVJfJXBlS/fmtwnxn4
	 OUnrV8fIJg/XDHvO355omRY/lsoAvgtWottPQbULCPC2P/iU4LuvgUUOkW7ypUDAhp
	 3W5tjf3N0mY8z4FOMyoCP8no+j3Q6VHGKHdCZmus=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A3FCF8025A;
	Thu, 27 Oct 2022 18:45:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9C4EF8025E; Thu, 27 Oct 2022 18:45:49 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD612F80095
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2022 18:45:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD612F80095
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="z7vJkI3S"
Received: by mail-qv1-xf34.google.com with SMTP id i12so1847339qvs.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2022 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o8E7f+pbai6yNionn/RucFtJANfu+mS+MIa2K7Eho/8=;
 b=z7vJkI3Sc3woYN3W1CoV94ELnbBfBwnApLU5+2VLwFinpR5/nT4L711ilpekqYgNcC
 ukQAnfFpt0DZ3pNmN1snpxXrKx/mt0z/leChy5W2pSjYibqelOFNWafYk5FZW1EBdIBU
 ieAJUANrvOPu06uXKZewj3T4bfK/EJ4Wg+bHUO53SOr1dZkOa4n5/fh7iyqInnn0rw7A
 ZUPYTMp0iiMt3VQNO7I2KOboAamniF7cM4HtugId3udr0Bvog/ezITI2vEc30/djD6IM
 WOfg0HP9hne7Pc+0MsIyhW89Y1m1D9/7x5mRE0wsZHsJs6u7C8yHSTBzDTTHFQ5UYBSx
 Yw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o8E7f+pbai6yNionn/RucFtJANfu+mS+MIa2K7Eho/8=;
 b=AiT33Y1+w+krjsCnqkiim96V45lvPkG6kF/OmXOLP2uvSgvsvkHEVOtP3KLQDI3e0h
 qYwVBaeji73QbTDLrSQEjt7EzmUCcOFBJsk7GrOOLLy1GcDZ0tl0muwgzx+OKReAA/Jm
 sM0aSkXb5O5ROE0jq8unBGFVDO1QZWworEwYlVKjvIqfiGbdS4GBN6JzYgKdPe76LSH6
 cB7PPee+E2n1bX3Vnc6gtzy7Usmhm4nromNY7LsrMKRexSSC/h3CA9t2ev+YdqBtd2ck
 ANXW8+GB2TX8hbV2R4XipWZ5beWKHUiE4v4oZ9Ou8H+8maFhv1KAyJlFd1ZReV81RMr7
 hdfg==
X-Gm-Message-State: ACrzQf2cZTKshXi/smDx5KStCnErI4nSPfNv8RcRA0o/kGhtZSt/UGSB
 aM0dZk8QhmdRR6tGlwkdKULn2Q==
X-Google-Smtp-Source: AMsMyM57a6LQobl39EIHUvYv9F9ueqjvF0NgC33FdCUUNQFRFn6DRCQ8utqMeylgbUFbcEJxjucwNQ==
X-Received: by 2002:a05:6214:2aa4:b0:4b3:fcfb:6479 with SMTP id
 js4-20020a0562142aa400b004b3fcfb6479mr42265023qvb.127.1666889141013; 
 Thu, 27 Oct 2022 09:45:41 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
 by smtp.gmail.com with ESMTPSA id
 bq33-20020a05620a46a100b006bb366779a4sm1293337qkb.6.2022.10.27.09.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Oct 2022 09:45:40 -0700 (PDT)
Message-ID: <f1f514d3-cab5-9502-02f6-0a1b84067eab@linaro.org>
Date: Thu, 27 Oct 2022 12:45:38 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: fsl, sai: Add compatible string for
 i.MX93 platform
Content-Language: en-US
To: Chancel Liu <chancel.liu@nxp.com>, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, shengjiu.wang@gmail.com,
 Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
 linuxppc-dev@lists.ozlabs.org
References: <20221027060311.2549711-1-chancel.liu@nxp.com>
 <20221027060311.2549711-2-chancel.liu@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027060311.2549711-2-chancel.liu@nxp.com>
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

On 27/10/2022 02:03, Chancel Liu wrote:
> Add compatible string "fsl,imx93-sai" for i.MX93 platform
> 
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,sai.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

