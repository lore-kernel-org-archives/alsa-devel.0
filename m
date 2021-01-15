Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169E8C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 11:13:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D75236FB
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 11:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D75236FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 558271798;
	Fri, 15 Jan 2021 12:12:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 558271798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610709225;
	bh=98xUeOcG+Gz1L0XVQ4Qax662VXBfAjmuJs9ZXgVOwE4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TiYue3Qc8txIpLhc8uXVkBEjWiYxmbfd0Mi04tXHWjINXamjNuYv7XAW4Ef8BxbbI
	 /27/BrryC7YVunKJQSP01T0KUKRrF/I37PEA4Xc7kDabJgqlLdZaD3NYWTJXVk+NhO
	 By0UJ+kLIUOu0+h/2AropyK/JCJpIDuJCqucz0f0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C8916F8016D;
	Fri, 15 Jan 2021 12:12:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C044EF801ED; Fri, 15 Jan 2021 12:12:51 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E9A1FF80134
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 12:12:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9A1FF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ETWqj32E"
Received: by mail-wm1-x32d.google.com with SMTP id o10so1687711wmc.1
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 03:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8hOPqiKxYh57wkKCGDlQE85ouMI8Pjq2OXu/MBK/GBo=;
 b=ETWqj32EUC/lVfGcEnrERegA0IfyyyfTQBugipiNDz9oezr2FUyXSgNjERTQhyzitT
 5zXV13jV2QfbErvJHqnJXkiPYsBMkih9apQHrrKK5OK+P2cn+nFP+Ujs56tF/3J76dwn
 keVommed8cXFUXxwKiyD162/yJ7T2BFhSzJjfZe3D2cGa/KQRowm71sEduN6Iv7WOasG
 YTMzC/kSxrOXgZqq9HUGrcg/gKygcFJ5m/Qoig8NtSgjLnr+xtM+RSMJwkjBGdQK5Bzn
 cCOQaIHk6N7aTrEH9W75pdoX+e69sE1IfFRjCJiB2kaTalfRhTLmS02MsZN+F2WBV+C5
 Hndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8hOPqiKxYh57wkKCGDlQE85ouMI8Pjq2OXu/MBK/GBo=;
 b=DngaKZ8YjrYjAFKzjAXwAEXxbJNte1mbDZkXD0zGID2tnjMXT4oh7gAnePFOwmG69x
 vMj4FtWN3djAbTVBYO0bWZDshg+9iOnxgcFDMmdkBdb0Km2cv5dMv03s87mh0ncMAoXZ
 4Zt91YztI2V393aKmjlzBlQWdIO+EzE59/pLT7KX/e4Itoq5Xf/aMZ7qSYs2Y4w6ulyU
 O8doWVoV1mHR04C0joeP9NJ6nt/UrkBlshoVnHAStGiBp7P/ZaA0Qkkc0CjKaDjinp7l
 leNvIriWc565vKa/i+Q/rF+dyjGI015dYWxPU1bMlDlo8TW5JT3TOHuWfW74IA8x9n0T
 UvEg==
X-Gm-Message-State: AOAM532Z80Rn7nrNwcOwD9M+ogKI1OUyKIioF6tvXsbhrbacAmlYxXBA
 pXu0Cv3tbSa+ZVzatgg66InHvg==
X-Google-Smtp-Source: ABdhPJxZxPpbEPACV3JGhyB3zfkvu0YT51nxUVRM08/3jMLDRr4l2mATYKPVXAsaURWiMAg+h9NBGQ==
X-Received: by 2002:a1c:9ad5:: with SMTP id c204mr5322138wme.65.1610709164628; 
 Fri, 15 Jan 2021 03:12:44 -0800 (PST)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id f68sm1305763wmf.6.2021.01.15.03.12.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Jan 2021 03:12:43 -0800 (PST)
Subject: Re: [PATCH 0/4] ASoC: qcom: Minor code cleanups for lpass-cpu
To: Stephen Boyd <swboyd@chromium.org>, Mark Brown <broonie@kernel.org>
References: <20210115034327.617223-1-swboyd@chromium.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <f60d2cf1-7952-3e85-e988-53e6b91ae75a@linaro.org>
Date: Fri, 15 Jan 2021 11:12:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210115034327.617223-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Srinivasa Rao <srivasam@codeaurora.org>,
 V Sujith Kumar Reddy <vsujithk@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Cheng-Yi Chiang <cychiang@chromium.org>
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

Thanks Stephen for the cleanup patches.

All of them look good to me!

On 15/01/2021 03:43, Stephen Boyd wrote:
> Here's some minor code cleanups for the lpass-cpu driver. I noticed that
> it casts away const from the driver data from DT. That's not great but
> fixing it is a little more involved. I'll get to it later. There's also
> some questionable clk_get() usage that should probably be
> clk_get_optional(). For now this should help a little.
> 
> Cc: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Cc: Srinivasa Rao <srivasam@codeaurora.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Cheng-Yi Chiang <cychiang@chromium.org>
> 
> Stephen Boyd (4):
>    ASoC: qcom: Remove useless debug print
>    ASoC: qcom: Add some names to regmap configs
>    ASoC: qcom: Stop casting away __iomem for error pointers
>    ASoC: qcom: Remove duplicate error messages on ioremap
> 
>   sound/soc/qcom/lpass-cpu.c | 17 ++++++-----------
>   1 file changed, 6 insertions(+), 11 deletions(-)
> 


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> 
