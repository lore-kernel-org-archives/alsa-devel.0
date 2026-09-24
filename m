Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6AAC98318
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:40:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3C38D601E1;
	Thu, 24 Sep 2026 23:40:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3C38D601E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790286015;
	bh=8OlW9XcFXyCs1RxCwFvnga2lzg0M/WLisor2qfZ3SD4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=e9MYdkX5EdXUwuVKziqyKyjL1PwGcN+GUkTq3zIgYMW7Boc0BPiSDc0/yNOh5DlY7
	 hHQjGkIJ43BFrXDDWI0JPLz+bF3wGQkBCnuopTf1qI1iGlSl8yCR21evsJAGG34lZw
	 xs6FyDGzijiH0wSBDnC16uL9/G0kCLoc4WHi5zOo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5FA8F805F6; Thu, 24 Sep 2026 23:39:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B58E5F80603;
	Thu, 24 Sep 2026 23:39:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1B45F8049C; Thu, 24 Sep 2026 23:39:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790285973;
	b=Or11qTZPVQYiF1ADAtT9r5ig+8koqLpFcDu0q9YYhfqHhXSQmhDlymLgnSmXMWRhJXxV
	 xmeR0eXXlwJOWcC3baONmkUkzrL6TydNph227lBz6eyJeDQoCdC8s5gtedmbi4VM4LDxM
	 KkO9ONBfXJOEi5Xc5hk5yTj4as6G/EJ5e9eNF84wL1jMOQA8ge5wcrhEHIKnfTQaIE4Fr
	 +lJCqiiisH+Bdij0oRnHVRtnMCBIrZ11bEojSaF7hgDsisilmdOJPDWQXny9oKAWUD92l
	 xVWm6WIAXmIhrwdiX0gwwB4vDYhMRcjCMxV2mf70wuHFcYXL/RrsIOj9/NGxBjcBveA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790285973;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=8OlW9XcFXyCs1RxCwFvnga2lzg0M/WLisor2qfZ3SD4=;
	b=sRaGoaBdPq4ky6LWdwbhXSfazQKB46ddOe5iQfLYfVQgWBR1Gh3Ky83RH1q1pxdHezmD
	 Rqqfi+BiPTsaY6GTn+qqpP/+yf5kq05TicK7mby06yE7lK3IJEcJ+H/Gpw04xV86BF+9k
	 iMAaYG92mKpNKtPa+Il7pnWBl800gzrANG0mSqnPDHdu2kF07vV2g3a61jwb0e7+Diw+H
	 0ZbiJhuoU/IBbotHg3mOqfXjdXMVCcrl1JzW/2j7oQMGa0iJm2nEBkoccBIQz3szuQQvC
	 KvULAimj3OxQ+r34TWuR4vcWq9lleYDOfjJg5C0r+SoHdS3GenU+e53s9P2hXNLMZ7Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cNyAom4w;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 25CD4F8027B
	for <alsa-devel@alsa-project.org>; Thu, 24 Sep 2026 23:39:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25CD4F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cNyAom4w
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1A9BD4011C;
	Thu, 24 Sep 2026 21:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7829B1F000FF;
	Thu, 24 Sep 2026 21:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285968;
	bh=e4nDVsEWk7/BZR2BFiu/SEpgj9SxAFAIpP7/yIZ970g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cNyAom4wdBDLlQcA5WKJhiXUnmwpavGUSGUmLyx8YQWNo8kFJ4EkujAZtQbfk7BHe
	 Zo3gGVbFrsT2WaWzvmO/WwWQeXtTkhsAlJJUBNTOSPS+M1ezTiljM6OvcGSQUWE9un
	 rwq2VV+ysGzCWBnfU3Rk6P8oMB8dR0sU/JCSCaC1cY7MsDSB1VVyZ6qbyzhW6tR73m
	 eeXxfEao6uW0pMged+ijSOoO4JGCiEYtZeA3xLJNATl4LQHu0EkVz9aE8DB+nDcVoj
	 c6TTlRqbi0Q0Uyq0EX1pvCVbRbg9ywK09so2BncHhKc6vasJZOZ0DFTcvqQq2/ykVP
	 2E2Z9rIPpmcIg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, shumingf@realtek.com, derek.fang@realtek.com
In-Reply-To: <20260924020510.3551163-1-jack.yu@realtek.com>
References: <20260924020510.3551163-1-jack.yu@realtek.com>
Subject: Re: [PATCH v2] ASoC: rt1320: make SRAM registers readable to stop
 being cached
Message-Id: <179027477362.149798.6244485054542986808.b4-ty@b4>
Date: Thu, 24 Sep 2026 19:32:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8OlW9XcFXyCs1RxCwFvnga2lzg0M/WLisor2qfZ3SD4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtZiLLWNsmT1lYaQF8+TTZqMjRtFNwtv3sbWt9
 km8ju7mrKSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarWYiwAKCRAk1otyXVSH
 0BRRCACBQrd5tUeX1C230kQaWKtaQAtj0zAl6tZCOC3qFZcC3e6WPK3fm7GR8/GV4pMDWARqkvI
 O0GeGYcT08QfahMtgS5uioLsxuz8lWzOcc2jio+HFpfYi1aF5QlvmTEV26N4/dIbJp857ITbTqd
 826SN+BmVPotbwfvNskxM+sqk8O03L1OhUC638b0iP+gAjOVl704Jz9IEDDx3glvw9BF258n5HB
 820VzLWJIn8vvccHmcTZZr/Q3scliffo6nE2cwNcs7o7PGTj0dD1PXdSK6Eu2CGf2BcpUoTOKJO
 I2NsiSzBVVBOer0oRVsEMoqaLa4JWspzmbVbj63AaOjtuqCw
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: AA76QUJMSVETRWM5R5GKWZRIGPVIL26L
X-Message-ID-Hash: AA76QUJMSVETRWM5R5GKWZRIGPVIL26L
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AA76QUJMSVETRWM5R5GKWZRIGPVIL26L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 24 Sep 2026 10:05:10 +0800, jack.yu@realtek.com wrote:
> ASoC: rt1320: make SRAM registers readable to stop being cached

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: rt1320: make SRAM registers readable to stop being cached
      https://git.kernel.org/broonie/sound/c/eb169cc54b87

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

