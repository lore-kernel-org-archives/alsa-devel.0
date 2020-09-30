Return-Path: <SRS0=iKRb=DH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA88DC4727C
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:14:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0FA62071E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H6MCePhA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bd6wn1wS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FA62071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C92421817;
	Wed, 30 Sep 2020 17:14:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C92421817
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601478895;
	bh=MNR+bUtMZLuLBJt10auA5jj1QkNQ9OW5xWDqLbXoQoo=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H6MCePhAV1MZSgwhT7Uu+ZgTFwCWg2U383sAYIu0DFbtD28osPUvl+uK4J8RVhKMd
	 K9XkEYvFRP6U59XeYuwRr0hcgVik2KQ37+DeEA4ooA2uBAhUtvesbxTSGHNintbn/F
	 6ZnmlWWCzAhVd3chR0AT4RpwcFMygqs0l1Jy2FZc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D40EF800DF;
	Wed, 30 Sep 2020 17:14:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C91BF801ED; Wed, 30 Sep 2020 17:14:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53289F800DF
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2020 17:13:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53289F800DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bd6wn1wS"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8E0E520657;
 Wed, 30 Sep 2020 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601478837;
 bh=MNR+bUtMZLuLBJt10auA5jj1QkNQ9OW5xWDqLbXoQoo=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=bd6wn1wSr1CgjWh0B12Y+pmZmxywyjyGRDedju7a/xvFqeSWuGplDGRs0wPWo2DmC
 f8Ig0/dfOIQXMP3bFWDSmFF8hnIftY6ouoY0MPOurr/DbG1tau32qWfRVsv0ExL9Pn
 IHERdr1XXHoQpeSJ2eOMqOfnjduQm6ZVf6qmPnmg=
Date: Wed, 30 Sep 2020 16:12:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Jaroslav Kysela <perex@perex.cz>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20200930145330.3043528-1-alexandre.belloni@bootlin.com>
References: <20200930145330.3043528-1-alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] ASoC: atmel-pcm: remove unnecessary include
Message-Id: <160147877281.10117.14415421643228167921.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Wed, 30 Sep 2020 16:53:30 +0200, Alexandre Belloni wrote:
> Since commit 95e0e07e710e ("ASoC: atmel-pcm: use generic dmaengine
> framework"), the driver is using dmaengine and is not using any definition
> from include/linux/platform_data/dma-atmel.h, stop including it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel-pcm: remove unnecessary include
      commit: 62e5d7774629aac671c8c56a0ba016dbffb6dff2

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
