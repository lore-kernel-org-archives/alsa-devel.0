Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B344FEB64D7
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Jun 2023 17:30:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C0F5823;
	Tue, 20 Jun 2023 19:29:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C0F5823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687282244;
	bh=lioq7mex040QABLYI2qsir/2Ee7Vlv3H1GUQrVC7a1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nYUEenBgGvHQ5A0zCd8qO65O5NFG37Qd4Cp9Z/77XZ7EC3NW9dfYFJ86CpY+Jimqn
	 Nq+oQge/qazDMtZwHIqg0ydEOpsdit5NFEPQqD0EFAM5GPvx63VujROakE1PyS5FXT
	 /shrOaUfXMDfdycy8dmC5MY62HFup3Dx4V8T0KDw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF86AF8051E; Tue, 20 Jun 2023 19:29:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 30745F80141;
	Tue, 20 Jun 2023 19:29:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8A056F80141; Tue, 20 Jun 2023 19:29:24 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BDC94F80130
	for <alsa-devel@alsa-project.org>; Tue, 20 Jun 2023 19:29:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDC94F80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AX/ucCzo
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6502361077;
	Tue, 20 Jun 2023 17:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40909C433C0;
	Tue, 20 Jun 2023 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687282154;
	bh=lioq7mex040QABLYI2qsir/2Ee7Vlv3H1GUQrVC7a1g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AX/ucCzosrfmmUjihrXZ3Jg0wYzmj2LxqptcCPX9l82bXdhFy6lLM7RPLJ7vUYD0W
	 weIh5TYKkap/EMk/jiLL/wVvS1mlSVRXs8/5gBOw5Ou6iU28ZPwuPQd1I+0FQw9ait
	 CX1dpjYuKqhtXbQKqWbZdX2k8pnLfEE1wWKDL8z4L7EWF2Yj3NlSrz/KYGgRuoDvyB
	 sW9AHehm8X0F55BpKVlJVI4TCSKOYX8pFfnPJgQg21AfqOKccmMSCKxbeyivcHPW6A
	 P+84JtUO7wpckJpq0adzFYcO5aLQXGthq4hAu+J5ZxHuDX2bHt6lte70lnOfcoY2Db
	 mjkybMX9H1Iig==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shenghao Ding <13916275206@139.com>,
 alsa-devel@alsa-project.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230620095620.2522058-1-colin.i.king@gmail.com>
References: <20230620095620.2522058-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: tas2781: Fix spelling mistake
 "calibraiton" -> "calibration"
Message-Id: <168728215296.92979.15498830214406273531.b4-ty@kernel.org>
Date: Tue, 20 Jun 2023 18:29:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Message-ID-Hash: 4QZZWCZO6OO2KFDOSH7C26GRBURUZMLE
X-Message-ID-Hash: 4QZZWCZO6OO2KFDOSH7C26GRBURUZMLE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4QZZWCZO6OO2KFDOSH7C26GRBURUZMLE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 20 Jun 2023 10:56:20 +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it. Also fix
> grammar and add space between last word and (%d)".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Fix spelling mistake "calibraiton" -> "calibration"
      commit: 0a08778126284481c300336f1ba3d7b1906851a5

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

