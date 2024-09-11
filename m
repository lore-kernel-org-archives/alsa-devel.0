Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E34BEE01EE
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:16:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99607868;
	Wed, 11 Sep 2024 13:16:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99607868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1726053406;
	bh=eKrbjaomEDXQn1d+1L+LNn3HUG2MOI3OG6WLs28DAzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=I4rJ7dgABJARke+Jn47db+2LnQYi8X6NDrmSNo8msywEoT60Os79M/Cjnptx/DETV
	 OoF8VelSyBN5qRfZDPo99SWIdUtmMH56y7u//LPB0i08ltO87gkLUKYMaJP3RJNIO0
	 tEd217+et2gQS4OIUdHTeU7EwqikTdOfLjVG/k7k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A305FF80536; Wed, 11 Sep 2024 13:16:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 033D3F805B6;
	Wed, 11 Sep 2024 13:16:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3FBBF801F5; Wed, 11 Sep 2024 13:16:08 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 20FD4F8010B
	for <alsa-devel@alsa-project.org>; Wed, 11 Sep 2024 13:16:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20FD4F8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bt9tN10W
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8B79DA400A3;
	Wed, 11 Sep 2024 11:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D87C4CEC5;
	Wed, 11 Sep 2024 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726053363;
	bh=eKrbjaomEDXQn1d+1L+LNn3HUG2MOI3OG6WLs28DAzQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bt9tN10WpAwempYNP/4YfUhRmUL3d2fUlMV+8kh4Y9rjgoD9i8zXijycuK9Uoy1IV
	 TBYSMwAutvstlJ/rR6nflCdeBac/aAFoCqyddErCMHJdbSevQrSd2iUnMcSpYynC1i
	 4Im8tpAw10qgx7GIfLHg99+j5FutpHffCr1Ucg7fA+FINfFPPl/AFPnPz5fDX1xGtd
	 EVyxYhxTNi7fGjNtha30Nrg/6gcFtM2MqQDLwgvFobjgacO6wT3epyUEnxguh9+gS7
	 czAlALC7D1x7c3HKeyn81u58ALWZWuq5qSro8V2pdI8h6/09AfS5EMcRITisn+5dmG
	 /9WJBKUQFijOQ==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Andrew Kreimer <algonell@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>
In-Reply-To: <20240910211302.8909-1-algonell@gmail.com>
References: <20240910211302.8909-1-algonell@gmail.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Fix typos
Message-Id: <172605336126.29902.15923004900083559208.b4-ty@kernel.org>
Date: Wed, 11 Sep 2024 12:16:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12
Message-ID-Hash: KRNDEVOQPANRKG2II7QZ2MTN3SMQ4PSD
X-Message-ID-Hash: KRNDEVOQPANRKG2II7QZ2MTN3SMQ4PSD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KRNDEVOQPANRKG2II7QZ2MTN3SMQ4PSD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 11 Sep 2024 00:12:41 +0300, Andrew Kreimer wrote:
> Fix typos in comments.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320aic31xx: Fix typos
      commit: 69f3014248f0f10e24f07a66ae650061ecaf732b

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

