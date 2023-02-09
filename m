Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA69C636D6
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Feb 2023 18:39:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AAE6AA4D;
	Thu,  9 Feb 2023 19:38:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AAE6AA4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675967949;
	bh=KJFYdKEwIQ4c63KYJlEOv6bHkZ40qvZiPlbsQ4nPPMc=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=s8pKiDLyHD2CTFbl5LdymHyiegp+C3EQ8AYOj/xTBxlvUwXtMnXFK6GFgG1rNPpjc
	 AKoTw/t0ijDO2A2ZUWzOROllX1T83EDaI9rheOgVvNz9G8eT78jkYZJ07BwSg2CGpP
	 TM+sISUe+b0qxPE6xx2IwV2i18hSkrI9n9duyWeM=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 42648F80558;
	Thu,  9 Feb 2023 19:36:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4D7E1F80557; Thu,  9 Feb 2023 19:36:37 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 62633F8052D
	for <alsa-devel@alsa-project.org>; Thu,  9 Feb 2023 19:36:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62633F8052D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=keTcFSJD
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4FAB661B80;
	Thu,  9 Feb 2023 18:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141E7C433EF;
	Thu,  9 Feb 2023 18:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1675967791;
	bh=KJFYdKEwIQ4c63KYJlEOv6bHkZ40qvZiPlbsQ4nPPMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=keTcFSJDyJWxI188DJ9zkzk0OZOjkllBpCgxCYXP73ogRTdu2nl3DdKqYia3nQoj1
	 66Hhmjr+RDnThjZW8oTuchniDteXnuiZ2HAxTdcU0Ex64GI5l5aYN9zzVPSWM8Du3n
	 4RAeh+wrzhMCpCJZ/3ecw9TDOVrB0KjvKJRK/xigHzuJSv3gd4V+RsCfuseVEz6Blc
	 qDToSqGR6x43J9rowSP6GW5Mw8HnILSWWZMNsFV4eqISMo/SN9R3JI6cdAUVERZSv4
	 BhgUlCEl7SbxJQPmH6yFuERuSohBPngTSmBvOD4NABczjtlatlbL7JdhcywdPNb/wa
	 YYeoCgfOoYc0w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Herve Codina <herve.codina@bootlin.com>
In-Reply-To: <20230206144904.91078-1-herve.codina@bootlin.com>
References: <20230206144904.91078-1-herve.codina@bootlin.com>
Subject: Re: [PATCH 0/3] Add the Infineon PEB2466 codec support
Message-Id: <167596778880.879652.18301706233837933352.b4-ty@kernel.org>
Date: Thu, 09 Feb 2023 18:36:28 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Message-ID-Hash: FOFBVA7H3B7LMIY2ANJPU56T46YERHBT
X-Message-ID-Hash: FOFBVA7H3B7LMIY2ANJPU56T46YERHBT
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FOFBVA7H3B7LMIY2ANJPU56T46YERHBT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 06 Feb 2023 15:49:01 +0100, Herve Codina wrote:
> The Infineon PEB2466 codec is a programmable DSP-based four channels
> codec with filters capabilities.
> It also provides signals as GPIOs.
> 
> Best regards,
> Herve Codina
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] dt-bindings: sound: Add the Infineon PEB2466 codec
      commit: 4c03e952ad8688a28aed9b72fc48291240707c7d
[2/3] ASoC: codecs: Add support for the Infineon PEB2466 codec
      commit: 227f609c7c0e44f2103a8406ff9379ee1de3bc28
[3/3] MAINTAINERS: add the Infineon PEB2466 codec entry
      commit: 564972dbf85c0900521e6273b772fd7f0b720dd7

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

