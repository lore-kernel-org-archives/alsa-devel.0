Return-Path: <SRS0=n32M=CG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D5BC433E2
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:48:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E375920665
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jXlJiI36";
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ubpnrgUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E375920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D04116D5;
	Fri, 28 Aug 2020 13:47:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D04116D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598615311;
	bh=0rgWnTQDvI1gXzP6f1KUEA7XQMmKc15LrspHZkX5wa0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jXlJiI368uIikLqJKK8t43D661WhggPswdyPzrFUua4a/Wao1g6lq9QIA/ma6S5RA
	 4UYx0IH8qDMOxRRyCTuZCEUk2Kb2TUoLF/0L5L7rswnT1i3+LTQXMkp4MF5Npf6BAY
	 a7AuQ2HBBEz5F5ja6Q8kXj8ZSlv1NsXxnVYAigx4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39FA8F802E9;
	Fri, 28 Aug 2020 13:44:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8BE0F8016F; Fri, 28 Aug 2020 13:38:29 +0200 (CEST)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A22FBF80118
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 13:38:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A22FBF80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="ubpnrgUr"
Received: by mail-lf1-x142.google.com with SMTP id v12so529040lfo.13
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2020 04:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QABqAEN9ubf2NHgDZksbNeh9dKG5mUkpgI4WfwhV/hA=;
 b=ubpnrgUrfsc6DS+Ol5TKTd9d+pf5xWaPwj+2VPJbltNqex2/EsMZ3vC+trlpUhPZ3j
 ljw3EgEddYgw90LCfDCx6KH/2adNxA7Ej3fA8luAXpLMJ/pGKFfcSNqPV1qPmlhy/vLC
 IGqb3hqIF7dBbKemHM2R1ECLnJAuLPIBLj+uOM9wA2F27sh+crd6SNclO/tjf4J0198J
 Sk6M/RGdXzbtZ7gQ0O2bP0+UNq1USklApCCG9Rd6VrIj68wa8bCOAHc9AuklkWRBrtwT
 qthGFetFWHYg3isTmKkm9yfUv8nYtozKfjqoYKjejm546i4gbQiYX2pnlSVvwMAMPSsn
 YjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QABqAEN9ubf2NHgDZksbNeh9dKG5mUkpgI4WfwhV/hA=;
 b=kdrJ3XEynkohnV+HH72Iisrk8y2ppYTVwOYOtpK1/tWj4p5IEzaxKAn9wUtGEVU7ez
 u96VL3Gn/Vt/3U9qg5/IvEwu1HD9x+2GVQVOSN7sLEdvwLf3sMOeku2gWFsgzSHX7nI8
 XKMDcuFd8mEHBNcZCCxnnli3UG1yGM472zjznP6t3mWsH6S/KgdmQPwrafjvMkIQnK2L
 4LdUXUrBtzmhGgCQtC9pyzaCQ1SZLQ0aJnUAtY4la195aVsGLzvYrpjbTPOY2VWMmGfb
 +JDDJ+iDNMoMiUujP0wwaLG/7ZRenzsmyi+ZUC9xoLrPdWApOTIDeB06iaX4YNTbLBQ7
 cJPQ==
X-Gm-Message-State: AOAM531vnuMrsvzLHBdf79TbzRy5CTEszF72YU4ENtRyzXI/3dz6g9jN
 lD8TXVlLw9TAJE0hbKq4eXljJQ==
X-Google-Smtp-Source: ABdhPJx5UJ7GVY+ckdTPuBmifPbJ0bATZCsZHPpTBj9Dmo5Oc4pjZat3HPMK/LM9ihQqlJC6+nAg0Q==
X-Received: by 2002:a19:8856:: with SMTP id k83mr596593lfd.131.1598614701453; 
 Fri, 28 Aug 2020 04:38:21 -0700 (PDT)
Received: from [192.168.1.211] ([188.162.64.62])
 by smtp.gmail.com with ESMTPSA id f12sm153880ljn.14.2020.08.28.04.38.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 04:38:20 -0700 (PDT)
Subject: Re: [PATCH] ASoC: core: remove artificial component and DAI name
 constraint
To: Mark Brown <broonie@kernel.org>
References: <20200827205100.1479331-1-dmitry.baryshkov@linaro.org>
 <20200828105354.GD5566@sirena.org.uk>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <190cb4fb-44d9-cb70-f3dc-f8285e6abebb@linaro.org>
Date: Fri, 28 Aug 2020 14:38:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200828105354.GD5566@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 28 Aug 2020 13:44:03 +0200
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
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

On 28/08/2020 13:53, Mark Brown wrote:
> On Thu, Aug 27, 2020 at 11:51:00PM +0300, Dmitry Baryshkov wrote:
> 
>> Current fmt_single_name code limits maximum name of a DAI or component
>> to 32 bytes. On some systems corresponding device names might be longer
>> than that (e.g.
> 
> Are you sure the name doesn't get exposed to userspace through a field
> that's 32 bytes long?

Good question. From the first glance the only place where the names are 
exposed is the debugfs.


-- 
With best wishes
Dmitry
