Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E2C433E2
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B693206EB
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lF+018O0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4S0BMe/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B693206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F24217BB;
	Tue,  1 Sep 2020 16:53:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F24217BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598972041;
	bh=fCAv1y//4a6UC8MVETGKggnvPbFkFDYGouK55xIoJqo=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lF+018O0UDEUwsjuUDAv0H3RKRZH0E0p8TPpiKUtR2vvfsWBUPJc10e2tsaC34fI9
	 XCbn05LplVhH6d4W4jFkfQ5sgTb9SL5C9Olya6Mw9a61urkbMCFk6HPNTyRMODM4Tj
	 EvgG3O2xepJHJ6v6NzQ7xtmLVM146MfsIuCfYYqg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F80FF802E1;
	Tue,  1 Sep 2020 16:50:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2870CF802E3; Tue,  1 Sep 2020 16:50:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE7E2F802E1
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 16:50:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE7E2F802E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="g4S0BMe/"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DB76A215A4;
 Tue,  1 Sep 2020 14:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598971851;
 bh=fCAv1y//4a6UC8MVETGKggnvPbFkFDYGouK55xIoJqo=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=g4S0BMe/r8cu4FMwk0ntbalQbZsJaQSAhjHnAiabD+OgG0sBV2KQVfFMq+FF0NDV6
 054WFdeOA6VomWybTpZkwG0dvwGCXdVtM1injYU3jWjUld85qzz8zc93Q2UqHRzWLO
 XRYipEN0LwQx/gRIv6oBJ+2KgesA+KqvugcK5CEg=
Date: Tue, 01 Sep 2020 15:50:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
In-Reply-To: <20200828162005.1.I4f67f494c4f759b0e5c7f487e040dfdcf16e0876@changeid>
References: <20200828162005.1.I4f67f494c4f759b0e5c7f487e040dfdcf16e0876@changeid>
Subject: Re: [PATCH] ASoC: rt5682: Prefer async probe
Message-Id: <159897179515.47719.15361648860135990824.b4-ty@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, cychiang@chromium.org
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

On Fri, 28 Aug 2020 16:20:27 -0700, Douglas Anderson wrote:
> The probe of rt5682 is pretty slow.  A quick measurement shows that it
> takes ~650 ms on at least one board.  There's no reason to block all
> other drivers waiting for this probe to finish.  Set the flag to allow
> other drivers to probe while we're probing.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: Prefer async probe
      commit: 160c174ff6972bb56bf48ac3335297889839e1f1

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
