Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9B8CEFCFE
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Jan 2026 19:44:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5F0E601EF;
	Tue,  6 Jan 2026 20:43:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5F0E601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1767728639;
	bh=h/iVNzg+UertnrcOWwRay3g2wdZm2ZoZsVbti84bcB8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BW4lqyXE1i0tUMZV8LCzxK+dz2WFKfmLefLwFu+J58NK17tMmDVgkG+TMFl3t/xl2
	 V1eq4gSQ/YrrkfuWN4Z16kIdD0aUdZkyMkuQFSGJflvnvlMKBlE+xEMTMRRP3Nk8gV
	 9x51t0CQy2YZJhkZwKa0h1TDf47CWFQGcxS8F7KA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D53B0F805DF; Tue,  6 Jan 2026 20:43:23 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3651F805E0;
	Tue,  6 Jan 2026 20:43:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 520E1F804F3; Tue,  6 Jan 2026 20:42:31 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 57A12F80154
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2026 20:42:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57A12F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qk+B007B
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 55EE640474;
	Tue,  6 Jan 2026 19:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E796DC116C6;
	Tue,  6 Jan 2026 19:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767728545;
	bh=h/iVNzg+UertnrcOWwRay3g2wdZm2ZoZsVbti84bcB8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qk+B007BlP5m01I4pFUO59rjP0y+PaLQLVqlWEJRehsR4N5jRi3eoi1lkCYj3mjDS
	 tMzpHwL+oHkhiFWvXEbNt+rVhzxS0dBOcrLUbHjdR98lu1Q6sinDSYor44mM5QO8yF
	 PRBYpFqCPUmjx+viu3MjolNbBT8x+jagqHnmBq3oeE23DVGUDgReaCa+6tFTEZ+Sos
	 V57JpfPsl5Wuig5ynrLfclnTeESuB5WtTOqTy4gWKOyFKEUgY5QdrYIEoqTPsahf5U
	 o7MSjK6Cm/b8gW7+FV4uOhHobfW5ppB6m5MrXa+Ra0PnvGduA030Ebuud/a+O44faL
	 CwNUhGkm8M/PA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, flove@realtek.com, shumingf@realtek.com,
 jack.yu@realtek.com, derek.fang@realtek.com
In-Reply-To: <20251015103404.3075684-1-oder_chiou@realtek.com>
References: <20251015103404.3075684-1-oder_chiou@realtek.com>
Subject: Re: [PATCH v5 1/2] ASoC: rt5575: Add the codec driver for the
 ALC5575
Message-Id: <176772854368.328192.15212175237614413656.b4-ty@kernel.org>
Date: Tue, 06 Jan 2026 19:42:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773
Message-ID-Hash: D2VXNM2LZPQEU57NOXRSHIJPHLABKLGB
X-Message-ID-Hash: D2VXNM2LZPQEU57NOXRSHIJPHLABKLGB
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D2VXNM2LZPQEU57NOXRSHIJPHLABKLGB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 15 Oct 2025 18:34:03 +0800, Oder Chiou wrote:
> This codec driver is for the ALC5575 that has a built-in audio DSP. The
> firmware can be loaded by the SPI from the SOC or the external flash.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: rt5575: Add the codec driver for the ALC5575
      commit: c7ac7499ac5bb50ab3e00add121822c5c904bc91
[2/2] ASoC: dt-bindings: realtek,rt5575: add bindings for ALC5575
      (no commit info)

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

