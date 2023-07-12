Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A076EB64D9
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 11:51:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A08986F;
	Wed, 12 Jul 2023 13:50:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A08986F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689162675;
	bh=MrD10ypRydCEI5x7llBX60wzJIoyt566JqIz24flJbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kQbFPLCD0N40IOXghc90z1i1fXjwhH08fqL8CnwVEXOD3Ic6ATyx1VFSUNrpGm3HS
	 5lHdrK6XPuZzghbjADdFe2hm/3kbOvHAl65grTcA1mRt/dPLFIH2WpyjRZBQxMCj/o
	 MyH1gHdeTqaDaADNPmVKlDZccAkTwINYB5GhQs/8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D51C5F80607; Wed, 12 Jul 2023 13:47:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 79206F80602;
	Wed, 12 Jul 2023 13:47:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BCEEF805E9; Wed, 12 Jul 2023 13:47:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26589F805DA
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2023 13:47:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26589F805DA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=UrclTGnl
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1683F6178F;
	Wed, 12 Jul 2023 11:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFABC433C8;
	Wed, 12 Jul 2023 11:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689162429;
	bh=MrD10ypRydCEI5x7llBX60wzJIoyt566JqIz24flJbI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=UrclTGnl1R0Z+MjkfclmgIwW+o44bCtTx/pbsEej3kKcmnBEiREyGu3D8OQZbEREV
	 igvMYLhBRCVvBLsjHKDSZJX8npW1uBTzsD7feS761uTcIYMcZoFfy1RmZRqHDA2Pd4
	 XTjYdVrSVq/IEcmV9VzgGBy5dRWp94S0DVOCO9gGfZFTgJjo/1kHk3LfU/GXgsWKC0
	 Yr4M4ZpEBwV/OwJP/7hbMAl2a7LN+1xXLateipXzBFsMv0ZdxQBCcL31Ny4Jj3+t+W
	 cW2FJfZK9doWmMnwXNu4O9gCxxPF+8DlsAKGsU2qV15JUlRdaS+DCdBRXJTxqHUFsy
	 ykwrcjhhAQJww==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
In-Reply-To: <20230701044836.18789-1-rdunlap@infradead.org>
References: <20230701044836.18789-1-rdunlap@infradead.org>
Subject: Re: [PATCH v2] ASoC: stac9766: fix build errors with REGMAP_AC97
Message-Id: <168916242817.46574.1012924701910516434.b4-ty@kernel.org>
Date: Wed, 12 Jul 2023 12:47:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: SUZBI6MWDJQME3WRSELDVIXH7DX5UV6C
X-Message-ID-Hash: SUZBI6MWDJQME3WRSELDVIXH7DX5UV6C
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SUZBI6MWDJQME3WRSELDVIXH7DX5UV6C/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 30 Jun 2023 21:48:36 -0700, Randy Dunlap wrote:
> Select REGMAP_AC97 to fix these build errors:
> 
> ERROR: modpost: "regmap_ac97_default_volatile" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
> ERROR: modpost: "__regmap_init_ac97" [sound/soc/codecs/snd-soc-stac9766.ko] undefined!
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: stac9766: fix build errors with REGMAP_AC97
      commit: c70064b96f509daa78f57992aeabcf274fb2fed4

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

