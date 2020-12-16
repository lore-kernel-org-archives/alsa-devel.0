Return-Path: <SRS0=ORgw=FU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23D2C4361B
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Dec 2020 15:55:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D690022283
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Dec 2020 15:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D690022283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EC231812;
	Wed, 16 Dec 2020 16:54:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EC231812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608134108;
	bh=88R5HX8QPG4Rb/zadgAFPZrUoglDHE4sM8jJ+aR23aU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DpVlMHU0WWvj58j0isLJ8bwX6Vx7vpepU8zWBzyd6UzaVDINoOuC7OYIOlvlaewSX
	 8whvNqYTHuwM5zNlDLbuIxzYGen6KKY07eH2M9nepQjUNCmLUYhqmM1N1K1/HLANMv
	 yHZm/AIv5zF3zOTPVeLKrsG/xWgAtUKh3Cz4NOj4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9903EF804BD;
	Wed, 16 Dec 2020 16:53:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27C3CF80276; Wed, 16 Dec 2020 16:53:25 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA358F80276
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2020 16:53:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA358F80276
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: robh+dt@kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
 lgirdwood@gmail.com, jarkko.nikula@bitmer.com
In-Reply-To: <20201215130512.8753-1-peter.ujfalusi@ti.com>
References: <20201215130512.8753-1-peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/2] ASoC: ti: Maintainer mail address change
Message-Id: <160813397774.31838.10952894427041068328.b4-ty@kernel.org>
Date: Wed, 16 Dec 2020 15:52:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, jsarha@ti.com, tiwai@suse.com,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Tue, 15 Dec 2020 15:05:10 +0200, Peter Ujfalusi wrote:
> My TI address is going to bounce after Friday (18.12.2020), switch my email
> address to my private one for now.
> 
> Regards,
> Peter

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] MAINTAINERS: Update email address for TI ASoC and twl4030 codec drivers
      commit: fe6ce6c394fb1ef1d8a6384c5180e70893157f22
[2/2] ASoC: dt-bindings: ti, j721e: Update maintainer and author information
      commit: 61fc03b6512b18f27a25002426d595f5a36645ed

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
