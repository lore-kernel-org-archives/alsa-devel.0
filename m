Return-Path: <SRS0=+0+W=NV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2CAC432BE
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 11:50:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1035261153
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Aug 2021 11:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1035261153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BFA53171E;
	Mon, 30 Aug 2021 13:49:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BFA53171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630324216;
	bh=Vdhx1qYkCydHotzV/G7cGTCKO958pP29I3Bua4L+D/4=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=odZ24ZoSHPJmtCffQlKGnRebSE+GtraDP7l26d1DBRumWT6gkaP+Si9/so0olPjrT
	 r60jBLBrO4aAWKwKHM4ptPOmAp6qWfGTFxk2tLck/JBXCndCJfJT4p24NTf36pPpZN
	 rOnSHhA3bXzkLzrz2AJ1/pnySNvxf8OVD/OcjJAg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 48848F8020D;
	Mon, 30 Aug 2021 13:49:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 78DDFF80218; Mon, 30 Aug 2021 13:49:24 +0200 (CEST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com
 [209.85.167.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95492F80169
 for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2021 13:49:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 95492F80169
Received: by mail-oi1-f182.google.com with SMTP id o185so19338181oih.13
 for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2021 04:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=JTWNeOzPya3nNu0WFhWPDsxrKp/zSguxB/tKydwWrag=;
 b=MpjEhq1LZ3lYaiOeyzMdwrx9QABVDy7+dDZOBP/V9CHKDtlN4aWguCUmDNWg3K6sY5
 l8ajDxyjnxRTk5V17cG5+E6mHELCnxxhFtkbihVjbF3BkbAnu57JoJBuu2sBNQSqIcek
 pWI0ZMjy8/XOQC+S+BskmXKjl8HzKB8N1v3Si28yUfiOA8o5dN+PbEtt1OdXqb1vZYTT
 LHRSReeJgS99I6aFFRguyc8cpq3DlVN3elMNZrlB2saAJkI6DBl7+Rznkz6AN7Un6eKx
 1lWVGMVPRmbGvqXRo1SgRlMWvAg9nLTE6C11uPUWJW9a3kVWZeQKVtSuE96FaUlBuwRw
 CgdQ==
X-Gm-Message-State: AOAM530WjLR460D2Hn5/SKc4kXlvCbtJDpgK8a5PVbiEegDOvzfUzvhK
 Lm8SeJzpiJs0o3bSlye3uw==
X-Google-Smtp-Source: ABdhPJwwEkgsS1GB6OQSTyCZgYSxrcjUoCWW5L8KMurAZMwyuCTgAYQQ+h3D86cTz7mDgrBVz2E8uQ==
X-Received: by 2002:aca:6541:: with SMTP id j1mr14958919oiw.146.1630324153939; 
 Mon, 30 Aug 2021 04:49:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id 97sm3214312otv.26.2021.08.30.04.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Aug 2021 04:49:13 -0700 (PDT)
Received: (nullmailer pid 1731755 invoked by uid 1000);
 Mon, 30 Aug 2021 11:49:10 -0000
From: Rob Herring <robh@kernel.org>
To: Sugar Zhang <sugar.zhang@rock-chips.com>
In-Reply-To: <1630285861-28147-2-git-send-email-sugar.zhang@rock-chips.com>
References: <1630285788-28002-1-git-send-email-sugar.zhang@rock-chips.com>
 <1630285861-28147-2-git-send-email-sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: rockchip: Convert pdm bindings
 to yaml
Date: Mon, 30 Aug 2021 06:49:10 -0500
Message-Id: <1630324150.931479.1731754.nullmailer@robh.at.kernel.org>
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
 broonie@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org
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

On Mon, 30 Aug 2021 09:11:01 +0800, Sugar Zhang wrote:
> This patch converts pdm bindings to yaml.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
> Changes in v2:
> - Fix yamllint errors.
> 
>  .../devicetree/bindings/sound/rockchip,pdm.txt     |  64 ------------
>  .../devicetree/bindings/sound/rockchip,pdm.yaml    | 115 +++++++++++++++++++++
>  2 files changed, 115 insertions(+), 64 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/rockchip,pdm.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,pdm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/rockchip,pdm.example.dt.yaml: example-0: pdm@ff040000:reg:0: [0, 4278452224, 0, 4096] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1522032

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

