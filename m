Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DAFC04FFE
	for <alsa-devel@archiver.kernel.org>; Wed,  8 May 2024 12:00:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C3AB839;
	Wed,  8 May 2024 14:00:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C3AB839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1715169643;
	bh=iPSLYdvpHZL8N99CSAPTgsQXdLDe9wyW44Dsp+ra6Dk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Im5r55Ie5R05cJxnN1qVbuiCD/FJjUY9elYeMFPhFUryoeEy5YccPN4t6go3DShUd
	 3LErf6BPm6U9xtO2Dl3GKZvTjdKLKxVs4Sh2ai8jUiXJ3oh5+tvCtiF0NXP8nRkmfm
	 8Rm7sJVf7B5ypkqD6ZxceCMsvyNLomrgN9mqYaH0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55112F8057B; Wed,  8 May 2024 14:00:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BE7BCF805A9;
	Wed,  8 May 2024 14:00:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22FC9F8049C; Wed,  8 May 2024 14:00:05 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 77582F8003A
	for <alsa-devel@alsa-project.org>; Wed,  8 May 2024 13:59:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77582F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iu2fuU1D
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8C529CE185F;
	Wed,  8 May 2024 11:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E02C113CC;
	Wed,  8 May 2024 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715169579;
	bh=iPSLYdvpHZL8N99CSAPTgsQXdLDe9wyW44Dsp+ra6Dk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iu2fuU1Dk8Mzv2pz0J2X/l580RyNBoBQ/xDmcl3K9BReNoWJH6oTUzEiFcWnvpKHK
	 WAtHBDgNjHnHfsmjDql5ZEiIGs1c8M+L6MDg9GvugUKu+1ciNS2aVmWg1yKzYusm3a
	 p2iSR7DI62fSJUNjSBeIBEs1QqkMHzdGlcLmdDD6FJGNqzVmgCqNLrTp8wQ9sUitmR
	 NTHxVez+gv8FAWQzCaDYMaFsY+weSkxSxnk9XXoHwtVvks0Ws03jJ6wLbLpfYKoepo
	 2SMfQToz7o1VRdveI7XAFGgZUGdwLDXJVvS4VvrUi5Nxfjz+v+Q1XYAELj98ipbRYl
	 LQJ+Q2ujO7vsA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Peter Rosin <peda@axentia.se>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
In-Reply-To: <20240507205659.690270-1-andriy.shevchenko@linux.intel.com>
References: <20240507205659.690270-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] ASoC: atmel: tse850-pcm5142: Remove unused
 of_gpio.h
Message-Id: <171516957734.2010832.13216398163199457795.b4-ty@kernel.org>
Date: Wed, 08 May 2024 20:59:37 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
Message-ID-Hash: LT6PW3225TBNMCTKT5JRNBILEF3EIRHX
X-Message-ID-Hash: LT6PW3225TBNMCTKT5JRNBILEF3EIRHX
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LT6PW3225TBNMCTKT5JRNBILEF3EIRHX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 07 May 2024 23:56:59 +0300, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel: tse850-pcm5142: Remove unused of_gpio.h
      commit: d45ae45f328b6824966ab7dbf8b1c712f7d0e877

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

