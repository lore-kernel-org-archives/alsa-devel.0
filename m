Return-Path: <SRS0=RrJr=FN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474EFC4361B
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 20:16:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD0D23BEF
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 20:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD0D23BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38A5B166C;
	Wed,  9 Dec 2020 21:15:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38A5B166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607544992;
	bh=J0ORhYtlfgVCCuomdBwe8gnub3OU1z1pfRRG0DzkTsA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d2U1bjd+k0yVYWSE2HNn0d/QHsgqtx9CV7Yp1FrDADD5/a0ej/SSfGY5VajALtuZG
	 U77EJi2tTIdSWxvMgaMX+d6DQEavFEaBjBcYYXQx2k2kXcbV1c4MEmRckaYD2QQ+0H
	 Z8if609v7+xHcvEMuaPpLkxz4RF2r7aXmuPahTNI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FDABF801D8;
	Wed,  9 Dec 2020 21:15:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F30FF8020D; Wed,  9 Dec 2020 21:15:39 +0100 (CET)
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A5FBF800E1
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2020 21:15:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A5FBF800E1
Received: by mail-ot1-f68.google.com with SMTP id y24so2667914otk.3
 for <alsa-devel@alsa-project.org>; Wed, 09 Dec 2020 12:15:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HkZkOlvU17tWN9kGhwEHEyzk6vBPnUYvFHyetdZXKVA=;
 b=pYdack87dNZxwzMOxw0ipqrDsvR+JhALNUn20MHxG1oWch6/p7QRZ22t7UJlblCuhp
 luMvR+WKPobi36HCYnQjD2N4hpkqAViSR0lO7rcfG+Tzl84pbRqyG1qAiEtoMkf1S6Z7
 DcSa4V167HVn9R6PoesmYw9TdPbaZB7E04T/v9XnqI5n/THV4YpNF/o9Nf/0TWbl/3Jd
 DOvylsYboHEDYSpvpe1VG/OG3p3SAeTdBDuVfL13Ph/iPkjugT3M/6mTTt+hmp7Zd7mY
 xqpvCRuWVLdR51ofud7HC4DBzI7VbiF9FwRu97pQdW7Oa7Nww7akg0gLr2vXqtbOwvZy
 lNBA==
X-Gm-Message-State: AOAM530WeNenXGgmT/bpliNNsPVY8g4/Se4FldA42hJ3/XBb7ishs2Mt
 RsF/U6EOEhYOzvJN6WJ6Dg==
X-Google-Smtp-Source: ABdhPJz6SA76JGYn9n/Qh4vb6FiikJm900RuCu35Bj3qJ5ugpBm0a7qioElUowlY/gcxRlS7VcXqAQ==
X-Received: by 2002:a9d:7f84:: with SMTP id t4mr3198018otp.302.1607544930935; 
 Wed, 09 Dec 2020 12:15:30 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id i1sm518487ool.43.2020.12.09.12.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 12:15:29 -0800 (PST)
Received: (nullmailer pid 867331 invoked by uid 1000);
 Wed, 09 Dec 2020 20:15:28 -0000
Date: Wed, 9 Dec 2020 14:15:28 -0600
From: Rob Herring <robh@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [RESEND PATCH 1/2] dt-bindings: tegra: Convert HDA doc to
 json-schema
Message-ID: <20201209201528.GA867274@robh.at.kernel.org>
References: <1607006202-4078-1-git-send-email-spujar@nvidia.com>
 <1607006202-4078-2-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607006202-4078-2-git-send-email-spujar@nvidia.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, jonathanh@nvidia.com,
 sharadg@nvidia.com, broonie@kernel.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

On Thu, 03 Dec 2020 20:06:41 +0530, Sameer Pujar wrote:
> Convert Tegra HDA doc to YAML format.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../bindings/sound/nvidia,tegra30-hda.txt          | 35 --------
>  .../bindings/sound/nvidia,tegra30-hda.yaml         | 98 ++++++++++++++++++++++
>  2 files changed, 98 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
