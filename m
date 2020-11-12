Return-Path: <SRS0=f4/q=ES=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A172C5519F
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 15:37:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386DE21D40
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2020 15:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QzoB4V7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386DE21D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 724901616;
	Thu, 12 Nov 2020 16:36:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 724901616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605195458;
	bh=aPjo24K47G7wdusoVWtHb/qbSrGndgTLKiO/kJlwXug=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QzoB4V7AfEuuhMD1v0ISygi3TblIzMNiqVEsod1cRoFvRcxvj5czTx8WDh45Li1ax
	 l3/eFdWBhf0p4cfbOaofI9LtvaVpptNNn/n/P3vJvCSxSzQOmfuXwadvXXI0wGs9R8
	 Iab9E2qwWaotpWwePVq7seoKNPOixpw5dqhoJtQA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CCD0BF80161;
	Thu, 12 Nov 2020 16:36:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 78432F801D5; Thu, 12 Nov 2020 16:36:45 +0100 (CET)
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4600F80059
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 16:36:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4600F80059
Received: by mail-ot1-f67.google.com with SMTP id n15so5954733otl.8
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2020 07:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p9+hRtNlsfx2yF16OpisDfS8jNzJ5O4v4uBVZuIduPk=;
 b=GLsDwcfj9O4mPYjM+Ng0i4ucxqxqAb7jiMDbTNkltLxN7jaJPpgFta92fd571+htdp
 NkEkCSnEytQ3451ed9XmyyPIvGeUYEEuElRK7bwwadt0atQB4qEvsCrDbmAB14G7YedE
 o7/8iSFJJRJzhurERP+67B29gR5jIi6noef/rUjiSzyDYV3T+vlA1ODHZazlmkSbDZ/A
 znUyyRQ89IUT8QkynwOA4QgM40l4XWVoCGAMYuLdmDKGqc1qFuzom1rie27pHJip+9My
 igcpCgwDvAjmr5a3D4sDSTCF7HPqEutso2RmAEW9JILh8S2vQYRo/s68mg2DiKpzrAuO
 yTPQ==
X-Gm-Message-State: AOAM532EBb3tO/EmM+9nrIylVhQWE/N9Qv42yp3Gi5KMDwt74j+rSikl
 80bIHlLZ0LVtZ0bAoFgfVQ==
X-Google-Smtp-Source: ABdhPJwkhtfFF05VG+OK+BA0SxYnNU69zP7sOu9txuTpeGVO/qtQGcr7VPJws5/GzmtrmeFeTZaOPg==
X-Received: by 2002:a9d:1ec2:: with SMTP id n60mr22629900otn.63.1605195399851; 
 Thu, 12 Nov 2020 07:36:39 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id v144sm1161536oia.21.2020.11.12.07.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 07:36:39 -0800 (PST)
Received: (nullmailer pid 3641422 invoked by uid 1000);
 Thu, 12 Nov 2020 15:36:37 -0000
Date: Thu, 12 Nov 2020 09:36:37 -0600
From: Rob Herring <robh@kernel.org>
To: xuyuqing <xuyuqing@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v2 1/2] ASoC: google: dt-bindings: add new compatible for
 sc7180-coachz
Message-ID: <20201112153637.GA3641134@bogus>
References: <20201112014328.695232-1-xuyuqing@huaqin.corp-partner.google.com>
 <20201112014328.695232-2-xuyuqing@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112014328.695232-2-xuyuqing@huaqin.corp-partner.google.com>
Cc: Taniya Das <tdas@codeaurora.org>, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Rohit kumar <rohitkr@codeaurora.org>,
 cychiang@chromium.org, Patrick Lai <plai@codeaurora.org>,
 Andy Gross <agross@kernel.org>, dgreid@chromium.org,
 zhouguohui@huaqin.corp-partner.google.com, devicetree@vger.kernel.org,
 tzungbi@chromium.org, Stephan Gerhold <stephan@gerhold.net>,
 linux-arm-msm@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, judyhsiao@chromium.org
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

On Thu, 12 Nov 2020 09:43:27 +0800, xuyuqing wrote:
> Add devicetree bindings for coachz in documentation file
> 
> Signed-off-by: xuyuqing <xuyuqing@huaqin.corp-partner.google.com>
> ---
>  .../devicetree/bindings/sound/google,sc7180-trogdor.yaml      | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

