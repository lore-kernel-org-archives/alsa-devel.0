Return-Path: <SRS0=gPEE=A7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0D2C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:40:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7949422B4D
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="i/Q61Gfk";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z65breQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7949422B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1D6E1615;
	Mon, 20 Jul 2020 16:39:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1D6E1615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595256025;
	bh=ojeKwU/anC+K6WiUwmutMl94xrosd3vZOyL4uXwrhGs=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i/Q61Gfk9vKgQJUrR1Zn+mHAa8iKVTJ+/rBYZHsvs1bO+fCRqX6yNJLIhLrC8KglR
	 4KjebFKvzsd4LSLy98cnBvwSAxyjNRtuF7nidfN4YvEk3donKgXNaq3klOgxcc7RaL
	 YYqyP1HVZYOyGS/FSGfB3Zdotgs8vad0C+5SmPGU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2E69AF80125;
	Mon, 20 Jul 2020 16:38:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6989F800BF; Mon, 20 Jul 2020 16:38:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E57AF800C1
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2020 16:38:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E57AF800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="z65breQu"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2383C22B4D;
 Mon, 20 Jul 2020 14:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595255911;
 bh=ojeKwU/anC+K6WiUwmutMl94xrosd3vZOyL4uXwrhGs=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=z65breQuAB2vMfjTUQvXAql+nZLs88eKrgoN1X/Jn/J8Pq231icqSbm0KjmsNmRtg
 hIvBuUiHe7soq0PlefALErIm0OzDY/frr0LRdyWHWU9N1wjBLFHLeA5CkqalKqAG4f
 kHzqePeY3KGd21QezPN8+7UnxHu2YG85gHSzNkKg=
Date: Mon, 20 Jul 2020 15:38:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20200719003307.21403-1-rdunlap@infradead.org>
References: <20200719003307.21403-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ASoC: soc-dai.h: drop a duplicated word
Message-Id: <159525589435.6792.14774617062559072369.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
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

On Sat, 18 Jul 2020 17:33:07 -0700, Randy Dunlap wrote:
> Drop the repeated word "be" in a comment.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-dai.h: drop a duplicated word
      commit: fc926a7c818c97e98c5c2db1cb910523df0419e5

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
