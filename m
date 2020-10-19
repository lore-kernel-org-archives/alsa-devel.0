Return-Path: <SRS0=W2oN=D2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699EEC43467
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:49:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1E1223FD
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="e4G4AGBg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1E1223FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 950AF16F3;
	Mon, 19 Oct 2020 22:48:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 950AF16F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603140562;
	bh=oi8wGhEsvuY/SFHt/nDa0WBwIEEttQAUKB/mGGvThRA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e4G4AGBgeaev+y+Rxyzusfao61UIzR+fVqHf1gIVsdrQZFoAuam9SlOQm4pT+KauD
	 lo4VeQ1kGF9TxXmKPk1b7rW5r/4j2eU22o8xHtNdduLIBd7gC6OBV+0a8hMxMM1Y4j
	 gvFs6qBQDRZPTIJepftIOsR/Bp60Cj+eVd8Q9hvA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 825ACF801D5;
	Mon, 19 Oct 2020 22:48:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 60243F80247; Mon, 19 Oct 2020 22:48:29 +0200 (CEST)
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com
 [209.85.161.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3E216F801A3
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2020 22:48:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E216F801A3
Received: by mail-oo1-f67.google.com with SMTP id l18so261747ooa.9
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2020 13:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fxa3uzHmULeVmNdtF5y01CM2QpDZ2ApdIjLlwOHG4sY=;
 b=P2m67sya1mL7qbaaE4yUsX+kK7KMemMZs2jDxfvqcQN/z1fhjfEZ2fwfdD9Ui4yOf5
 wZ9FtnSUTfa1CUcVuHlItOUHLJCox1z+txPk3f/MRKqRHGjZveXXZrlpwFN4lbfWP8x7
 R275Tfc7/VU3x9scLFCJ43AzQpSdebwcWyzEezeWzZAvAjGMr5uWkhDm1+xtaDuu1cWh
 4sEEEs21dSo0FycFAn1Yocg7kt3r/OrteNr5OwIjhsjq5YDTqeX7rkry272c1YafUlcw
 QeAeZK+g5FS9yKWmXaMKaPJ8WJcE87cG+EQeP7UvX3t3LGt22E6c0wYNz/8IxrpA6rfZ
 U4vg==
X-Gm-Message-State: AOAM5305gZ4pZt15MNYaPZFJLNRaYy9h8WO+dErD/BaWPXIWiKngyQzs
 QBtAbpCWchCyVu9sNs59Mw==
X-Google-Smtp-Source: ABdhPJwl/iQfkO5suixU4PBWEHxz8p2fHudaNaiDXdTvQ5KBbgmlpr2GV9/HQXy//V7q3Emcotkdtw==
X-Received: by 2002:a4a:dc0d:: with SMTP id p13mr1278563oov.2.1603140504163;
 Mon, 19 Oct 2020 13:48:24 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id j191sm237505oib.52.2020.10.19.13.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 13:48:23 -0700 (PDT)
Received: (nullmailer pid 3577895 invoked by uid 1000);
 Mon, 19 Oct 2020 20:48:21 -0000
Date: Mon, 19 Oct 2020 15:48:21 -0500
From: Rob Herring <robh@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/7] Add dts for Rpi4 + Cirrus Lochnagar and codecs
Message-ID: <20201019204821.GA3569507@bogus>
References: <20201014145418.31838-1-rf@opensource.cirrus.com>
 <20201014185632.GD4580@sirena.org.uk>
 <b3376cd4-010f-cf72-8c81-1f5d22cb6454@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3376cd4-010f-cf72-8c81-1f5d22cb6454@opensource.cirrus.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 nsaenzjulienne@suse.de, linux-rpi-kernel@lists.infradead.org
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

On Fri, Oct 16, 2020 at 02:30:08PM +0100, Richard Fitzgerald wrote:
> On 14/10/2020 19:56, Mark Brown wrote:
> > On Wed, Oct 14, 2020 at 03:54:11PM +0100, Richard Fitzgerald wrote:
> > > This set of patches provides support for using the Cirrus Logic
> > > Lochnagar audio development platform plus Cirrus Logic Madera/Arizona
> > > codecs with the simple-card machine driver and a Raspberry Pi4. The
> > > ultimate aim is to provide the dts file but some updates are needed to
> > > the simple-card machine driver.
> > 
> > Why extend simple-card and not the more modern and flexible
> > audio-graph-card?
> > 
> 
> I'm struggling to understand how to use audio-graph-card where there are
> multiple alternative codecs. The host I2S endpoint has to point back to
> the codec endpoint, like this:
> 
> 	cpu_i2s_ep_cs47l15: endpoint {
> 		remote-endpoint = <&cs47l15_aif1>;
> 	};
>
> But obviously that depends on which codec node was enabled. Listing
> multiple endpoints makes the whole port node disabled if any remote
> endpoint is in a disabled node. I've tried adding status="disabled"
> to endpoints or multiple port definitions with status="disabled" but
> I haven't figured out a solution.

Multiple endpoints is what you should do. And 'status' goes in the 
device nodes (not the graph nodes).

Rob

