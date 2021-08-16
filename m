Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17508C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 19:59:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2973860F41
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 19:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2973860F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3DBC112;
	Mon, 16 Aug 2021 21:58:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3DBC112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629143968;
	bh=s9l5IsedF/5S4SnJF4fAydWyt7KoVJCD7oSIXdqwVD0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NjAo3lwpdc93bgi+/bLhoi72tW+cveOCy6i3rX6ltDvGpO9vJ4kyqCMCIJPpmZPoL
	 aik7bicOkRT/nNRV0hkaX0zPlnv26rdqkqcQM2A7ou+r/3wEsHu54Xo9WjXxgPM5IH
	 q0lTg0cdsEUTf5O4uWYjQrTOpYPz70GlY/kzNJ4c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 604D2F80246;
	Mon, 16 Aug 2021 21:58:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 177F4F80249; Mon, 16 Aug 2021 21:58:37 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7D90CF80134
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 21:58:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D90CF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Ue/nsPau"
Received: by mail-pl1-x633.google.com with SMTP id f3so21928580plg.3
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=s9l5IsedF/5S4SnJF4fAydWyt7KoVJCD7oSIXdqwVD0=;
 b=Ue/nsPauk7U6/n3kytH2QA63vMZ7hMlJ6o+jRyIO+TXAAn5Cfyd6nWdtYBbtA3J3Pt
 gGMXmjbTyBKeY9AzbTy4YzVaR9PQETDQGPWorPB6gHG3IG9zujI1tzKVBlFZwGelsnav
 of61ongXjhXr7f7H1Qk+p/jqWXgGnwRs59kpdQ1gV4Lix0lkWdjtCJF3URLF/Dr/Ps6G
 p7OJhTRksVzsrtxSpnUwzBOukJnVsGWpiPYN5iUBKKQ4ybPZDYEgoadJ1wEGvaxoTxti
 o++Om859MCxZz4jSnVxGTcYmItEURXy2BxxQxigQyKeVOVeSVOwfIbKMLVHssa/9d6wu
 4UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=s9l5IsedF/5S4SnJF4fAydWyt7KoVJCD7oSIXdqwVD0=;
 b=VIR23IA02KXbgnGYhWqdKVbT5fvi8Xc374ye02rs0yfN+5xa4hbls/oaKry/EK0Iwg
 vc8m0427ajDGg50zEzUZ7HIdZt9zUcnkIcZeuECFt9iIyQ5vxSxUcMPciHoy8O6i1NMC
 YNAz5HY8kkX4wdrOh2Jc04OnJov9AOVw8yQ6g4tT0jA9Ps8acWwsPYGUuIm/eBhtRX3m
 qqCb7Ga3fjyBLQukdyI8/GG2No1t5C5kzCNB4lyhPfphrt8TpSwaZKytp5naflZ80AFO
 lMs6wVxkq/pFLI2o7cYidmngaM3tj2dRtsmNu7z9KB+3HkuEV6TphubzFBTXXq+bhoYS
 tgFA==
X-Gm-Message-State: AOAM530+mBxmb3aSnMrp9g2UHdWakLnJ/XrszSwtS4wounLAtF7BQxpS
 q1KdpmUx2MbRRW9Gk7XWhFY=
X-Google-Smtp-Source: ABdhPJy5BO8UPitxBJFGj9SnL787Ml47xibIqz1zp+gWTNa1A1DD/jzJ8/nvqsnSQnuQlY7WyZGZxQ==
X-Received: by 2002:a17:90a:116:: with SMTP id b22mr239613pjb.97.1629143908577; 
 Mon, 16 Aug 2021 12:58:28 -0700 (PDT)
Received: from localhost ([49.207.137.16])
 by smtp.gmail.com with ESMTPSA id l11sm119501pjg.22.2021.08.16.12.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Aug 2021 12:58:28 -0700 (PDT)
Date: Tue, 17 Aug 2021 01:28:24 +0530
From: Aakash Hemadri <aakashhemadri123@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: tegra30: ahub: Use of_device_get_match_data
Message-ID: <20210816195824.ulvnb2kfas4rtpjt@xps.yggdrasil>
References: <cover.1628971397.git.aakashhemadri123@gmail.com>
 <e568d621c9c05ee23732a6a6f9e3606a780b1707.1628971397.git.aakashhemadri123@gmail.com>
 <20210816183906.GC4253@sirena.org.uk>
 <20210816194621.mrudqykxvkbt3a2w@xps.yggdrasil>
 <20210816194934.GD4253@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816194934.GD4253@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Bjorn Helgaas <bjorn@helgaas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Shuah Khan <skhan@linuxfoundation.org>,
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

On 21/08/16 08:49PM, Mark Brown wrote:
> Since I applied the patches please send an incremental fix on top of
> what's been applied rather than a v2.

Will do Mark!

Thank,
Aakash Hemadri
