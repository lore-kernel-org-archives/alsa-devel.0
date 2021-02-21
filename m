Return-Path: <SRS0=DIAL=HX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C048C433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Feb 2021 10:56:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F6164E24
	for <alsa-devel@archiver.kernel.org>; Sun, 21 Feb 2021 10:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F6164E24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF50A166A;
	Sun, 21 Feb 2021 11:55:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF50A166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613904996;
	bh=AmrdEjEZS0RScZGXH1mefuqeHWqENbPRSsAg5pVSKzE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iQaj6Ul9xCn8LXa2z5u+LFpjBS7M5tJXiSyRKBAhME9LX2Z/2CZH0G8JDjxPR1qAP
	 D9Yyyw2gwtsTCdpHkwKTcOaKB03y7yd8zsyOTp9UxIx6KzTYBjecFtuxJxJuLZSuB8
	 z39fHH2AXuZQlqdwD26sDKYOJVF8811H4FtiVAZ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D043F80082;
	Sun, 21 Feb 2021 11:55:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3B4B1F8016A; Sun, 21 Feb 2021 11:55:45 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A64EF80082
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2021 11:55:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A64EF80082
Received: by mail-wm1-f41.google.com with SMTP id v62so11724303wmg.4
 for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2021 02:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=83EXuSvMuykJ8+eRW2lqgiLnsfboHJCFOVYV26UiUA8=;
 b=AEVGom++Ecm4tV/vIvcd3JG0UetLXlA5XCRAm86MT+XTqIdt2FKgh1amHa1PhBHoLI
 HEsMBox7uBX7wybahsxuiBhywL6HjuHTZEcS4Ed83eH6T+0FBp3V6OtlM0u4SbmdeknJ
 bLaIfLntzXIrkZlX1tPLeeGWdw/bnojIRigfIDMO47VFQo7ebSrZSGE0Ue5vHZcJPyOi
 uRbPW0i/5LC1vAUWzb/C3GxkGQapXSka4LEq6k+FdWgNo+wVADFx0QEfu0wi4brYGsxM
 BHl2w90bp3obS/ZLua3SNpLSvtxLboCPFeW4Ayf2gxd62aQaH79yHxLRZHxnUPo84XcD
 UAJg==
X-Gm-Message-State: AOAM531k76ECQp85c2JsF32eLQBKA+LTCOxxwrj5UCB8TRYskigtHF3Y
 Aq9FOvWobxW5u8hXCB2LHr/3ef4nSok=
X-Google-Smtp-Source: ABdhPJx/g9eo3TwGYShoBzpeRqhJzob7SWhmzLxJFtuaa5YWFhWpvIn/lbD6TuIMsUY4FvjLVpF4tQ==
X-Received: by 2002:a05:600c:148a:: with SMTP id
 c10mr14132221wmh.158.1613904937021; 
 Sun, 21 Feb 2021 02:55:37 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id b15sm23108063wrr.47.2021.02.21.02.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Feb 2021 02:55:36 -0800 (PST)
Date: Sun, 21 Feb 2021 11:55:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/6] ASoC: samsung: s3c24xx_simtec: add missing error check
Message-ID: <20210221105534.2kfjyywhboxx3gh3@kozik-lap>
References: <20210219230918.5058-1-pierre-louis.bossart@linux.intel.com>
 <20210219230918.5058-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219230918.5058-3-pierre-louis.bossart@linux.intel.com>
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

On Fri, Feb 19, 2021 at 05:09:14PM -0600, Pierre-Louis Bossart wrote:
> cppcheck warning:
> 
> sound/soc/samsung/s3c24xx_simtec.c:191:7: style: Variable 'ret' is
> assigned a value that is never used. [unreadVariable]
>   ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C24XX_DIV_PRESCALER,
>       ^
> 
> Looking at the code, it's not clear why the return value is checked in
> the two other cases but not here, so mirror the behavior and add a
> check.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/samsung/s3c24xx_simtec.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
