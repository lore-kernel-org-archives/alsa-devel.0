Return-Path: <SRS0=nXTK=HZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB56C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 19:42:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6250E64E6B
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Feb 2021 19:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6250E64E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADFE1167A;
	Tue, 23 Feb 2021 20:41:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADFE1167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614109363;
	bh=yOcFLrHwE4GZlLqKrm18vjxZfgy2CmBDOxaEg5KyM0g=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ErnlwxavKiSfkgLo09P4h0DqwApbwa3a56KLZ8R2aB6V56btgPh9zD4D3my87DOaw
	 lG+fuS/1aL6mOHln2C9TffnpmpkPPaP+bMbBvvhFi9vfNlydigbBOyXN0Wbilws8KO
	 u1TGvyDbiNdZMAadriIi5pexYGUGgxgCnklZ+xZg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36967F80169;
	Tue, 23 Feb 2021 20:41:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A71B9F801F5; Tue, 23 Feb 2021 20:41:51 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9B849F80169
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2021 20:41:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B849F80169
Received: by mail-wm1-f45.google.com with SMTP id p3so3549428wmc.2
 for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2021 11:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wXxkd63d9iWoeygkWevR6jM6NN3y+t2NfzbBFoAkMlc=;
 b=CoaHlTMLym53nHU8if/5RkmYhvTmsexppedZRW81pHaj2QYRNX8ex7Av8kuFkAz9kH
 aiP3TPdTKiilCGwmK6EuSiHTojeNRStz/0TVsKqnv/f4yQS3C5TshoWplOT/TnoN0Nyr
 9fO9cXW3Prnhd8bWxJWbMPd0+gVm2k6WwY3Du0oQXtoC4B8pTQ79S30F5wjJJk+IIrFP
 DQqjMiB/KyGAfp5v7Oy6ds0DKXiE72XDmc2cwSYlWAGUZ/dh9dQ1/pjDAtbOGoiYKE1U
 v6+Tr7+i6Au2fPEsqQgvHd/e0GMeTzVqCk4WUi8/QnGLkGmIgByg5nszDiHvz790J3EH
 fi4A==
X-Gm-Message-State: AOAM530GVabeDrHcBUQJ1u8+yW58PgHbV2AowEGbxEjmAH1E5NOd69j2
 VVMoTG7sdgijivFO2f3Se60=
X-Google-Smtp-Source: ABdhPJzfArPVSlQ9vovanqud4afk1eWHBghAIfoOAU8L+iFa/J2R7/SCtHQEq0FE0aKHe2lreS0Hig==
X-Received: by 2002:a05:600c:2e43:: with SMTP id
 q3mr296478wmf.143.1614109305046; 
 Tue, 23 Feb 2021 11:41:45 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id b83sm3957102wmd.4.2021.02.23.11.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 11:41:44 -0800 (PST)
Date: Tue, 23 Feb 2021 20:41:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 6/6] ASoC: samsung: tm2_wm5510: remove shadowed variable
Message-ID: <20210223194142.vwksklelntkncpaw@kozik-lap>
References: <20210222213306.22654-1-pierre-louis.bossart@linux.intel.com>
 <20210222213306.22654-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210222213306.22654-7-pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
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

On Mon, Feb 22, 2021 at 03:33:06PM -0600, Pierre-Louis Bossart wrote:
> cppcheck warning:
> 
> sound/soc/samsung/tm2_wm5110.c:552:26: style: Local variable 'args'
> shadows outer variable [shadowVariable]
>   struct of_phandle_args args;
>                          ^
> sound/soc/samsung/tm2_wm5110.c:504:25: note: Shadowed declaration
>  struct of_phandle_args args;
>                         ^
> sound/soc/samsung/tm2_wm5110.c:552:26: note: Shadow variable
>   struct of_phandle_args args;
>                          ^
> Move the top-level variable to the lower scope where it's needed.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/samsung/tm2_wm5110.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
