Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9104FC433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jun 2022 13:49:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70E9416BF;
	Mon,  6 Jun 2022 15:48:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70E9416BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654523368;
	bh=pNb8/cHtExl8X5RDcZzVzKU9o0g3SCz+nU7o7IkmV/U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gMQHdQgb7QcJmZkvOlJFf8QzFp99WRhkedwWy49qUH+BrB2qEEdRI18nuynp9HYnU
	 C5NxjpMBwlFsgr5UbzQmvgwl+X/3w8Ose3EpPz495U1AROUwz0cSc59M6NTrdpnpGj
	 tPP3PlTfUwV9CBaVMxbbbYtTFlXyaG250C3KzJYc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 17815F8012A;
	Mon,  6 Jun 2022 15:48:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8311AF801D8; Mon,  6 Jun 2022 15:48:37 +0200 (CEST)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com
 [209.85.166.170])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B865EF80109
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2022 15:48:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B865EF80109
Received: by mail-il1-f170.google.com with SMTP id u2so11026970iln.2
 for <alsa-devel@alsa-project.org>; Mon, 06 Jun 2022 06:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Iq+/ZT5S/tsKY65k+c5zzqLlMmHdbOtpYrK6tQD4cqY=;
 b=L6DUFvxTKDUu6K5kqyAfllI3gD3hh/Z0mQJ0aWexTfpDRBFjFPrVcqomjhQzmI1uct
 taMWLqoUESHM8M0+/AO6IQPs3IjYPezIAHZtc1JYU8NjiK2kNA9Db+UJqNtul5WfaxQe
 7Ry8865zf+8zBi9Y1af1W9W1pcksusS+SymstlbkR/t/i8VFtET2kU3nRq52OI5wvZPN
 OtLMvOaKxsRvrlVreYlG8d8KcOOzSJUkZi62q0/5/eabyd78LokLY9qzM2qqcaJvsjSg
 40Pm9SfYH7bD2zESAFbkqUq9M3CrSP8BIypl7ju0MsxJjzHyBEHbbCz2DMBLBkfZoZx5
 LsJA==
X-Gm-Message-State: AOAM533D6f4rC8ST25hidJfdU/SQGetGy2L3RZQ2FYqq7t4uLbbbAQ4d
 kNQTVfWod45Sn/T1iym54w==
X-Google-Smtp-Source: ABdhPJwbi6EJiI2PaM91wEcFQReWOmrXQCRfzQHoHXpccKkWDSHoKnOoq6i68X1AyLTQWbbX3840mg==
X-Received: by 2002:a05:6e02:15ca:b0:2bf:ad58:4a6d with SMTP id
 q10-20020a056e0215ca00b002bfad584a6dmr14825916ilu.13.1654523306793; 
 Mon, 06 Jun 2022 06:48:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
 by smtp.gmail.com with ESMTPSA id
 y38-20020a029529000000b0032e583132e4sm5675598jah.123.2022.06.06.06.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jun 2022 06:48:26 -0700 (PDT)
Received: (nullmailer pid 632986 invoked by uid 1000);
 Mon, 06 Jun 2022 13:48:24 -0000
Date: Mon, 6 Jun 2022 08:48:24 -0500
From: Rob Herring <robh@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH v3 1/6] ASoC: tegra: Add binding doc for OPE module
Message-ID: <20220606134824.GB564610-robh@kernel.org>
References: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
 <1654238172-16293-2-git-send-email-spujar@nvidia.com>
 <20220603203003.GA852734-robh@kernel.org>
 <b70e024b-4f80-16b9-4bbe-ed8a24a384df@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b70e024b-4f80-16b9-4bbe-ed8a24a384df@nvidia.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 catalin.marinas@arm.com, tiwai@suse.com, broonie@kernel.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, linux-tegra@vger.kernel.org,
 jonathanh@nvidia.com, will@kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jun 06, 2022 at 01:47:48PM +0530, Sameer Pujar wrote:
> 
> On 04-06-2022 02:00, Rob Herring wrote:
> > Doesn't apply for me. I guess there is some undocumented dependency
> > here? Resend after the merge window if that solves it.
> 
> These were getting applied fine on linux-next.

linux-next is not a base maintainers can apply to. Convenient instead of 
having to get a specific tree, but you still need to say what the base 
is (what tree it should be applied to).

> Merge window seems to have closed now and v5.19-rc1 release is out. I can
> apply these cleanly on v5.19-rc1. Please let me know if re-send is needed
> now or I need to wait for some more time? Thanks.

Yes, or the automated checks don't run.

Rob
