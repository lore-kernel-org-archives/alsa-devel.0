Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20733C4345F
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Apr 2024 22:36:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D5212BF5;
	Fri, 12 Apr 2024 00:36:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D5212BF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712875003;
	bh=ZgKCfsWFqENGu2Mnw8GcJWs4r368JeG6kTQENU1jAkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=G5xvPU0b4QN7EIYIdxJLAi4JbrUF4mnfCsZufKuAEIb3jM9GjxOY+hZEMhRLveq1x
	 VvRBKFpMgK92TevMFPiNChZyecp6N7Lqtl7Bh1VYi0dtVGEj3plbMrXGn493bJ+uTs
	 QcZetreDch5GGrJBzAWt4TU1j1a7ScWxQpDVfzW0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 61A18F80236; Fri, 12 Apr 2024 00:36:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E8FDF8028B;
	Fri, 12 Apr 2024 00:36:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F05CDF80238; Fri, 12 Apr 2024 00:36:05 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BE758F800C9
	for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2024 00:36:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE758F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GOKeKENm
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CC5A36217E;
	Thu, 11 Apr 2024 22:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD48C072AA;
	Thu, 11 Apr 2024 22:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712874957;
	bh=ZgKCfsWFqENGu2Mnw8GcJWs4r368JeG6kTQENU1jAkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GOKeKENm2iBE7FcHqURXogLvsi1VM/SOP+bnihaC34q1pf5cC0YxmAU3RB69q2IU7
	 qRlB7GrGAhUthAcVE9Nb+kl2dD07dQreOwOlCWoM+EYYLtsT2X4qctULVfmYqEwa8i
	 xBr9kt68BlyRlTaq8ueOR48JFobItbNt1zjQ7EKX7GxLn2cf5Hm/t+Z3FTgR5zaUH+
	 p2dlk0GbzsCfoRVzOb5qPo8ISM5hSua+WNUC2KMfwSkYx7M3VcvHF/PXVjOHp75ohb
	 ZXdVJ3aCvU4Y4NoFXN6tqIATZo0SncP7FXrA4HZs1SbEOVTKkduTIjYocK21umR2H3
	 pbaVp7pVlDdqw==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20240411075803.53657-1-lukas.bulwahn@redhat.com>
References: <20240411075803.53657-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in TEXAS INSTRUMENTS
 AUDIO (ASoC/HDA) DRIVERS
Message-Id: <171287495520.96963.7535991617111488759.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 23:35:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
Message-ID-Hash: N64R2MAWFHC6V37TKBYDCT5QMGXHZKII
X-Message-ID-Hash: N64R2MAWFHC6V37TKBYDCT5QMGXHZKII
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N64R2MAWFHC6V37TKBYDCT5QMGXHZKII/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 11 Apr 2024 09:58:03 +0200, Lukas Bulwahn wrote:
> Commit 8167bd1c8a45 ("ASoC: dt-bindings: ti,pcm1681: Convert to dtschema")
> converts ti,pcm1681.txt to ti,pcm1681.yaml, but misses to adjust the file
> entry in TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: adjust file entry in TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
      commit: 82116e539ffb7ce0c317c208d53d2126cdcee687

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

