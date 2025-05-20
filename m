Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4E2C3ABDD
	for <alsa-devel@archiver.kernel.org>; Tue, 20 May 2025 09:21:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17DC9601D9;
	Tue, 20 May 2025 11:21:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17DC9601D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1747732877;
	bh=eO6pk5EwDizoXN8rjv6gjfg1ELRx+++/2HAzTllOyYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QG+LBYg8xa+zZLHaNIkojhw0IkIRyRkvCnvSCt+O1NMwFim/EUrWNoW++epKqA/LJ
	 ZfbPs6RHuQcej+0qXF/MyTxKg5IidThs4VmI0keb1y/oZ90SZB7HafF4bYX+S8RfwT
	 v5DFodQFtRQ41FIp1GuSYF92l6J7a0CSW5KkJDOI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E00CF805E2; Tue, 20 May 2025 11:20:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D1B7F805D2;
	Tue, 20 May 2025 11:20:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9124EF805BD; Tue, 20 May 2025 11:20:24 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D2666F805B2
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2025 11:20:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2666F805B2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=meAjp9ha
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 227ACA4C986;
	Tue, 20 May 2025 09:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5794C4CEEF;
	Tue, 20 May 2025 09:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747732820;
	bh=eO6pk5EwDizoXN8rjv6gjfg1ELRx+++/2HAzTllOyYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=meAjp9ha1fvRfGj+kjLyEfhmFigRYI7Z656G0MltZvO6ff/DvvRr4jFLOLRmqAGnZ
	 dLJdjUNBVLsj3d+CLGA/6cCcPx97mKEYFrJ8HdVWtN6NjqtSWZZMsEFvWH+o7fpAQZ
	 Q1kkR6Lrg8QdSXgzjcPZyyWEaI8Lfe68Z3GS5HuMCRbV2IYxuOW03E3IqlWmqvz1q/
	 rbVxt3jHgTxr65BFw5pSLytKM9r4TrqxTOlY0RQhezJOQNbMXFG7p4lSHV8i3axiUR
	 vdsnF0kXRpk7m3oBkTz++eNaPDvjr2fEIjoUdxLnWz0yG9V1gA7cJ5ZPjShjuJNglM
	 6at+Jh1aSSaRA==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, tiwai@suse.de, 13916275206@139.com,
 13564923607@139.com, alsa-devel@alsa-project.org, baojun.xu@ti.com,
 jesse-ji@ti.com
In-Reply-To: <20250518132451.707-1-shenghao-ding@ti.com>
References: <20250518132451.707-1-shenghao-ding@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Header file cleanup and Move the
 macro definitions to fwlib
Message-Id: <174773281840.19497.392067315556087453.b4-ty@kernel.org>
Date: Tue, 20 May 2025 10:20:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1
Message-ID-Hash: DXQW2XEDWPZ7VUH5VBCLTM5WTR2DFKN6
X-Message-ID-Hash: DXQW2XEDWPZ7VUH5VBCLTM5WTR2DFKN6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DXQW2XEDWPZ7VUH5VBCLTM5WTR2DFKN6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, 18 May 2025 21:24:51 +0800, Shenghao Ding wrote:
> Drop the I2C in one comment, for these registers are also used in SPI
> driver; Move the macro definition of TASDEVICE_CMD_XXX from tas2781.h to
> tas2781_fmwlib.c, because the macros are only referenced in only fwlib.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Header file cleanup and Move the macro definitions to fwlib
      commit: e4dca67b2463e6abe775876c9cb049ea5b1c8e0d

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

