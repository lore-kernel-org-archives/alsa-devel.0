Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B75C433E7
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 03:32:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA8B2072A
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 03:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XBWySZuc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh3AakFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA8B2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7B1C18AA;
	Thu,  3 Sep 2020 05:31:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7B1C18AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599103965;
	bh=te6pE1+iYGPtV0+OUGLduuP3rcgXdSsZHL0zma/+DTk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XBWySZucZ6ABwmZ/p/qjvFhza/tFrYIWwdikQ40RPArR4YlcjZm4Hh1oX7TJ4k0rw
	 LoLk/ytfiS8lLjMqRkWWM0bskUM6DNTJj1zRT8Ce6EsuDHvzRMe3QPTYqoFwrghPR0
	 bFFxzi/naKupAzAHAp+VC80E9uN4VCB58weCBOzo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5949EF8020D;
	Thu,  3 Sep 2020 05:31:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39592F80217; Thu,  3 Sep 2020 05:31:53 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B699F800BA
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 05:31:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B699F800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Lh3AakFc"
Received: by mail-pf1-x442.google.com with SMTP id o20so1083980pfp.11
 for <alsa-devel@alsa-project.org>; Wed, 02 Sep 2020 20:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jVbQJV7FQRWnjXc4WFRtSyL4necLOFwK41hOpTt0Y3c=;
 b=Lh3AakFc2ktTayAXJ3pnozs/7S5cR9pjcLsMH65p4Oypa4yVlDrB9sxuRsvs1ZqnJf
 m4Q0T8KEeVSiLJk58AEEWBzSDM22WlwCsu4r4uQ95h9GjGMNX3XSWrqAFEsSskncgFZM
 ZThvCDfsFIa0zcXzx+ihAjyoiDVREI78q1NU113ynXd6tHcph1oO0oWBDRxpkBAdG/Ed
 5wvVArnBumGOdJcZFzgCNkqry+qjE/zQjZv0i8Sk4f7qiZfT39t+qUXyf/Dcy/UONlin
 L/2zLZHpqboem355bgN5gcnEYmbfmbqBCBe+GU/vMmSTFIbKgsK/Nl4Z+5Utskgx5iic
 D6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jVbQJV7FQRWnjXc4WFRtSyL4necLOFwK41hOpTt0Y3c=;
 b=Nx6NgwXbAvLrXVQJaWaTDG2ZY3OZxHz6tIKD05slq4KGivCtDD2MfY1hlFFZahgA5E
 AXx3LWyvQH6M+EoThNep5cLkSxXiOC+EmV/DfBayQHbyycZeH9M+qgPv2u0h3A+ghnZG
 GkPBEGQ0gy8xXPkpEg9+xVhLVINrt9+9a24dju2xZccY+486wohgSjpTMyx8WVql8WVm
 NEDHK3+ubtrjivIGOp2QiQQEt1pZWnA8nS6j7UiK5aapp51dBbVt+symocmd3DemBsb1
 j86WX8Zn/PPpULarzse8wjOSxsA3BtGh8wH0AtZuuqsJ9g95ZCdpS2nxuNrfhHceZMmr
 8EvQ==
X-Gm-Message-State: AOAM530ON9DZZSKPkNw6B8aJe/PVfbU5y5n4WxaEB8Xb7frRf8u9ANdO
 6xjBk61BH4JDAP+PVN0OtWI=
X-Google-Smtp-Source: ABdhPJyeeNghFiK0krO7HS3KViJMyxOmRd6O6x+am6iTWrNYXrgGQ1ZUoP1V6uOaTIiWadIkyIrllw==
X-Received: by 2002:a62:ea01:: with SMTP id t1mr1699823pfh.125.1599103901928; 
 Wed, 02 Sep 2020 20:31:41 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id x22sm1047250pfn.41.2020.09.02.20.31.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 02 Sep 2020 20:31:41 -0700 (PDT)
Date: Wed, 2 Sep 2020 20:30:57 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Support multiple data channel enable bits
Message-ID: <20200903033057.GB4517@Asurada-Nvidia>
References: <1598958068-10552-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598958068-10552-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 broonie@kernel.org, festevam@gmail.com, linux-kernel@vger.kernel.org
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

On Tue, Sep 01, 2020 at 07:01:08PM +0800, Shengjiu Wang wrote:
> One data channel is one data line. From imx7ulp, the SAI IP is
> enhanced to support multiple data channels.
> 
> If there is only two channels input and slots is 2, then enable one
> data channel is enough for data transfer. So enable the TCE/RCE and
> transmit/receive mask register according to the input channels and
> slots configuration.
> 
> Move the data channel enablement from startup() to hw_params().
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
