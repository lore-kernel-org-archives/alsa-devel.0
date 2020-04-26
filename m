Return-Path: <SRS0=mTWV=6K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C4C54FCB
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 22:22:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155EC2070A
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Apr 2020 22:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Cvf0Cn2v";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG2tQbWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155EC2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5707F9F6;
	Mon, 27 Apr 2020 00:21:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5707F9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587939756;
	bh=b64c4u9vDd94M89V0vTQXULnrhlOrBp7dhmkEbPDN9Q=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cvf0Cn2vZ6jfU1GaUBpEtBHjb+jviURQ8H+Vg0jewNNg7WZQ1T/FeiZAJ21niz3Go
	 8Y7A/TRvcF54Qxe8c7vZxsfb69bJlb9W3tX2KjKxRyN4ELdzA0OLKeujVACn6TyPxA
	 e8e0/7EXZeBuUsbaalwfTB1UoM/RvVaL/6uAEGB0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A238AF80136;
	Mon, 27 Apr 2020 00:21:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07123F801DB; Mon, 27 Apr 2020 00:21:43 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6674F80105
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 00:21:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6674F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="BG2tQbWa"
Received: by mail-pj1-x1042.google.com with SMTP id ms17so6605593pjb.0
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2020 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=87krT2AY3IIXSFmpZQdTxrUuwCEzZrT19IZOtMtjJGw=;
 b=BG2tQbWaMlVPecrCiNejX4J+DAsEwq/APzsWFxkCTwVKg1SnkZczk7YACoyXLZ10o4
 nqOR7c4BV9OI8ZO1n6K345K2LnClacAbTcsILMCgREgjEhsLMf6JoKpY+9RrRl5NquzT
 tObNYS/0C3jFnH0bJWzQnAILzhbwOp3ZP8f58+5ubUOOc7hvbNuTXhdpKN1UbpfMRRHC
 wbW/DIgwu6WV73ypUANjq8/tIfu6H9csMyASqls+/OMZb5FKY/YNBrgYaRsr7y5hksfg
 /oQOklkarLaAbJqQwFhTKCV6BlmQWYupLhYxHIx3sZ7/Qe4TcptJECFiZBN2EW8icX2Y
 0CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=87krT2AY3IIXSFmpZQdTxrUuwCEzZrT19IZOtMtjJGw=;
 b=DjZ2jJgiiZCsles9BDisvS6tAkNJfyOUYJzfs7Jr0Kkn2kw3v72W73MXa9ZgeHLsza
 MkRqlq5g3xmQczWkXI0ACk4w7wYoJ2thF83mHwss8Qn8pB/o+plJJc9gTvuNCKr/8oFq
 LYZWiJaPJxG8QG17y+57/hLqT7AN1BIRd/vzR++39aIEnUJJjTOaG3sfygtDupYB/Alb
 CuYWUH9we4v8Wpdikix3SMLtDNsDOj0V/omFdB5E5psuFdbOZ4jb/mHsfiE0dLHxNkPn
 UrRQPMAXD0Bq0bQORAiiMnko97vBb9vziLndPnNBy4TNBpLh52f0qNRTUS3o2OTN5VH9
 vvbA==
X-Gm-Message-State: AGi0PuZ4V0EJTA+HKj6+WoTZzglpLnjEhH8K9II75ZDvGxVxwrcu7E8F
 OESVvL/PdjVydoDJzAnwSek=
X-Google-Smtp-Source: APiQypLF/2t+K1/Ik2f9YAXqpwjsS1ALdwWoEoZ88bxnxZu874DYOblLKqaoFUIlehzyHcSlhLWwhA==
X-Received: by 2002:a17:90a:e28f:: with SMTP id
 d15mr19829287pjz.79.1587939693670; 
 Sun, 26 Apr 2020 15:21:33 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id f21sm10781067pfn.71.2020.04.26.15.21.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 26 Apr 2020 15:21:33 -0700 (PDT)
Date: Sun, 26 Apr 2020 15:20:51 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_easrc: Check for null pointer before
 dereferencing "ctx" in fsl_easrc_hw_free()
Message-ID: <20200426222050.GA28661@Asurada-Nvidia>
References: <d23c939f1c9eeb3fce34b6c34d44e2d6156f663a.1587799355.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d23c939f1c9eeb3fce34b6c34d44e2d6156f663a.1587799355.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
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

On Sat, Apr 25, 2020 at 03:19:29PM +0800, Shengjiu Wang wrote:
> The patch 955ac624058f: "ASoC: fsl_easrc: Add EASRC ASoC CPU DAI
> drivers" from Apr 16, 2020, leads to the following Smatch complaint:
> 
> sound/soc/fsl/fsl_easrc.c:1529 fsl_easrc_hw_free()
> warn: variable dereferenced before check 'ctx' (see line 1527)
> 
> sound/soc/fsl/fsl_easrc.c
>   1526          struct fsl_asrc_pair *ctx = runtime->private_data;
>   1527          struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
>                                                       ^^^^^
> Dereference
> 
>   1528
>   1529          if (ctx && (ctx_priv->ctx_streams & BIT(substream->stream))) {
>                     ^^^
> This check is too late, to prevent a NULL dereference.
> 
>   1530                  ctx_priv->ctx_streams &= ~BIT(substream->stream);
>   1531                  fsl_easrc_release_context(ctx);
> 
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
