Return-Path: <SRS0=4tTe=BK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31430C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:55:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73582076B
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cyfYVIS0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1CXslw7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73582076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 378011661;
	Fri, 31 Jul 2020 20:54:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 378011661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596221749;
	bh=cPENTsFz9NF34PUPiqsjoOUpv0lIovNmL4NJV2As9rY=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cyfYVIS0zLKJbuNl2XydjOl47hVvWEH3+21msQ923GYIFLjvyXm7A49c8AraVgfb6
	 wN4OxKdoxfenG+dOjqDmo6qu/yTK2E6kl0TI2UnpSVAjfK6MHWuYB9frym6ygSPd44
	 9UO/87lCWpcQl1FT3qkANs4Fmh3UR3FeZRZai3Ic=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE60AF80161;
	Fri, 31 Jul 2020 20:54:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0AEB9F80171; Fri, 31 Jul 2020 20:54:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ABFDCF8011C
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 20:54:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ABFDCF8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="1CXslw7Z"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ADF682076B;
 Fri, 31 Jul 2020 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596221691;
 bh=cPENTsFz9NF34PUPiqsjoOUpv0lIovNmL4NJV2As9rY=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=1CXslw7ZcjA8wGEp6WkGIj4fIERNm2rwKBELVJ8SoffTqg3wy2yhUKxHu4BmH/YWF
 strMAr2J0tsImHVpgIxZw3tYlf2aOW46AzBlKyL0Qr5D3CHhbiQuZI4b0t4O4XOpXs
 XnWNKOaRj278/QBTtKXqPMH4gWUbQ+6Ns9iH/C9s=
Date: Fri, 31 Jul 2020 19:54:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20200731120603.2243261-1-jbrunet@baylibre.com>
References: <20200731120603.2243261-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: cards: deal dpcm flag change
Message-Id: <159622167150.22822.13397652809932065449.b4-ty@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org,
 linux-amlogic@lists.infradead.org, zhangn1985@outlook.com,
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

On Fri, 31 Jul 2020 14:06:03 +0200, Jerome Brunet wrote:
> Commit b73287f0b074 ("ASoC: soc-pcm: dpcm: fix playback/capture checks")
> changed the meaning of dpcm_playback/dpcm_capture and now requires the
> CPU DAI BE to aligned with those flags.
> 
> This broke all Amlogic cards with uni-directional backends (All gx and
> most axg cards).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: cards: deal dpcm flag change
      commit: da3f23fde9d7b4a7e0ca9a9a096cec3104df1b82

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
