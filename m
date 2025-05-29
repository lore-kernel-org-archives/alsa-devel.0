Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0DEC54FB3
	for <alsa-devel@archiver.kernel.org>; Thu, 29 May 2025 15:07:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B941D601F1;
	Thu, 29 May 2025 17:07:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B941D601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1748531267;
	bh=vSQQBmqESvaIBrltiLlSkDlazT7W+E+6mQQ3hgklAZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VTOrte4yFt2VuDkD3WIZBxccNSd/DuGfVDOR3QQMBdqbYZj+DMyFv/BCz0Xv45Vzu
	 H8ADnFYTJiUMTSANxWFIa8ffT5d6SwHEdD5apkJapBJNLrT/UH7gDAGqHUxRmSRDam
	 HAjAG2N+xMvjWUmtrzSqCiCxDS8rZ3G2LJRYvr74=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8292F805BD; Thu, 29 May 2025 17:07:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C83BAF805C0;
	Thu, 29 May 2025 17:07:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F1D85F8025E; Thu, 29 May 2025 17:07:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2BC5FF800E2
	for <alsa-devel@alsa-project.org>; Thu, 29 May 2025 17:07:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BC5FF800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hZhSKoG5
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B19D35C67F5;
	Thu, 29 May 2025 15:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0E6C4CEE7;
	Thu, 29 May 2025 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748531222;
	bh=vSQQBmqESvaIBrltiLlSkDlazT7W+E+6mQQ3hgklAZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hZhSKoG5/x8/BETpTAOpmMt0SuqVe4AT6K/c+tRA57N9Xi8JfOzP9FUnPQhkLeqkU
	 QqSm60FcsxwvNjNTgPRpRlFhX+9AjZuDSDqHOPoyj3snZkCVZUMzOcgx8hJZ3jPce5
	 ghZRArXM4IQR8Rhj6uC5ZxfERglR/pTP0n0Xnypp4emp/cHjKh0ahr5YIvR+Mn7Bw0
	 oHGYmPC/ohkPWyC8Qic0l4Ctn/1jhCq+/TFeKfM5vy+d7TorwZWl9u+0WeAJlopl8E
	 auvd8GR/PWyAOjE2LjU3mdszKjP8dFfedruQz408s7064zxy1c5cy3jK7mxfQ0cTaV
	 CNGFdxnwncxyw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, meowmeowbeanz <meowmeowbeanz@gmx.com>
Cc: mario.limonciello@amd.com
In-Reply-To: <5015425.31r3eYUQgx@gemini>
References: <5015425.31r3eYUQgx@gemini>
Subject: Re: [PATCH] ASoC: amd: yc: Add support for Lenovo Yoga 7 16ARP8
Message-Id: <174853122150.49405.4623208921881043990.b4-ty@kernel.org>
Date: Thu, 29 May 2025 16:07:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1
Message-ID-Hash: SODOWAVIVN2AVVBOAY25SDGOXLZEZK3L
X-Message-ID-Hash: SODOWAVIVN2AVVBOAY25SDGOXLZEZK3L
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SODOWAVIVN2AVVBOAY25SDGOXLZEZK3L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 27 May 2025 20:24:39 -0700, meowmeowbeanz wrote:
> Add DMI quirk entry for Lenovo Yoga 7 16ARP8 (83BS) to enable
> digital microphone support via ACP driver.
> 
> Fixes microphone detection on this specific model which was
> previously falling back to non-functional generic audio paths.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: yc: Add support for Lenovo Yoga 7 16ARP8
      commit: df7996076b1e1ba8a0690542d0e40f703f2f9eb7

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

