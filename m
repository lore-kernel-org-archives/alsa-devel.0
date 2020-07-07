Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6ABC433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:38:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24D252065F
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tmnrMwZO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N9v65sF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D252065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3A44950;
	Tue,  7 Jul 2020 12:38:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3A44950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594118337;
	bh=v6WAZtD7JpuzWpeL2+3I4pG5Ry/cXGafUR8qBW1i0iI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tmnrMwZOP/wTax/gTd5wD3C+YRV4/7ObSjWe9cGuqBujwtHYUGyE7y/NEm7Cpm/sQ
	 FbHexF45Bcwnar2c1OEBpAsXnldF0VO607jEnl03+lT9o7gzVixDwSOresvL5eGCEv
	 NdEDRbLg7VimwmvZs5viaTFyROa55yB7A8ZwTUhA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED33DF8011F;
	Tue,  7 Jul 2020 12:37:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6AB1FF800D0; Tue,  7 Jul 2020 12:37:49 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA7D8F8011F
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 12:37:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA7D8F8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="N9v65sF4"
Received: by mail-wm1-x341.google.com with SMTP id o2so45952201wmh.2
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 03:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=mf3pdpNIYNXuepMWI1ZHXgBTgUZ+8BAmloxxPTENvW4=;
 b=N9v65sF4/0TFzZxvu1mwNmZUyPsKVIz1bvlkKprtt6x1BOWiWIsW6T9PJlF0Bro0Us
 mv5kif1e3dop0XL82JEO2Sycq7Ena5HyXwiOMYNWUxU6FARVX9tuEQw7+v1FXZb+r6Zy
 c+Ja9NnwvnSzNLPDLl1tb80wcWcNhEAglvbMpM/wQPfxLDly4hniWSgKnQvBiAHs4csm
 RxT69psZIJsDKuYEpbIUVCS7ghJ5iYDRjFqWrSB2uxm4qKon5cNJRxoaBRzUZfHPrAcN
 yqG7IYc+n57t0HzS5FYD9iPTxWn9fMNXsgguyMu2LO4i6tevw5p1ki7MvCyg7MkvxZxl
 J9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mf3pdpNIYNXuepMWI1ZHXgBTgUZ+8BAmloxxPTENvW4=;
 b=olGbYxSryLrj0VuYqPuTtrTx1cdPkrgIaYKIIFbvknDEpKrb2KifvPGIag7t44S1SA
 JhXeQIKRyKcit6VosKPxV+HndqnOqNiQ2hyISTgUHuQ9KgVSAUx4PdW9KlReo7Ro0AoX
 gNLmFSPPMbRgenMMBW/86xnw25GQYE7ylfA6PAQcZAakBqSFQvXqJHxw0C7Q86KbXGJL
 IwmxxhI1iT5TSuZ0NeStSE8Jt9+4k8PXbVjH0O3yRwWoYc3GwAnyOcab8PM4KVdAh31H
 En/iPAhZSciQvwu3/OcBjKNO0kFTaUESCm8mOq4BLPjzir03DxJJHp8hiU8GSqQ3AWgT
 AhIw==
X-Gm-Message-State: AOAM530hqr/rSM4aRKHtzxv8HeR1PxauXsJC/wAAnBHtYs+1vxw7CJEf
 DipN5yqI4trRoCVxfHVk7EXapg==
X-Google-Smtp-Source: ABdhPJzzy9gogmGmZPdl41qneqg70g9FMVK/Xo0I5AodHHhUPYLf7EJqRbWe7GoWHL8uThYGwnoLow==
X-Received: by 2002:a7b:c406:: with SMTP id k6mr3398657wmi.130.1594118257863; 
 Tue, 07 Jul 2020 03:37:37 -0700 (PDT)
Received: from dell ([2.27.35.206])
 by smtp.gmail.com with ESMTPSA id j24sm510160wrd.43.2020.07.07.03.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 03:37:37 -0700 (PDT)
Date: Tue, 7 Jul 2020 11:37:35 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/28] Clean-up ASoC's W=1 build warnings
Message-ID: <20200707103735.GG3500@dell>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
 <20200707101915.GC4870@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200707101915.GC4870@sirena.org.uk>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 tiwai@suse.com, linux-arm-kernel@lists.infradead.org
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

On Tue, 07 Jul 2020, Mark Brown wrote:

> On Tue, Jul 07, 2020 at 11:16:14AM +0100, Lee Jones wrote:
> > This set is part of a larger effort attempting to clean-up W=1
> > kernel builds, which are currently overwhelmingly riddled with
> > niggly little warnings.
> 
> Please coordinate with Pierre (CCed) who is also submitting patches for
> this issue, there's a whole bunch in flight already.

Well that's frustrating.

Some of these issues have been present for years.  It's quite the
coincidence that we both submitted these this week!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
