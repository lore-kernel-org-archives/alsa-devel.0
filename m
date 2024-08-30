Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44C9CA1009
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2024 19:31:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1448C209;
	Fri, 30 Aug 2024 21:31:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1448C209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1725046276;
	bh=rz8KDKw3aTWGQcJdgAqnxUa0Kv/DBZMxKlXY8HtiKFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=D5jg2iEVuQ4cYzSKL7ltJWIzSsfFzhpEQIabkHsrBkvFvH0VwvkKhubiU3ZCJrUVT
	 rNYDGcCt2aWLfna6k7yuSVvjjbBFNDWyIMIjNH+1Q/3hYXBeemFt8ni2P5FXmcryq5
	 O2yOUwi2AEXovGLcT6hBC2cZBpT7SZRoMiv1CTu0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F991F805B6; Fri, 30 Aug 2024 21:30:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 93452F805BA;
	Fri, 30 Aug 2024 21:30:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 798BCF80518; Fri, 30 Aug 2024 21:30:41 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6BE36F8025E
	for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2024 21:30:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6BE36F8025E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jXcp/9+s
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8F2DB5C2726;
	Fri, 30 Aug 2024 19:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC793C4CEC2;
	Fri, 30 Aug 2024 19:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725046236;
	bh=rz8KDKw3aTWGQcJdgAqnxUa0Kv/DBZMxKlXY8HtiKFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jXcp/9+snMJHOYEgWuq8md6a8c055bh4zmF5ps27aLwFi5MpxHT10AitTZKkvZbt1
	 nZFxYsO+Fqko0Vbwu+1leQo9D2jZhOMqBc2e0U+9zYp9EpLGswwYBMXk6ycolf74zO
	 Mpn0hr/CtxZOBues2jY7VaWFauXfq0RBk8QH7nbKS6+p5tiZ0aCnLiKO2FOYNOjp7q
	 +vzCwlLJL27xEPOQCp3P8/eWnlyiNa/Qb+xwKM/VXKk78JbZSbUWTxByHlQaM0yWxt
	 wIciwVXClMWc8zuJzvVN4MtAVXK/SXDrcKA7Ic5taHyccl63gIsgN44tV8xq0IAHId
	 tdLYhOGEMgNnw==
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, amit.pundir@linaro.org,
 dmitry.baryshkov@linaro.org
In-Reply-To: <20240816091210.50172-1-srinivas.kandagatla@linaro.org>
References: <20240816091210.50172-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2] ASoC: codecs: lpass-va-macro: set the default codec
 version for sm8250
Message-Id: <172504623446.461126.12391681424311035210.b4-ty@kernel.org>
Date: Fri, 30 Aug 2024 20:30:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811
Message-ID-Hash: EYLOKMNLNQODWBYOPBPCBITCVQPDZY6Y
X-Message-ID-Hash: EYLOKMNLNQODWBYOPBPCBITCVQPDZY6Y
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EYLOKMNLNQODWBYOPBPCBITCVQPDZY6Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 16 Aug 2024 10:12:10 +0100, srinivas.kandagatla@linaro.org wrote:
> sm8250 and sc7280 have lpass codec version 1.0, as these are very old
> platforms, they do not have a reliable way to get the codec version
> from core_id registers.
> 
> On codec versions below 2.0, even though the core_id registers are
> available to read, the values of these registers are not unique to be
> able to determine the version of the codec dynamically.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-va-macro: set the default codec version for sm8250
      commit: 77212f300bfd6fb3edaabd1daf863cabb521854a

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

