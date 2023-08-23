Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E172C3DA6F
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Aug 2023 19:56:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFC4284A;
	Wed, 23 Aug 2023 21:55:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFC4284A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692820571;
	bh=CqjHocjfffVY1CO2kXeTYo/Af2OwsRp/OMO+v31uqME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DIJCDYdrJJAKTEx3AGY7ZdTHmovv6v8kkdgy73Yx22nD141/RJgyg5hMEyQqDKynf
	 055fjkctS4vpsT7jHB338Z7YQWCw/oCJPeLOAOpmF6pXZyBKrXFjSLkSKVSyjeN32P
	 xuqd7j/5ea0NhbTHZDBLqorQBKwiRfeqTSp739UE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EBE3AF80563; Wed, 23 Aug 2023 21:54:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B6E2F80564;
	Wed, 23 Aug 2023 21:54:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEC0FF80551; Wed, 23 Aug 2023 21:54:18 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C5849F8022B
	for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2023 21:54:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5849F8022B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Q9oDqkZ/
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E7D4F66249;
	Wed, 23 Aug 2023 19:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA8DC433CB;
	Wed, 23 Aug 2023 19:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692820453;
	bh=CqjHocjfffVY1CO2kXeTYo/Af2OwsRp/OMO+v31uqME=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Q9oDqkZ/d3ltG41Vn823QyHcCw8Ild+rHyxrBJ5965I0NxKY5qFb9Fm66Ng36dayt
	 ALWvBz68rcXwQMm/j8eDOojX8smN34SA1PBwCW7pBXILAqjonplTggqupmQ0SGN7t8
	 1RCHqqcD6RsXukC6y23HiUpWtrFFY6TmEg6FOIr8CnhA0OqJNqVSiwgjbkLV6z+kMM
	 McKLX8WZKJN3lCGlmFSNDOxAqMsvNVgmNevAxfhpOn4x4ss4BW+UVhAdr2lUF+oR6k
	 S5BRomqv2lAq1ZY8/oDfSufRhljXGGzCLElfrFmdTnTigNiwroieSCibbmWqacctGs
	 iOmV1s1ukr0sw==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
In-Reply-To: <87edjuzk2p.wl-kuninori.morimoto.gx@renesas.com>
References: <87edjuzk2p.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: audio-graph-card2: add comment for format
 property
Message-Id: <169282045171.176026.1629500134448535408.b4-ty@kernel.org>
Date: Wed, 23 Aug 2023 20:54:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Message-ID-Hash: STFQLC6KOWADQ2JCTT6RXAELV7R2S6XE
X-Message-ID-Hash: STFQLC6KOWADQ2JCTT6RXAELV7R2S6XE
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/STFQLC6KOWADQ2JCTT6RXAELV7R2S6XE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 23 Aug 2023 00:19:42 +0000, Kuninori Morimoto wrote:
> We don't need to have "format" property on DT any more if
> CPU/Codec driver has .auto_selectable_formats settings
> on snd_soc_dai_ops. The sample dtsi doesn't have it.
> To avoid user confusion, this patch indicates it on comment.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: audio-graph-card2: add comment for format property
      commit: ea2cb26a98378b60be8e952eca801130c1da4c73

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

