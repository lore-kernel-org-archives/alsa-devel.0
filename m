Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA35C3DA7A
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Dec 2022 22:51:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 601E91633;
	Thu, 29 Dec 2022 23:50:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 601E91633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672354306;
	bh=FZkVvYP0hRgawowsbzU9qFlXAar+AEXGrqNOdGX38lc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=bcry2Jk6+sKWHBvxW+xu4bjrLy4Oa1qZdMVDWYThGq8DE93FYC7bdtJVM9B3anwk2
	 89ONxhVQsanOPqlSokjZShNjtxPBcYeo4/8WmILdqyijf1PveAawkAYTfIB6RiNj4X
	 vY8k1r430hx/xQ/YECIOcSBUjjYSvKJFIpT4r43A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72C5EF804FB;
	Thu, 29 Dec 2022 23:50:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1BF3CF802A0; Thu, 29 Dec 2022 23:50:28 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37573F802A0
 for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2022 23:50:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37573F802A0
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=a281IrsU
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 869A1B81A7C;
 Thu, 29 Dec 2022 22:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421C1C433F0;
 Thu, 29 Dec 2022 22:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672354223;
 bh=FZkVvYP0hRgawowsbzU9qFlXAar+AEXGrqNOdGX38lc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=a281IrsUMyyItlA1r0OC2wji1Ju7YgSOkvOBrZkNV9IrHny2hLKRvbksNTuYFw9KC
 LknlQJplG0f/R4Ddq6WsDQ3OpPsVbly85xQSbO1moxkHyIvRZiDU/NkDZWT+mb2ZZ9
 9U08kxxsOlcYkvU7JF/HGSK4QsfYpzGHvK7TnahynxyPrYj2Y/ub5/tSs0W9AN/WOZ
 s2D8HxizA7aV3iehUhcpb48n3g2yCFa1uEx2DS5k03J6KI93GCk2clFxUd9ZybpNb8
 jKXkLb3iQDfaMr0vdNjcYKH7aW92FC/jdOe+FFHBqDNI7tfSDppcRiL4adS7JIevDZ
 FngarhJQLGwhw==
From: Mark Brown <broonie@kernel.org>
To: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Francesco Dolcini <francesco@dolcini.it>
In-Reply-To: <20221223080247.7258-1-francesco@dolcini.it>
References: <20221223080247.7258-1-francesco@dolcini.it>
Subject: Re: [PATCH v1] ASoC: wm8904: fix wrong outputs volume after power
 reactivation
Message-Id: <167235421935.130379.14139804640942970883.b4-ty@kernel.org>
Date: Thu, 29 Dec 2022 22:50:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-69c4d
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, 23 Dec 2022 09:02:47 +0100, Francesco Dolcini wrote:
> Restore volume after charge pump and PGA activation to ensure
> that volume settings are correctly applied when re-enabling codec
> from SND_SOC_BIAS_OFF state.
> CLASS_W, CHARGE_PUMP and POWER_MANAGEMENT_2 register configuration
> affect how the volume register are applied and must be configured first.
> 
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8904: fix wrong outputs volume after power reactivation
      commit: 472a6309c6467af89dbf660a8310369cc9cb041f

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
