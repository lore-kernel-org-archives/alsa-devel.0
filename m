Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293F0C10F1A
	for <alsa-devel@archiver.kernel.org>; Thu,  9 May 2024 06:40:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBDCEB65;
	Thu,  9 May 2024 08:40:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBDCEB65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1715236840;
	bh=qFPm43GWM1lM0OBGd/yZI232yqutNkxEsBoODKAMOvo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KP/FPFfPvk/XUKtagv1ytgQPuNm7rshWCXO6lpCYVBRhCczsdI+KOcyuwUxgtagOr
	 U7a0AXH8KUtXx6t4L9rp7+g28HdpHqjt2k5SjEBmGTMU7WtlT4YMNMOauq/mvXKnUC
	 K4KOJ+ZJ6mEpndAzG7wIytab3UJsWjXHhjJ+DWFM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63676F80588; Thu,  9 May 2024 08:40:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E5DE2F80588;
	Thu,  9 May 2024 08:40:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2197AF8049C; Thu,  9 May 2024 08:37:13 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7BF0AF800E2
	for <alsa-devel@alsa-project.org>; Thu,  9 May 2024 08:37:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BF0AF800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=P/cIyW3C
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3BC2D61BCB;
	Thu,  9 May 2024 06:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDA7C116B1;
	Thu,  9 May 2024 06:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715236623;
	bh=qFPm43GWM1lM0OBGd/yZI232yqutNkxEsBoODKAMOvo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P/cIyW3CsGFmIN9P4Q8VFmcw5BYm3K8Sb9HTrH8tyZIlT0OAURktSe7la1Z7fr8v3
	 NeDZjeljpbguvoADY6S1rV8XEuiTUYDTPs0DQqMs4iqoP6/E8+UIztlEDGj9FzQ43T
	 hu2+E8xpHPSHrP3ZnSMF/atoH2sj2uSzG/mnFkZaA9/clB+66F7AyvYN835v/SDm6X
	 UkBZzChEwG6iKhkqLTyUS9o6UWFwCJz0ptZeOKn9ZsNnUgCuMr3HSye4aCp9b2x+TS
	 df1ew5RPBvpBC/HkSxeV+z9J0rG66gJsmTNbyHWwqYYzIjATj2Zuwf7ew+uJoP7P1u
	 ecHZ5ocYCGY+w==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <87jzk3akoo.wl-kuninori.morimoto.gx@renesas.com>
References: <87jzk3akoo.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: audio-graph-card2: remove unneeded of_node_get()
Message-Id: <171523662353.2030088.599220576551108747.b4-ty@kernel.org>
Date: Thu, 09 May 2024 08:37:03 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
Message-ID-Hash: NZVR2WWXKD475CRWFELFNTZRQBYDELQO
X-Message-ID-Hash: NZVR2WWXKD475CRWFELFNTZRQBYDELQO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NZVR2WWXKD475CRWFELFNTZRQBYDELQO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 09 May 2024 00:33:11 +0000, Kuninori Morimoto wrote:
> "lnk" is used as "port0", and it will be used to get "port1" by
> of_get_next_child(ports, lnk). It will call of_node_put() inside. This
> function is calling of_node_get() to make up for it, but it doesn't call
> paired of_node_put(port0) when it quit function.
> This of_node_get() itself is not needed, let's remove it.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: audio-graph-card2: remove unneeded of_node_get()
      commit: c6f597bc598a8c3456fa017eb0c55e7a41bfce2c

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

