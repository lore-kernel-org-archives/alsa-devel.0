Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE767C49EA1
	for <alsa-devel@archiver.kernel.org>; Wed, 31 Jul 2024 13:57:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43E662D04;
	Wed, 31 Jul 2024 15:56:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43E662D04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1722434222;
	bh=zfFdBqb5BUwIbjmApJtLDWnc9JvUFI65Ftp4qJFFzsY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tmTT41aYDtDKp7fGiB2Ar1h+cwJL/W+MDX91YJlQxm0D5XpWQS2UieeqkInRftxm/
	 9J5vLBiA/QXq6dMMWWV/yjELH0MuP8G+kZLxJAAnufnOEHPiMn9P/+IuurTMFyY5Dh
	 vclgLFP0J5shutlYQ1/RiuANShThjrocP0lGiYdo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3498DF805C2; Wed, 31 Jul 2024 15:56:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 47593F805E3;
	Wed, 31 Jul 2024 15:56:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BDDBF80448; Wed, 31 Jul 2024 15:53:45 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7EC70F800C9
	for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2024 15:53:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7EC70F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hkqUB78y
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 807C4CE16BA;
	Wed, 31 Jul 2024 13:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F326C4AF09;
	Wed, 31 Jul 2024 13:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722434008;
	bh=zfFdBqb5BUwIbjmApJtLDWnc9JvUFI65Ftp4qJFFzsY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hkqUB78ymrQEFocNFipg6sDy2KmlNHdayph8DnYfVgkzCzo7vX/vUd9Wi12phEuHh
	 pLy/FP+AoB3kywT+lRg4Gl6Kk7XD8SmKD017enzJIr+MQVm0F2eosTRpSqbwrCxI2x
	 dmYsp3+a/mYlB6EYMCYjyU/TNhjYsramQXIGJ22YfBmZht+PaqReAZCXS7wl4/QeZl
	 Vh60/VC5CIXat8xh02BLVicBfu891OB9cYosHWyVfLwdDkMdKR4rHtgVnaj+nLhTnS
	 Pq6EFLUuu+mi1xIwq/X7E+Wp/InhxhicvAFDI0s7JydxGFVIEm3wqGBsralQ3Rmq3J
	 i2Whp8+bDtYCw==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
In-Reply-To: <87cymvk3t5.wl-kuninori.morimoto.gx@renesas.com>
References: <87cymvk3t5.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: rsnd: use pcm_dmaengine code
Message-Id: <172243400805.75630.14895074133963830022.b4-ty@kernel.org>
Date: Wed, 31 Jul 2024 14:53:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811
Message-ID-Hash: 2IFKH3ZZZ4NXNLJP447ZPY3V6OP35Y6T
X-Message-ID-Hash: 2IFKH3ZZZ4NXNLJP447ZPY3V6OP35Y6T
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2IFKH3ZZZ4NXNLJP447ZPY3V6OP35Y6T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 30 Jul 2024 02:32:22 +0000, Kuninori Morimoto wrote:
> rsnd is implementing own DMAEngine code, but we can replace it with
> pcm_dmaengine code, because these are almost same.
> Let's use existing and stable code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rsnd: use pcm_dmaengine code
      commit: 22c406c9bf5e28d9fed0bf37ac9d544e56127fd3

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

