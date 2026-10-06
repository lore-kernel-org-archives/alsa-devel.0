Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C0AACA5FFC
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:35:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4C37601E4;
	Wed,  7 Oct 2026 13:35:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4C37601E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791372913;
	bh=bmer4zo5i3MF/+SBZHwQ1Gwak4NUPrHOd9hhApaX9sQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JLdyGfWngtLj+7GlACT2SsRwiFLfK+PJQfKeWlaycJKF69bAT/fiexXl47tXfUcPU
	 T5IkQRpjKV/1WTG1gQ0AjKyPFLxk3a5sJS7lWG0EtRKJ54MJpZd7CP6N0il2dbzpf3
	 OnFf3CTPIqYv6aSr8M+penS7j/bvG3ReUvR00AIE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CAA0F805F6; Wed,  7 Oct 2026 13:34:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 22BD5F80605;
	Wed,  7 Oct 2026 13:34:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ABFB7F8051E; Wed,  7 Oct 2026 13:34:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791372873;
	b=i28FnSCt1tzhlAKf0F9uOyt0ccj+nH1tE9cBkFU3MYzWRgb2lMJRY2Z0HoPqq6G1dhxH
	 FGaacJoPKdWRYqK1JOKxRNRI8FKZuorRLD34UEQ7wY1C8XSoKBNm23h7Z4YRe5LgALHi+
	 6MODkd8AY8sgWIhTwztIvhrmjvHrHzmWLurZE0w+865IS4w+aM5iigHlaCWnqNaCLePEi
	 9M5mhXg+G5XVUwBhQnLsORvmOYRtg++1Hg6/hKT29RQTgd4PwkO0XSstyqtF4SCyu5X5n
	 DoMObiPjbyQ0t5BZlpqESGmtWi+UKbnWYbVJU4T/G6wodRApAi2vV2k5NGzA8OU0lRg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791372873;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=bmer4zo5i3MF/+SBZHwQ1Gwak4NUPrHOd9hhApaX9sQ=;
	b=GLEeDL++cweFTTCnHflpPu7jfcCiJ8EyRsN9+ZTXAw2rXa9AMz3OuxUIilPad/IS8pl8
	 y/PwCZ9CYSPXwr0MzfFbZF/tqHIANI4AY7A4ZXlpbXExWZBiQ68QDk7GqbFQ5Mn51vLCR
	 K7Kdf9YPiLtRlg1S6o2J3rBNyq2yxjrUs5eEmV+2PXug13NamGXl8HyKY6BPvAsy1kORg
	 145eqtUcBGQQW7PRvXy6KHQsdUrCxDYuKtsym+8G8NCoPj58CWJca+dn12begowGke7sr
	 ulzh10G8ztDI8RZy7Gm/8D6MpwiQHol3qiOiliHAVfWMKJJN9Q2aBqLH43MXm+n5MuQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="Vtlj0/TU";
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D4EF7F8007E
	for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2026 13:34:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4EF7F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Vtlj0/TU
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8ADCF42A43;
	Wed,  7 Oct 2026 11:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236521F0089D;
	Wed,  7 Oct 2026 11:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791372868;
	bh=kgOi+4BuX9MleURHmIMwd5AVwaGn+Cj54SB0kpt/DAI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Vtlj0/TUEycj9dENkVv76YSeU0uKPGOpW1tSAkW7Uzucbxln85Qpx1sFF25t6eeX0
	 0MZtCzw0+pN2gq6eo1vWLgY+3lD3bC9WrgbuJX31i2sYeW/cYM6+N1gW5HsG2RBAkU
	 4mTqhdxz8BfQWimXQgNPHbk7HckdYN0w4Ih/9wHJLJJqIa5k7Sl6pDmJqTt1W3BGZG
	 CI0kMM/Pl/x7p5PlN4qB2TLJIU9MmNSG25rJ9hGjC+FdPfHHfE9n3DSb7ZzyBwjaKl
	 PCjtpMv5ep6RLQJlIq+zZieH+sGd1iZZXijFA6Kwwac1L23w7g3IKe+YDbkYrCqFsr
	 Ffn7bNAgq35uA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, shumingf@realtek.com, derek.fang@realtek.com
In-Reply-To: <20261001024657.739186-1-jack.yu@realtek.com>
References: <20261001024657.739186-1-jack.yu@realtek.com>
Subject: Re: [PATCH v2] ASoC: rt721-sdca: Adjust blindwrite flow to fix
 type detection issue
Message-Id: <179130256812.150114.6173207753938230873.b4-ty@b4>
Date: Tue, 06 Oct 2026 18:02:48 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bmer4zo5i3MF/+SBZHwQ1Gwak4NUPrHOd9hhApaX9sQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqxi4+BipkrxEPbW+PVn9eAQP+os7bJ5n4spv2w
 aBvJZcK2DqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasYuPgAKCRAk1otyXVSH
 0FkZB/4j2/X1lSkvQ1ORKD+8aZxodPTdKzU25WuG/XUkVI2j3gqj37DdfL2z4aJCzXL28cxc+k9
 DwEkS1r/MabX2sobOel5pY9Qu3sGJNuzwudtiHMa+pzhiGON1elC3hZwWc3FmT3xUJei192LTiC
 DAu6ry58KsR1pS9rRmoQznnRFsyPcYKA1yG28xJ1W17qTYactS2jI84D/aJuegSG+7BPwOhOAaP
 XMdKKi8nFubZ2WexxNM5GBe7bf9npl8vNWQNcA1U7o4DLH4po2tRNOEiUZd/VCI1zB6U/HWSRid
 6c7gqgkrag+onmelOpqDXlmL49triiR3FJ2rq67apQV/c96T
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: VJHE4J2FA5U6ECOIJOGNLXKKQGT65UDX
X-Message-ID-Hash: VJHE4J2FA5U6ECOIJOGNLXKKQGT65UDX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VJHE4J2FA5U6ECOIJOGNLXKKQGT65UDX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 01 Oct 2026 10:46:57 +0800, jack.yu@realtek.com wrote:
> ASoC: rt721-sdca: Adjust blindwrite flow to fix type detection issue

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: rt721-sdca: Adjust blindwrite flow to fix type detection issue
      https://git.kernel.org/broonie/sound/c/e2eb4873b901

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

