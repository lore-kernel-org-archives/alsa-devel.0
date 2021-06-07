Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BE7C47082
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 19:52:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE7661108
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 19:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE7661108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=b4.vu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 223E21672;
	Mon,  7 Jun 2021 21:51:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 223E21672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623095541;
	bh=qx5N1H1eoV0hwhrwtNtb7evqpbnON3iVIYpUk7dF5Sk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gp3o9KcsstWJVYwxbtbdMknl2KBBg6aK3lKG7t4DV5Fn17VYCsXXBElTYDdWy/HYz
	 rEhkzGsM7CA8TDfY18NQ2jldZ0d/wlyMHjOpOp0ziMjJMhDrQoDMnB5xCIqeJLhrwH
	 KjA+Vjo6F+IGI1Iy6gY/2xQ+WDV/sQ/XZr6B1ALw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24011F8020D;
	Mon,  7 Jun 2021 21:51:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A8DDF80212; Mon,  7 Jun 2021 21:51:27 +0200 (CEST)
Received: from m.b4.vu (m.b4.vu [203.16.231.148])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CBE1F800AF
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 21:51:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CBE1F800AF
Received: by m.b4.vu (Postfix, from userid 1000)
 id 5A7D961956CD; Tue,  8 Jun 2021 05:21:16 +0930 (ACST)
Date: Tue, 8 Jun 2021 05:21:16 +0930
From: "Geoffrey D. Bennett" <g@b4.vu>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 0/2] ALSA: usb-audio: scarlett2: Read all configuration
 at init time
Message-ID: <20210607195116.GA182875@m.b4.vu>
References: <cover.1622974661.git.g@b4.vu>
 <s5h1r9ef895.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h1r9ef895.wl-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Daniel Sales <daniel.sales.z@gmail.com>, alsa-devel@alsa-project.org,
 Vladimir Sadovnikov <sadko4u@gmail.com>,
 Markus Schroetter <project.m.schroetter@gmail.com>,
 Alex Fellows <alex.fellows@gmail.com>
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

On Mon, Jun 07, 2021 at 09:23:34AM +0200, Takashi Iwai wrote:
> On Sun, 06 Jun 2021 16:16:44 +0200,
> Geoffrey D. Bennett wrote:
> > 
> > These two patches add support for reading the mixer volumes and mux
> > configuration from the hardware when the driver is initialising.
> > 
> > Previously the ALSA volume controls were initialised to zero and the
> > mux configuration set to a fixed default instead of being initialised
> > to match the hardware state.
> > 
> > The ALSA controls for the Scarlett Gen 2 interfaces should now always
> > be in sync with the hardware. Thanks to Vladimir Sadovnikov for
> > figuring out how to do this.
> > 
> > Takashi, if these pass your review, I believe that they are
> > appropriate for:
> > #Cc: stable@vger.kernel.org
> 
> Well, in general, having a proper fixed value for the initial mixer
> value is the right thing, which is a part of the driver's role.
> Though, in snd-usb-audio, we don't set up the initial values just
> because of laziness; since the topology in USB audio is variable per
> device and often hard to parse correctly, it's difficult to determine
> the suitable initial values, hence we leave untouched.  So, in that
> sense, setting the zero isn't wrong, rather safer, per se.
> 
> However, Scarlett 2 seems to want to be different; it has already some
> initialization code to read the existing configs.  So this change
> sounds more or less acceptable.  But it's questionable whether it's
> really for stable as a "fix".

For the Scarlett devices, the sensible (but not all good)
initialisation options are:

1. Don't load configuration from hardware so the ALSA controls show
default values not in sync with hardware. This is a bad user
experience.

2. Reset hardware configuration to hard-coded defaults so ALSA
controls will be in sync with hardware. This is a really bad user
experience as it is common for the device to be configured using the
proprietary vendor-supplied software and then connected to Linux with
the expectation that the configuration is kept.

3. Load configuration from hardware so ALSA controls are in sync with
hardware. This is a good user experience.

Before these two patches, it was option (1) for the mix/mux controls
and option (3) for the remainder of the controls. I would call this
definitely not sensible behaviour.

I got many queries as to the apparently strange workings of the driver
due to this; certainly many users besides myself considered the
original behaviour a bug so it does fit the rule "It must fix a real
bug that bothers people" from
Documentation/process/stable-kernel-rules.rst

You might consider that it does not meet the "It must be obviously
correct and tested" rule though, and I could agree with that. Perhaps
leave it out from stable for now and revisit later after we get more
test results? Is there a particular amount of time or number of test
success reports that you would consider sufficient?

> In anyway, please fix the bug ktest bot spotted, the missing endian
> conversions and resubmit.

Thanks, I have resubmitted.

Regards,
Geoffrey.
