Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27B4C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 02:12:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2889861477
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 02:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2889861477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54F67166A;
	Tue,  2 Mar 2021 03:11:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54F67166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614651128;
	bh=vwyUtDxwiNKk+ynoP3q+QLEEjbm/rJVYSWUVbdibiKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uyDMmcL6POWIAV1Q4OilIN/nlCPLAjOi0vg9VHk1HNH1ohXUWqdWRCwo4PNOlsTpE
	 USe/Iq99hhfAQwvCJUrFt8QTLYeEzEQB+ICIGqzjyY0mJTCRXFA4n79ftv/TTOlf5I
	 WQsYg6y7GTUlXsGR5GBNEyLN1SKhvMHHwaPJIqfQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D4CD7F80257;
	Tue,  2 Mar 2021 03:11:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63411F8025E; Tue,  2 Mar 2021 03:11:16 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E16EBF8010B
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 03:11:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E16EBF8010B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="rbKRB3kU"
Received: by mail.kernel.org (Postfix) with ESMTPSA id B38D160234
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 02:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614651066;
 bh=vwyUtDxwiNKk+ynoP3q+QLEEjbm/rJVYSWUVbdibiKU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rbKRB3kUrCgw5NeYHrpMgzimtGvCrWXkFsibJcBZjZ3NlolKoBurfLrbqEpwKjUg1
 R3kpc1bIDqVJCviwFqlDOItVDd9kydfT5xsVQkEk0lc2lrLKY+p1xjm8ZFzxe+eTRP
 Q6n4HpeWZb3ItmmT8bFNC92yxnAz55rcqxeuSqg/nQNGwuDbPBEkcXADYJjBS1GNDT
 WQUGO3AvpyeOexLYUTAqM5PzsT5mp9XBYjZj0ObV82NVE0m4hnm8OrBBTwrHwanDYW
 /BswQDCK3RgIBmWJkcrl7+5LM6xY7GGGfOiGwmtt84AF6Y9bizxyBs4Dle8/ap/xJd
 aMqiGN5Thv79w==
Received: by mail-ed1-f48.google.com with SMTP id d13so18307055edp.4
 for <alsa-devel@alsa-project.org>; Mon, 01 Mar 2021 18:11:05 -0800 (PST)
X-Gm-Message-State: AOAM532QnaANE+nVB8p9JZNpeWbMVlNyFa8dikOV5aLt10ft+etL5cXC
 +A91MMrbgJqfAme3qa5SVLi6IfjI9qeLiAz9pw==
X-Google-Smtp-Source: ABdhPJyWebOHWQP7njU4m2dvQglQXnk4r5eZJ4pcMx2WhPXBWc0SlmoYi4n8+GWICYKhfnpGtYXlrCdIRZMY5g5sG20=
X-Received: by 2002:aa7:c991:: with SMTP id c17mr18868381edt.165.1614651064202; 
 Mon, 01 Mar 2021 18:11:04 -0800 (PST)
MIME-Version: 1.0
References: <1614276364-13655-1-git-send-email-spujar@nvidia.com>
 <1614276364-13655-4-git-send-email-spujar@nvidia.com>
In-Reply-To: <1614276364-13655-4-git-send-email-spujar@nvidia.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 1 Mar 2021 20:10:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+9esDGw7ZCLnZS_KLmLUFyVenz83ohgNKFK3bdPD2ouQ@mail.gmail.com>
Message-ID: <CAL_Jsq+9esDGw7ZCLnZS_KLmLUFyVenz83ohgNKFK3bdPD2ouQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] ASoC: audio-graph-card: Add bindings for sysclk
 and pll
To: Sameer Pujar <spujar@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
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

On Thu, Feb 25, 2021 at 12:06 PM Sameer Pujar <spujar@nvidia.com> wrote:
>
> ASoC core provides callbacks snd_soc_dai_set_sysclk() and
> snd_soc_dai_set_pll() for system clock (sysclk) and pll configurations
> respectively. Add bindings for flexible sysclk or pll configurations
> which can be driven from CPU/Codec DAI or endpoint subnode from DT.
> This in turn helps to avoid hard codings in driver and makes it more
> generic.
>
> Also add system-clock related bindings, "system-clock-direction-out"
> and "system-clock-frequency", which are already supported.

This all looks like duplication of what the clock binding can provide.
We don't need 2 ways to describe clocks in DT.

Rob
