Return-Path: <SRS0=iQjD=KU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EC6C4707F
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 08:01:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3A4613F4
	for <alsa-devel@archiver.kernel.org>; Tue, 25 May 2021 08:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3A4613F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B6C8847;
	Tue, 25 May 2021 10:00:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B6C8847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621929699;
	bh=gchEmDe+oRb5ftX56FYGhtL1CvMT7RWbmjwlMqhvjpU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R7eB94DCQAsNmlCGTVqwxapqgDw+0LBc/yn12gzzs9n61eK74WwEeD+K83gyd77Qf
	 s/c1KMZdNVQvHG1EDZSYbYswvkgtfM76n4jrlvajLQmkDOOLy6LIjriTscThjjuaXG
	 DJ6KmLv6GfU+A0MGLhNWvFa+/IbgnrvSn1Uw8wqo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7253F80113;
	Tue, 25 May 2021 10:00:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20A47F801EB; Tue, 25 May 2021 10:00:45 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D2A4F80137
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 10:00:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D2A4F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Bi7XQPY7"
Received: by mail-pj1-x1033.google.com with SMTP id g24so16331796pji.4
 for <alsa-devel@alsa-project.org>; Tue, 25 May 2021 01:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=gchEmDe+oRb5ftX56FYGhtL1CvMT7RWbmjwlMqhvjpU=;
 b=Bi7XQPY7lQeZ1QeotVdNrHHmJLkgHfcPqD9lmKjLdCUm/nxRHTqSWYG3RsDvFHxx0E
 Lm27iXNs/aKXKr+vV6Qro6rEn8XRMyXirp2LEgmycG8kNfzwLaOHgFyVCmMrnXv9pc5w
 DdDmIcrm+iByZDuLXIL3hjAiVrAjRrNM9S1gFbzXuW1Dl8PJRvOH29SsQsIZ4MSilB07
 +Swy/7dXSJbSDqK2Q5WE6tp+mhyeDtdoJkCxBTw8D+KPbLDBzhvXRBjn7SS4QGjrGx3+
 DZwlPtBCijqVJQukA5nPxjWBj85w50LgtamyBkPtIX+nnAzUyK8lQLPeA3eN/uzO69VC
 rhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gchEmDe+oRb5ftX56FYGhtL1CvMT7RWbmjwlMqhvjpU=;
 b=JQlz0zwyqknPLFh70TkM5LdfeE40xdIApcmuH4bWPmZOiGNv7Fy8MR69oPftw9K/Ec
 r62q9ad63b+wa5GgHKBtcdO+0nqCJq+iKk9zDLqut1CkzNT8Pww85L1z4uL74E0tgCO4
 hmR0PAXg72lwOweVrlziIR94upg6ryXXwx5Gl5ixPVg67bizY+Zmqwr7b6xkfRrYaiXT
 XDTS8HUkNn25wJQ8crqQ1b8/jSe58GXBlGkBM8qWsOm69Oe0KtjA1hdNJDCfxGwoaB59
 QScsRkPADGRn50Ank/iVXM2WY9xygPqTEnidQIF9mT1WW6VFjTwxvCH8yNwMKjObpq0X
 fl2A==
X-Gm-Message-State: AOAM530Hqzh2O/q0GSXlO/GTJ2rN7/dIEV5nveeSjlGog/k8jufNHvAN
 pKFntYSjebVpF+a7elXLch4=
X-Google-Smtp-Source: ABdhPJx73Fq00enLr2aONG1g9uC31io/Xz1z6wNY0U7uPc9dCIWSZYNTtyEJF8LTaSHfc8H32cRQMA==
X-Received: by 2002:a17:902:7795:b029:f2:63cb:ab16 with SMTP id
 o21-20020a1709027795b02900f263cbab16mr29180113pll.7.1621929639029; 
 Tue, 25 May 2021 01:00:39 -0700 (PDT)
Received: from hyeyoo ([121.135.181.35])
 by smtp.gmail.com with ESMTPSA id b21sm9699790pfo.47.2021.05.25.01.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 May 2021 01:00:38 -0700 (PDT)
Date: Tue, 25 May 2021 17:00:33 +0900
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: line6: Improve poor error handling in
 line6_init_cap_control
Message-ID: <20210525080033.GA13895@hyeyoo>
References: <20210524173644.GA116662@hyeyoo>
 <s5hh7ire1jq.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hh7ire1jq.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>, Takashi Iwai <tiwai@suse.com>,
 Vasily Khoruzhick <anarsoul@gmail.com>, linux-kernel@vger.kernel.org
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

On Tue, May 25, 2021 at 09:05:13AM +0200, Takashi Iwai wrote:
> Those resources are freed in the common destructor of the card
> instance, line6_destruct(),

Oh my god, I missed line6_destruct.

> at disconnect callback, so it's redundant
> to release them here; even worse, since you haven't re-initialize with
> NULL, this change would lead to double-free.

Yes then it can cause double-free..

>
>
> thanks,
>
> Takashi

I made a mistake, I'm so sorry to take your time...

Thanks,
Hyeonggon
