Return-Path: <SRS0=vl9c=YK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CFCFA372A
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:35:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32ED821835
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dqRFh3XI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32ED821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 384BC16A4;
	Thu, 17 Oct 2019 18:34:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 384BC16A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571330131;
	bh=Y2kviDH+oo5kQp1vRFR0yQGJlcdax349uBuMrZEvs0k=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dqRFh3XIG00HHtEAF8koraXB+rsSy4bZNQNcZ3c8isozAHKdCPMPA3Bf90/867W5J
	 M7HwOxRva5/li/RFbpgpXARmX18E0Xt3dg0h3EUupqQMLKeszIsuuznFNchDtp/lVc
	 4VKpc8FSvDIV6jvN2yflNOiB3BS+jeC1nuUCk0co=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9FBF7F80322;
	Thu, 17 Oct 2019 18:34:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86F2DF804A9; Thu, 17 Oct 2019 18:34:38 +0200 (CEST)
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E484AF80276
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2019 18:34:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E484AF80276
Received: by mail-ot1-f66.google.com with SMTP id 89so2405132oth.13
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2019 09:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=C3mMcajmmWiTF2tnnxoirKHCmnTAKZDTtWXx5ZDHeWs=;
 b=OX+Njptpzi17gdPfnTajpXmSvJC688eO2JPTHYXOoRJMeSBfNyTtHXPeh1bJ+ACnk9
 VW9mL1P7Y4Y6ymFPZ4HZ049jWAhq0Jk3MJl67bTzhJyNeVnYfFguiw9+IiLfjMSdc3fc
 TncGwdOu3rGcwufGBXD1IR2GirBKBJqMuS6bnnVsOPV8JmjcKo3yjQPBX86CQczIPp13
 Pb7gZgqvr6sx/qekFMKJ3DRbLdakp6eR4e1othqBS6ThyLK0sIEkjST5Dm87f9uZQ1M0
 0eoAZn1s0D9zCCky7M4RTPkJPtX80QuEXrBzOVm/96jEzQsCo9yI+F6egahGHoXd7gkG
 UYfw==
X-Gm-Message-State: APjAAAVVE/1Bb61/lLWh4MLvyijqpl/I4kZSINQCL2u2cgDWUlcDpKvk
 VubHWMAcsplAovFWfG3Z7Q==
X-Google-Smtp-Source: APXvYqxmXr4i5Zk+4RgsYpkljl8yHKw0u/wDt5mYRIh6dw01K8bE2nEDXt13Ws7kQI7FRmola1U7ow==
X-Received: by 2002:a9d:6a93:: with SMTP id l19mr3934654otq.196.1571330072588; 
 Thu, 17 Oct 2019 09:34:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l30sm711247otl.74.2019.10.17.09.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 09:34:31 -0700 (PDT)
Date: Thu, 17 Oct 2019 11:34:30 -0500
From: Rob Herring <robh@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Message-ID: <20191017163430.GA18716@bogus>
References: <20191016104355.65169-1-mripard@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191016104355.65169-1-mripard@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 broonie@kernel.org, Frank Rowand <frowand.list@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH v3] ASoC: dt-bindings: Convert Allwinner
 A10 codec to a schema
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 16 Oct 2019 12:43:55 +0200, Maxime Ripard wrote:
> The Allwinner SoCs have an embedded audio codec that is supported in Linux,
> with a matching Device Tree binding.
> 
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> 
> ---
> 
> Changes from v2:
>   - Change the audio-routing values to an enum, and enforce boundaries on
>     the size
>   - Add restrictions to the possible values of audio-routing
> 
> Changes from v1:
>   - Fix subject prefix
> ---
>  .../sound/allwinner,sun4i-a10-codec.yaml      | 267 ++++++++++++++++++
>  .../devicetree/bindings/sound/sun4i-codec.txt |  94 ------
>  2 files changed, 267 insertions(+), 94 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-codec.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/sun4i-codec.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
