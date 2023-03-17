Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BF0C74A5B
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Mar 2023 16:42:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34F8BF14;
	Fri, 17 Mar 2023 17:42:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34F8BF14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679071377;
	bh=lCxa2338SgBPuW+ok1w/jwS3okMbVkrZTlxCoSWBWcs=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ila932Lgw4qut7sv4/89lBv5wvL9qo3dun7Vx9yvhBlqm6cgknqqFtHj0LiEh0+UP
	 bjtFyWIkyeIqGanrTyekB/yLBIp3RO1USYyx6tMUFwQv8ZNuxVImakmgd4pJEPWPXS
	 Is7oeqtY4zDopuKyV1DYOi0DZqddt2md8RwTQufQ=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 32EE8F80558;
	Fri, 17 Mar 2023 17:41:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B40BAF80533; Fri, 17 Mar 2023 17:40:55 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7CBD7F8032D
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2023 17:40:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CBD7F8032D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jMWZT1CW
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 17362B82654;
	Fri, 17 Mar 2023 16:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1988AC433EF;
	Fri, 17 Mar 2023 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679071249;
	bh=lCxa2338SgBPuW+ok1w/jwS3okMbVkrZTlxCoSWBWcs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jMWZT1CWhPxQJXBMCg0qFk/uicDJWyPZpGQgSa3aQdwczpLSEZrA/YzPIb7sYCo1d
	 qMq/rTexyCmYkm1DUVzs91yKDR3uDRZnlgScUxJBq2NZ2Fd7rZ937AZwybvbn3+SPk
	 8pBfPqffZRdguiX8LTMMePOB6IBnL2Fj5PEVH87bXXm8ZOr6+bDO9Ro9m+uYOKEo6/
	 haLHIJ0MuqKyjj1+/waPEP9DmVw/uOzYux+L7+UwOlxkSS/Jd+4RRUeZ9L9P8kHJSw
	 kjEaX5pQ9rBe9XVX2UjkOMNZXGp8xyXq1DZItZ3h8WeIKCaeqbJoZ+fVYfIAdVhmYh
	 hClcN3vxqwBDQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230317082137.12629-1-krzysztof.kozlowski@linaro.org>
References: <20230317082137.12629-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: renesas: rsnd: correct comments
 syntax
Message-Id: <167907124782.46507.1842486955927522063.b4-ty@kernel.org>
Date: Fri, 17 Mar 2023 16:40:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bd1bf
Message-ID-Hash: TKULKHPLQRGAOLXX5S45EYXAMBSF577O
X-Message-ID-Hash: TKULKHPLQRGAOLXX5S45EYXAMBSF577O
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TKULKHPLQRGAOLXX5S45EYXAMBSF577O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 17 Mar 2023 09:21:37 +0100, Krzysztof Kozlowski wrote:
> yamllint expect space after '#' comment mark:
> 
>   renesas,rsnd.yaml:282:4: [error] missing starting space in comment (comments)
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: renesas: rsnd: correct comments syntax
      commit: 47df94faa5e3775510177cdc0909e397300cc791

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

