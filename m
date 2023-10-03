Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ED4E7AD42
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Oct 2023 13:21:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F54E84A;
	Tue,  3 Oct 2023 15:20:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F54E84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696339293;
	bh=bL/2RWcdfIs3uBPgbF0uigzU0E9baOJfVQtweOW66cA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XQ/t29IM++wADDtaeS80H62tYbzJBz9NNiyyV2LvwtvfDPEcr6dEiVDN8/s3e+zfc
	 MGQv9sySsttjBPRJ/1dbm6Hcpk3pKYZWS38FIZriq1c6wawGPeQ66lGiIN6oxs+u2N
	 tl/cmsn4yCN/RkwgYwdPj1HO2vsNgpvlrANcLRWU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9C42F80558; Tue,  3 Oct 2023 15:20:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C39CF8047D;
	Tue,  3 Oct 2023 15:20:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 894C0F8047D; Tue,  3 Oct 2023 15:20:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D5042F80166
	for <alsa-devel@alsa-project.org>; Tue,  3 Oct 2023 15:20:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5042F80166
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gzECuFYF
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2578861207;
	Tue,  3 Oct 2023 13:19:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841B1C433C8;
	Tue,  3 Oct 2023 13:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696339197;
	bh=bL/2RWcdfIs3uBPgbF0uigzU0E9baOJfVQtweOW66cA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gzECuFYFB67U4/QV8U0/sDvcEva1Sf84KNvoRerS3j/7DAF81qoa2nMJI6e4EfFfF
	 0Zkddvo2m2t3Te2gYMxksxAc81cTubgsjNXZb0DtLEt4H7nhc15BntmCEuRXysBluw
	 myNuOy3UwOGNvwAnxUIHM0t1WWQhz2eI0WhHA3aIPWlL81WNJ50H8NBmeFxyPaPIz0
	 xcpa1OgK26QjdvZc5QqKUtN0MKsI3C9wlabBJweHrICjwqfDNYSAgwYVo7qwmQ50e1
	 CZPEIoCFcrm/QiJ+trSkBB+juv46OGfLf8xH1Kk/0OA7NTvfbuW+i81KbRwLDEpi6T
	 XD1/QYTGP1MWA==
From: Mark Brown <broonie@kernel.org>
To: Joerg Schambacher <joerg.hifiberry@gmail.com>
Cc: a-krasser@ti.com, joerg@hifiberry.com,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230929150555.405388-1-joerg.hifiberry@gmail.com>
References: <20230929150555.405388-1-joerg.hifiberry@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: pcm512x: Adds bindings for TAS575x
 devices
Message-Id: <169633919521.32637.15894077647457160748.b4-ty@kernel.org>
Date: Tue, 03 Oct 2023 14:19:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: V2CFNWW6LHZLAIDAF4C6QTJQZWG4QVNH
X-Message-ID-Hash: V2CFNWW6LHZLAIDAF4C6QTJQZWG4QVNH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V2CFNWW6LHZLAIDAF4C6QTJQZWG4QVNH/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 29 Sep 2023 17:05:55 +0200, Joerg Schambacher wrote:
> The TAS5754/6 power amplifiers use the same pcm512x driver with
> only minor restictions described in the bindings document.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: pcm512x: Adds bindings for TAS575x devices
      commit: 736b884a7b68c4eeb66dbf75b97c8ec9b9eeff7f

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

