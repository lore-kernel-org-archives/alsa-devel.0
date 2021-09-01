Return-Path: <SRS0=HqWb=NX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8129BC432BE
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 06:06:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C23E60F4B
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Sep 2021 06:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C23E60F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=flatmax.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB0DA1759;
	Wed,  1 Sep 2021 08:05:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB0DA1759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630476367;
	bh=q9aU6qEMyKDbFhk9jTm4zsYvIlsTWN4gpWcf1Ob4O44=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GMVDsXHjo+GGAOA/uwH5iM6Xedc60qiexJXAmX+9/4C8fB6hRXpzhGVsJAntN8xk/
	 kr+AXT+gQ6Kpmd5+D7SzY/hu/D3PquNbnhqnQ+4A/QGo+USUwCDjUzJvHfUK7kUP3K
	 a+vM0LViOHJk3eCdfrBb1YbIxSz1vydKmGLOwR18=
Received: from vmi242170.contaboserver.net (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 66D0AF80227;
	Wed,  1 Sep 2021 08:05:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1B93F80254; Wed,  1 Sep 2021 08:05:10 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B539CF80171
 for <alsa-devel@alsa-project.org>; Wed,  1 Sep 2021 08:05:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B539CF80171
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=flatmax-com.20150623.gappssmtp.com
 header.i=@flatmax-com.20150623.gappssmtp.com header.b="yi5+wBzc"
Received: by mail-pj1-x102a.google.com with SMTP id
 j10-20020a17090a94ca00b00181f17b7ef7so3821376pjw.2
 for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2021 23:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flatmax-com.20150623.gappssmtp.com; s=20150623;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-transfer-encoding:content-language;
 bh=jWUwO2YlItopWkgXjW88CUCbL+38vBcIyZUyWa0Z+QQ=;
 b=yi5+wBzcKgOTlxM7iRJSrlp/PKi+yYDwR9Dg89JRRzLEn6PadFr7ddkneOn3Hy9zP5
 Zyyk4uHpXNgXqM6B5qk9DUgeFn5fcnlrFlYs4gzhaQP5udbxpjQOH+juI9ZBncBj0/LK
 t1Rx2xq7hNZDuk3Sgkyp9CpSkeMbSOuBOw71CNgM6jJXtQR4EGYGL6SYwWg+h0VAUhzB
 2/kDziYMbMs7pAhrEG07jkrpiBaGvYdY8rpJgiD4j3C9aBL1N1F3ou5BD6S5IkJZx9sr
 lFXsf95gLwxslVe5pSE7nOyb/BYxk6+RL4U0chq/+54T45ez0eN6rIU1OSxnf+qCKcri
 oc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-transfer-encoding:content-language;
 bh=jWUwO2YlItopWkgXjW88CUCbL+38vBcIyZUyWa0Z+QQ=;
 b=GFeVvnIodQwiwG13RznJ+Y6tK961Ud1A/nhOrWYzS1cVJwSqTc0OEhvyOrDryVBzDs
 h2/h7qrij8WpjTO7xHnFqZtJenk1k9Z6THWMndKK0OGl1Umn6qPhHA1Gy25/1QZ+PHFf
 9LKjng+JtrrCiwf/JFVFBbcV5EZ+TMUPgfroqQpcrRJ7fWdp2AKZ9hPtKGMeUI6+7gw3
 kAbyaqCGBirnhYInfTFl6jtyHx6wsBy6tSP1LN3ZpeGyd1DYczCXdxWwoLlYRkuNP0RC
 0ldcFN5AGsZTHbJsphv4R+hXIiQ9FQl+RiGFiT+bE+ZZnSHTy7PoA2xzmcTserRhTNk1
 lDEg==
X-Gm-Message-State: AOAM5336ltALQFYI+0L9Uyk1pmgL2sB95tE4MseP51l0++IyY9iDrxNe
 78jwgtN8ORoLCGuDqwUl0AncGC1trmM0p53H
X-Google-Smtp-Source: ABdhPJzszt59M0oc8lMTTmPsjHsU/knrkx7DkJR714tNeeWkTKdHVQL1CHS+OzE5NkXRM7wjAPu95A==
X-Received: by 2002:a17:90a:4d8d:: with SMTP id
 m13mr9718965pjh.190.1630476299158; 
 Tue, 31 Aug 2021 23:04:59 -0700 (PDT)
Received: from ?IPv6:2406:3400:213:70c0:9df6:7e57:88ce:1bea?
 ([2406:3400:213:70c0:9df6:7e57:88ce:1bea])
 by smtp.gmail.com with ESMTPSA id x4sm4705261pjq.20.2021.08.31.23.04.57
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Aug 2021 23:04:58 -0700 (PDT)
To: alsa-devel@alsa-project.org
From: Matt Flax <flatmax@flatmax.com>
Subject: external plugins and openmp
Message-ID: <50617aa9-6856-a8da-d79c-66612efd088f@flatmax.com>
Date: Wed, 1 Sep 2021 16:04:55 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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

Has anyone succeeded in using openmp with ALSA external plugins ?

I compile using the -fopenmp flags however I can't seem to increase the 
number of threads beyond 1.

Matt

