Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60968C25B10
	for <alsa-devel@archiver.kernel.org>; Fri, 10 May 2024 13:19:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75720852;
	Fri, 10 May 2024 15:19:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75720852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1715347153;
	bh=vPEihfYqQpI0l28AJwopfpSnD1PbmaJ35DJTIaqB9wU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=D1gLvhtSq7hFK1f2odYqoj5mmSSz12NPMzM2MjizCMW9iK0jKJ9hH4kY6HVR10cKe
	 fL/7WU6Or4Erg4ef1DqNnnZPhqj6OyIoq+FzPInpLvwbtmWgv2OPlOyc6JRT9657vW
	 X2uJGVCpoRAtiST/PN8VY2QvFPzwUwPTJbZyQvDU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DD843F805C4; Fri, 10 May 2024 15:18:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FD80F805BD;
	Fri, 10 May 2024 15:18:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A90BEF8049C; Fri, 10 May 2024 15:18:20 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4DF0FF80423
	for <alsa-devel@alsa-project.org>; Fri, 10 May 2024 15:18:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DF0FF80423
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ilKti+Xp
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 38E14CE1DE8;
	Fri, 10 May 2024 13:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17A1C2BD10;
	Fri, 10 May 2024 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715347090;
	bh=vPEihfYqQpI0l28AJwopfpSnD1PbmaJ35DJTIaqB9wU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ilKti+Xps/khkqQf+H23eNZ4wIFzBncbTiRe5CDcccatF7RbwyoDuOrHZRBLAzmTe
	 Zm0cIGk2UXfKhzIPHNyZRcUVgEU5nYlkJb93Zp5SVbvXJfpEx3LyRVCyPlrpV1K0bq
	 Kb6dKc9oNx2XlOoZnUh3AGHiavR7n5K3WGNZWsezPl0w8hJqhAciMgSySzSDhQRQ80
	 UfhHyiHGezgS1bgE5+q83CP/Fthl/PV1AKrXnuxMbXxQ95vfrGGmhcuNGFp1x5abQl
	 oiXz+KjHaJd3Px9QGlB5Xq1yXevnHtbH4ddVZTcF/WxeDA8+b7VM7gpaKfA39dHTPw
	 wy5kc2YEoXslg==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <875xvmqzs8.wl-kuninori.morimoto.gx@renesas.com>
References: <875xvmqzs8.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: audio-graph-card2: call of_node_get() before
 of_get_next_child()
Message-Id: <171534708821.2178997.18212177468417353881.b4-ty@kernel.org>
Date: Fri, 10 May 2024 14:18:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
Message-ID-Hash: Q6YTRBHOWYKGREN5YADFFX63WULRC3XC
X-Message-ID-Hash: Q6YTRBHOWYKGREN5YADFFX63WULRC3XC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q6YTRBHOWYKGREN5YADFFX63WULRC3XC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 10 May 2024 00:24:55 +0000, Kuninori Morimoto wrote:
> commit c6f597bc598a8 ("ASoC: audio-graph-card2: remove unneeded
> of_node_get()") removed of_node_get(), but it need to keep original
> reference, so of_node_get() itself is needed.
> 
> Because of_get_next_child() will call of_node_put() inside, if the
> reference count dropped to zero, then of_node_get() after that will be
> use afer free. Need to call of_node_get() *before* that.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: audio-graph-card2: call of_node_get() before of_get_next_child()
      commit: e54f128b0c2fe543816941342e085e21f49c5b6c

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

