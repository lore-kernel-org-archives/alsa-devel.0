Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A86DC48BF6
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Feb 2024 17:21:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E99F6E85;
	Mon, 26 Feb 2024 18:21:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E99F6E85
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1708968088;
	bh=nYrXyuWOkS6zdHWlq6i1e4OrZlpxjmsrtwPb0T4RU4w=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=OYMbCHrTgZ9taxS4/Ja++cX/239LokUFhFuL18b2Fy4FTKiiI6gYg5MvnCaiUjpB5
	 mjSNBCMOLnjDwsnPybS9akKNAsTdij4+k3ipLVxE/N/KrIZXg48clLz6fRcvYDlOMX
	 0E4SIiHG1+r4VVkC9zBrBzFVh3d5oh5eTxkAvRTg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 192BEF805AD; Mon, 26 Feb 2024 18:20:46 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A9176F805C4;
	Mon, 26 Feb 2024 18:20:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ABDB4F80246; Mon, 26 Feb 2024 18:20:40 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 82AE6F8012B
	for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2024 18:20:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82AE6F8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=U9+ZnGMh
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6C35C602F5;
	Mon, 26 Feb 2024 17:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624FEC433C7;
	Mon, 26 Feb 2024 17:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708968028;
	bh=nYrXyuWOkS6zdHWlq6i1e4OrZlpxjmsrtwPb0T4RU4w=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=U9+ZnGMh7KVEtFXTkLLsUTbqjIfeTyotQ+HHAHkZU7Jq0I73LAG7CqUE8mj2wCOfj
	 8skjBiCQPIu/ThRao7ETfFx55yZdc1PlCzT2u3oua/vm7dH1I3NA4il+1KGmTuIknr
	 z17CO/fLHpH9gEOgBVrFYWKA+m8Nwy8T39KCVRbHWsWNKZVsegM692n5xSd4io0Y0l
	 1WeEwhVktMNpH0CikUKY/w8xV20ZojnXU6j+qCNizCin//Hhz4tpinrRoyuoDz++8t
	 NY9RssSBSvSADYVoSA3VZ9taoeDFM9jrM2cn8lcypXRaZ5595q8R2iokoIFffmv+6F
	 aEfuvIm2SS2oQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240129143534.109196-1-krzysztof.kozlowski@linaro.org>
References: <20240129143534.109196-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn
 widgets on SM8350+
Message-Id: <170896802613.63378.9584283021927878510.b4-ty@kernel.org>
Date: Mon, 26 Feb 2024 17:20:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c
Message-ID-Hash: 2T7VCLEADF2F3YBS6B5PEBYIFACCUJ6S
X-Message-ID-Hash: 2T7VCLEADF2F3YBS6B5PEBYIFACCUJ6S
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2T7VCLEADF2F3YBS6B5PEBYIFACCUJ6S/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 29 Jan 2024 15:35:32 +0100, Krzysztof Kozlowski wrote:
> Changelog in individual patches.
> 
> v2:
> https://lore.kernel.org/alsa-devel/20240125153110.410295-1-krzysztof.kozlowski@linaro.org/
> 
> v1:
> https://lore.kernel.org/all/20230717140138.201745-1-krzysztof.kozlowski@linaro.org/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: tx-macro: split widgets per different LPASS versions
      commit: 051e887264b3e161cf2c1e163321b31191bf78a4
[2/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn widgets on SM8350+
      commit: d34f0c8ee2e30b8a1470ce635289591148552a93

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

