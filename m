Return-Path: <SRS0=4l9v=GP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E452C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 19:10:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2917023109
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Jan 2021 19:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2917023109
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8FCD516B2;
	Tue, 12 Jan 2021 20:09:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8FCD516B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610478621;
	bh=wP0pKnGxvW2YrVteg+jwf411EVpSExoLZtMY/1uBq04=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oh44ZSsdvzAuUFRjRrJrjX0ZypSke98rCF+RD2WIP2ylPQSs38BUdnY9nfFSIoETu
	 Ylt2yJucMXrh/UNJGKnt84CtIp2weVu+VB/oqXMQrKxx/y/QWjm/13vIhFBENWbpHd
	 3jR0TYVTHkuGXqeiO480oEDeQ0X5SoK3fQmR0zcc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2573FF80113;
	Tue, 12 Jan 2021 20:09:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19AE6F8025E; Tue, 12 Jan 2021 20:09:29 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89ED5F80113
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 20:09:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89ED5F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Ph1/Gxgy"
Received: by mail-qk1-x731.google.com with SMTP id 19so2879905qkm.8
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2021 11:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CPfEryF2bxPOdgxHkNjvHkSKCpA8G96wI04AOG3xMSg=;
 b=Ph1/Gxgy/41uF4BAAfVDKy7+imzx904TvEw+Eu/WblDKtQtdri1X4MDaStPM7awQ7I
 sOI/tgXlhTD39bLtKzCH3BBetYGzwkHWCn420dJExppM8vIn63xtrRpMg2cfcnmmhuKC
 rruw5KY6mTE53Wkxicns7eEBwcy2BPkue5zB0u3bN/gZOYSLNuHc94DIZoqWz4bdnCnm
 osZp+ndQyIlh3Zqfh8yn/oQgYOgWayRSBaeczRwJjpsm/qa1CI6ReZDOmnulR63X/ATQ
 fHCWmB74oiCx5teGkpmHMmgnXFa53TQVBafdSCGjtJk3YnEsf8id6sWiWMyADr+7fFrb
 f8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CPfEryF2bxPOdgxHkNjvHkSKCpA8G96wI04AOG3xMSg=;
 b=MlViWNvFXg7WQDugWc8DOw7d1BuutZ7tK/ATYuwzRmMSWqEW3qSxUVBaFkelsgBDlB
 Mep8iVxGwtxpILe+NuX2c9+HjpPgPa1PemaWASNNYz23T+qh085fryzcXnAPC53R6sDt
 CdRw9pbbmHX7GDGISGLt7XV7BY/qM6udSC3ngqlrS06OvHXTuzt3Q5N93HytRl9GeiIL
 oTCMJgxIs50s0509O1MvUamYmoZMV06K45DSrLn0nCn4Cm/eNaMvWB2m9DuPIU452erN
 qWiazet77654CVVFdql+OwDCUNAK3KccLbreFOfDfn/EAA13lYPH6dQhe0fPL5Gic19q
 yKBg==
X-Gm-Message-State: AOAM5323MSPNQGViijVVyPa9atAiXI3HQsy77DOcm9XHM4wS5mQXbPsV
 ZzNxUgaB9Gf/DjUDJEvCTfQ=
X-Google-Smtp-Source: ABdhPJzPgfw/zVoqhZTuXj+3LsvbWpph1NVpC1slqYO+oR5yTcVJwoUscYt3sisXvbLe7akxa/MdDg==
X-Received: by 2002:a05:620a:10a8:: with SMTP id
 h8mr821484qkk.315.1610478564017; 
 Tue, 12 Jan 2021 11:09:24 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
 by smtp.gmail.com with ESMTPSA id v4sm1629295qth.16.2021.01.12.11.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 11:09:23 -0800 (PST)
Date: Tue, 12 Jan 2021 12:09:21 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-hdmi: Fix warning of the uninitialized
 variable ret
Message-ID: <20210112190921.GA3561911@ubuntu-m3-large-x86>
References: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
 <20210112181949.GA3241630@ubuntu-m3-large-x86>
 <20210112184848.GG4646@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112184848.GG4646@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 tiwai@suse.com, nicoleotsuka@gmail.com, festevam@gmail.com,
 linux-kernel@vger.kernel.org
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

On Tue, Jan 12, 2021 at 06:48:48PM +0000, Mark Brown wrote:
> This is a random warning fix, why would you expect it to be sent as a
> bug fix?  This is the first indication I've seen that anyone is seeing
> it in mainline, in general the people who report and fix warnings are
> doing so based on -next and the patch seems to be from a month ago.  I
> don't have this in my inbox so I assume it's applied already or needs to
> be resubmitted anyway.

Well, I consider compiler warnings bugs. I have had plenty of my
compiler warning patches sent as bug fixes for an -rc. Furthermore, this
patch was sent three times by different people, that should give you some
indication that people are tripping over it.

https://lore.kernel.org/alsa-devel/X9NGQaF4pmK8oUAF@mwanda/
https://lore.kernel.org/alsa-devel/1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com/
https://lore.kernel.org/alsa-devel/20201230154443.656997-1-arnd@kernel.org/

The first version was sent on December 11th, it looks like your pull for
5.11 went on the December 14th, then the second version was applied on
December 16th so I figured it might be destined for 5.11 but I could not
tell (your for-next branch is a merge of your for-5.11 and for-5.12):

https://lore.kernel.org/alsa-devel/160813397775.31838.8934909997692637790.b4-ty@kernel.org/

Cheers,
Nathan
