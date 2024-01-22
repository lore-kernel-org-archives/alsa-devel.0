Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB2AC47DD3
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jan 2024 20:45:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A9767F4;
	Mon, 22 Jan 2024 21:45:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A9767F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1705956344;
	bh=oDkDT6iAXlV0QIqN+s4z7Li/nnh1PW76mppCWWK9Ehk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kdbgpkFNpsgPFoGGZBnlyiUIpqAR/Kf6x/ZOAnGND7Ch/KgC5dV9sVGlFwc0KA15K
	 Vp0IcSQyl5O6Ffbe0GOq/6OXe2mIGukpBr6+3KgNGT0r+FoU4WlUkcMrjIyIIO4XJI
	 mm2dXC3fwATwHqISena7t26i2bPFzGsZlMBajiOM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1CB82F805FD; Mon, 22 Jan 2024 21:44:43 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 94555F805C9;
	Mon, 22 Jan 2024 21:44:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A6C43F804F1; Mon, 22 Jan 2024 21:44:33 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 495BAF8028D
	for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2024 21:44:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 495BAF8028D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=gI/lmstp
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 356B461AAD;
	Mon, 22 Jan 2024 20:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1BFC43394;
	Mon, 22 Jan 2024 20:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956265;
	bh=oDkDT6iAXlV0QIqN+s4z7Li/nnh1PW76mppCWWK9Ehk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gI/lmstp97c7THLe+3ZeoFa1fdCoCYuCqw3e2APufzr4P/JzjRHnd6oVP9vxDuENT
	 CVHAv/jEAh7HF4zj8nTkoYQ5ljYDADdVe5Lm6WGDTASMC6prANqpFavK4NMYfpFF2d
	 JULnpC0DgFoHeWBvUkzgUN1f1Uv2X3/2gBhu/oOE5DGJ3RperrqaIh0sRJnC1p5mot
	 DkfzHwzUGtQVNOxJnh1VBWrUEnTB+/DvDlFDKcaKBmBkTuZlbGlSPkEzASUVJIB+8S
	 R5P19Dn6H3HQSIGIKRJ1dJgQ4cNsfh2L4MoGD3BhZlFA/9QMZiWQsX06APuTbR5aUO
	 o813355Aa2dyg==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
In-Reply-To: <20240117151208.1219755-1-krzysztof.kozlowski@linaro.org>
References: <20240117151208.1219755-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/3] ASoC: codecs: wcd938x: handle deferred probe
Message-Id: <170595626282.145475.12611674756831880298.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 20:44:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066
Message-ID-Hash: 3TGZTPQS5ISZ7CPVFRKVXKTN2BMUPMFJ
X-Message-ID-Hash: 3TGZTPQS5ISZ7CPVFRKVXKTN2BMUPMFJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3TGZTPQS5ISZ7CPVFRKVXKTN2BMUPMFJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 17 Jan 2024 16:12:06 +0100, Krzysztof Kozlowski wrote:
> WCD938x sound codec driver ignores return status of getting regulators
> and returns EINVAL instead of EPROBE_DEFER.  If regulator provider
> probes after the codec, system is left without probed audio:
> 
>   wcd938x_codec audio-codec: wcd938x_probe: Fail to obtain platform data
>   wcd938x_codec: probe of audio-codec failed with error -22
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: codecs: wcd938x: handle deferred probe
      commit: 086df711d9b886194481b4fbe525eb43e9ae7403
[2/3] ASoC: codecs: wcd938x: skip printing deferred probe failuers
      commit: 22221b13d0c20a9791dec33121df73fe0b2ac226
[3/3] ASoC: codecs: wcd934x: drop unneeded regulator include
      commit: 35314e39dabcfb256832654ad0e856a9fba744bd

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

