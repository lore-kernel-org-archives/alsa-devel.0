Return-Path: <SRS0=nSv5=DG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE041C4727C
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:42:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04F4207F7
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZB2lyQtk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04F4207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A414817F8;
	Tue, 29 Sep 2020 21:41:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A414817F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601408553;
	bh=E5iYVPM3gQHTLqkCsYl3e8xDst/5Xfrk9N0eakWowmY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZB2lyQtk+QtZyHxlch+bEQBl8YPmx2LHvN8vY6v6S/8B8kIdEHhsHOBShcCd1aKIi
	 yWycBcMI6rNT2eGPLGGd0sPMlxPxtqqsliy00iPJL6/uYLzE/Ex+CgezT89zd9jC7V
	 IKRapxMahDRWzAUNXMoLk9k9nK/0gW3vtPLojlD0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2CE86F801DB;
	Tue, 29 Sep 2020 21:41:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9C2B6F801F5; Tue, 29 Sep 2020 21:41:41 +0200 (CEST)
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21417F80115
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2020 21:41:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21417F80115
Received: by mail-oi1-f194.google.com with SMTP id z26so6777996oih.12
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2020 12:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sJ7YkgOz8i3irzVIPv/sXkuM9djFbty0kO0zCwYqlSw=;
 b=Awi6AwRTzxt2lmuaFghmTLJC0R98dGtDAXSfBG2cLihtzM1JNEn982PWsE3zh9n2Ev
 aio18wp5s3hHRVyjAjQ6wenyxX3X5Ihp8NSvyTPZIgfVBGE7UztOeJ3Qbq0ksw3ARPoN
 iQEJwOaoJQREW2/0xljiKZJLHjIE7KwxCNGEHR9KIHzfWvywHxmYZVa8LoX6fHrPDQ0u
 pmPFjzU20GygqGWM0x+0hS2Ct133OM4+slyl32CTRMhZ7cTPLfNISV+v8Tz1MIm+FWY1
 SbQZt9iRI1oxF1m55zX2FtOYrJBnboDqeEhRXS+c8Z6WF/CzM4KcuH6yktIpkN0QfYlb
 /ccw==
X-Gm-Message-State: AOAM5316AtB8YO/MUQKMfZCmNMrdMzOvbFLCsBYWKtyzLL4OXq/7FQHr
 p8W9xADedC1OMISSQikf7A==
X-Google-Smtp-Source: ABdhPJxM7cgu2wM21FpDnae9IpBVGD6PA3tfuQhAN79/9TJMzMoSsUN094B9V/aLWeOqzSBdwO+hLg==
X-Received: by 2002:aca:cfc2:: with SMTP id f185mr3733588oig.56.1601408489357; 
 Tue, 29 Sep 2020 12:41:29 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id o13sm1225641otj.2.2020.09.29.12.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:41:28 -0700 (PDT)
Received: (nullmailer pid 1034926 invoked by uid 1000);
 Tue, 29 Sep 2020 19:41:26 -0000
Date: Tue, 29 Sep 2020 14:41:26 -0500
From: Rob Herring <robh@kernel.org>
To: Ajye Huang <ajye.huang@gmail.com>
Subject: Re: [PATCH v1 1/2] ASoC: qcom: dt-bindings: Modify sc7180 machine
 bindings
Message-ID: <20200929194126.GA1034850@bogus>
References: <20200928063744.525700-1-ajye_huang@compal.corp-partner.google.com>
 <20200928063744.525700-2-ajye_huang@compal.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928063744.525700-2-ajye_huang@compal.corp-partner.google.com>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, tzungbi@chromium.org,
 Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-arm-msm@vger.kernel.org,
 Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org,
 dianders@chromium.org, Rob Herring <robh+dt@kernel.org>,
 Andy Gross <agross@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>,
 Mark Brown <broonie@kernel.org>,
 Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
 linux-arm-kernel@lists.infradead.org, cychiang@chromium.org
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

On Mon, 28 Sep 2020 14:37:43 +0800, Ajye Huang wrote:
> Add compatible "qcom,sc7180-sndcard-rt5682-m98357-2mic"
> for 2mic case.
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
> This patch depends on this patch series
> https://patchwork.kernel.org/patch/11773221/ .
> 
>  .../bindings/sound/qcom,sc7180.yaml           | 64 ++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
