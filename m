Return-Path: <SRS0=2Byq=DF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74A5C2D0A8
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 19:37:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A922076A
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Sep 2020 19:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="V++8R4Pc";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP75wg19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A922076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 433501868;
	Mon, 28 Sep 2020 21:36:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 433501868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601321855;
	bh=LcJtUPXXoFuJEAfj8VdKX+yxcZ/jCnpuAAfZ0654HPI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V++8R4PcZqR4576FqnNH1g1yNFHPjRE4jDxx3G34D3G5WpaF+kqieq/D8buWUtvXc
	 jt03ame4lZ5p2cqBD5Igzn+ufc8S0BwrlAKRu6i+lJjys6HXMVYkrCP/7uUvcTmcoy
	 zVgGegkAlmRUT74X1u23/2sNUArIHZAYCn3Nx+Vc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2553DF801ED;
	Mon, 28 Sep 2020 21:35:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2660F8029A; Mon, 28 Sep 2020 21:35:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C83EF800DF
 for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2020 21:35:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C83EF800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="eP75wg19"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D085620773;
 Mon, 28 Sep 2020 19:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601321744;
 bh=LcJtUPXXoFuJEAfj8VdKX+yxcZ/jCnpuAAfZ0654HPI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=eP75wg19co7MEAqNHnZInfqCu0eZgAKr5jzAVdgXxEqnh9AKLnIiJfq0JWN5OiMhS
 fOKJfPUw3MvrpmKkrILKRfKhLPlGZ1fNZ31ByA4p1uFlgmsIOETYINZ88c1Z/pCd40
 XPa1xEfTLWQPiRfbA20NBiBFHCicLFTxFKi43eJs=
Date: Mon, 28 Sep 2020 20:34:47 +0100
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@ti.com>
In-Reply-To: <20200928074330.13029-1-peter.ujfalusi@ti.com>
References: <20200928074330.13029-1-peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: ti: j721e-evm: Fix compiler warning when CONFIG_OF=n
Message-Id: <160132168198.55254.17359569253979567286.b4-ty@kernel.org>
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

On Mon, 28 Sep 2020 10:43:30 +0300, Peter Ujfalusi wrote:
> Remove the use of of_match_ptr() macro for of_match_table to fix compiler
> warning when CONFIG_OF=n:
> 
> sound/soc/ti/j721e-evm.c:528:34: warning: unused variable 'j721e_audio_of_match' [-Wunused-const-variable]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: j721e-evm: Fix compiler warning when CONFIG_OF=n
      commit: 5ec3c854d1a7edb95b20999d480b0c16c717254a

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
