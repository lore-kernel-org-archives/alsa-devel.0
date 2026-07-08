Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967AEC43458
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:20:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCB6B60222;
	Thu,  9 Jul 2026 14:19:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCB6B60222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783599601;
	bh=vlPUTcGzxlMUD3k3AyOxrB6G7qRoJw4Q46sKR6E7FoA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=oAZH1fQdfJRnMAPWzKNUhqLqkedtg36Y5rVH67PbP/xVK6FVw+BGvzgH34ZrD/kfp
	 rVQ0Ysnhsh1dxiA2CBpPVYxHhucTSABvMFtw5PNQLoxlbTBwbML4/ya/pS/AU8Ukun
	 BeWc/5ot4+sJ1ytoBq0FL/nq3FbkxFg3rhlqcTWQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42B0FF805F3; Thu,  9 Jul 2026 14:19:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A36AF805FF;
	Thu,  9 Jul 2026 14:19:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 306C4F80495; Thu,  9 Jul 2026 14:19:23 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783599562;
	b=DUtsFtn9v2KqIqE7njh4GnhYEW/XgudnDSCd1gYCHjMZxYUZyctsBigYMVLTuMciCWBl
	 ScODj5WHykflyrDm7DgLvxkqT48A5IvEh/h3eV+u1gCQ8URtCghjaT8b4by/UnAeLVzlC
	 Uj0iac9zIPq63vQSinfaHH4rwrJAaCHGKn/ecbMZGHMfbNr2wUJiOqXOPTLm2c5QAimuT
	 GQgVW7+5AmdIUSpgMuXD3k9Xn1EhuW28lliPvCl3sYFoocDNgva9U0DikuOaYUvGOtumD
	 HHx8sXXaXtIn/CNYsSC+32gyZ6Zmrd3Dr3HtkiJCcOd8aZZzaQ4P9uYb14M9S7zz5tA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783599562;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=vlPUTcGzxlMUD3k3AyOxrB6G7qRoJw4Q46sKR6E7FoA=;
	b=TscUBn62sbIYpVF3H+6N5pmKEsnqBiiQwerKwrbPwi23xaj9eAggGdW7prb061Gix9Or
	 h2vnmMQCZVF9fJeaB5dpmLGk2zgpAur1+aNvwr7hKxemQ9n3rQe0TqzmjMBhhV0clXkxc
	 txtHCDRx6jwqqR6Be3NG4nHQhdGVeFwv/96qCi4muulIGaI4s4d0tccFy2Eig7aMfDCQb
	 QF41qb/Ja78eR9GikqQ8e+APwLNMKrm3/spvYK9tMdmmPOG62cxl1Iq2oVshwGDR5oTdN
	 /2EiPQAR0t4U0ppjOLjJjEFPcwV7QI9Q/0+OJS6d0yAS40UgHkvyFXhdCUYIc9rcAMA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=n2HLKx2T;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4B807F800C1
	for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2026 14:19:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B807F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=n2HLKx2T
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 19378600C3;
	Thu,  9 Jul 2026 12:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFD41F00A3A;
	Thu,  9 Jul 2026 12:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783599558;
	bh=pTKbBgXBY4UPnNa8ng5W41cURWrnrZC5zN/zl9qP1WE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=n2HLKx2TbcoooEsQJgjn9821DeUjv/CzgEOFwNPMG0dRC+H+weKeEsS8PWTZjpYfl
	 YKgrbOEL2RTdDOJt26wqiparSt+ZftLsZGubD0j/BspyiFwP97z68ywJ8P1VUcdUbe
	 Tk68jnZRhsA1gbIUHZOLFvhtHAqnKFS8/kJ+bTyt3cT2m7NhVQjAxDwNgQfktM2YBV
	 ZuI4ltt290iqVXotBVOCCoI6rw1KUmazaQbtaLCD8N3AQk3GvMpN+1ZMa4p3B+9ISG
	 4fgjcQNx1+YNAjhyFPaI+yZFNCYuhfRoAzanl29mhEuqU7A0tIauwHXLIH0Rzuw/AZ
	 A3IZN/yroHNlw==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 mario.limonciello@amd.com, syed.sabakareem@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260707060130.2514138-1-Vijendar.Mukunda@amd.com>
References: <20260707060130.2514138-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 0/3] ASoC: amd: ps: bug fixes for ACP PCI driver
Message-Id: <178355451432.26140.15336452910757545939.b4-ty@b4>
Date: Thu, 09 Jul 2026 00:48:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787; i=broonie@kernel.org;
 h=from:subject:message-id; bh=vlPUTcGzxlMUD3k3AyOxrB6G7qRoJw4Q46sKR6E7FoA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqT5HDmOmecBbDyHD8LMZObGd4m3Cw0Ycn2qCmA
 RVkE3kFWpaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCak+RwwAKCRAk1otyXVSH
 0DIrCACCGW7eJf3VI2/bFc1ALJuPUqlpA9oWQ9G2faWm0idAqYmBB0kahsE/Ko7lAiWzx4g6Kwi
 T2Kp5TVYflFtqmb7JB7Mu3hGCWfTK2j/D4tqVMpevei0QX+iQHRGyQTH+LHihqIGDeQWxbGXBlv
 F6vqx9ALL6y7YLohbhu1WFaFCuQm9nnNAwDvspZcQcaqyCN3QfCpN/ds3ljjluwGZuXMYyezj+w
 uo6SnunpCp5PwbrsTFd5Td7iFm9SPo06Wq9x+FlwWQKfwXjEaTrc6WRUkjiXrjM0SjKMRH74M4o
 YVg2TwK8q3kWLpJZEjcJLxHuAfsJf/2HeDNL+oTh+mI1j35M
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: PEART4NS45WJ7J275NYQTJVALQ2UOGVQ
X-Message-ID-Hash: PEART4NS45WJ7J275NYQTJVALQ2UOGVQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PEART4NS45WJ7J275NYQTJVALQ2UOGVQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 07 Jul 2026 11:29:35 +0530, Vijendar Mukunda wrote:
> ASoC: amd: ps: bug fixes for ACP PCI driver
> 
> This series contains three bug fixes for the AMD common ACP PCI driver
> (pci-ps.c) covering ACP6.3, ACP7.0, ACP7.1 and ACP7.2 platforms.
> 
> Vijendar Mukunda (3):
>   ASoC: amd: ps: disable MSI on resume in ACP PCI driver
>   ASoC: amd: ps: fix wrong ACP version string in pci_request_regions()
>   ASoC: amd: ps: replace bitwise OR with logical OR in IRQ return check
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/3] ASoC: amd: ps: disable MSI on resume in ACP PCI driver
      https://git.kernel.org/broonie/sound/c/5893013efabb
[2/3] ASoC: amd: ps: fix wrong ACP version string in pci_request_regions()
      https://git.kernel.org/broonie/sound/c/f7697ecf6eab
[3/3] ASoC: amd: ps: replace bitwise OR with logical OR in IRQ return check
      https://git.kernel.org/broonie/sound/c/dec5aaa27603

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

