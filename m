Return-Path: <SRS0=4dkw=PN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFCEC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:40:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3EB60F22
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Oct 2021 16:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC3EB60F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF9D516CA;
	Mon, 25 Oct 2021 18:39:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF9D516CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635180035;
	bh=OG4xVFMz61gmA5aN/a4qTFWUoD7RB1ivYPTxQ1ppB3s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PC3I/Tic9CqYg1mKduuTBGWHIwT1vgojgIOedcyd8MFacP0HKwgifLc749p1xHzx9
	 7qbWJwR3ztqT4qSS85iFQoYDsXkixOdM5SydZQiATfLzpnWy6AF9z0MFlaWZ6uZ73f
	 kEdclUzzoBhaPELwCw15ko/r4tg7r4rDBWK5z8Os=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B3B7F80086;
	Mon, 25 Oct 2021 18:39:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0C6EF80271; Mon, 25 Oct 2021 18:39:43 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 75495F80086
 for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2021 18:39:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75495F80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TG47zceU"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0AD660EB9;
 Mon, 25 Oct 2021 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635179977;
 bh=OG4xVFMz61gmA5aN/a4qTFWUoD7RB1ivYPTxQ1ppB3s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TG47zceUXSpXIn0gbCOXte6XsKfSv5g9+wuzQBYS12EiuyIW5x/zAcoIOFPRix28b
 HzkW8VceTVE4/504/690lnfAy+pEoLnpZZXUFxIfANR7+GbKjqGVhKyuK2kqqvdTpI
 BYqObbJ7tsvUhA/7qXBf4pYkoddg9nnHvBVp67yqrtlQkpx4KZJ2S695zOBibEPCAa
 5vmi88R54gGnUYCwzIwFUHrN3ASbg5x7+3wYCuCJ1GrU3c4NJh5MGH1H6v8vsyhGrJ
 LajLDCpw06g1qdoN3mAG+d2gNG57yVm4DMhvmexoh1EC10IlSux+V+UcnjcZzoYRUn
 ldRi+lXAS/OyA==
From: Mark Brown <broonie@kernel.org>
To: patches@opensource.cirrus.com, Adam Ford <aford173@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: (subset) [PATCH 0/2] ASoC: wm8962: Conversion to json-schema and
 fix
Date: Mon, 25 Oct 2021 17:39:21 +0100
Message-Id: <163517996156.3558038.1402289987821049770.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1634565154.git.geert+renesas@glider.be>
References: <cover.1634565154.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Mon, 18 Oct 2021 15:59:01 +0200, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series converts the Wolfson WM8962 Device Tree binding
> documentation to json-schema, after fixing an issue in the imx8mn-beacon
> DTS file.
> 
> Thanks for your comments!
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[2/2] ASoC: dt-bindings: wlf,wm8962: Convert to json-schema
      commit: cd51b942f34431a2a2c92a8385e94cdd97e15350

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
