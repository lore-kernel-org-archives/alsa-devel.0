Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF150C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 19:54:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DF4206F4
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 19:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LrdJIk8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DF4206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CBBF684A;
	Thu, 16 Jul 2020 21:53:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CBBF684A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594929264;
	bh=wILV5KufGlLqxpvSMB+HYlNmiUBm7PW6b26u3pPvo5k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LrdJIk8Ma/IctwZPWeR5nE3C72MQb9M7qN4JF5faTYFbMfMclMVD3Y3MIMd1/aO7i
	 kgyekLX62ZGNXHqeTBVo+WPStaSmJio7wxfNRGb8bLOpaEsl3hkMcFgxxR6sYZ330c
	 zx9gWgFwN84qj9lX3L8bsxD6bj/VeDmFR0z5p0YU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F5DCF8014E;
	Thu, 16 Jul 2020 21:53:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0B3FF801EC; Thu, 16 Jul 2020 21:53:32 +0200 (CEST)
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10227F8014E
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 21:53:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10227F8014E
Received: by mail-il1-f193.google.com with SMTP id t18so6155935ilh.2
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 12:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xPJI5AUNc3GLpKlOl9E8pVIu2DWZ+nUPV7c3Fd1fTW8=;
 b=YigEyXpwilNxGNA6TN79E5tfVbfoJnzhhcA4QzQEKpnDFU5AjWx2W+c1JmCV/sprqd
 /WRKJWfgltX9vwTy1HI/72m3DE7KDqxmqoboiCo34bL6fJEqeqhGj+emQur3Fj8Rjqz8
 /aaeO84o5emLzYZYs/KczeqW+Ly3seP/FhM+DlJuhJl1yqN3e+1lnNpuRocsMrXbwRMz
 CsezSRytDA02al2SNWXYmq8tBbKjq3vX6naPwV+07wVuZAN0cl4T0L7ZCWA34GWa4m1F
 8B9a+dzFKby5ryRAGyQAgSFNEo2TteCX6RUgKHWpDzYa6hZTTHjUG89mRjhsy9JtnPVq
 u0ag==
X-Gm-Message-State: AOAM5305kEsxBj+G0bBWdgH2tuPOTfZOQmCkXdZz6npreBZfPfhSePDs
 fY2OP3TnezrvkBp8JCPMbg==
X-Google-Smtp-Source: ABdhPJwbtrb2hzcyMrDtMJ8lQQG2F77dP0WpMBde2WE/BUG6j0yjkG7KFC7V4dHYMGHTHGdG0n/9rA==
X-Received: by 2002:a92:d186:: with SMTP id z6mr6614069ilz.227.1594929204916; 
 Thu, 16 Jul 2020 12:53:24 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id a5sm3219354ilt.71.2020.07.16.12.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 12:53:24 -0700 (PDT)
Received: (nullmailer pid 2739233 invoked by uid 1000);
 Thu, 16 Jul 2020 19:53:23 -0000
Date: Thu, 16 Jul 2020 13:53:23 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 2/3] ASoC: bindings: fsl-asoc-card: Support
 hp-det-gpio and mic-det-gpio
Message-ID: <20200716195323.GA2739158@bogus>
References: <1594822179-1849-1-git-send-email-shengjiu.wang@nxp.com>
 <1594822179-1849-3-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594822179-1849-3-git-send-email-shengjiu.wang@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com,
 tiwai@suse.com, robh+dt@kernel.org, nicoleotsuka@gmail.com, broonie@kernel.org,
 festevam@gmail.com, linuxppc-dev@lists.ozlabs.org
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

On Wed, 15 Jul 2020 22:09:38 +0800, Shengjiu Wang wrote:
> Add headphone and microphone detection GPIO support.
> These properties are optional.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
