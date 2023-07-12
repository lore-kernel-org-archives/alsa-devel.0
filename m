Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C02EB64D9
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 11:52:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 16547207;
	Wed, 12 Jul 2023 13:52:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 16547207
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689162770;
	bh=3PzrarJLzvgqBlteTxXCL0ZlbXn6P3Hxt+y6kC4WrKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=V+DUiVhctvlWxG9+N5eI+UtDhjfFyhOLms8n797SNPo8fUT6Xb5mQ3hYHMJGc8C84
	 ReMealwRKm+wh94DPtFoTtQnFMLAcR1LKVx2rGxHKKUYH8mfkoPN1H9D+iTnIw842k
	 85jDVEvtlkve1J9Z0XJVXxZGa6A5JGp3kR38yRro=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BDA40F80652; Wed, 12 Jul 2023 13:47:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 041D2F80641;
	Wed, 12 Jul 2023 13:47:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2ABEBF80620; Wed, 12 Jul 2023 13:47:32 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 21580F80606
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2023 13:47:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21580F80606
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Y5YFXLPW
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0BBA66179A;
	Wed, 12 Jul 2023 11:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA9AC433AD;
	Wed, 12 Jul 2023 11:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689162448;
	bh=3PzrarJLzvgqBlteTxXCL0ZlbXn6P3Hxt+y6kC4WrKo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Y5YFXLPWO2h7N62O2SqObAyrtpjKjGMpFFpoINqGiGWo9P+YljBfO9vz0K0d9TX+J
	 IPwkQpZCGwPV10KktI32n7JASQK4F9642KVNx0SyubgjHwzLc7GlWdWm1T+5cQuVDZ
	 Z2KVPDoZNaGbwKf5nO5RORFrQ5P7d5rS3B3hfHfa5aJpkScdQL9elbPLk6qWO/or8C
	 AYFCTcr5JQt3j6hidQM8kj83bQjuN9F12rDCRowHRxlmL6oVlnZtLHZL3lxd2YVNrX
	 5Xurl9LkYBttwBkrBh0MDcz7E+3nkXFJIwjwGnZtfBlA+C4gvcpR0VVQ9GxaqraulA
	 vA8Y4Bj6vsFkg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, alsa-devel@alsa-project.org,
 kernel@pengutronix.de, Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <20230707072830.3395789-1-u.kleine-koenig@pengutronix.de>
References: <20230707072830.3395789-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 0/2] ASoC: Another set of platform remove conversions
Message-Id: <168916244662.46574.4204772528049988078.b4-ty@kernel.org>
Date: Wed, 12 Jul 2023 12:47:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: VZNASHZWQJ7ZCO4NO5LVPD2DLBQ4IVGC
X-Message-ID-Hash: VZNASHZWQJ7ZCO4NO5LVPD2DLBQ4IVGC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VZNASHZWQJ7ZCO4NO5LVPD2DLBQ4IVGC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 07 Jul 2023 09:28:28 +0200, Uwe Kleine-König wrote:
> two more drivers were added during the current merge window that
> are users of the original .remove callback that I plan to get rid of.
> Convert them to .remove_new.
> 
> Best regards
> Uwe
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: amd: ps-sdw-dma: Convert to platform remove callback returning void
      commit: acb5c0b14b761df258e480cc721676073f6d953a
[2/2] ASoC: starfive: jh7110_tdm: Convert to platform remove callback returning void
      commit: 50a91c513fb7da5c48b1cffdaa30c1f98f403801

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

