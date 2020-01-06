Return-Path: <SRS0=qF1Q=23=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B44C33C8C
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:02:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E84207FD
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jan 2020 14:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Hz1L6NQV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MA1lw0M1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E84207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C59517E9;
	Mon,  6 Jan 2020 15:01:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C59517E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578319334;
	bh=T3DUnUXvuR5pFU6g5yLUY95IAjImUQrnFCDv0f4Ivws=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hz1L6NQVF3jfTIiiFRy74n78GmmLmFRNC3m0uhfTt5mQhCOXYIRC4D7sPoBctghan
	 9Z34gXr/TKZApyCdP+jlIg4KabxdtmLU5jPxJSQkuOw34ekw7/3g82enCrtZWMjeFV
	 l0ohRUYoXfZ5TN2GmWaS+8z14MZ9UC9+OB5UeHVw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FA39F80149;
	Mon,  6 Jan 2020 15:01:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79B99F80159; Mon,  6 Jan 2020 15:01:22 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A06AF80116
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2020 15:01:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A06AF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="MA1lw0M1"
Received: by mail-wm1-x342.google.com with SMTP id d139so12031486wmd.0
 for <alsa-devel@alsa-project.org>; Mon, 06 Jan 2020 06:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Lz7ikis0geWQiGTegeuXGmTWQm7+VDbN7NPm2DYVWb8=;
 b=MA1lw0M114PfeJblTQ7enuGZIR3qzoZFsrCNUeTMdJ7eUnf+1/2XYPUMQT93mBU6As
 dd6kNjDGv/ol7YKtE//7NFnauJnLq49UiuJYxzUiJZyLTw/8L/sY4tNR3v/3Qm+eNmwh
 r4MYamBx1J2KgQeTIrX3EuOfz9gLiplZPzw0WdioOLeLhO2IbE2W4IbdMS15ujXfv+Ie
 x6KlXPSHVOt/Ma99I7mZgMUbB0GpBvs/lYsL1yP2hYlJR41K8h4SFyaTEmPW6LPFD+V2
 JhYceIC+sevCdYnTpdmDDw6AkwppQuyNFDp27LbS17FN+GzkICIJmvK2ZK2HfkZfSikG
 gWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Lz7ikis0geWQiGTegeuXGmTWQm7+VDbN7NPm2DYVWb8=;
 b=jiO/GPUTpQE2mxNYBc1VauTUjBYxNUMsIBKMssF9/B73nOethlfyqrcuUlYJZVGUcj
 D5/sXz5DRhDZ6vThtlfPxU5HWI+JyJsdpMm1/4nGxmECsDKhYJ7nTNFC1SnHHKYqlpUB
 ufVka1Aa/zKqWudy1hrDiWnSblkKMQog/80kin7i37LxDtLcwEmIKcvIz/5zfa6ziGH7
 f1UWOsiN87qUSJlTlJP7wI1HEYHPHri03R3gDlXZBd1JFA88oWgGz6LEJvheunUXoxK+
 3EmQAApt68Bpbv3JNm9eFZpnbrkI/lbzkjJDxoRvDjebVg4594ggF2gr4FCBD8MkbdMj
 gdRA==
X-Gm-Message-State: APjAAAUIs6f2rsp3RgBOHKdAW3nDa0+gu8UO98d/kgjDodaFqVwJDosO
 invcepzuHfVMngOkHDL7xxaJnw==
X-Google-Smtp-Source: APXvYqzM2jmyz/J2syp2KInXPWWwzhzK4IPDbTGtsIuU/hKoh62sCmhnmHrHpKTCTeKwraFV03oM5A==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr34354871wmj.117.1578319276916; 
 Mon, 06 Jan 2020 06:01:16 -0800 (PST)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id c9sm22385471wmc.47.2020.01.06.06.01.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Jan 2020 06:01:16 -0800 (PST)
To: Nishad Kamdar <nishadkamdar@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joe Perches <joe@perches.com>
References: <20200104141433.GA3684@nishad>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d0ede580-5abc-b2a5-52a2-bc8ea41a369b@linaro.org>
Date: Mon, 6 Jan 2020 14:01:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200104141433.GA3684@nishad>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] slimbus: Use the correct style for SPDX
 License Identifier
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 04/01/2020 14:14, Nishad Kamdar wrote:
> This patch corrects the SPDX License Identifier style in
> header file related to SLIMbus driver.
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used).
> 
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46.
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>   drivers/slimbus/slimbus.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied thanks,

--srini
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
