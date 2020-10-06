Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CF9C4363D
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 21:12:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACAB6206BE
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 21:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BuJZRY+g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAB6206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBA8316E5;
	Tue,  6 Oct 2020 23:11:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBA8316E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602018736;
	bh=mOeVC8UTTosfLA/ZXQaE+0aqI9khnVDOKxzfW1T9FJg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BuJZRY+ggJRkPS0NPpDNB+5kcH/WMJMbf0rxaPIPz1c85kiWHRWrxF9/u34JrOTv/
	 ylvw3jehgJ7X4/UpbpYGnQNnSSnDRs6R16bDgyESw1ru0hb/nqolLhZTvvk47G/CpR
	 SY9KZrG/4MGoNWlG8qANdr4iyJDqEBe8EKoWzhcg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B79AF80129;
	Tue,  6 Oct 2020 23:11:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4EE7DF8012A; Tue,  6 Oct 2020 23:11:24 +0200 (CEST)
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D66D6F80128
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 23:11:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D66D6F80128
Received: by mail-ot1-f67.google.com with SMTP id t15so229598otk.0
 for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2020 14:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5FP0smEmtRjA7sa6KoPbSMBo/XXzMk5YV0latxBLaGo=;
 b=jl04mdJhanY8kNWDwoHL9FZNymbF7c3AVzthpRVSS06oqKaLGO8ateVzLIqSGL0tSS
 L9I21Yhhd9F5qVvFzDF9YvO6tCJoyCfx942N9AMti6iGPBPV3sdoS19/bVhMZzRNBTsA
 IdqAQU1AZdhh/2Us5vYL+CMINYNOmmoSO7hXJkyY5z4/FiUAQq/PyOlnyx3Wo9lAwwYE
 IMzmyVprepW3jcRX0mrklGUMMsqhrApUrP+fgq3xfCgVCQ1VcGjCq6x9ENpXg9FOUcLe
 e7EnuD+rRXNqnUCXWeLbwZ4iwDs+GUqEBMFL/PW6rNFG3nxE6abi+Ihlp3W1ykZxWL5j
 7I4w==
X-Gm-Message-State: AOAM532XIVh7mDe0MKfkjTds9ziw1IYnrSkUHXBWuxsS9NLlfICI7GZr
 tHNEaGDtA4WQk1LeYq4UmQ==
X-Google-Smtp-Source: ABdhPJznxbwgrx4oSXOYZC8dTgbjtyD4TW76I6oDeE7VGirnsKALIyRtHYG26LH2daEjUmTJm4T2ag==
X-Received: by 2002:a9d:2ab:: with SMTP id 40mr3904256otl.137.1602018678507;
 Tue, 06 Oct 2020 14:11:18 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id i205sm3286oih.23.2020.10.06.14.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 14:11:17 -0700 (PDT)
Received: (nullmailer pid 2848240 invoked by uid 1000);
 Tue, 06 Oct 2020 21:11:16 -0000
Date: Tue, 6 Oct 2020 16:11:16 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Subject: Re: [PATCH v6 13/14] dt-bindings: sound: sun4i-i2s: Document H3 with
 missing RX channel possibility
Message-ID: <20201006211116.GA2848184@bogus>
References: <20201003141950.455829-1-peron.clem@gmail.com>
 <20201003141950.455829-14-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201003141950.455829-14-peron.clem@gmail.com>
Cc: devicetree@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Marcus Cooper <codekipper@gmail.com>,
 linux-sunxi@googlegroups.com, Mark Brown <broonie@kernel.org>,
 Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
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

On Sat, 03 Oct 2020 16:19:49 +0200, Clément Péron wrote:
> Like A83T the Allwinner H3 doesn't have the DMA reception available for
> some audio interfaces.
> 
> As it's already documented for A83T convert this to an enum and add the H3
> interface.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml    | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
