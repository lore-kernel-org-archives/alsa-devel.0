Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8084DC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  3 May 2022 15:51:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA9961D7;
	Tue,  3 May 2022 17:51:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA9961D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651593116;
	bh=NlTsvBlO18kHLoY5vefs2kSNvqMoN8yUaqrgdYHVSB0=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QFZmNcN5Hicrv1+SXndnRm113KzieAL9HPt72crn9Nmsd8QlWjGjxHkiwY4nDOefD
	 /PlRPz6Ot2EauvRhFD3ysbA8a9dQQAZ5nfwtzW+XTwh4GY5sUE9WAygdNuymfrfwd1
	 29KDDpxPf4XzMuX2siIqgHtPD8zN+XRBWrQ3wqB0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D9B1F80129;
	Tue,  3 May 2022 17:51:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6308DF80129; Tue,  3 May 2022 17:51:03 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29EE9F80158
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2022 17:50:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29EE9F80158
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PC60GeXP"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 11505B81F07;
 Tue,  3 May 2022 15:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F4DC385A9;
 Tue,  3 May 2022 15:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651593055;
 bh=NlTsvBlO18kHLoY5vefs2kSNvqMoN8yUaqrgdYHVSB0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=PC60GeXP7E/lXL38mx/7VXRL4RN06V0JPvcAb1TT/P1z8jk4TbCCCcDQIN3WPiL7q
 EnYKh4YN+23hy90fgh4Bel1VWzXqM1l3kzfnH2XVx5b1jRNBfjQyGwmuJM6PDyaVDF
 EqKiTLWuRJZ2E8NLkOCVBvE+e7piXutu4LwJ2er+NcNNtpVBuG+3/NS/dK88bKk9i6
 oGa3JPOFG7lzJA3LRGtzJ+/f2MffwG0yok0pvWhJlckXpLA13WPb/fYzUR5USYQ4Q0
 B0z9cMsu+9cpJ2YaNtjgqH5Nc3zHq5KJZfByScgmOI2rXP/yTuhEXhtwabCe5Jlz6o
 51no/59IXSf0Q==
From: Mark Brown <broonie@kernel.org>
To: broonie@kernel.org, lgirdwood@gmail.com
In-Reply-To: <20220428113221.15326-1-broonie@kernel.org>
References: <20220428113221.15326-1-broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98090: Fix event generation for custom controls
Message-Id: <165159305479.184114.3423181884508202913.b4-ty@kernel.org>
Date: Tue, 03 May 2022 16:50:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Thu, 28 Apr 2022 12:32:21 +0100, Mark Brown wrote:
> The previous fix for event generation for custom controls compared the
> value already in the register with the value being written, missing the
> logic that only applies the value to the register when the control is
> already enabled. Fix this, compare the value cached in the driver data
> rather than the register.
> 
> This should really be an autodisable control rather than open coded.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: max98090: Fix event generation for custom controls
      commit: a0746cbd0b8224c4c0e4ae59968075cb7c14762a

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
