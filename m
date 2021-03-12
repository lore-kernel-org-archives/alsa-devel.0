Return-Path: <SRS0=XQZd=IK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33D7C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 10:47:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DB06501F
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Mar 2021 10:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DB06501F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DAB3816ED;
	Fri, 12 Mar 2021 11:46:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DAB3816ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615546043;
	bh=Auj0pqrTthap34sH1e6BX/B+EF5AdlNd0BXgLDukUfA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=psrKKhONayoq2c54EhzRPYw19BvZKTxBQYhWVDQXv+GY/FXxI1X3VP8XXY1lIBEyY
	 uet7juUgx4r8YD1WYUn9twzKKxE9+BwdZcid1UoHDbmirN+qtKm5ybDJNL33kpYYCW
	 FKqsnRxLAIi/USfAX4a58XnanaJNaT2fuwvvK01c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FC83F802E7;
	Fri, 12 Mar 2021 11:45:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB988F801D8; Fri, 12 Mar 2021 11:43:40 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 34235F800BF
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 11:43:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 34235F800BF
Received: from mail-ed1-f69.google.com ([209.85.208.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <krzysztof.kozlowski@canonical.com>)
 id 1lKfGN-0003gP-3J
 for alsa-devel@alsa-project.org; Fri, 12 Mar 2021 10:43:23 +0000
Received: by mail-ed1-f69.google.com with SMTP id p12so11319673edw.9
 for <alsa-devel@alsa-project.org>; Fri, 12 Mar 2021 02:43:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k3krHMf8FRMVK6CtYPofCBzLrKQGSEz6pFoDSv1Aq7s=;
 b=dZVvj8+xGyUXs6BMYetdbzaOk8dqPnf5fbKW5dEtHk6pCLSLSXtWZ256wPIXjHxFXe
 Gho6cSaj8VPKsbcx5aHQbTOuRY+2hdoeXjm6rTDVdIHbpi+UAw7bAWKpSEm+22R++I/+
 aJ5Tz77fKg7Pmt37JD1R8qET5Fb8HyUBY1POpJ55iunkEebJXGE7XzMyjEkIRdpWyQWg
 nNG05Zf+uctzUnAb8YWxBDOW7uVbtRV7geXH3FuxkIQj+0DZQ9MOnlPtPDW4nQAfY0z7
 lTXACfIxYs7Yg/n8HQMsnVjutrtzqbNaczxBagF59zJWt7XqngcnL7EXdRdSHmDiPGKZ
 CU2w==
X-Gm-Message-State: AOAM532Feco/itn1Lro+z3YK8J0cqwmbxciinRan0OBeZKHaSXBn9S1H
 WTzg5d7KRC9/DCnnMHhzg+XIiuDZ2ox94GYqhm+GU4RXUH5+7w0lnVPP2t7iOIe4oaLLBhz6ga4
 bVn55PUdPkIgs37Ny8v2tWig+qXUQ8pytx2VpdPmA
X-Received: by 2002:a50:d753:: with SMTP id i19mr13381978edj.43.1615545802823; 
 Fri, 12 Mar 2021 02:43:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNugyXYmLMwKIxfkBcrE+fq0BL9z6U0OsA4mFutDTaa/42Ml2+NTvEwFgIlJazoXpPMTP1JQ==
X-Received: by 2002:a50:d753:: with SMTP id i19mr13381969edj.43.1615545802665; 
 Fri, 12 Mar 2021 02:43:22 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch.
 [84.226.167.205])
 by smtp.gmail.com with ESMTPSA id c2sm2524450ejn.63.2021.03.12.02.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Mar 2021 02:43:22 -0800 (PST)
Subject: Re: [PATCH v3 1/2] ASoC: samsung: tm2_wm5110: check of of_parse
 return value
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20210311003516.120003-1-pierre-louis.bossart@linux.intel.com>
 <20210311003516.120003-2-pierre-louis.bossart@linux.intel.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <98d492b4-4d1f-fcc7-c8f0-5191b1a31e1c@canonical.com>
Date: Fri, 12 Mar 2021 11:43:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210311003516.120003-2-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 12 Mar 2021 11:45:35 +0100
Cc: tiwai@suse.de, broonie@kernel.org, stable@vger.kernel.org
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

On 11/03/2021 01:35, Pierre-Louis Bossart wrote:
> cppcheck warning:
> 
> sound/soc/samsung/tm2_wm5110.c:605:6: style: Variable 'ret' is
> reassigned a value before the old one has been
> used. [redundantAssignment]
>  ret = devm_snd_soc_register_component(dev, &tm2_component,
>      ^
> sound/soc/samsung/tm2_wm5110.c:554:7: note: ret is assigned
>   ret = of_parse_phandle_with_args(dev->of_node, "i2s-controller",
>       ^
> sound/soc/samsung/tm2_wm5110.c:605:6: note: ret is overwritten
>  ret = devm_snd_soc_register_component(dev, &tm2_component,
>      ^
> 
> The args is a stack variable, so it could have junk (uninitialized)
> therefore args.np could have a non-NULL and random value even though
> property was missing. Later could trigger invalid pointer dereference.
> 
> There's no need to check for args.np because args.np won't be
> initialized on errors.
> 
> Fixes: 8d1513cef51a ("ASoC: samsung: Add support for HDMI audio on TM2board")
> Cc: <stable@vger.kernel.org>
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/samsung/tm2_wm5110.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
