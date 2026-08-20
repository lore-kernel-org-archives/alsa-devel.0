Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F38C5DF81
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:54:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB08560284;
	Thu, 20 Aug 2026 20:54:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB08560284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787252075;
	bh=30NQCGgF8zzfY6EI5R58110uo+r9hHzsS1dR77lWVPE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=J33KTwa0WPnmAW6DyPbCUQJRJ7bSnJOc4S4mE3ONtO4ucQ8hPqf6bxKUVohJL1gPB
	 JaU26U+/kUCxpJEPysI7u1DaHKBaKz4qkjxk8GEZ86cYJS6dAvS7wD8bEKdEJTU+Fu
	 eSrXdyYmBlzT+BY2WqM4n83YX57y9KNXZDm0OmRM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B435F80246; Thu, 20 Aug 2026 20:54:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CD107F805FF;
	Thu, 20 Aug 2026 20:54:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B31EF8053D; Thu, 20 Aug 2026 20:53:55 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787252034;
	b=pQHTI4kilbg/x/P81v3k0oHHFLl4QyNGK11LK9A1ff5Vjq+hN+8+PL+sM/NzODCj/N2H
	 ecIZTbZ3+zs2jjyS5HATwhmw3YRP6fP6B8gOt+86bUUWBgrJWa3KkaB2eojmx4LgMPEPj
	 joST5n42m5Tka1kxWLRByYnPMTVvB5XBOEEI7Y0d+8qE+U8EJX9u3+8wz48I6JKrtC7v1
	 1PlMcvDVg8aqMHCcqRRIIKiJMfvDl8hJ5T67y3DBwDY2BX6BhmNFduND0QUf+cTPO1hZF
	 PxsJgm/gIDpaPbaWk/Gr85Az+0UGvf2yWmoGfL57xsq7BIgeDnUvdus/wyfRneO7I0g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787252034;
	h=DKIM-Signature:From:To:Subject:Message-Id:Date:MIME-Version;
	bh=30NQCGgF8zzfY6EI5R58110uo+r9hHzsS1dR77lWVPE=;
	b=HhXm8IN1Unp+ZKcsenHAUy/j6pxieBgFzTcrPBrTsX0Jpp2IkdezO09F625LVS4zgWgy
	 OfknoC3TAQOAKZay8c4SLi9/sxdP3KzbPJu6qHePZoQZvtA51obZcHXUrl4ZyYChQTbUV
	 ++C1lmm2V20nCXBAFvodNtLFdvJLJc9cQfH8Py159igbvHonkRwDFariCsHQwVEb3Jrfq
	 q39y5F5RoRmkcfOHh8/JwQpPMd65KK55uNXL3vqPb7QzIAK+Yi29+/NxZtaoVJIwRMFme
	 4RHobVomuaF/Ue3/TiJe2Vx0IbXw7Y2NKrQqOn3zpg3wUAW46icfLsB/nz/TKRyULeA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Os+0H8f2;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 71300F800BD
	for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2026 20:53:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71300F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Os+0H8f2
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D78D760A71;
	Thu, 20 Aug 2026 18:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA1E1F00A3A;
	Thu, 20 Aug 2026 18:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787252030;
	bh=PIjzTOLctrigvITPLq9x/HIQEGz+Yc+obEP6pgu6Kz8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Os+0H8f2xDl7eZjSneLQsNTYPYaNpOXLhHO4qYsZBhmQ3SlylFPaX14rd0/kIgYE4
	 ypA2wIYPDd6rRh7O/3/iDMGsNgkSRTC8U3aoHLxvv3NMffki9z+sXGFOX5O8ssbaK+
	 tU6A58YWMI3g5nXYCLeJyDfMj17qbSXs4nWCHq48Fvbtza7Gvm/eXRchDiR521Yg5s
	 GRGbmG4x00QofES+LZFreUc1/dBgp03tHHlfprkB63Dz5oGsW4uhfNA2TkEnXa9296
	 iCMBIcXIeuiDxcbxuQH598uguiGUbwz67Mw+klF0fLeR4iu3d9UVekWFwEidfbHPdO
	 SARovO9LsiVQw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, jack.yu@realtek.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, flove@realtek.com,
 oder_chiou@realtek.com, shumingf@realtek.com, derek.fang@realtek.com,
 Trevor.Wu@mediatek.com
In-Reply-To: <20260820092415.2979641-1-jack.yu@realtek.com>
References: <20260820092415.2979641-1-jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt712-sdca: Pull high JD2 to prevent from
 entering TV mode
Message-Id: <178723395826.89147.1797965398058922835.b4-ty@b4>
Date: Thu, 20 Aug 2026 14:52:38 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=broonie@kernel.org;
 h=from:subject:message-id; bh=30NQCGgF8zzfY6EI5R58110uo+r9hHzsS1dR77lWVPE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqh0065CKkFg/aywBYeYzkP4DVXqqqdYqk3j5iF
 VwMqUnZXwSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaodNOgAKCRAk1otyXVSH
 0J02B/9ylciFftv3NrQgPitlcWFGXIT4Bh0DHKUE9JNhFgYChnGGHMIsDOroR+IZQyViOlrI94z
 mVsW72ZDZQFvD5cwQwXtfXIW50IsWNjLu0qGdcIY78ju4JnHIBH15xveLZsYK45+XSymOD6SY2G
 dru8JZ/DA2T+KKqvYaPc7IyX+yDJr/cxgkETDLqwpuVnZfYGRhjKGNShfeMKFxBaJM2xVO5bvSf
 B+hReq9lnXB8y3/KjlmEeeM19YBdD6iiaHVRF0z0/+qZpTZUSTvylaUOa4g/MP2tbx5PDEil63t
 hr1on3SxOJFNR/E2zKYQW13OEdooiT3TVu5a6xLAO1wIWKgj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: 2LWK7NDKCLRN464PHFHDM7AEWUKJ7CM5
X-Message-ID-Hash: 2LWK7NDKCLRN464PHFHDM7AEWUKJ7CM5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2LWK7NDKCLRN464PHFHDM7AEWUKJ7CM5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 20 Aug 2026 17:24:15 +0800, jack.yu@realtek.com wrote:
> ASoC: rt712-sdca: Pull high JD2 to prevent from entering TV mode

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: rt712-sdca: Pull high JD2 to prevent from entering TV mode
      https://git.kernel.org/broonie/sound/c/dfb8bc1d286f

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

