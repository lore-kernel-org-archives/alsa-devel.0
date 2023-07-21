Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA5BEB64DD
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Jul 2023 10:56:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 397DF83B;
	Fri, 21 Jul 2023 12:55:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 397DF83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689936972;
	bh=P93rQLt+HbT+haMc2bru+0/BFEl6sR0r4+uZfisc2mU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=b+/d8EgmWXDep4Rp+j7c5IH/2J4PFHkxDCiByNmZlh8sJvktoKi1EVlI6kxn8iPp+
	 YWs1nP6dATx2UqMT2igcoRE4VcewEmaC6g+zJHShHb4LuyWrFVW4Phk+6t0yEKSZkS
	 lMBsHI7L/1nI1tj6J5FmL6tPXpbi4oaUgO1Afks0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89196F80548; Fri, 21 Jul 2023 12:54:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 03889F80494;
	Fri, 21 Jul 2023 12:54:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1FE6F80494; Fri, 21 Jul 2023 12:54:50 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7A377F800D2
	for <alsa-devel@alsa-project.org>; Fri, 21 Jul 2023 12:54:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A377F800D2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=js9LRL8B
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CE3DF61789;
	Fri, 21 Jul 2023 10:54:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1711AC433C8;
	Fri, 21 Jul 2023 10:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689936882;
	bh=P93rQLt+HbT+haMc2bru+0/BFEl6sR0r4+uZfisc2mU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=js9LRL8BYtSeSsiAGLiLTDDfDPpCKPqL1KLUgbQX/A1WRYTEqa8mTGuxe4UOm86Cl
	 HD4NWCgGvwbVqsCLU5V0/znaqqcmboX9J9ubnV8C274sbysgmw0Lktq/pvAPfBhjt9
	 lgeI2QP/vFmYexeHAHw8QwWPPIk6PFlgWPGYGFTf9bEzhDiikRx5+5NnK2aU3Hgb8W
	 zxHa4JbMyEnak1R6F93bwxM+9R89l/L6Xlk/KrwGnw8zlDsBEF+7QR6uW6HqHDpY3E
	 VLHt0Eb38FqriAOKSv/naBEUSwAwFMwuAlnQPae93WwsFhUPkRq5i9/D/JooU1kf4i
	 EhmbiGw53T67w==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, CTLIN0@nuvoton.com
In-Reply-To: <20230719124752.248898-1-francesco@dolcini.it>
References: <20230719124752.248898-1-francesco@dolcini.it>
Subject: Re: [PATCH v1 0/2] ASoC: dt-bindings: nau8822: minor updates
Message-Id: <168993687980.20527.4752913856777924592.b4-ty@kernel.org>
Date: Fri, 21 Jul 2023 11:54:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: ID5Q5NILNHNAGSERES24TCZOBMJIJQXK
X-Message-ID-Hash: ID5Q5NILNHNAGSERES24TCZOBMJIJQXK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ID5Q5NILNHNAGSERES24TCZOBMJIJQXK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 19 Jul 2023 14:47:50 +0200, Francesco Dolcini wrote:
> Minor updates to NAU8822 DT bindings:
>  - Add #sound-dai-cells
>  - Add MCLK
> 
> Francesco Dolcini (2):
>   ASoC: dt-bindings: nau8822: Add #sound-dai-cells
>   ASoC: dt-bindings: nau8822: Add MCLK clock
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: nau8822: Add #sound-dai-cells
      commit: e8c213ca026d3cadbc306885ad1b37efab02c218
[2/2] ASoC: dt-bindings: nau8822: Add MCLK clock
      commit: c214131f492083025e33354430d5b420add88b5e

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

