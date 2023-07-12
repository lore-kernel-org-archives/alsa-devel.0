Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B227CEB64DD
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 11:51:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A836E7F8;
	Wed, 12 Jul 2023 13:50:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A836E7F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689162658;
	bh=ENkcW96EGy+1LPYBYZW3/JRK1Q9huG6TFa9pKV63ocU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=i5Fiz+plXErg0MOLpvdDI5zZQsBxWhEJJEYHOGmSsY6PzuSQ7yXgiyWjQXd1g1Gpc
	 l+M7gqjcparAceRPekGzhf6KuYAG7E9HmE+Qige9PzzdloDVjLBrESe2MNZDhssY3i
	 hKxHUcC3V5nGgYgWLvx3AQFQdaOkmGlwMGtVIgnk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 176DBF805FC; Wed, 12 Jul 2023 13:47:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 79BEEF805FC;
	Wed, 12 Jul 2023 13:47:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 355C2F805E1; Wed, 12 Jul 2023 13:47:12 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9E6FAF805CA
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2023 13:47:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E6FAF805CA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lxPf5Cy3
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8EEC96179B;
	Wed, 12 Jul 2023 11:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7F8C433C9;
	Wed, 12 Jul 2023 11:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689162428;
	bh=ENkcW96EGy+1LPYBYZW3/JRK1Q9huG6TFa9pKV63ocU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lxPf5Cy3tZid05IKGZsXeaJYEleuf6zbFdpLUGMhB1SXgyVnOypsbRyfTzv6PVsBK
	 G27PUZZOr8MlOQdo/FBujM4ypCA2LFStN0hLER7rVFPtK4XrmmQT3QnD0E7VSz32Yg
	 NK+RifmfGCoA7HJmIF/E7Wgku52fXUBvy4L4cbo1ZO83IkJEhERDSeznSbucp1nc+K
	 enPOVA9IqLNGScZcvR95/nigiZ0+9tm4yZAYFREpa7BFy/aSMWLzVlIMEyO47l2i2l
	 MLL3+fwbY446AFTDhpa6dwAnLD+QA3ZAMIyCJZEUuJk3t8q2tvtq/9JYM/XCC2afx3
	 hbtQSlb1uXC5g==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
In-Reply-To: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
References: <20230630172155.83754-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/4] ASoC: rt5677: Refactor GPIO and use
 device_get_match_data()
Message-Id: <168916242630.46574.7633971537485557226.b4-ty@kernel.org>
Date: Wed, 12 Jul 2023 12:47:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: ZITVF63P2FZPYWNWTAIIWIFTXB57MPHB
X-Message-ID-Hash: ZITVF63P2FZPYWNWTAIIWIFTXB57MPHB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZITVF63P2FZPYWNWTAIIWIFTXB57MPHB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 30 Jun 2023 20:21:51 +0300, Andy Shevchenko wrote:
> The code can be simplified with refactored GPIO parts and with use of
> device_get_match_data(). Besides that couple of additional changes,
> one for maintenance and one for making IRQ domain agnostic (not being
> pinned to OF).
> 
> Changelog v2:
> - refactored GPIO code in (a new) patch 1
> - fixed compilation error in patch 2 (LKP)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: rt5677: Refactor GPIO support code
      commit: 5512ffd9f39832f312b7f903703ac39d6367fe8a
[2/4] ASoC: rt5677: Use agnostic irq_domain_create_linear()
      commit: c3d42d7baf6b4032171270e3df001fb946493452
[3/4] ASoC: rt5677: Use device_get_match_data()
      commit: 043bb9c012ee7d092a477159cc66dbdf62fd2666
[4/4] ASoC: rt5677: Sort headers alphabetically
      commit: ea1c1019a88d88cf0a7d6892f594b72ddb3b8c0b

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

