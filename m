Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AB5C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:11:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716062067C
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PLRts12Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cESQYc2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716062067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02C1717BE;
	Tue, 18 Aug 2020 19:10:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02C1717BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597770672;
	bh=OHZvWecYvKy95NxWDafvdTZBC/UOwa9QCGfqnRNcDhE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PLRts12YCVv0zwik4QoH68+ABXlDq7IxByyDlXG+veBfAXWlo+7YljXnoawJy8tnQ
	 GFO7DO5CmMYtUO921AMtz9bxaovqdZ/NRUNl8StZkqHTR4Hekk9oBLZKxagN34jduc
	 bLOoR6pj/cLJWGLG00CCCdA/g1NhJYFwfTcbtZ+Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60DA7F803BE;
	Tue, 18 Aug 2020 18:56:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7FECCF803CA; Tue, 18 Aug 2020 18:56:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14250F803BC
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 18:56:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14250F803BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cESQYc2m"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4DC1E207D3;
 Tue, 18 Aug 2020 16:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597769786;
 bh=OHZvWecYvKy95NxWDafvdTZBC/UOwa9QCGfqnRNcDhE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=cESQYc2mBCeVYMDyY/iVKWmJCtLNmpNlJqCUHwaJUr/Y1/oExql0IB1t4cnlwSRNJ
 GxCtULgbfTzaEKj/YrNwc4R8nKB4h8sx2gKqnLdR0w1rphrtVaN4OKXaZwkSFoaE8a
 CLxFQMC7RFDKtICeNAaVLTwZnbuQDLcNHtDOcrnw=
Date: Tue, 18 Aug 2020 17:55:56 +0100
From: Mark Brown <broonie@kernel.org>
To: ckeepax@opensource.cirrus.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20200731173834.23832-1-s.nawrocki@samsung.com>
References: <CGME20200731173856eucas1p292d2bc7319aa6a9af9b0e48b89ae803b@eucas1p2.samsung.com>
 <20200731173834.23832-1-s.nawrocki@samsung.com>
Subject: Re: [PATCH RFC] ASoC: wm8994: Avoid attempts to read unreadable
 registers
Message-Id: <159776961933.56094.2130746902213654082.b4-ty@kernel.org>
Cc: simon@lineageos.org, alsa-devel@alsa-project.org, b.zolnierkie@samsung.com,
 patches@opensource.cirrus.com, lgirdwood@gmail.com, m.szyprowski@samsung.com
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

On Fri, 31 Jul 2020 19:38:34 +0200, Sylwester Nawrocki wrote:
> The driver supports WM1811, WM8994, WM8958 devices but according to
> documentation and the regmap definitions the WM8958_DSP2_* registers
> are only available on WM8958. In current code these registers are
> being accessed as if they were available on all the three chips.
> 
> When starting playback on WM1811 CODEC multiple errors like:
> "wm8994-codec wm8994-codec: ASoC: error at soc_component_read_no_lock on wm8994-codec: -5"
> can be seen, which is caused by attempts to read an unavailable
> WM8958_DSP2_PROGRAM register. The issue has been uncovered by recent
> commit "e2329ee ASoC: soc-component: add soc_component_err()".
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8994: Avoid attempts to read unreadable registers
      commit: f082bb59b72039a2326ec1a44496899fb8aa6d0e

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
