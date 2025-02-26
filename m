Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A836AC021B8
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2025 20:06:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28DF96031B;
	Wed, 26 Feb 2025 21:06:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28DF96031B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1740600390;
	bh=QakDqxq98ltYIoHeSe0g3diafvyJuCB8+9CHvFKc3hA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lAMkL/v1yqZ3Ib3OSkXCtI3IFKDBDXH8BWUZ2G3uQXkeMpS2lF4MnFKBdmxEq5A1Y
	 Tx9UQWZsXvbmEEYMSXDF1DdZJ2QHfPvhEHBhU2tKXVwYV6PLl0OC50ZQ2HdMj8BmD8
	 sShezGRfNYPmJ7ebGO1RcEIHTVUGe3kK04qSkekc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24627F805B4; Wed, 26 Feb 2025 21:06:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4556BF8016D;
	Wed, 26 Feb 2025 21:06:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6BC9FF80116; Wed, 26 Feb 2025 21:05:46 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 86738F80116
	for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2025 21:05:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86738F80116
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tHs6+xvW
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CAA905C72F1;
	Wed, 26 Feb 2025 20:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D59C4CED6;
	Wed, 26 Feb 2025 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740600338;
	bh=QakDqxq98ltYIoHeSe0g3diafvyJuCB8+9CHvFKc3hA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tHs6+xvWm2woCzbdci1zHJCcfaZLNnMeyANIWDdwarJdp4fyT5A77pYfXIktm1Ibe
	 mOsllnLThT0IPHmT1bExWeSBwloMgdX9FRwkNkRC3+qbyHpr55z2thh5jCpX28LxVP
	 h9mLVPX82Y3vzyEZabKec1UTWUuipttGRzMG9K8aQy4XthU2BcEVmTOxaX5frbFbr0
	 mPDHs2FzB0WyZSauRrVK9/evQ9YeUAqvjbDDlh6A53Hro7wMDb1XhOHeXAaNeRGxAH
	 M5PMPJoLsP0d7llB65a87m+oSL3cW//0JasXOgYLrh5Oy6igkf8lydBKDtVaT2rob6
	 5XTK1epYax1yA==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, Baojun Xu <baojun.xu@ti.com>
Cc: andriy.shevchenko@linux.intel.com, 13916275206@139.com,
 alsa-devel@alsa-project.org, shenghao-ding@ti.com
In-Reply-To: <20250226144328.11645-1-baojun.xu@ti.com>
References: <20250226144328.11645-1-baojun.xu@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Clean up for some define
Message-Id: <174060033695.117087.9907238914299357088.b4-ty@kernel.org>
Date: Wed, 26 Feb 2025 20:05:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6
Message-ID-Hash: 2BGHMP3YX322UYB7HOYG26PEQOVQ2LVP
X-Message-ID-Hash: 2BGHMP3YX322UYB7HOYG26PEQOVQ2LVP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2BGHMP3YX322UYB7HOYG26PEQOVQ2LVP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 26 Feb 2025 22:43:28 +0800, Baojun Xu wrote:
> Do some clean up for some define in header file.
> Like change lower case in value, up case in define,
> space add in recommends, change date of files and add author.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Clean up for some define
      commit: be1e3607f29a5a182eaa70e3058aef32fd0cc4f8

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

