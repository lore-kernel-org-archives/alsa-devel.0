Return-Path: <SRS0=2Zex=O4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C06C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 21:59:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3D360FC2
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Oct 2021 21:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A3D360FC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D72E51685;
	Fri,  8 Oct 2021 23:58:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D72E51685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633730356;
	bh=V5sN8fkNrqHfS9+2YdIdsgMZ2X6X5clutLAK1kRTT/g=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sYYcMtz4o+KBcPksP82P/wv3vcjhxmcJbHi+AvLaPEYUsKloVk0Ig1v/l8T/Tnd+R
	 qkp2QruVWFGenl8jIPRcwOLDYPrIunD+htFFY4yOznCxIvBuLhRaw8g3PY0lGFeyJZ
	 udGIG8xZ9sNRJm700OI291IKSiXYtmrjqEfIuG/I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CBB5F80240;
	Fri,  8 Oct 2021 23:58:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1596AF80246; Fri,  8 Oct 2021 23:58:25 +0200 (CEST)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com
 [209.85.167.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3CB4F800F0
 for <alsa-devel@alsa-project.org>; Fri,  8 Oct 2021 23:58:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3CB4F800F0
Received: by mail-oi1-f170.google.com with SMTP id 24so15626775oix.0
 for <alsa-devel@alsa-project.org>; Fri, 08 Oct 2021 14:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=J+PB1GhDEx5QjCPzMUbl+MUlC9KDbTpIS4i7gs7AJxk=;
 b=SS3jgyKm2P52RDp4sePaVZsNfmiQtXCOzsHFJ166xC9dWoUAnzEhe7jbymfOx/9kVL
 BO7KFqRdcHmwFDN6/KqdAldv2xH4STQVwaTRss81lQK7ZUPOKYuBPt3g6B8ro+LpMH6K
 oH386uuU+vDdN/AGLvy7b/7nbwpfRBW4qglebhQzFYViXkR8Zy9PDEnTPPg/zPnTztnN
 gMCwfNdsLHffTfrD9MzX5IMvExND3eR54VX79ZcEAkwJs9XwAj2/zVon/Zvv1CcXLJun
 z40HNZggsZTGjDgsGwG2NdyecUUCWOrvD3jw4LHhPvckQiDu6xecDTTCb+kJsmNpdZ7f
 12Rw==
X-Gm-Message-State: AOAM532gMxBynnnwYufwn73eg15/AKYdqczp5DbIqPRT1gM77dDoVwI7
 ATxug9CsHJ0RTsWnCPmwLg==
X-Google-Smtp-Source: ABdhPJwJXLGgMO3pWGsrCW8mdAxa0PsY9A5IlolFsjx2OCeIr+FJ1Tl1xWw/2AZ+gYpjjrSfvCRY2w==
X-Received: by 2002:aca:4303:: with SMTP id q3mr11391664oia.9.1633730295280;
 Fri, 08 Oct 2021 14:58:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id i24sm134566oie.42.2021.10.08.14.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Oct 2021 14:58:14 -0700 (PDT)
Received: (nullmailer pid 3389719 invoked by uid 1000);
 Fri, 08 Oct 2021 21:58:13 -0000
Date: Fri, 8 Oct 2021 16:58:13 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: Re: [PATCH v3 2/5] ASoC: qcom: dt-bindings: Add compatible names for
 lpass sc7280 digital codecs
Message-ID: <YWC+9TjkadLfJcV0@robh.at.kernel.org>
References: <1633702144-19017-1-git-send-email-srivasam@codeaurora.org>
 <1633702144-19017-3-git-send-email-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633702144-19017-3-git-send-email-srivasam@codeaurora.org>
Cc: devicetree@vger.kernel.org, bjorn.andersson@linaro.org,
 bgoswami@codeaurora.org, alsa-devel@alsa-project.org,
 Venkata Prasad Potturu <potturu@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 plai@codeaurora.org, lgirdwood@gmail.com, swboyd@chromium.org, tiwai@suse.com,
 robh+dt@kernel.org, broonie@kernel.org, agross@kernel.org,
 rohitkr@codeaurora.org, judyhsiao@chromium.org, linux-kernel@vger.kernel.org
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

On Fri, 08 Oct 2021 19:39:01 +0530, Srinivasa Rao Mandadapu wrote:
> Update compatible names in va, wsa, rx and tx macro codes for lpass sc7280
> 
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml  | 4 +++-
>  Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml  | 4 +++-
>  Documentation/devicetree/bindings/sound/qcom,lpass-va-macro.yaml  | 4 +++-
>  Documentation/devicetree/bindings/sound/qcom,lpass-wsa-macro.yaml | 4 +++-
>  4 files changed, 12 insertions(+), 4 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

