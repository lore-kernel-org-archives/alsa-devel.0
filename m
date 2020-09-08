Return-Path: <SRS0=EqiG=CR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2913EC43461
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 17:24:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828CC2098B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 17:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uORQZ0DE";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtUemtIh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828CC2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DFE683B;
	Tue,  8 Sep 2020 19:23:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DFE683B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599585885;
	bh=LBPJd0L8n/8XJ1Qd3rukDT67d+MY/Hku7khI6Rr1pvo=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uORQZ0DEoW2S8uo4/RE3vNVMJwVMQrOXdZzbpFJtqWsB7jd7GhKJkFmcD22RjsEvM
	 dzrJclD9bSnODw/ChUNXbLg3byxDObBdE+7g/vnidnZaiBxcUY44o3lBW0pLbTOAYk
	 80cL1q40wDQb1fg638E5hMB0Fwh0tlwnjUzWIMMY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFC77F802EA;
	Tue,  8 Sep 2020 19:21:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00509F802EA; Tue,  8 Sep 2020 19:21:31 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F15CAF802DF
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2020 19:21:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F15CAF802DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="HtUemtIh"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 25B7820768;
 Tue,  8 Sep 2020 17:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599585684;
 bh=LBPJd0L8n/8XJ1Qd3rukDT67d+MY/Hku7khI6Rr1pvo=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=HtUemtIhp+/hT1zo7fMsAvV1/P2t8geWpqWRJNFCRVaCs+dO9tRGWD9gFCy0gEB37
 uzjBk4oL9gzFS20og6n+M4rJtRp6ZM0nLVoLZAhpOCBz6gq++wArsmpJsEISni19dE
 muQ+yMftQS70NQ9zd1uS3feRxASh/HRh/Rj93AG4=
Date: Tue, 08 Sep 2020 18:20:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20200908070044.1142644-1-tzungbi@google.com>
References: <20200908070044.1142644-1-tzungbi@google.com>
Subject: Re: [PATCH] ASoC: mt6359: fix failed to parse DT properties
Message-Id: <159958562063.16576.3044446748020736063.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, jiaxin.yu@mediatek.com
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

On Tue, 8 Sep 2020 15:00:44 +0800, Tzung-Bi Shih wrote:
> Mt6359 platform device is instantiated by mfd_add_devices().  In the
> case, dev->of_node is NULL so that mt6359_parse_dt() always fails to
> parse the desired DT properties.
> 
> Gets the DT properties via dev->parent->of_node.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mt6359: fix failed to parse DT properties
      commit: 6835302853169441069e11bc4642300c22009c2e

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
