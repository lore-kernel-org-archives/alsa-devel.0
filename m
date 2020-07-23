Return-Path: <SRS0=vWr5=BC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A504FC433E3
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:57:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3209220771
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 15:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MZbYlLLj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0oyzTe84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3209220771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC6B2167E;
	Thu, 23 Jul 2020 17:56:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC6B2167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595519844;
	bh=GcS2kAU29xEZ0jnjZv+lYshFkwhHH/EsbplOO3bG05k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MZbYlLLjQzN+RUoZpADG2zYB4C0G+AXhvWpolfSAkce9vO6hm5H3HVM3uY5qbEb5H
	 MzGXr3zDHyx5t/8lw3mM1t1bbGeznDKNF9mAdenVngefLb2DnLtpbMZ+Us2LLg+2tP
	 MSWKfJ27qL7o2wJ3RLTNv8RtQJKAEnJ2To08rXdE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D6CEF8020D;
	Thu, 23 Jul 2020 17:56:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 834A6F80212; Thu, 23 Jul 2020 17:56:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 788A3F80090
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 17:56:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 788A3F80090
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="0oyzTe84"
Received: from localhost (unknown [122.171.202.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 15CBB2071A;
 Thu, 23 Jul 2020 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595519777;
 bh=GcS2kAU29xEZ0jnjZv+lYshFkwhHH/EsbplOO3bG05k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0oyzTe84hn6Vi+wGOvEXcgLfAzirXbWQJ19VhKfJoYDqWTBUsvmi/Ur6HbDyxfBgK
 OjloT3wXweREikgFKAWxvNvD+ia6USsUei/xHKb5GqTHWIOy3LVZBSvWWni91il77j
 d+RHqZ7QrGeIFiwWbZXrK3MKpywI/hUmjwsAht0I=
Date: Thu, 23 Jul 2020 21:26:12 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [RFC PATCH v2 0/6] ALSA: compress: add support to change codec
 profile in gapless playback
Message-ID: <20200723155612.GC12965@vkoul-mobl>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <s5hpn8mqudq.wl-tiwai@suse.de> <20200723130522.GB12965@vkoul-mobl>
 <s5hlfjaqsk7.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hlfjaqsk7.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
 broonie@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

On 23-07-20, 15:17, Takashi Iwai wrote:
> On Thu, 23 Jul 2020 15:05:22 +0200,
> Vinod Koul wrote:
> > 
> > On 23-07-20, 14:38, Takashi Iwai wrote:
> > > On Tue, 21 Jul 2020 19:00:01 +0200,
> > > Srinivas Kandagatla wrote:
> > > > 
> > > > For gapless playback it is possible that each track can have different
> > > > codec profile with same decoder, for example we have WMA album,
> > > > we may have different tracks as WMA v9, WMA v10 and so on
> > > > Or if DSP's like QDSP have abililty to switch decoders on single stream
> > > > for each track, then this call could be used to set new codec parameters.
> > > > 
> > > > Existing code does not allow to change this profile while doing gapless
> > > > playback.
> > > > 
> > > > This patchset adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL along with
> > > > flags in capablity structure to allow userspace to set this new
> > > > parameters required which switching codec profile, either for gapless
> > > > or cross fade usecase.
> > > 
> > > One idea that came up at the previous audio conference regarding this
> > > implementation was to just allow SET_PARAMS during the stream is
> > > running (only if the driver sets the capability) instead of
> > > introducing yet a new ioctl and an ops.
> > > Would it make sense?
> > 
> > That does sound good but only issue would be that we need to somehow
> > mark/document that buffer info is useless and would be discarded, how do
> > we do that?
> 
> Yes, the buffer and no_wake_mode can be ignored in the gapless
> re-setup.  Is your concern only about the documentation?  Or something
> else needs to be changed significantly?  It's a new scheme in anyway,
> so the documentation update is required...

My concern is potential abuse of API down the road, if you feel it is
okay, I am okay with the proposal

Thanks
-- 
~Vinod
