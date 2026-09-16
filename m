Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66201C982C9
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:06:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA39F601F0;
	Wed, 16 Sep 2026 19:06:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA39F601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789578370;
	bh=IF1w4YkKYEOtHYQOlWDYuuhdT7uZw8MjALmnJ3vOXZY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vVXTzmS1EiYEAstE+CmZzARcU9hfrE8WmehnwXcp06vSCBnkP3mTQMZ+qcKgEtNc/
	 vS7sGph4UMSHGPJJiWCWshyv7FnTmrSlpvJjxWEk3t9FaKGvIzRUfkZsZyyPxPIUT1
	 N7SGS8mvDQmksv1C94Cvz8mt2ShgsYivatoibO/c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1C0BF80600; Wed, 16 Sep 2026 19:05:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A047EF80601;
	Wed, 16 Sep 2026 19:05:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7CB65F802DB; Wed, 16 Sep 2026 19:05:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789578328;
	b=cIn00J+Ya/UXVMJYTYAwujXnjxqU3ZUfn4V45Vwuy5OoeRPr0d3KHnLf/KcdWLLxNGOc
	 TlghziCk6b2Z7iuEIKvdTFivLdjxoIZtkQy7X0smb5Mrj5+rgmuBSeCcqdxIYKFTuNvUc
	 O9RzJHm2R0tWQoP28K67KZmkg6JC1/OJu/GbhCOiBjMclXaX3qqRZ/QrThdhYZb42C5L/
	 zLwdHlEloUtvethTh2z2vcgf7lD0/NeoY0uuAFS4toNf+p3pzJpH7Ccp3qwBO0tIhHAQj
	 Dzrh+kcS2/KQoOOO4BrIIh3q2p2xShEcxWLdqbOdA1TCNo3Qqo/KICyXkBPABEqmjmw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789578328;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=IF1w4YkKYEOtHYQOlWDYuuhdT7uZw8MjALmnJ3vOXZY=;
	b=ObQy70JSol5U+RsotdYoDlZ/FvflKVk5S866BjJrQBILwp2pMeHDGMOkO9yH3p6kA3YN
	 +49Ogo9jT11vkQYqKLWPa1aWqRFGXEYlWoEZglI5yHu6NG91SM1PTyqXTqNN80pSFc+cS
	 LT3rJRSklioWnSaTrczUCYmXZi0FB8KIDxrX3ew/UporKmxKO0edlxNRaDwFg4wQgFP5g
	 KmivXKedntL0sueYuMoPz02NTtpnzl1VkA1TWtXpuZGidIb8VWKQFuuB6A8d41hYRZvEk
	 GUOT0+CiZT1KN1gO8bvz+NLJCBC4Qmsr62YMDs/5aDnhEDn+05Y2vfEwi9Mex/bz4pg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ky1Qnxpw;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 78BA8F80007
	for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2026 19:05:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 78BA8F80007
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ky1Qnxpw
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0E980600CB;
	Wed, 16 Sep 2026 17:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73D71F000FF;
	Wed, 16 Sep 2026 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789578324;
	bh=/4QzDOFGgzvxHnAPbU0sK5Shh1UZgj6em+khavRLcHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ky1QnxpwAnL+lEqMTCWu5STCTlzVG9nX43OWhzzfsIHvAGKZz4BdAnNGH9sUNUQHl
	 yu8Lt5tojF1+rBYqqIFxZukOkcIt/ce1D8hfdz9Aikv0mliFAsbMIhAdEe7Wu8RooT
	 MtV0sg11BaN9XvpLzaDqjENOsp0OkJgYF7bCci9IXVFVDe5ngOORm9GwKYqtXR3hAL
	 r29M4ltCuyJp5bTj48q+eew3A879MmKkcyyT+HoZ+BNqe0lq3/u34lCGpA4bqT7dVf
	 GbJuvndtA/Z708wW5KGr2hL2PATotE1piDdu550hzGdATkcwQThXVVflUXBjuN2lfF
	 pGLmw2Z1kOwGQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
 Neo Chang <YLCHANG2@nuvoton.com>
Cc: error27@gmail.com, lkp@intel.com, perex@perex.cz,
 krzysztof.kozlowski@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, neo.chang70@gmail.com, kchsu0@nuvoton.com
In-Reply-To: <20260915014940.317403-1-YLCHANG2@nuvoton.com>
References: <20260915014940.317403-1-YLCHANG2@nuvoton.com>
Subject: Re: [PATCH] ASoC: codecs: nau8360: Fix misleading return in
 nau8360_message_to_dsp()
Message-Id: <178957831392.100121.4806798682515883550.b4-ty@b4>
Date: Wed, 16 Sep 2026 18:05:13 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IF1w4YkKYEOtHYQOlWDYuuhdT7uZw8MjALmnJ3vOXZY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqqsxPX/8pUU8pRAopq04NND4Xoi5S8qGjIbUaE
 y0u4nSW+ZaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqrMTwAKCRAk1otyXVSH
 0DE6B/9Q0mJpzxHze1wTROtD045JZl/ETrv6qYbfZWRziexbWpWmNRIP+BCInCStrp7ndGQBbCG
 ACvBWnRP0Gkm+pHnNEiCMtaXRKnug7oW0ccDQ68sAX/hWMHuWRRDnZuHKyk7izZNqR/ENBum1nk
 +XgR8A70BZGKXdKRZsJhGvQMWvwvCSIHZS1AYhdCLL4wA3wuXfbIFcCdYtcqjm8QS4cxkHG7nCe
 jHN5+O3mVXCZDRpLsXSmEnsoSBgz/pnUT3cQtcNUCFXKYOuEbOdpbW99yHsVCwaaVTvt1oWwmTP
 c4Zysj4H7ngLPxJ8IsHtdwcsDZyRutYP/sQGj5+kV9XL951k
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: RY4T4Z3NM7EQZY4V5ZBO75FZYCDQ5NAM
X-Message-ID-Hash: RY4T4Z3NM7EQZY4V5ZBO75FZYCDQ5NAM
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RY4T4Z3NM7EQZY4V5ZBO75FZYCDQ5NAM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 15 Sep 2026 09:49:40 +0800, Neo Chang wrote:
> ASoC: codecs: nau8360: Fix misleading return in nau8360_message_to_dsp()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: codecs: nau8360: Fix misleading return in nau8360_message_to_dsp()
      https://git.kernel.org/broonie/sound/c/40ebc8f73630

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

