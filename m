Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B3DC433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jun 2022 12:40:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE06A170D;
	Wed,  1 Jun 2022 14:39:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE06A170D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654087230;
	bh=gR+lFZDnf1dnocWxYK3aI9jqbAWCRD4RCO7Ob7HKy2w=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bZ0z+p+/NPT8UNYQlecAUGVZpIrRmMGAr663DphAu3FyyBXzbXM1/0GQPxEy2J8QH
	 k4ZuTKbPlNv10dfarwGTnkXQcVLUm0lZS8dxWCrgcq6I4Ky1iWda2dkk7sbWXVGK03
	 3n47C2I0UXAMhQ+9i6Wwf1mxR0kNgQOIiitHZNPo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0DBBF8019B;
	Wed,  1 Jun 2022 14:39:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB988F80482; Wed,  1 Jun 2022 14:39:10 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 589DCF8019B
 for <alsa-devel@alsa-project.org>; Wed,  1 Jun 2022 14:39:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 589DCF8019B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="E+9B9Idp"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0F5E3614D2;
 Wed,  1 Jun 2022 12:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1554CC3411D;
 Wed,  1 Jun 2022 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654087143;
 bh=gR+lFZDnf1dnocWxYK3aI9jqbAWCRD4RCO7Ob7HKy2w=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=E+9B9IdpO4se2dzEvW0qdL5pBMJi4mX3KZasxXlRYbErMvNgv5wW/tIqB5jSEfhS4
 KaJnM4WwLWzkofadzE+/hFyD0cmwJeevtnWCtRT+EZQJhBubILWqlJISkZbudAsxyv
 JkYB65kWVynSblgqDmM95T4zLTDU2qvJ9eTRFPv80ch8eB/3SW1ElgbyNLTnADJF4W
 hFGAAqdVnSQdOp65nLbevatfZCaT0tCKgNK8Ym3vKbB76OW04APPBzMCOe2si4RMwS
 tptT1mopG00HwfNzE1+Eq6wn6fceYl89fQ8CX6Hlb0kjgIG6onzIGTSyQlzKbDCE8v
 M+TVa2bAOQxDw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, hui.wang@canonical.com
In-Reply-To: <20220530040151.95221-1-hui.wang@canonical.com>
References: <20220530040151.95221-1-hui.wang@canonical.com>
Subject: Re: (subset) [PATCH 0/2] Switch to use internal PLL for iMCLK
Message-Id: <165408714183.3032499.11457698420353367654.b4-ty@kernel.org>
Date: Wed, 01 Jun 2022 14:39:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: wtli@nuvoton.com, kchsu0@nuvoton.com, ctlin0@nuvoton.com,
 ctlin0.linux@gmail.com
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

On Mon, 30 May 2022 12:01:49 +0800, Hui Wang wrote:
> Taking your advice and try to enable internal PLL to get a more
> accurate sample rate. And I also changed the fsl-asoc-card.c to support
> the nau8822 codec, now the sound quality is pretty good on my imx6sx
> EVB.
> 
> Please help take a look at these 2 patches on codec driver.
> 
> [...]

Applied to

   broonie/sound.git for-linus

Thanks!

[1/2] ASoC: nau8822: Add operation for internal PLL off and on
      commit: aeca8a3295022bcec46697f16e098140423d8463

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
