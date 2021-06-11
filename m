Return-Path: <SRS0=W3EJ=LF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10F8C48BE6
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 20:00:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5E9613EA
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Jun 2021 20:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5E9613EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 186FA1A9F;
	Fri, 11 Jun 2021 21:59:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 186FA1A9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623441626;
	bh=kLerl3pGIBUO85KQ3wuOq8DWmZyCRmZMnQtstv9++FA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PN0aPPMcP1FbUfta0LR36ZU79pdH6JWcV3Keel68FNxeXGHDiFZBCCJg3zFpTT3uv
	 BPqpNePr7hgPklaoiDSACls23/6RNUSVJJLN8eoR2xQLQd9V3qSfgubOY6G6GPW2sH
	 r9AKXvzbTZciVsWfy9n8I+T2TGWrsJoQmLXBlNLg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94066F80212;
	Fri, 11 Jun 2021 21:59:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 40B95F8026C; Fri, 11 Jun 2021 21:59:34 +0200 (CEST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com
 [209.85.166.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BAF8F800FB
 for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2021 21:59:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BAF8F800FB
Received: by mail-io1-f44.google.com with SMTP id q3so9173770iop.11
 for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2021 12:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2MShu2QtVsTqRdskB6+VsVqYV5HgLpTWfQ/M1na3eIs=;
 b=sKaLhYI40XGF/EvrunWgd68HIo9N/pm0uVIC5eyNLi2Pmymjl5ozXr7D67QhRAHiCc
 pGXLQgzDGuI3zMYEKR1C1yl/5ddWIrAzZYQ1oCu0mbG8YIMn84M045kXhsLxI3OMvehH
 X7eKahWEFm2ZymucJdOx1S/mr7fzH1fWXqXuA8OhVn2tQhxDt8IwzB73LjggywVpFVTu
 mZP4/U/OdiwY+kyunvJSxe9+JWkCXfYaORDPBwGm6A4f6BarM2IqPTLr/N46pKf1ynt6
 7cu0S/F2yil70LWJD5hKBR4K4LlS1dU7cRkckIwbbcNWnBgVtVZx2r7mAJJ/rTuIdeBM
 8Rhw==
X-Gm-Message-State: AOAM530FJdSZBIfE9NxAdnnUqKLQ4BwdQWbnUKsovOXcIh5m07Ul0FqC
 UNAHOdf2SZM+1UoSMaFZRw==
X-Google-Smtp-Source: ABdhPJwTFpbeqD9YH9tBdz46jdLN4xy2ht/+rh8ETaVXV5osiP4uPcIJFDR/WZ+x0E7XuQBg0hr5tg==
X-Received: by 2002:a5d:9e41:: with SMTP id i1mr4454339ioi.72.1623441564508;
 Fri, 11 Jun 2021 12:59:24 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id c11sm3971336ils.24.2021.06.11.12.59.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jun 2021 12:59:24 -0700 (PDT)
Received: (nullmailer pid 1581560 invoked by uid 1000);
 Fri, 11 Jun 2021 19:59:22 -0000
Date: Fri, 11 Jun 2021 13:59:22 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: dt-bindings: fsl-sai: Add compatible string for
 imx8mm/8mn/8mp/8ulp
Message-ID: <20210611195922.GA1581497@robh.at.kernel.org>
References: <1622613770-10220-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622613770-10220-1-git-send-email-shengjiu.wang@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org
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

On Wed, 02 Jun 2021 14:02:50 +0800, Shengjiu Wang wrote:
> Add compatible string for imx8mm/8mn/8mp/8ulp, these platforms all
> support SAI IP.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
