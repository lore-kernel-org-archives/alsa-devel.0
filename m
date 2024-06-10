Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25590C27C55
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Jun 2024 22:12:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15E26BC0;
	Tue, 11 Jun 2024 00:12:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15E26BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1718057553;
	bh=8o6kg64HbkvdrfcrEkyY7Cx6hEEdz/yWEWoZqQ6I68E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=V56dr6+/iT5Gypgbgh0hS+BjVuUEzL6Aq+RuEX46OQjY3f5opwtCEMD1oDxS/ulXd
	 RV1EwMmO5Ba5y37MoOqym3JHF8wzd/rKSKvZ9V01R5S3u8oeEOcdESLjuHnoOj04cG
	 H+X5I18ElLbhDXS4+hnlPks16wiMCBrbJTvthQPw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53F89F805D6; Tue, 11 Jun 2024 00:11:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B84C5F805E8;
	Tue, 11 Jun 2024 00:11:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F0E4F80580; Tue, 11 Jun 2024 00:09:49 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 75D8EF800D0
	for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2024 00:09:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75D8EF800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Szv982VC
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1A884CE18CE;
	Mon, 10 Jun 2024 22:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E72C2BBFC;
	Mon, 10 Jun 2024 22:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718057380;
	bh=8o6kg64HbkvdrfcrEkyY7Cx6hEEdz/yWEWoZqQ6I68E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Szv982VCkx/BvNLWkx6h/EugAR3pIv0w6yCTLX92OJDYYRFdL7NpkB7m6RY6h9/QQ
	 PJmMAQYpPLB5fDCYNxTx1cUQGOtNYcagG1SZqLoL0B2kUOJ3GQJt1dE7z7YbB446DR
	 PytvOSzNjh4KO+B0U0vmRUfI3WsrPunMSEd/2bKwJDKzIOLr6MqwUU+lYfLA4IRLDU
	 IPt31ESzZo1l6+7n6p2sWsKaAsMrZkpBvNbqDGIMjB6ztbZPSPE8fnoJ7cUD4nVdGa
	 T0Ol+beuG10TrgNtpFYFr/Yuzg1UrrA4gA9DIy//w1yxp8v0qwXNR5nvkzHozhYIhT
	 2cSWDlvtR7RAg==
Date: Mon, 10 Jun 2024 16:09:39 -0600
From: Rob Herring <robh@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Linux-ALSA <alsa-devel@alsa-project.org>,
	devicetree@vger.kernel.org, Maxim Kochetkov <fido_max@inbox.ru>
Subject: Re: [PATCH 2/5] ASoC: simple-card-utils: add link-trigger-order
 support
Message-ID: <20240610220939.GB3150939-robh@kernel.org>
References: <87v82ls82e.wl-kuninori.morimoto.gx@renesas.com>
 <87sexps81d.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sexps81d.wl-kuninori.morimoto.gx@renesas.com>
Message-ID-Hash: OXTOAZQLYXLCHGEB37TSBMBVT2E2OPTG
X-Message-ID-Hash: OXTOAZQLYXLCHGEB37TSBMBVT2E2OPTG
X-MailFrom: robh@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OXTOAZQLYXLCHGEB37TSBMBVT2E2OPTG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, Jun 07, 2024 at 04:15:10AM +0000, Kuninori Morimoto wrote:
> Some Sound Card might need special trigger ordering which is based on
> CPU/Codec connection. It is already supported on ASoC, but Simple Audio
> Card / Audio Graph Card still not support it. Let's support it.
> 
> Cc: Maxim Kochetkov <fido_max@inbox.ru>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  include/dt-bindings/sound/audio-graph.h | 21 ++++++++

Belongs in the binding.

>  include/sound/simple_card_utils.h       |  4 ++
>  sound/soc/generic/simple-card-utils.c   | 71 +++++++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 include/dt-bindings/sound/audio-graph.h
