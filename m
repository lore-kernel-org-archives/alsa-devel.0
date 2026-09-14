Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE65CC88E75
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2026 22:54:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 230D2601E3;
	Tue, 15 Sep 2026 00:54:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 230D2601E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789426470;
	bh=2FcZ5UZqIjVillaDy/Al+qiBeAJfUNwIUD6cC4hbKOg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=e9Au6LOttFLeFA1Gcff+csu/A8qNJWwzA4S0Myuhvhvwzw1vZIiwiE96TVWAAIHV3
	 zIt0uxxiBOdA21iqZIpQfiSIhNZ1D8SqRXZqNIXG/VVZu/2R9ONcHZHxWx1+grdbOO
	 hz9Fajs1TqO5RG5P5ZqqL6yDfHzZLiM4SLMx3e+w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D413DF805FA; Tue, 15 Sep 2026 00:53:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AEDEF805F3;
	Tue, 15 Sep 2026 00:53:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4B040F80588; Tue, 15 Sep 2026 00:53:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789426427;
	b=e4xWZMTZOtgnn4kwJ+7DGv7OCCZRj27zNEV1FOSR7LqPGBtWLpwDn0AFoTRMklHikMRb
	 6NYuerm/OjMyDekW6V4uVUupblbRlr140C8s91DXnDFYNxCBvU2jf2PPUi4goz6SPE3+8
	 Ylf7gVMa9suuuqAgkeXv83ZNtqSLapORmR4HahWkbpUAHueWBbpIlvx9TlWqliN2XAV1/
	 G1YGRNvmDEwM0XHItEeMUmHTWljlAR8vLAig3IblXEFXgKFc1qshXiBYq+8dvj7MKmo8K
	 WzBZ3zSKyw5n7JZsfHaHWsQ47kQFQOKpn7tzyYTSQCblezP9vVQePsyJXAKkF/otGrA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789426427;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=2FcZ5UZqIjVillaDy/Al+qiBeAJfUNwIUD6cC4hbKOg=;
	b=dQUXzVgyMSxzdvsbUg06z4ByBCV2z+kEyUzZZZ/7WUYpOydm/Q6P8r8LVCCqh2tKXpx2
	 Wtxp6dyTZUULDH6ITF4dBu8xFSXcOftBV1M35zfxTxva4+wE2+sIiPak92xtrq8HvkPTV
	 IVLkHZpWWXUgfFtTz2LfAbffiqaRzyT+XsWbg53e2tRQzFYWf80ZSrFpQOKZp8Ei3UbUf
	 xmtG0MnOPhcYDTnvKoX7IvMXxHTV/org7iPUimxEXQIPv93m23j5cB/Nl+4HE88WiHDGX
	 4vzjoBMJFX2CL/A7gg3WAXWGmzkMLCm81edlGhVBCzaaTGj2JxlsQh3eqcCICNl3PDw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FWKOWbX3;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A1AF5F80217
	for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2026 00:53:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A1AF5F80217
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FWKOWbX3
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9F1C841A39;
	Mon, 14 Sep 2026 22:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68FD1F000FF;
	Mon, 14 Sep 2026 22:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789426423;
	bh=4FlgsHZGZFeo8HdlThrqiIcKPLiZF8Hx79n5WIDnYgE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FWKOWbX37KnyXJ2yRZ3bzNoSM5Lt+Nsrdi1pVZDLIBIJoNTBzYe834m1nX6DSbBXC
	 YS/gvJEm7VtWgihUjAWkHgeiG3BKAJui7J+p5qQC56gYAg8PY6I5qGdam1/4xyAYrL
	 rdQmrywaEP6+1RqJ6vRPpjkwKuz1ZUe6KvALDVVdVEX5Ld0AZcTkJ4NFAshJMTW/Pc
	 tk5HcbUpgWrh3jSrx/+aaKR92Bb7H7BHdCS/Jxmq5s5aQwqXCEMZm0v3UjOGSjEWvb
	 tzJVn4aii3oJ37o/bovRFAXkHmbiXlgfQYUlPHjym1GSmrJue8Wqtw6XtaA9Gd/PSr
	 zIjw7sm7F7oNQ==
From: Mark Brown <broonie@kernel.org>
To: Neo Chang <YLCHANG2@nuvoton.com>
Cc: error27@gmail.com, lgirdwood@gmail.com, perex@perex.cz, robh@kernel.org,
 krzk+dt@kernel.org, linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, neo.chang70@gmail.com, kchsu0@nuvoton.com,
 sjlin0@nuvoton.com
In-Reply-To: <20260914015648.311986-1-YLCHANG2@nuvoton.com>
References: <20260914015648.311986-1-YLCHANG2@nuvoton.com>
Subject: Re: [PATCH v5 0/2] ASoC: codecs: nau8360: Fix DSP routing and
 deadlock issues
Message-Id: <178938378715.1239410.2210412179676360057.b4-ty@b4>
Date: Mon, 14 Sep 2026 12:03:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2FcZ5UZqIjVillaDy/Al+qiBeAJfUNwIUD6cC4hbKOg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqqHrxh5XZbciWZC3hbOxYu5LULjT0kZie6Qcts
 NiHMhyfu+OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqh68QAKCRAk1otyXVSH
 0GgNB/9vrC2fx/H/BaRiHMgDJgGOaQsQlylqjM3md3zPFoTcSlLz7fsK60GyvJNQA/BB5PnW0DW
 KqSLhYydsaWQvo75pe0aAZYwyCenQKG0qz9WNg4JfqPqRZn7xu6lERQv6LkenDvWTS44j2LttLa
 g11rl5NVYat6mxpJdmn05wCrgAWi92Cph77iTFyotJwD7oekD7dH6jEzYmeECdf6aC622gPO0bx
 PPQD5pOHFbzqEc5GXVIiUF42yIP5tUOl/9PnNn0q+RnMcb0JOef+U6H/MEN/jQ0smmCrsaEx6hv
 3dA8A8/zFe1QSgzVcTnWL1/VC+sDEj5xl3HtnVVSQsMdFyn5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: D3SOY46QLSLCESBW5CVEKTGAYLYUHCDN
X-Message-ID-Hash: D3SOY46QLSLCESBW5CVEKTGAYLYUHCDN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D3SOY46QLSLCESBW5CVEKTGAYLYUHCDN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 14 Sep 2026 09:56:46 +0800, Neo Chang wrote:
> ASoC: codecs: nau8360: Fix DSP routing and deadlock issues
> 
> This patch series addresses two issues in the nau8360 codec driver
> regarding the DAC mux control:
> 
> 1. An invalid hardware routing state that occurs when the DSP firmware
>    fails to load but the userspace attempts to switch to the DSP path.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/2] ASoC: codecs: nau8360: Block DSP path selection when firmware load fails
      https://git.kernel.org/broonie/sound/c/9231c12286ab
[2/2] ASoC: codecs: nau8360: Fix AB-BA deadlock in mux update
      https://git.kernel.org/broonie/sound/c/9b4647233ef5

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

