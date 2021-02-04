Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D33C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 13:47:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8580E64F45
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 13:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8580E64F45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C466016DD;
	Thu,  4 Feb 2021 14:46:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C466016DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612446430;
	bh=5YGrmL2V6B3c99pwNr/oyzcjeXThHVo7PnuQ5Pl6/s8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y7tCAJdJbl7opOTUw+frAb+ShuHKf7LhOIjV7nMqYAedifdmVUK/qUzyXx/K7ub4j
	 7Ad/Yd78v3MbzUN2PQ5OBamTK+2zAh4tBvlbcqiugxvuMnoJN2Uytb1YFbU47/XBck
	 CtoUkTLMXHFrNGqz2CpQ2Myv7mVIKndFUL3BnGz8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C6F0F80155;
	Thu,  4 Feb 2021 14:46:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86F79F80171; Thu,  4 Feb 2021 14:46:18 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6FDD8F80152
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 14:46:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FDD8F80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="vcX10tK1"
Received: by mail-wr1-x42b.google.com with SMTP id z6so3525719wrq.10
 for <alsa-devel@alsa-project.org>; Thu, 04 Feb 2021 05:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=Dc2qXVoLurmP1y6qGwsvfYp52EWzBpvbfbLeLIxscWo=;
 b=vcX10tK1JXGeAOOqnN5qkSnrM0WTN2R/PdrCmgvbefToo/2uSgDcfLT6Xd8NM/mKEl
 xMfRDm0yVYJQX8w/QhvLlCks+9AJgUiQlDMqupirjP9dAV0pn+XAbUpv9gpNFwEGNg22
 q7fBzmF0ensUbqLyzqCPm+6i+m+rvJlO3fHrtyCKdwTStk1H03Adc9d3bxeuqJ5zRd4L
 3vtLRDddOqVlUf9sVnHZ9h+8USZ3ZMEykRzMLAAoi6qeQWO328wvXjZNDf+2HmShrvoP
 hRkKEUGLbrHEPnVLdHJ+K7BUj3rgzVaPyFWh11Q0ZFB93DpTM7LsdzjIbKazFBKf0Q8A
 9l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Dc2qXVoLurmP1y6qGwsvfYp52EWzBpvbfbLeLIxscWo=;
 b=DEWoOxw0W/3KD8qTxDmhnUoDv3AZGLYSBeLtw+n6RjJ42W5VYLMFHS8nIkwtp2gALo
 0GIj/LsIsLOx+N5cPCUC/yIebVN9TvJ7XKuZ5Bdf85eIeO5P2iDjamF4exN++kSzzSi9
 XWEnyTB6HjeisQIYsWjxAIVwTOQ2QfhcsLmrybxfwvyJ3KoZmEn42/HNucgOocTST2uq
 k9cnkMe4fo1F5LYjKjAncbzXF3LyJdnWdGFllnpCxgi/ysa2vM6uBcwQpxoniSTplvHD
 ov7y9OP2WT2ZptejkB0NaW8LuuRFviFE5ZcIHD6INpJxHnOLD1TBdIAm5tXpRfLWxB7A
 MiYQ==
X-Gm-Message-State: AOAM531+asEjqe/h0pg3ZJa6erqwZ6WVdCJcDULu6LZ/arw7JYhaoF6x
 zyrZOF3HXHVUDvT8ULpbvLeDGA==
X-Google-Smtp-Source: ABdhPJydeDZ+8e1+KMnG8GflcBvfY2Mg3GWNDaEqkj0KlgohdEXPBXZQ8GD5ktuU19qx3aBMThKUPA==
X-Received: by 2002:adf:81e4:: with SMTP id 91mr9635163wra.161.1612446368624; 
 Thu, 04 Feb 2021 05:46:08 -0800 (PST)
Received: from dell ([91.110.221.188])
 by smtp.gmail.com with ESMTPSA id b4sm7912769wrn.12.2021.02.04.05.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 05:46:08 -0800 (PST)
Date: Thu, 4 Feb 2021 13:46:06 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards
 with WM5102 codec
Message-ID: <20210204134606.GH2789116@dell>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <249f1a7c-048e-d255-d860-68a97a0092c8@redhat.com>
 <20210204105748.GD2789116@dell>
 <7f53dede-946e-c38e-e871-3df1119f1faf@redhat.com>
 <20210204124335.GA4288@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210204124335.GA4288@sirena.org.uk>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Thu, 04 Feb 2021, Mark Brown wrote:

> On Thu, Feb 04, 2021 at 12:07:49PM +0100, Hans de Goede wrote:
> > On 2/4/21 11:57 AM, Lee Jones wrote:
> > > On Thu, 04 Feb 2021, Hans de Goede wrote:
> 
> > >> series are both ready for merging. All patches have Reviewed-by and/or
> > >> Acked-by tags now.
> 
> > > I don't think they do.  You're missing ASoC and Extcon Acks.
> 
> > Right, what I meant is that the patches have been reviewed by other
> > stake-holders, including the follow-up series being tested by the cirrus
> > codec folks (thank you Charles).
> 
> > But yes the actual subsys maintainers have not acked these yet;
> > and I'm aware that you will need those for merging this through
> > the MFD tree.
> 
> The usual pattern here is that the MFD patches get merged and then I
> pull a shared branch in for any dependencies - at this point the series
> is now on the backlog of serieses where I'm waiting for the MFD to sort
> itself out before I really look at it again.

I tend to push patches awaiting Acks to the back of the queue.

Stalemate.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
