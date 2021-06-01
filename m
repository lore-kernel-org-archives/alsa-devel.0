Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14146C47080
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 15:59:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E479F613AD
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 15:59:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E479F613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 881141670;
	Tue,  1 Jun 2021 17:58:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 881141670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622563176;
	bh=+Eve2pn68G1CH/H9L5BDFopyr5Iy9IWJJAag24k0n3U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZvR4fOTMxQ+x5iOksBlxBz8yxVOhCHIu6Jdb/Y+vc004NkrwJ0EOv7ANB78MEVw1P
	 tSU61GSoqJfFveI0r/3yYE3wclpsEMgGtSwOLmnddUXZcfcigc1QvMyGYQ2V1xyOSc
	 bBfAaJakiX6IlT66zGiyYxwyTdq4CV7X/osSrPPo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F79BF80253;
	Tue,  1 Jun 2021 17:58:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61C68F80254; Tue,  1 Jun 2021 17:58:44 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71CBCF800B2
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 17:58:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71CBCF800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="bZ9MxfqP"
Received: by mail-wm1-x32d.google.com with SMTP id
 l11-20020a05600c4f0bb029017a7cd488f5so2249690wmq.0
 for <alsa-devel@alsa-project.org>; Tue, 01 Jun 2021 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=DfdeHTGjcCYPTchbky8FXiwy44uVWCQdaNoLYkK3gGA=;
 b=bZ9MxfqPj25Sllazfq16qEXmkBVdfRBnrSCMmS/fJaDhTbPtW1VB2MzqzmNJhzv5xw
 MmhdUesnw7wu+B6P6xJd67gFVV638kzdxwAEv5/YF0bcWYJNpWU53+ZIzz4MDEf+BErp
 8wVKwB11ob2HGzwNsdAk2Y/p4t1aF4jftNHIpcAU0vmDB/IZxvnLTu8VP0+vPW9T47gQ
 NKJ3ag4Ega/Y3Im7My7v6rnJobGbT7hdQjZUcvfusme1CUNgEiPbH7dMda1V6sbelQ6A
 3hThdSAP29YJDsgr1HtKyMYB4q3b7EBvc0oDzI/UVtZdG5Qv0Or3oSkzx6g8s1IMoNn6
 PLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=DfdeHTGjcCYPTchbky8FXiwy44uVWCQdaNoLYkK3gGA=;
 b=Zdi9wIMJGqwpOPP9ixEYw0yfrOvFvgt65KCBReOtlyti3VovMMvLHQxvAOU4r0vBcJ
 yB4h/4QIa12Me/IVRl7DdSeky326Uu6B02iED3negsomTTy3A6TXZ98yUe45Jr+IG0zW
 g/bdD3rpfSS9Esump9AiLpsdevTWv6c9kIw+5vVT12SHuNBwtRj0EUodZHHe3Hmmw3RU
 v9BxfYFpjFSsb4L5TaIqUaHI3gAJjFl4c/t6X+vdJzPXAXHoaU+q7RAn5glrCn2E+3cK
 /BtXDccxPvVVVgM+Ss/qHoijtEMsI4G9f5uX8F5slDHQd8Ty/fjyKqcz9HNcsh6bgG38
 uRQQ==
X-Gm-Message-State: AOAM532OVr7IrWyjksVUNIF6AKJlpJk9hP2mXqJ0yPvtdFdYZE9hI8v/
 blBtF/cpqUyClBv55dzgcAO9Xg==
X-Google-Smtp-Source: ABdhPJxS4orObivxiUr7tCfWqSfkjoAv1xblsQUGN0WKI7maOGwBGJsigyuynzIzzbcA96eMcNrvJQ==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr12465034wml.29.1622563115864; 
 Tue, 01 Jun 2021 08:58:35 -0700 (PDT)
Received: from dell ([91.110.221.249])
 by smtp.gmail.com with ESMTPSA id e27sm4300744wra.50.2021.06.01.08.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jun 2021 08:58:35 -0700 (PDT)
Date: Tue, 1 Jun 2021 16:58:32 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [GIT PULL] Immutable branch between MFD and ASoC due for the
 v5.14 merge window
Message-ID: <20210601155832.GC2165650@dell>
References: <20210519203754.27184-1-macroalpha82@gmail.com>
 <20210601140145.GH543307@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210601140145.GH543307@dell>
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 heiko@sntech.de, devicetree@vger.kernel.org, tiwai@suse.com,
 robh+dt@kernel.org, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org,
 broonie@kernel.org, Chris Morgan <macromorgan@hotmail.com>, jbx6244@gmail.com,
 maccraft123mc@gmail.com
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

On Tue, 01 Jun 2021, Lee Jones wrote:

> I've applied the non-Arm patches.
> 
> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tb-mfd-asoc-v5.14
> 
> for you to fetch changes up to 437faaa6cebadf8ff4c2c28d7cb26ed4e34aeb14:
> 
>   dt-bindings: Add Rockchip rk817 audio CODEC support (2021-06-01 13:40:41 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD and ASoC due for the v5.14 merge window
> 
> ----------------------------------------------------------------
> Chris Morgan (3):
>       mfd: Add Rockchip rk817 audio CODEC support
>       ASoC: Add Rockchip rk817 audio CODEC support
>       dt-bindings: Add Rockchip rk817 audio CODEC support
> 
>  Documentation/devicetree/bindings/mfd/rk808.txt | 188 +++++++++
>  drivers/mfd/rk808.c                             |  81 ++++
>  include/linux/mfd/rk808.h                       |  81 ++++
>  sound/soc/codecs/Kconfig                        |   6 +
>  sound/soc/codecs/Makefile                       |   2 +
>  sound/soc/codecs/rk817_codec.c                  | 539 ++++++++++++++++++++++++
>  6 files changed, 897 insertions(+)
>  create mode 100644 sound/soc/codecs/rk817_codec.c

Looks like the builders reported a W=1 warning introduced by the set.

Would you like me to fix it and submit a patch?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
