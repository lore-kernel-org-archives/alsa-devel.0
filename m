Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24BEC77B75
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 15:01:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B056200;
	Tue, 23 May 2023 17:00:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B056200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684854073;
	bh=InLVYXsRNBld89Tn2yQ42XMCfWkEVa559kvKKp9VM9M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EI6FjFYxJNOee+rzcjAOJ2ghx+7677iwWQ0frDCd7W4evbh5VXZDX3smRv9NPRCby
	 W4Re+RBXE0mzUFVtCpgc8h1dWDyauMQegi+m2ldQHPwMyQWP74ri/U2k+Z/Q3t141b
	 XRTu7dRCStvmur60n1z1T/NdDY8o2U1dSsDN9efQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AD2A9F80544; Tue, 23 May 2023 17:00:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E8F9EF8024E;
	Tue, 23 May 2023 17:00:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4222F8026A; Tue, 23 May 2023 17:00:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 08CC4F80086
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 17:00:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08CC4F80086
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=CTnLBuT9
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9C7FA6173A;
	Tue, 23 May 2023 15:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D153C433EF;
	Tue, 23 May 2023 15:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684854003;
	bh=InLVYXsRNBld89Tn2yQ42XMCfWkEVa559kvKKp9VM9M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CTnLBuT9JPwEzpNogrSkMKuoreXIiMu5ANgAFuyhb1Sdu2ar+9URYW6eRM9zBQ8t6
	 fZB7oPbAR+pLapO8yICp2QocOs+vZJjiNYYwAgRX0+1zzoYiOwYcVuY1QdpiYCYzFK
	 3oFyzD4zVxjyO5YckbSEblm93zrJbgnDnhYlkSbqvaCw62ID3vyDzCaZGcrZq7MziA
	 4ClZrlqxiJy4PwFIbkqMJGeGUbnaBuJV0EBlvPYDheUnZAX03HRo3SlG2rT2wMgg8k
	 Oq+ONy/ubg5QG3slsVs7XPL2ouTUFNgSdC/syPswoDbQPtJBrQ/Wdnr35gdyvZZ0/R
	 spMEt5awgF6ww==
From: Mark Brown <broonie@kernel.org>
To: David Lin <CTLIN0@nuvoton.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, YHCHuang@nuvoton.com,
 KCHSU0@nuvoton.com, WTLI@nuvoton.com, SJLIN0@nuvoton.com,
 ctlin0.linux@gmail.com
In-Reply-To: <20230523083303.98436-1-CTLIN0@nuvoton.com>
References: <20230523083303.98436-1-CTLIN0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: Add pre-charge actions for input
Message-Id: <168485400116.197206.3552138872945112088.b4-ty@kernel.org>
Date: Tue, 23 May 2023 16:00:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: 4P3ZLICK2344WAWPWUJ36COFUZD3FXAB
X-Message-ID-Hash: 4P3ZLICK2344WAWPWUJ36COFUZD3FXAB
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4P3ZLICK2344WAWPWUJ36COFUZD3FXAB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 23 May 2023 16:33:04 +0800, David Lin wrote:
> Adding pre-charge actions to make FEPGA power stable faster. It
> improve the recording quality at the beginning. Thus, it is also
> meaningfully to decrease the final adc delay time.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8825: Add pre-charge actions for input
      commit: f9d790c578d4e0f715213cc7f2f6f2b0d2d91988

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

