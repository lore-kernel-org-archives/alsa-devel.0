Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C2DC432BE
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 17:02:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 123C561373
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 17:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 123C561373
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F9B71676;
	Tue, 24 Aug 2021 19:01:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F9B71676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629824566;
	bh=eZMBFcuNnFkeFZX8p88yoxYe1dpraNgSxJOUI0B40f4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NmJxtJaEt5eKbXM78L5sUIQS/C9bnDeMi4cGFjzXyLDfgfCyOR8s01EcC7vghQQ2I
	 KZL/BGRBj/vtkXwc5db1bQ4HaX1DFL8h2jMvCrheriMJHDaq9uvf3U0o4cIrs7MauO
	 roGvSP2YivcBFXPO8yFihQKF7onCpxxPaU4w2u+8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9519F801D5;
	Tue, 24 Aug 2021 19:01:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBBFDF801D8; Tue, 24 Aug 2021 19:01:54 +0200 (CEST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 925F1F800AE
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 19:01:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 925F1F800AE
Received: by mail-ot1-f48.google.com with SMTP id
 c19-20020a9d6153000000b0051829acbfc7so47849801otk.9
 for <alsa-devel@alsa-project.org>; Tue, 24 Aug 2021 10:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=nUUWA5CRF6HLqmKmoi7Vjo2ILY+GNb621NKyvGmJA8s=;
 b=R8g4vrUWSIOdDH7Jn8i1iZebugxrWMbz2NoU0gRpsXNEKZtbFt4rCHKdDVBd1UHJfi
 o1QIaIxnj5Q+jrPxLTxo3k1tzH35PntBCgGHUyZwECZ9YLG3n7d5BiPzNd76PxplMIL0
 PiL+ArtM+KohSTxsKSbNVLYjEmdzWQZPb7MozKER5v466Zlh4IpPHbxjcf7Xu7EeQTfz
 wNV9ExzpEFzA1DrDhdT7sDGl792lJatmkfat8ZuLE+Dc9/4/xQWIXotvm0hyTXpUeQK5
 589rAM4bRKPZRPA37UcDWRYrX8EuzeUyCkslGdRSDIjLzQ/f6lMCg/VgG8vkWEkn7u0q
 N5eA==
X-Gm-Message-State: AOAM533DWurL2eaMnZLtSLr724t7GH5Dn1RSMhKA6QDf/OAKD49jZKQj
 ZaZTIHR3xnR/LkNYBgD1YQ==
X-Google-Smtp-Source: ABdhPJxk3xxIG5/F1f6fBOsunCUzkOVmpUpV1nAU+ih3BbcLVZRf59oAnpIFJdiE4ZUhjqGI5dUqUg==
X-Received: by 2002:a9d:7ccc:: with SMTP id r12mr33420960otn.350.1629824503999; 
 Tue, 24 Aug 2021 10:01:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id 33sm4499216ott.19.2021.08.24.10.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Aug 2021 10:01:42 -0700 (PDT)
Received: (nullmailer pid 630780 invoked by uid 1000);
 Tue, 24 Aug 2021 17:01:41 -0000
Date: Tue, 24 Aug 2021 12:01:41 -0500
From: Rob Herring <robh@kernel.org>
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v2 07/15] ASoC: dt-bindings: rockchip: Document reset
 property for i2s
Message-ID: <YSUl9aqF8AP2Kb8n@robh.at.kernel.org>
References: <1629796561-4025-1-git-send-email-sugar.zhang@rock-chips.com>
 <1629796682-4170-2-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629796682-4170-2-git-send-email-sugar.zhang@rock-chips.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org,
 heiko@sntech.de, linux-rockchip@lists.infradead.org
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

On Tue, 24 Aug 2021 17:17:54 +0800, Sugar Zhang wrote:
> This patch documents reset property for i2s.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
