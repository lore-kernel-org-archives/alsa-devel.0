Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27611C88E72
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:32:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90A01601F1;
	Thu, 17 Sep 2026 13:32:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90A01601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789644770;
	bh=z9eNiPj5wDyiTB2A/OcoLh7ppc5eD2mfvBaiWSEdvQ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eAlK1iCSLXCChYsLdUvcPsDJ2js6+p/63r5E2bebXdjPZs53AqZdwWSBgV4r+G6fD
	 F9NQ8kM/MXr8+27rf0lGoXvI/MNzhVc2Nf4UmqCksRBiABssSuuc21FMU11wAz8dcy
	 qNUsSkpOJNvgpaOCFJJEBfz/ViR+lDmCB3XJ3HWs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 23593F8059F; Thu, 17 Sep 2026 13:32:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E8266F80537;
	Thu, 17 Sep 2026 13:32:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D6B8F80537; Thu, 17 Sep 2026 13:32:07 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789644726;
	b=N5EsykLmLKRRI2wrQcgTzZx8K5uP+4XuO9OQ/oLUWVVE60tFp64Y3A0SoN48C1QyIh90
	 U67Lyii46f0D/eP0JkMZvL6Z9lXA814S0q35hKCrcTzVfNJzlCgCiE+dQl0trhugK/yOb
	 /pXyDjAauds7/q+HNaJ2S/5OkmCj9RnZwUNJzuKxdy94lpsuoa2BLsd+sV92nURN3xDUg
	 uH9OlePLq7Da4L/xZX7ui0sM9ewqux3nrcqDVWFnmXhqyva+S8XC2EnQLUq0mjs/FY/+m
	 lsH1nMnxXxnmrfdmOsXZ8cS5uJA/LdMme9j6q6viGLmWM4+RsuLb7pckCRjD4oTmK4w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789644726;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=z9eNiPj5wDyiTB2A/OcoLh7ppc5eD2mfvBaiWSEdvQ0=;
	b=oxtSalCKvTp7R2rReFf/Rr+fyvTZBGFVjpLKzJOQ/wHd+HuIwPNUQIeM/Q+/r4DNPFZ3
	 PPd1nvHNdnuuME83g0pZKj1joD90yLMlpgRf4DUv/6jz/77iWQvZloyvB0D/VgcqrG5oK
	 suilRdPT50G+jJtJpx0RI1MYGutO6RwiahMlJzJRWn3O856QsftjE54xN4PJpKwqcivIR
	 1O6mD4rcph1xUyhs5NrIyjzZM5ShvPcXwb5FqePmE2qI/FPe0eB6Ea3qfx+h1CaI0enCg
	 tfqEwAAiIEHgnhIOTvxgfdG90/IRtBjN4mTb9Wc5EHosebhNwOGe1ZmKnaRMOSbPItw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QZmba+ga;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A7A26F80007
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 13:32:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7A26F80007
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QZmba+ga
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1D99A600D4;
	Thu, 17 Sep 2026 11:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212991F00893;
	Thu, 17 Sep 2026 11:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789644721;
	bh=UuRDRTa/pgF24T6CNlfb17GrjpX/75I8hK3VDhG7wLg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QZmba+ga10yMzQ1gemQipfG4BAK3F9RhZZfUxvHLmhhdhZT8HoKrw4jS1UtNndIf/
	 gsJYb97N3IE67Y9q2kogvJpN0o3vQY2oJGV9cRqWUnBOZhAremGq38ToTl+1Jap4Rj
	 Sg4iKXOqW1xd7s6bDZaC52N3G7iYcfMea5dH+CVJRZdjq5werMpHh2p3L3/CTdDsWg
	 bw3eHAIdiNwoBzDAbYcYevHkY92nY6JBkAm3qXULI9LsTLvqaMM9XhmjgQf+LVtdJt
	 wTyz3VjdyDuBRi37UimHQWIxig+xS0r22xrFBmMHLB5ilJ69bgL5L4r5G9ywqdmJ20
	 Lh2XNkX86iG6g==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com,
 ckeepax@opensource.cirrus.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260910161728.1452808-1-Vijendar.Mukunda@amd.com>
References: <20260910161728.1452808-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/4] ASoC: amd: acp: SoundWire machine driver fixes
Message-Id: <178958572197.100121.14407200644851450524.b4-ty@b4>
Date: Wed, 16 Sep 2026 20:08:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2490; i=broonie@kernel.org;
 h=from:subject:message-id; bh=z9eNiPj5wDyiTB2A/OcoLh7ppc5eD2mfvBaiWSEdvQ0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqq8+sKqbUOIjNIxWRoEOn2z3Gakz5kSPA8anPY
 BHbXPm3FLCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqvPrAAKCRAk1otyXVSH
 0MWMB/9GW5cSUO5cvH3ToZqAeRvPOvNVaRpkaj79V5uiQYm75pol0kZrB0Xta196VGRZ5V4nbO9
 EqExr7vE4yD8+wzdHT+yeFEO+ebOc0Pyma2ALt9e8hNTxOsFPgCWfaLYokWLAek98Y6pSPsU1Mk
 n7KOC+1esGnvS9Q2/IVDESVG3T6ozBVItC7otl6D5JVk4j3lHSbW9jFpTaOQ+p1CaQOxysZSLq6
 vbmf9jqTGlW5WqESI4RLQuKszsXBOugKpPhQ1pOwVL1tzPiHvU5/5gO3mFn8YGglrJt5v5+hbzq
 OpNG1LMz2CPaZiXpFvwjoHC5UOaX13fFOPnJVqsEU3J4FWG3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 7UIZ5BCDUDLX42OUO6U4AMR7QYY2A2VQ
X-Message-ID-Hash: 7UIZ5BCDUDLX42OUO6U4AMR7QYY2A2VQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7UIZ5BCDUDLX42OUO6U4AMR7QYY2A2VQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 10 Sep 2026 21:46:45 +0530, Vijendar Mukunda wrote:
> ASoC: amd: acp: SoundWire machine driver fixes
> 
> This series fixes four defects in the AMD ACP SoundWire machine drivers
> (acp-sdw-legacy-mach.c and acp-sdw-sof-mach.c).
> 
> A bounds check is added to validate the SoundWire link ID before it is
> used as an array index in create_sdw_dailink(), preventing out-of-bounds
> access when an unexpected link_mask value is encountered. The codec
> config count in the SOF machine driver is refactored to use a dedicated
> variable rather than reusing the endpoint-count variable for two
> purposes, making the intent clearer and avoiding a stale value being
> passed to the codec config array. An operator-precedence bug in the
> ffs(link_mask - 1) expression is corrected to ffs(link_mask) - 1,
> ensuring the link ID is derived from the correct bit position. Finally,
> the SOF machine driver card name is shortened to fit within the 16-byte
> snd_card driver[] field and eliminate a compile-time warning.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/4] ASoC: amd: acp: bounds-check SoundWire link ID in machine drivers
      https://git.kernel.org/broonie/sound/c/29218a4d11a3
[2/4] ASoC: amd: acp: refactor codec config count in SOF SoundWire machine driver
      https://git.kernel.org/broonie/sound/c/0b7d55d3a912
[3/4] ASoC: amd: acp: fix ffs() operator precedence for SoundWire link ID
      https://git.kernel.org/broonie/sound/c/27098aaf28b9
[4/4] ASoC: amd: acp: fix card name length warning in SOF SoundWire machine driver
      https://git.kernel.org/broonie/sound/c/d57616f8be56

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

