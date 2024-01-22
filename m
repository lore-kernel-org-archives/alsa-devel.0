Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E237C47DD9
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jan 2024 16:35:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7198883E;
	Mon, 22 Jan 2024 17:35:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7198883E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705941336;
	bh=XKrus9RtF23TPgY0Gt07JVnLABXAI86NttcHczRG3u0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WsKRFUEXpfttAqkKtbSCj7cTg4AxI4yGfz+TcNIU2XFAQ7eDaMFFFRVqXxrrdBomt
	 raIi13ydSE0Yqogzew6CM5uvKoZaBiYnL5l5KGSJlgZ7LY7yg/Z+8p1HP1gKwR5dtH
	 328jtOxq397BNYyQT7Mwjd7xK1gfArkStK1CD120=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46F7BF80619; Mon, 22 Jan 2024 17:34:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D03A6F8061A;
	Mon, 22 Jan 2024 17:34:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4ACF8F8025F; Mon, 22 Jan 2024 17:34:05 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 75E81F80149
	for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2024 17:33:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75E81F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=thg8hvZq
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7700E61564;
	Mon, 22 Jan 2024 16:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF4CC43390;
	Mon, 22 Jan 2024 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705941234;
	bh=XKrus9RtF23TPgY0Gt07JVnLABXAI86NttcHczRG3u0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=thg8hvZqbNwn7hTLdsfJRNX+hzCzaQa8IfdojSG59OYGqyS2eSLT+TwOI3TiLJpI1
	 CjIZAiJGPUn46kgmDfc4kd8W+eRqOY4ipEG3kG4ryYVgkLTELD96haB5CnnJTQ5ggc
	 izqW35Lq0VR1VzI2yM1XMTzlExOKVk6Hoohh18OyBeFPUWrlKrqq80km/rp085OKt+
	 OobgB4XEXxZibW7ITEKXu1/nE5SxhwcoK7myvduWlTm/0r679JyTUXvCfqEwqZI5mR
	 4mWX5sNbt73iDINxDyDF3VPB3ojFJ9QX43nORlX3DEK5FX6T9KMJ6GMHmn5FztX8Pl
	 w4PhczsAX9f8g==
From: Mark Brown <broonie@kernel.org>
To: David Lin <CTLIN0@nuvoton.com>
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, YHCHuang@nuvoton.com,
 KCHSU0@nuvoton.com, WTLI@nuvoton.com, SJLIN0@nuvoton.com,
 ctlin0.linux@gmail.com
In-Reply-To: <20240116024519.24569-1-CTLIN0@nuvoton.com>
References: <20240116024519.24569-1-CTLIN0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8540: Add pre-charge actions for input
Message-Id: <170594123229.63484.15951763586511536595.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 16:33:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
Message-ID-Hash: OKDRRBTFAPELQD2XNEJP7DWBRKAAPJ22
X-Message-ID-Hash: OKDRRBTFAPELQD2XNEJP7DWBRKAAPJ22
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OKDRRBTFAPELQD2XNEJP7DWBRKAAPJ22/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 16 Jan 2024 10:45:20 +0800, David Lin wrote:
> Adding pre-charge mechanism to make FEPGA power stable faster. It
> not only improved the recording quality at the beginning but also
> meaningfully decreased the final adc delay time.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: nau8540: Add pre-charge actions for input
      commit: 9423d7b9edba043c39f1607c752677c8b769922f

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

