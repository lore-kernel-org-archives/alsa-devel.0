Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76467C4345F
	for <alsa-devel@archiver.kernel.org>; Sun,  5 May 2024 15:04:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 687F81CE;
	Sun,  5 May 2024 17:03:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 687F81CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1714921449;
	bh=aaWY3YW5vu+MJcht4MahH1HYM7AOmCM1zQmPkE3E/e4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qOm/E/56jU8pzUVlfyWBMwsWoVdDkrKzKwq2qfTpT8GZnP/ugUtZ84ad/2GwgqHeb
	 vktHvkK4znkOQRIMd0fXKIJaERx067t8+dZXM3QKrnJdqgQ9+RL6OrRNsw8jzVJ5rG
	 c+0jgYjO2s/z4yZicKBUZ+y/xMZYHCxdH0s3f/0A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E698FF805AE; Sun,  5 May 2024 17:03:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 75467F80579;
	Sun,  5 May 2024 17:03:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D580F804E7; Sun,  5 May 2024 17:03:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 50FFCF8024C
	for <alsa-devel@alsa-project.org>; Sun,  5 May 2024 17:03:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50FFCF8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hXV1rdkq
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AC6E660C96;
	Sun,  5 May 2024 15:03:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211F5C4AF18;
	Sun,  5 May 2024 15:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714921391;
	bh=aaWY3YW5vu+MJcht4MahH1HYM7AOmCM1zQmPkE3E/e4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hXV1rdkqcvLp5eXPht+hHK4VlrnCJ8FdhGidjEpAN1ScqPEo78I0m9yZZG2osyLKk
	 680AGkdmh1myU2LH2fSypQwN3HGbWEYX9bveI95VnEysVGgALkTkp7ZpQt8jWPIRFq
	 RbrNzj6L+A8ApYJlrU2iYC1qhaw50ZxhCaYJAfPmJeAl1LawoyJQ+/yLpum5NfVKZT
	 aVh7ctbo/EA30Nye/q2/8LvMusNVvgFo54LN/InnXz3DbxikDO1gkd8hsccUMaeyE9
	 kKv+kmg6R/dQ3BeFzWrqL2RUy6XgBjrlszNYuWFC7ESes1uZrJZXbg+MbrvWWLB+LI
	 F36WIg1sBVrbA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20240502074722.1103986-2-u.kleine-koenig@pengutronix.de>
References: <20240502074722.1103986-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ASoC: codecs: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-Id: <171492138878.1933443.16726044818716946890.b4-ty@kernel.org>
Date: Mon, 06 May 2024 00:03:08 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev
Message-ID-Hash: J7QUE7XGEIXGCYKK3T74IOMHKYFR3IMI
X-Message-ID-Hash: J7QUE7XGEIXGCYKK3T74IOMHKYFR3IMI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/J7QUE7XGEIXGCYKK3T74IOMHKYFR3IMI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 02 May 2024 09:47:20 +0200, Uwe Kleine-König wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
> 
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      commit: ba2a2c378ada0cd641a1887151ea8af532617c69

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

