Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AAEC47083
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 07:03:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3B66135D
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 07:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3B66135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 774B816DF;
	Wed,  2 Jun 2021 09:02:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 774B816DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622617403;
	bh=PLARtuZaVZLi/9kl4OhmrhsbSKPUPEaE/C4tCAhsdFs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bFmFKlTLhlLPy4MJ9rTZs1py2SnAzSXvwr4M4nbEXaSEeCxJ2MpI2h+H/Hqz/mT12
	 cdNXknlMml8zlvzA5f+JYu7oWphLOADl7gomSe+5zPjjOPgd7U/KwsTVh4uDI+76ym
	 wTN53Lr92Xcg+w7aJIrZzYnrmwWQGEFcn+HFuAZI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 18B77F802A9;
	Wed,  2 Jun 2021 09:02:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00DF3F80424; Wed,  2 Jun 2021 09:02:31 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 87478F80103
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 09:02:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87478F80103
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="TyBmDWxY"
Received: by mail-wm1-x32e.google.com with SMTP id f17so539090wmf.2
 for <alsa-devel@alsa-project.org>; Wed, 02 Jun 2021 00:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=I2YDeFUanCg/pgan1aYlo4dp/IlnP/elTacPpIAPqQM=;
 b=TyBmDWxYKFC3qvRZJgxpGRuxNoysigaH/RAM3D4jQP4qy5Yinnsyf9O+voLa7FfE4S
 aX7dy8rHDITQf+/rGlqoQ8jpVuuIpAPPTV73619jOkWAAjDDK4SSob4HYiVHNl0k1wly
 if7UXApaH1EmzSAgw6srLLFeenzO9i2BHPKHxblfNAbRiBX/dSf2yEqpcAiThbmEtnme
 EN27zSQKC/PGa0TVAk2GlmZPhMmGbc30kOWDNd/QSPOegvb8T9PBxZODH4/GjVtFwet2
 oUdP5NVcmU2GfS46gPmEMJh/yZhiHJ4BJD3U473r037WwQhkNKPfrwo8wD31eLg2aFv4
 pE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=I2YDeFUanCg/pgan1aYlo4dp/IlnP/elTacPpIAPqQM=;
 b=XkA1t2nf3rPf7S3mKW4nWmWV1OPVs2Xzu73LsbqT5FIQvHEdRc6xMWyyNKk4CBoesl
 Iqv4rSelyQ+h6cy5IQGaCfaadus4MyXpS9CO4O/exhjmZ73H3DogIknrjihKnh6gK8wz
 TNER52YoLL1Hgf4dhMcSN/m9lrrwIipsgN7iRWCUbSz8bTQZwGppxmlTgKb184mz3/Z5
 O60aTIFsQHX8GcLZRKB9UtI6D436E3JJMzhVg2sMoK5ehKmf/yBgppqiGR7XDZ+vVfyy
 Dc7crprdY2AQ2me+9g8y86ZsAeXJJAouP2X3jzK/ipHkldJOT9vBNJ1PqOv5msVY4NTx
 nikg==
X-Gm-Message-State: AOAM530gT/LKfhwFHDWC9l1IFL+ueHD78QvZP0zFOVMYDcZrrCiFlGEf
 RWjF7+F05rAGO+OoYh502ZPljw==
X-Google-Smtp-Source: ABdhPJxkpzuIkxq/UzbNEPcxikIiBU1LLWTK7nwRLytD5ezE17H6HD6nRf1jPUKLxu53q8oo8x9BsA==
X-Received: by 2002:a05:600c:1913:: with SMTP id
 j19mr3537325wmq.167.1622617343177; 
 Wed, 02 Jun 2021 00:02:23 -0700 (PDT)
Received: from dell ([91.110.221.214])
 by smtp.gmail.com with ESMTPSA id z11sm5482193wrs.7.2021.06.02.00.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 00:02:22 -0700 (PDT)
Date: Wed, 2 Jun 2021 08:02:20 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH] ASoC: rk817: fix a warning in rk817_probe()
Message-ID: <20210602070220.GC2173308@dell>
References: <20210601214424.23432-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210601214424.23432-1-macroalpha82@gmail.com>
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

On Tue, 01 Jun 2021, Chris Morgan wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> The return value of snd_soc_component_write() is stored but not
> evaluated and this results in a warning when W=1 is set. Stop storing
> the return value to be consistent with all other calls of
> snd_soc_component_write() and to remove the warning.
> 
> Fixes: 0d6a04da9b25 ("ASoC: Add Rockchip rk817 audio CODEC support")
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  sound/soc/codecs/rk817_codec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.

Mark, I'll send out another PR shortly.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
