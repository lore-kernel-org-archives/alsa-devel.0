Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43808606A31C
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=IOoal8hz;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6yCfGoP
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30659601FF;
	Mon,  9 Nov 2026 22:46:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30659601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794260805;
	bh=sjjSvTkS9orj5DznHo9rAuH3nsBnHlo7W3ykTUnQZpM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IOoal8hzZ3yrIBMPL2FdyhfpXe00LhpP2dVszQc7+toyvNE4aOV3PHlh7Z9Mfq9wJ
	 4SBkD02T21Aq2YbjoDNYUz6xms3x2iQS0VlCDPoR0NmX8Z4v/YjdWOUL78XV7AsvNH
	 fA4GLINlCDZtVgmPvSaX6iXlh7cB93w/htTJBchQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 62C6AF805F0; Mon,  9 Nov 2026 22:46:10 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A7D9BF805FF;
	Mon,  9 Nov 2026 22:46:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B2A2F805C7; Mon,  9 Nov 2026 22:46:04 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794260763;
	b=nBzpkgTaR0ZBnVqprDaB9306qE0iE/mJOohI7Sr6jHIPDPu7Scio9vqkwDjbG8+Ee4Q+
	 Cor5G1Yw2kZdGjhVXRTmcC8ynSn6j8gtVsHx3e1wvsNDNz/E+/xPCZtv0rSJexYlW3VEL
	 v5R4mCxXqM0eKdf7Gczau9fJgVBHzmWS7SqvtGlUC3oOdDedRuKid/H70RCBBp1WaKL8u
	 pJa1/GHMUpS6f1gNP0r/Z++1VSDD6Mp+Bu14fvjUArxyRO5yR6IVqu07wfRI8XRUW/+RA
	 GNAEmaqvUHjh6a4hC1lovVSF2IJiAIgF2uKt4JaoZcFo48f/V1laeRZK5P6THQYbRng==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794260763;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=sjjSvTkS9orj5DznHo9rAuH3nsBnHlo7W3ykTUnQZpM=;
	b=YlZHDSP2tD/46jwejw9iaAS4oEa0q7pQUWB5H3hyCfi2RixjYc26bmeo7oDZX6hBHthC
	 EzcLnqn3lTfock853ZIk2+Fx9nu3JbLSMfL84Z3BoX2h08r4YsXXHOZmyjttB1BANAA84
	 RRC9cGvMN+A06E5PtXRTuEA7BVZhDRka23AEBjevH91YR3NqMENRYKDJiOy6zGCISkfph
	 1R6jaDA88XO+udW4ZaneCW/heen/Q6zG0g0VjUONBAWQPMZWtC+IxOHOgIqLZ+QbBpW2H
	 Radjy/Sj07bv1mDqfVoW5UqC12NGUKdYOkwWg14Shp/3Iw3XzKFmztY+lZ6hPyXbBhw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=f6yCfGoP;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7FCC2F805B0
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2026 22:46:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7FCC2F805B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=f6yCfGoP
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3DB864054A;
	Mon,  9 Nov 2026 21:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FE51F0089F;
	Mon,  9 Nov 2026 21:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794260759;
	bh=hDJIEeL3gMsVs5gZUcaKo6fon1UsVwq8sFjg6Oo26og=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=f6yCfGoPZkLpbNMiGSY09B1JKGZ4TZPcAXRLkr+7HhugPpb31afV8NZz65eVi/XSC
	 uZ8kccsMKF0k7N4xaym0K6iU11WQuGgOiGVuzsWO2F03bjcKXe10dHXikteWyrTULo
	 I/V0dTDuCTDiAYiljJfSnvRc744eh+U82/v3ZIXcLExqEG2QwoO6sPM6IEYDuImpwE
	 hYaaGn0OExU1UK/IAFcE1q2tJOHmLM6uPuhh5IKStWF1zKmkPnvoYJQTsu5jGIlrhX
	 jgSpr5gevj/H/eUMzN5v3/JFiNy8+3LaD/DHC/JERyrROvXCQ7pi5QNtAAiA+y/HWV
	 kSzxs1/DAbHww==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id F2ACE3021C4D;
	Mon, 09 Nov 2026 21:45:45 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, shumingf@realtek.com, derek.fang@realtek.com
In-Reply-To: <20261109085852.3952421-1-jack.yu@realtek.com>
References: <20261109085852.3952421-1-jack.yu@realtek.com>
Subject: Re: [PATCH v3] ASoC: rt1320-sdw: Update the driver to support
 rt1321_va2
Message-Id: <179425086528.3711751.13860534232587716225.b4-ty@b4>
Date: Mon, 09 Nov 2026 19:01:05 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sjjSvTkS9orj5DznHo9rAuH3nsBnHlo7W3ykTUnQZpM=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+2XPKn9+UbtvdPrkvMsBc31B7dmLTLrGVz7l6e1Lro
 kJnXTbpKGVhEONikBVTZInL4n5ZX/J6Dd/BhW0wc1iZQIYwcHEKwEREFzAyHNIwj1+qq1du278i
 6d26vNj1jddnN59MLem/xHjcyoBtFsP/UnaPmYZuFuXXtVblHb1i8Trnxbzn0vsM2gI7WA+cea3
 BBQA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: BK54PGH7Z6U7DSDN2Q7TFEZXJOZVIA3U
X-Message-ID-Hash: BK54PGH7Z6U7DSDN2Q7TFEZXJOZVIA3U
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BK54PGH7Z6U7DSDN2Q7TFEZXJOZVIA3U/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Mon, 09 Nov 2026 16:58:52 +0800, jack.yu@realtek.com wrote:
> ASoC: rt1320-sdw: Update the driver to support rt1321_va2

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: rt1320-sdw: Update the driver to support rt1321_va2
      https://git.kernel.org/broonie/sound/c/fea5ad21ad60

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

