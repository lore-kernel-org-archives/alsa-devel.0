Return-Path: <SRS0=y7O6=KN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F75C433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 01:10:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F4D613BB
	for <alsa-devel@archiver.kernel.org>; Tue, 18 May 2021 01:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F4D613BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5C6A166A;
	Tue, 18 May 2021 03:09:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5C6A166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621300242;
	bh=R1x5dqNg1d9tk642TaPPxeuTQ3iVG0vTqjrrenXghdI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q5lXzPSSWVWfh3os63QTGR4Xv49Pw4zKGv5ONR1zdJofkf1eQnYXnF4OZpQz3mGm7
	 J+JBuaog3BCpzHzBuVrbE57DAnsmavB7OuMd3ZOOy9eLPNfCYy1phmuDREIauoo6pt
	 LSposE6YGeFk9rlEL41beN1LEz57F1wYyMfqniOk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F845F8016E;
	Tue, 18 May 2021 03:09:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 088CAF8020B; Tue, 18 May 2021 03:09:51 +0200 (CEST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD746F80082
 for <alsa-devel@alsa-project.org>; Tue, 18 May 2021 03:09:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD746F80082
Received: by mail-oi1-f176.google.com with SMTP id j75so8204859oih.10
 for <alsa-devel@alsa-project.org>; Mon, 17 May 2021 18:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JNWjXggEu8J9sL5ZhoPZyw5YSW1iHpwfijjTjQ6C7Ek=;
 b=kqaUz3yAmkLz+jW89jTo7+WdKWsAMUmFJ8xX5KCCtcmJK+plCs+cqTILgyJEzhBjpj
 01C3SQGXYb0N13/i6nEtzFPNEmJr36XOoBqJ2LMBbqdlky6JvYOYSmd5e65fsVrb4o/B
 SkGQ7GVWTHksOcuNx2yxRVu3R6NOHCgEkdWKpi/Xn1Fp/seJTps5DkhvA6X5bE6CntSd
 7/TPjp6R5zfS/e3W3qUyUoPKgv61grAhllmvwAFXyEdHi8BxjeKY6DPJYCBQ5x2M6nNM
 zdy80jyvjbjSG9J2VAt59uHCeWcdkEKfkMhApIV1rcl78nrO3Yj2IsTcaeTHnMfJ6Wav
 xzzA==
X-Gm-Message-State: AOAM530QOq5GYXPm1EewPWhhI1darqwuHZnRwskBv2dkUqgIBs4kPZ5w
 HJMYT4ujEYKBTWzunJrddA==
X-Google-Smtp-Source: ABdhPJxp+pf66Lk1gp+j3TROFkuPYMIg0SSfCQ2Sp4EI5vcyetqOohnvREe2pb0K9qdihUjuiASPAA==
X-Received: by 2002:aca:afd3:: with SMTP id y202mr1538701oie.90.1621300182965; 
 Mon, 17 May 2021 18:09:42 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id s17sm3423215oog.31.2021.05.17.18.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 18:09:42 -0700 (PDT)
Received: (nullmailer pid 3571158 invoked by uid 1000);
 Tue, 18 May 2021 01:09:41 -0000
Date: Mon, 17 May 2021 20:09:41 -0500
From: Rob Herring <robh@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [RFC PATCH 1/2] ASoC: dt-bindings: codecs: Add bindings for nxp, 
 tfa989x
Message-ID: <20210518010941.GA3571094@robh.at.kernel.org>
References: <20210513104129.36583-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513104129.36583-1-stephan@gerhold.net>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Vincent Knecht <vincent.knecht@mailoo.org>
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

On Thu, 13 May 2021 12:41:28 +0200, Stephan Gerhold wrote:
> NXP/Goodix TFA989X (TFA1) amplifiers are controlled via an I2C bus.
> Add simple device tree bindings that describe how to set them up
> in the device tree.
> 
> Right now only nxp,tfa9895 is supported but this will be extended
> to at least nxp,tfa9897 in the near future.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../bindings/sound/nxp,tfa989x.yaml           | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
