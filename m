Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D0EEB64DC
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Jul 2023 18:48:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 340AF1E8;
	Tue, 18 Jul 2023 20:47:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 340AF1E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689706096;
	bh=o8g9igO7U5+ASKWMumYFxd8ogyiTtgaFXyMt2CAqFb0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eC6KR5QRGM9zzHAo0iOIhVCbKSzgtIo2HhNtXQEvs9PniH2dY3+XhTBa/1kQRpEoZ
	 Yp4FswS4TTQhyJFmJod/098igKzUV33sGZTB+zGGQwg/Z0DzPP2OinOPPyZJlNgp81
	 G0o02NIQnD2b10l12QMkiuxnxIesOoUm+4LIyGI4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 02C43F8032D; Tue, 18 Jul 2023 20:46:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 56B60F8027B;
	Tue, 18 Jul 2023 20:46:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C613CF8032D; Tue, 18 Jul 2023 20:46:55 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 24020F8007E
	for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2023 20:46:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24020F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=pZtdSroc
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 744B461652;
	Tue, 18 Jul 2023 18:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF2DC433C8;
	Tue, 18 Jul 2023 18:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689706003;
	bh=o8g9igO7U5+ASKWMumYFxd8ogyiTtgaFXyMt2CAqFb0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pZtdSroc5i0nbRxE7ZPhKmZcU1akOWuR6t0vjk98XJkiCKMCh2T8//nZnCKOndriU
	 M2XnsHmgFgDNpXrWRsMt0ySNv0xwGiU9N41naHi9132KdboMEtUG5IZMUhQN80ROkC
	 H0Z1Ru6/pC7nrapZOr7rwXBG2o/KCG7mDIRTAjcO6y4vHwdyWHMUOYq0TlS+0gdjVP
	 ZFNWk36pYQyiMtua3dR5Xhr+WNLzMa77R0mnhHLbYCqT1rEyX0U+rrS9pjY7reKbIg
	 6f1D01ug266xEyRVD680nobrjkNDIgXJH5aZbWr+QT61nftgHk0OmyVHKJSYUsBTHw
	 Asn/G7jnDZpEw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Yang Li <yang.lee@linux.alibaba.com>, alsa-devel@alsa-project.org,
 kernel-janitors@vger.kernel.org
In-Reply-To: <b0c5b0ca-68da-47e6-a8b0-e0714f0de119@moroto.mountain>
References: <b0c5b0ca-68da-47e6-a8b0-e0714f0de119@moroto.mountain>
Subject: Re: [PATCH] ASoC: amd: acp: delete unnecessary NULL check
Message-Id: <168970600162.93966.9028166669589055047.b4-ty@kernel.org>
Date: Tue, 18 Jul 2023 19:46:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: 5WM3GJQCKHHTE2ZYTUT3NDENE4UX6HJN
X-Message-ID-Hash: 5WM3GJQCKHHTE2ZYTUT3NDENE4UX6HJN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5WM3GJQCKHHTE2ZYTUT3NDENE4UX6HJN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 18 Jul 2023 10:04:18 +0300, Dan Carpenter wrote:
> The list iterator can't be NULL.  Delete the check and pull the code
> in one tab.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: acp: delete unnecessary NULL check
      commit: c1325a2d5182f263f2edbc6e0c1e581e4c5d5a95

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

