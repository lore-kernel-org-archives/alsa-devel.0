Return-Path: <SRS0=Nc9k=DU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812EBC433E7
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:08:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2007425230
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j9RXcsbd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2007425230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B6B8169C;
	Tue, 13 Oct 2020 18:07:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B6B8169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602605276;
	bh=Bd2/k6I7tUvLw1uxMDjQZmH0KLojw0cW7fKpO7gIJ2s=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j9RXcsbd3pG94DSui0/q/UPVzOsrWGsV4WEWUji+UkhwTKdZVFbM4+ThOXZbI5ezU
	 sfH4izLM9sNOlyMuQQacToEc1Eb3Mh3qRaX4VggwD5s6S5aTFkusV759c6tJtuetZD
	 +HikleX8dYa8LThlf3TEG3NI43NLIZgOjntnCE14=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D61DCF8016F;
	Tue, 13 Oct 2020 18:07:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C776CF801A3; Tue, 13 Oct 2020 18:07:03 +0200 (CEST)
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com
 [209.85.161.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4B5CBF800F6
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2020 18:06:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B5CBF800F6
Received: by mail-oo1-f67.google.com with SMTP id o20so16074ook.1
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2020 09:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lJvrwL/FuYX27TcA8XBAMttZyQaUzn/E6l7mrrmjFrA=;
 b=PE7o9lNWGba0l6l82MSw8/MNahNFfbMb8YIpl6g3hUcUQM0thVU3TT16sE+rnh5Y1n
 pPL+a80GTZXRjyUgKKLPtbbskopycPT+7YS63UciNlyv0FQdvMKFThM6Iy4gTfVYB4PR
 6fAvBIT+M/hnWjU7nk9LPwhxabK9HrT0MbIkXaFOxOdCXzR9MufXFoszIB0u2xt9j76i
 PQOPiZYFGti4kVHera+owPDQVb8CNDfx01H3BdPoHt6GYw4S81oDAhyyyCrfff4MmSXO
 NLuiq7gIS8JMujXCkr+XwR2rxBkD+9dE0qawCwdGoO4kx6J7fBO1VrkJ/HHGyn8wngIF
 N1vA==
X-Gm-Message-State: AOAM531jo+ULbbsUThjnHW+EfqSRcEihBQA9Q2Mc9yWlz8KGUhPtdU8R
 UPywrBts0ai70It1Ketcsg==
X-Google-Smtp-Source: ABdhPJxqdYOtrD/HpqNx8Jl2GuLgmmSCJn2kjs3ih3MXm5tW7/fk6d/rOnxhKD9k0szvgWN4vx9rbw==
X-Received: by 2002:a4a:d8c1:: with SMTP id c1mr65697oov.31.1602605213606;
 Tue, 13 Oct 2020 09:06:53 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 42sm52847otv.35.2020.10.13.09.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 09:06:52 -0700 (PDT)
Received: (nullmailer pid 3610298 invoked by uid 1000);
 Tue, 13 Oct 2020 16:06:51 -0000
Date: Tue, 13 Oct 2020 11:06:51 -0500
From: Rob Herring <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@st.com>
Subject: Re: [PATCH v4] ASoC: dt-bindings: stm32: convert sai to json-schema
Message-ID: <20201013160651.GA3610242@bogus>
References: <20201009141051.27365-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009141051.27365-1-olivier.moysan@st.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, alexandre.torgue@st.com,
 linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com,
 lgirdwood@gmail.com, broonie@kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
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

On Fri, 09 Oct 2020 16:10:51 +0200, Olivier Moysan wrote:
> Convert the STM32 SAI bindings to DT schema format using json-schema.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
> Changes in v2:
> - use pattern for compatible of child nodes
> - rework dmas and clocks properties
> - add "additionalProperties"
> 
> Changes in v3:
> - move clocks properties for st,stm32h7-sai compatible, to 'else' clause
> 
> Changes in v4:
> - fix dtbs_check errors
> ---
>  .../bindings/sound/st,stm32-sai.txt           | 107 ----------
>  .../bindings/sound/st,stm32-sai.yaml          | 200 ++++++++++++++++++
>  2 files changed, 200 insertions(+), 107 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
