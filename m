Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874EDC47080
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 15:57:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E08613AE
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 15:57:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E08613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE45616CD;
	Tue,  1 Jun 2021 17:56:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE45616CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622563051;
	bh=FxZxF8CUm+KWjU3wGRKaKMENJ6JPLN3HDamelOjPqxA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qRMtwEEIbKjT6reydioMr4icVRukX8zu1UHG4QlXJaUXcFQemWUc0mpRRk0UtR3Ks
	 zL1OQTZIrEipzpZHHbNSrXOVZml3hXBsd/pdaRtymt643VI5Eo6amYM8Gcbfu7K+O4
	 BAU7sbC40BsPH1FLmUrrdya+auzKhhC5Mrv2hKFw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 56788F80253;
	Tue,  1 Jun 2021 17:56:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7E46F80254; Tue,  1 Jun 2021 17:56:39 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6FE05F800B2
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 17:56:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FE05F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="UltuNVVr"
Received: by mail-oi1-x234.google.com with SMTP id v22so15941103oic.2
 for <alsa-devel@alsa-project.org>; Tue, 01 Jun 2021 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:user-agent:date:message-id
 :subject:to:cc;
 bh=FxZxF8CUm+KWjU3wGRKaKMENJ6JPLN3HDamelOjPqxA=;
 b=UltuNVVr5qb+Lf6MHAOXUvFc/IubBdtJ0yalaqOx2FHE0E5w6Vuy08BAhoBYBuP0M6
 qL2NGfxYmEt2zvVUTgwb4CPZ8IGwoYl0QQWyAzRBdAWt4C8lyBt5/gbIJuuPYMGtDd6E
 iQnu/6tIzDY09AKy+PtiFLo137kNIGMZIEc9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from
 :user-agent:date:message-id:subject:to:cc;
 bh=FxZxF8CUm+KWjU3wGRKaKMENJ6JPLN3HDamelOjPqxA=;
 b=gznDReFQTFcPYk5i8drIaeIM3+704qXHToYCHcWfOkxhgYTCJbyDGrGbmXGPgf1B2K
 Xgp1sKibHDlnVJsIlIzhN6FbLoi5fKGcUabIg9GZLrg/bQcbCbFA0ZbvGzHx0PcH1FFx
 Z4o6SoOt0ULnxY4TWA2nNkpFJdkJmDMWgTGOm9vqMdtcSAUBElkXuHCJ64ZJNyT/WOcg
 CoNnFBd8vYM/nhAk+akYuUlg143NcW0KwXnIOl8L9WojHCGOfYPnj/AFJYQll62tHTSX
 1pWhcgYVBUk4bd6aWpR3yZyYAgssdF8dnxjNtLNfzgkQBRrKJIwhW4oC38EpmGGQ0hsS
 B/vg==
X-Gm-Message-State: AOAM530ma8qVu7xGeFnEvBhvBtGJsohdaDv72K/k+g7hMvlu/LrnPUwD
 xOutx6+uzafquKk/Bb/z4nTsMjUBS0caWfgLAM8qiw==
X-Google-Smtp-Source: ABdhPJybv3iKPhoqDwc4qO/Zl0bqVJvkjD92sd0LaGvMmIxjQbCH/KfnaG/c0pbdJbbKDDMUmhNZFn4rtNC7tIAWj8Y=
X-Received: by 2002:aca:654d:: with SMTP id j13mr423624oiw.125.1622562989251; 
 Tue, 01 Jun 2021 08:56:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Jun 2021 08:56:28 -0700
MIME-Version: 1.0
In-Reply-To: <20210601022117.4071117-1-judyhsiao@chromium.org>
References: <20210601022117.4071117-1-judyhsiao@chromium.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date: Tue, 1 Jun 2021 08:56:28 -0700
Message-ID: <CAE-0n52DQ5yGxAFKLhuHQxK2Qj7eOTBNWNzGLhFLMR6sVhCMVQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: add label for secondary mi2s
To: Judy Hsiao <judyhsiao@chromium.org>, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Cc: Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
 judyhsiao@google.com, Banajit Goswami <bgoswami@codeaurora.org>,
 cychiang@google.com, Stephan Gerhold <stephan@gerhold.net>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 alsa-devel@alsa-project.org, Andy Gross <agross@kernel.org>,
 Rohit kumar <rohitkr@codeaurora.org>, dianders@chromium.org,
 dgreid@chromium.org, tzungbi@chromium.org,
 linux-arm-kernel@lists.infradead.org
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

Quoting Judy Hsiao (2021-05-31 19:21:17)
> Adds label for MI2S secondary block to allow follower projects to override
> for the four speaker support which uses I2S SD1 line on gpio52 pin.
>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
