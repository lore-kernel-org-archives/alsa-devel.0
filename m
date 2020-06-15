Return-Path: <SRS0=afjW=74=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA11C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:06:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CCF20739
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GFdl4WZM";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1QmXNSWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CCF20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 424871607;
	Mon, 15 Jun 2020 17:05:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 424871607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592233592;
	bh=PtHK/rBq5yXWf/az0yFNy5AZojX854pebSRDvWUlzS0=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GFdl4WZMlg9HQUE3StAINpb+P99v2BBlA8XYxPm+XeRGgfh9nu8s8Atm8/6y31oY1
	 HB/cQFJzlhlMW4QJQC24I34DrYSrRAJvNNCNyRCuljC7Exd7UfIM027gtJAXlyPvKi
	 W6JW+g9IxMgZPDb05GUTVrHCijHid55TfNSmYIPQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D7B5F80171;
	Mon, 15 Jun 2020 17:05:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC168F80171; Mon, 15 Jun 2020 17:05:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26894F800EF
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2020 17:05:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26894F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="1QmXNSWb"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 36E532063A;
 Mon, 15 Jun 2020 15:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592233532;
 bh=PtHK/rBq5yXWf/az0yFNy5AZojX854pebSRDvWUlzS0=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=1QmXNSWb34Ac+fdNe92nP4uKPNaUp4hSESZQ/+XPwVvlCvfl/Mdzk2Xp/UIOGMrXq
 YBDtQkBSz3H/qDiUjFgRnXuFdqiecQyj5AtSj4AEp5vuPMBwDezPI/4sqBVEzfDF9m
 O4H/RsZMgt23/SsCJkD2eZnMR2JfGh7m/2v7fbZg=
Date: Mon, 15 Jun 2020 16:05:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20200612205938.26415-1-pierre-louis.bossart@linux.intel.com>
References: <20200612205938.26415-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: topology: fix use-after-free when removing
 components
Message-Id: <159223353044.8967.3692848694814401597.b4-ty@kernel.org>
Cc: tiwai@suse.de
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

On Fri, 12 Jun 2020 15:59:36 -0500, Pierre-Louis Bossart wrote:
> This patchset fixes a memory allocation issue and removes a 100%
> reproducible use-after-free report thrown by KASAN in automated module
> removal tests across multiple platforms.
> 
> All the credit goes to Bard Liao for root-causing the issue. DAIs may
> be registered at the same time as a component, or when the topology is
> loaded. This two-step registration causes the memory for
> topology-based DAIs to allocated last, and conversely to be released
> first by devres, before the component is released and the DAIs removed
> from the component DAI list with snd_soc_unregister_dais().
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: soc-devres: add devm_snd_soc_register_dai()
      commit: 0fae253af563cf5d1f5dc651d520c3eafd74f183
[2/2] ASoC: soc-topology: use devm_snd_soc_register_dai()
      commit: 6ae4902f2f3400503f9b78e87e8371e4ffde1e0c

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
