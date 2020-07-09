Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A974EC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 22:30:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F7A620720
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 22:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h9JOgOGS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKqKKc8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7A620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2303950;
	Fri, 10 Jul 2020 00:29:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2303950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594333847;
	bh=E208A14aCfyfhIZEqe3NQHFbrt6g5zBe4tEPba/Vq9o=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9JOgOGS0t6vfyf7E7J4fkYFpJuyaWmUOzb5mF4eIB/edptZLPtnSHCMMU0iKZYBW
	 3eehbKJyUdvDV8JN3BGJePVn9tmlDEr3m2a7xoHdPxVmI5WQK3hm2s+WPuFdMv0j5D
	 bWcK65r/qrB4PyNvxWteg42Y1OAEh86b0HC2dqmc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1876EF801F9;
	Fri, 10 Jul 2020 00:29:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 573DFF80216; Fri, 10 Jul 2020 00:29:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0103CF80117;
 Fri, 10 Jul 2020 00:29:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0103CF80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NKqKKc8x"
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C286A2070E;
 Thu,  9 Jul 2020 22:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594333780;
 bh=E208A14aCfyfhIZEqe3NQHFbrt6g5zBe4tEPba/Vq9o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NKqKKc8xnvizQPi2StbY0b8q08RvrvefMq4WRetFnCvzXi4Ubx588t32FpsogtlwB
 kbyEITE2574L4GkNN42uoE0xB/omC4c1XcFwWetzUTLtbuMpjYgVVhZ5X3E03sU90/
 XQ5sErkspJfMvHFH7oTBSHySz/8jCT38FEJ91BVQ=
Date: Thu, 9 Jul 2020 18:29:38 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.7 15/53] ASoC: SOF: Intel: add PCI IDs for
 ICL-H and TGL-H
Message-ID: <20200709222938.GC2722994@sasha-vm>
References: <20200702012202.2700645-1-sashal@kernel.org>
 <20200702012202.2700645-15-sashal@kernel.org>
 <20200702111835.GB4483@sirena.org.uk>
 <0baf17f3-1af8-a4a1-644c-ab27490f9b44@linux.intel.com>
 <20200702160528.GL4483@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200702160528.GL4483@sirena.org.uk>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
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

On Thu, Jul 02, 2020 at 05:05:28PM +0100, Mark Brown wrote:
>On Thu, Jul 02, 2020 at 10:42:21AM -0500, Pierre-Louis Bossart wrote:
>> On 7/2/20 6:18 AM, Mark Brown wrote:
>> > On Wed, Jul 01, 2020 at 09:21:24PM -0400, Sasha Levin wrote:
>> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
>> > > [ Upstream commit c8d2e2bfaeffa0f914330e8b4e45b986c8d30b58 ]
>
>> > > Usually the DSP is not traditionally enabled on H skews but this might
>> > > be used moving forward.
>
>> > "This might be used moving forward"?
>
>> There are two conditions for the SOF driver to be used in a distro:
>> a) the DSP needs to be enabled (as reported by the pci class info)
>> b) sound/hda/intel-dsp-config.c needs to contain a quirk to select SOF over
>> the legacy HDaudio, such as presence of DMIC/SoundWire or a known vendor
>> DMI.
>
>> Traditionally for desktops neither a) nor b) are true, but this is changing:
>> we will start adding quirks for specific product lines as requested by OEMs.
>
>> Does this answer to your question?
>
>The question was more of a why is this being backported one - without
>those extra quirks this does nothing, and frankly with them it seems
>like a *major* change someone might see in stable if they update their
>kernel and it suddenly switches to an entirely different DSP software
>stack.

Hey Mark,

It got picked up because the stable rules explicitly call out PCI IDs as
something we take into the stable trees, and so the AUTOSEL brains
picked up on this...

I'll drop this patch as it doesn't do much.

-- 
Thanks,
Sasha
