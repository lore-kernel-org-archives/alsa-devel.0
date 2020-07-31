Return-Path: <SRS0=4tTe=BK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F5BC433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:21:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A74F92087C
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kLC9Kj6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74F92087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4159A1683;
	Fri, 31 Jul 2020 22:20:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4159A1683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596226889;
	bh=b6Kd7W7qIcd9HCB+grl80x+iMKiqdTkxM3biZ3nm8mA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kLC9Kj6obgFZKmeH6SI2ajaDPPf8LHSODpLdDICFI663FHygbEJ6z4hq+c0HJrhr9
	 ydENw4yNXmthzDctWeirNuTnsdy2jqEde2NTqad+ZfTl4Yeyf6b1UhXZiNWd6lIAJV
	 RE7brLbUfXtbuJFW8ZI9WMlLHwWLMhEPaXm00yr4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CBC08F8011C;
	Fri, 31 Jul 2020 22:20:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 618CCF80171; Fri, 31 Jul 2020 22:20:37 +0200 (CEST)
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 464F8F8011C
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 22:20:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 464F8F8011C
Received: by mail-il1-f194.google.com with SMTP id z3so16151458ilh.3
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 13:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=14cFHIH+5pcNnYf7nGiGjtZ3STT/BgFgufhbpVb8w2E=;
 b=dI+uVZ5tmK7NnUyFk8JFwaFZIagl9OcqyH5SxGZGE903OfPbzEfgtsdGG3FHVQNlUR
 pL8aL4lYYHHd+gsAYLE3AD0oI/NrXU7yVRcDh1HeoPeBKI6aNf13pusnRMZHEnpZI2YZ
 XaLMEjKwU1RL9mom9FBL6E2fIvF3hOfVyHQPtNAiyh5sdsWUNoisDmvD1deRC8bv9ptI
 NSyWu1TGOfQSxeib9hH7Wc03bawJ6y38fbYwBmZV+eHE05Bbam/xG1zXK1bIRpb8pPH2
 m3uhQZuaybTOm90l1JzznaDx6jVZ9zsiotNqJ6raX81Oe5Rfh28T62PXR2z+7jSxRdj0
 ATJg==
X-Gm-Message-State: AOAM5338o14MDm6cNHYeowYLVBtB+8TsqFZg9dpno3nHimGQIgSRropI
 OVFyiiTSHo57Ly+FjLrZkQ==
X-Google-Smtp-Source: ABdhPJwH+8TRsy44CdLoDhMeudbSS0ZxxndP4/x3ZTsHVWfrjyI+20UP81e+sp4iuHC9D9Xz17JjSw==
X-Received: by 2002:a05:6e02:134e:: with SMTP id
 k14mr2532291ilr.152.1596226829165; 
 Fri, 31 Jul 2020 13:20:29 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id a18sm4415112ilp.52.2020.07.31.13.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2020 13:20:28 -0700 (PDT)
Received: (nullmailer pid 713904 invoked by uid 1000);
 Fri, 31 Jul 2020 20:20:25 -0000
Date: Fri, 31 Jul 2020 14:20:25 -0600
From: Rob Herring <robh@kernel.org>
To: Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/7] ASoC: dt-bindings: Add a new compatible for the A64
 codec
Message-ID: <20200731202025.GA713768@bogus>
References: <20200726012557.38282-1-samuel@sholland.org>
 <20200726012557.38282-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726012557.38282-2-samuel@sholland.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Ondrej Jirman <megous@megous.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Maxime Ripard <mripard@kernel.org>, Vasily Khoruzhick <anarsoul@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
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

On Sat, 25 Jul 2020 20:25:51 -0500, Samuel Holland wrote:
> The audio codecs in the A33 and A64 are both integrated variants of the
> X-Powers AC100 codec. However, there are some differences between them
> that merit having a separate compatible:
>  - The A64 has a second DRC block, not present in the AC100 or A33.
>  - The A33 has some extra muxing options for AIF1/2/3 in the
>    AIF3_SGP_CTRL register, which are not present in the AC100 or A64.
>  - The A33 is missing registers providing jack detection functionality.
>  - The A33 is claimed to invert LRCK, but this is not seen on A64.
> 
> Since the driver will continue to work on the A64 using the A33
> compatible, albeit without jack detection functionality and with
> possibly inverted channels, as it does now, allow the A33 compatible
> to be used as a fallback.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../bindings/sound/allwinner,sun8i-a33-codec.yaml           | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
