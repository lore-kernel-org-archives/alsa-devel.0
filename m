Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52DDC04FF3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 12:01:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0785613E6
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 12:01:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0785613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B2FF1695;
	Mon, 24 May 2021 14:00:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B2FF1695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621857689;
	bh=aB67jAoUabmrvPvNeu2p/bIDSS6GeTv8dUedzFdTyQE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fZqsKDbh0nPa1gmmb+7r46bmnWwriIR0fCW/fCr6f+ek++nflJUphnEWFYcdLJI37
	 Q3ZYW4xRlE9L1RJrdmX076Krvkw7LDLCtKXwPPY3lKy+slIAbexok9zSnPiKCb2GsB
	 l0YJU0XyxciobYGP2tmTbroWSrJ8nbFp90fXAoLM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1C12CF8022B;
	Mon, 24 May 2021 14:00:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5EFA4F8023A; Mon, 24 May 2021 14:00:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C45D5F80137
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 14:00:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C45D5F80137
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gnu8Okow"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 001376128D;
 Mon, 24 May 2021 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621857632;
 bh=aB67jAoUabmrvPvNeu2p/bIDSS6GeTv8dUedzFdTyQE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gnu8Okowfm1deDMXO9mUDGl1Pxv2OsnBgPk6dJ4dCeQVojlY0yoj+Rf4ryUdk+PxJ
 J72crv7UY/xkyQqAVllGhqtowxpgBNxRb3XbrSAraQ2pc7ANUFseM8LGQIfXEKjKRZ
 799DpI/UYRByCgyiiaHwLnnMGpJEDdGh/BAdy/832YlzBZGLAiKJsSzLxLwRV3B77w
 JP4QcTCnDRtvv8JNT7fVf3r3BOnCrWWcnQcRXkl6w31Vp7Oj+sqwuTQNtRD0+3itSQ
 xByaiY0eDbdmfsqkAptAJEwqTmk6xj8Sf+L2twxqlTDJJGNlIwC7SfrFmKzgiHl6qy
 hWOAJ6Fo1FDkA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 0/3] ASoC: rsnd: add D3 support
Date: Mon, 24 May 2021 12:59:57 +0100
Message-Id: <162185746497.49382.1963607123568169981.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87y2c4oe3y.wl-kuninori.morimoto.gx@renesas.com>
References: <87y2c4oe3y.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 24 May 2021 15:11:29 +0900, Kuninori Morimoto wrote:
> These adds R-Car D3 support for rsnd driver.
> [1/3] is tidyup patch for dt-bindings (not only for D3).
> [2/3], [3/3] are for R-Car D3.
> 
> Kuninori Morimoto (3):
>   ASoC: dt-bindings: renesas: rsnd: tidyup properties
>   ASoC: rsnd: tidyup loop on rsnd_adg_clk_query()
>   ASoC: rsnd: add null CLOCKIN support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: renesas: rsnd: tidyup properties
      commit: 17c2d247ddd231199e682b0a7fda42fe46c2c07b
[2/3] ASoC: rsnd: tidyup loop on rsnd_adg_clk_query()
      commit: cf9d5c6619fadfc41cf8f5154cb990cc38e3da85
[3/3] ASoC: rsnd: add null CLOCKIN support
      commit: d6956a7dde6fbf843da117f8b69cc512101fdea2

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
