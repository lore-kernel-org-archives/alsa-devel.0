Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68300C982D7
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:00:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9FE6C601F2;
	Fri, 18 Sep 2026 12:00:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9FE6C601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789725628;
	bh=s3ZgRBw2+OPXdJXEEJj4lf6QKeyBQbR+J35FoYF0AaE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WYeV/r7I9Cg8RzKaGqexq7uwLN4WeodsAgRGlXfvqw6Yd+9qomsodjYapk1hqouse
	 wu4TRk5EKCUCWB2j94M8FmVVU95DrO/UdQKfxp8m0XePeZ3WX2G8xNGuMTuTR9c3vt
	 0Hvh6AU8vzhuc4/R66lrc8MOyGHrAupKoK1FoGhg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29819F80580; Fri, 18 Sep 2026 11:59:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CC874F805EE;
	Fri, 18 Sep 2026 11:59:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0F828F80518; Fri, 18 Sep 2026 11:59:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789725586;
	b=TIxHUVN2CQdxth6VIC81KFtw7H7VehDEA420jtxI8gFeCYkN94KNkENp5HuP78nDYTJ7
	 z7S5WFUXBMJFurM49lo5AnCgZHb5qCh5MCro1hlxaRlMIeAPuDT8HcyYZPLVjuW4/fmyU
	 CMYjz/0d+2aDx56PM3KVjJKsF8iVbwRAyFWIBPkx3yMhAn0TrXBAjEN5D3HLiIMwPXu9y
	 rdP9OTETkDS+3DNnfks7+7xi7t/HdrKYGur5rr9xGZyIjJQxxOY8GM5s8wE4vBRxXVPwg
	 wx1U9SyUSO/Ii7SlzOEVm/9MF1GbBqFpb8FTMslBSBiHrOVAGbksRtUu9+XVP8xgBwQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789725586;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=s3ZgRBw2+OPXdJXEEJj4lf6QKeyBQbR+J35FoYF0AaE=;
	b=Et34t9vyx+7w4sPCgOVDxLTkH0ZR8JlRYnfsXBpVVKYMnL9mHVWvy61NGNLAwdCrmfIA
	 8Ae+Fk/v7UTtXm1RNgBUXc3VDDU4mw92NSog7wqs009/A1f5stgoOCzZBfxU2n73w/MKz
	 xrM2SOyTf6dCEs85hshav+kt/9URvnKjJOCEPnwBYlHalBVIRGpCaUEEbyBfapLC3h+KO
	 MmQbLfiSgplSlZEFZl10E+4VGj5wwYcGUBC9C9Ke5v7Yu5utsHIuS2rmEMeMMgXvgCfth
	 v7du+mHRBNSPS0fIZyaY60C//t3wulGHXRnf7aCktly08YaXXsCisEFnkoVaL+Hudzw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iDT+IOl8;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A06A1F80088;
	Fri, 18 Sep 2026 11:59:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A06A1F80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=iDT+IOl8
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 73E5E60A5F;
	Fri, 18 Sep 2026 09:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEFC1F000FF;
	Fri, 18 Sep 2026 09:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789725582;
	bh=TH1rG/FOYbEL7rVZX3O9tbI7pBVYi5kaEYCsPOEZLfo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=iDT+IOl8JHp252cLe/ea/dvIdHy5vLWX0twjapiYSreCAjI9yBfFmBGGh/cKDcNjq
	 J5xbf1pigtz+ufyJOYTEd+Zh3Nfy/9/d1ECV/4pFl2/ftr0YcoaQIHU6V9amSCepA0
	 MEUWE3SH6rsykDwUKsbBQ8IuQrbYVY0Df8f9/RDZoNv/Rpg866erHhQySAAxfWC68S
	 DO6E66bIVKwXk3gGj6uyaORu0FpkPotCOnVIaKNbLTt8qF/jawADM0Yb/8JC2LP1J/
	 yQduuCCg9gtjQMN14L2PfmBBg1TFC1trhM4S7QA4X3o6GapPvVopqyahZDgleutFqL
	 vabjenBAJnHZQ==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 perex@perex.cz, tiwai@suse.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 Syed.SabaKareem@amd.com, Mario.Limonciello@amd.com, Richard.Gong@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
In-Reply-To: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
References: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH 00/11] ASoC: SOF: amd: SoundWire and PDM support and
 fixes for ACP7.B/7.F
Message-Id: <178964572768.162267.8731368279831621539.b4-ty@b4>
Date: Thu, 17 Sep 2026 12:48:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3286; i=broonie@kernel.org;
 h=from:subject:message-id; bh=s3ZgRBw2+OPXdJXEEJj4lf6QKeyBQbR+J35FoYF0AaE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqrQuID8W1mzjaKTeQl5XnrPWFHrwsDWkNstoCk
 m3QLUMwMXGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq0LiAAKCRAk1otyXVSH
 0F8GB/4q5rvhrYHAo187+SapOwBBNRasFGgnozo/LjGZ98/XNGI07LQiRSBnhnIJBezJYok/bx9
 nTi6gWqwtnh8ObIBvc0h/OGIIJ/U8OyezVmQTL3v4CxcsiJ0bTKZqwMh6ZeXCacY0XDIP7apla1
 eKTdy5y8DmraO9FFQ+I/HZZj8ieVWu/zTppuyxP9A9oVBi1wnkNlm4THuCMQ3htYBONViztKHwz
 1e+VEGvGelKV6iAJnY65A6KQkmjW/iMskr5UKKnSIbw0AKAApxV93GwITBP7PDrw2O2J6Z8lDlf
 caBGtuS6Y9coFt0maY4isFUUvirR/b6utqOmaG9gSWGobz/7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: POS2FTK3C7BEYTIYZEUPVXUIWGXWK2Y6
X-Message-ID-Hash: POS2FTK3C7BEYTIYZEUPVXUIWGXWK2Y6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/POS2FTK3C7BEYTIYZEUPVXUIWGXWK2Y6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 10 Sep 2026 18:50:00 +0530, Vijendar Mukunda wrote:
> ASoC: SOF: amd: SoundWire and PDM support and fixes for ACP7.B/7.F
> 
> This series contains bug fixes for the existing AMD SOF SoundWire stack
> that affect all ACP platforms, followed by new SoundWire support
> specifically for ACP7.B and ACP7.F.
> 
> The existing stack has three bugs that are fixed here. First,
> amd_sof_acp7x_suspend() silently falls through on an unrecognised PCI
> revision instead of returning an error, leaving ACP_CONTROL with a stale
> value; it now returns -EINVAL. Second, amd_sof_acp_remove() calls
> amd_sof_sdw_exit() before free_irq(), so an IRQ that fires in that window
> can dereference the freed SoundWire context; the teardown order is
> corrected. Third, the same use-after-free hazard exists in the error
> unwind of amd_sof_acp_probe() and is fixed in the same way.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[01/11] ASoC: SOF: amd: return -EINVAL for unknown PCI revision in acp7x suspend
        https://git.kernel.org/broonie/sound/c/e419e9a6cbfe
[02/11] ASoC: SOF: amd: fix amd_sof_acp_remove() teardown ordering
        https://git.kernel.org/broonie/sound/c/db2167f2e3f7
[03/11] ASoC: SOF: amd: fix amd_sof_acp_probe() error unwind ordering
        https://git.kernel.org/broonie/sound/c/b6aaef8ca8c3
[04/11] ASoC: SOF: amd: add ACP7.B/7.F PDM controller scan and pdata propagation
        https://git.kernel.org/broonie/sound/c/203ea76c4b0a
[05/11] ASoC: SOF: amd: update SoundWire specific acp descriptor fields for ACP7.B/7.F
        https://git.kernel.org/broonie/sound/c/59c03f40a53e
[06/11] ASoC: SOF: amd: enable SoundWire build for ACP7.B/7.F
        https://git.kernel.org/broonie/sound/c/612684a9d2af
[07/11] ASoC: SOF: amd: wire SoundWire probe and remove into ACP7.B/7.F paths
        https://git.kernel.org/broonie/sound/c/750176135630
[08/11] ASoC: SOF: amd: add ACP7.B/7.F clock-stop detection in check_acp_sdw_enable_status
        https://git.kernel.org/broonie/sound/c/db294afbd61a
[09/11] ASoC: SOF: amd: add ACP7.B/7.F SoundWire IO IRQ handling
        https://git.kernel.org/broonie/sound/c/c9b000c02879
[10/11] ASoC: SOF: amd: enable SoundWire host wake interrupt in acp_init
        https://git.kernel.org/broonie/sound/c/b99242b8d4b3
[11/11] ASoC: SOF: amd: add SoundWire PM ops for ACP7.B/7.F
        https://git.kernel.org/broonie/sound/c/be2823854e00

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

