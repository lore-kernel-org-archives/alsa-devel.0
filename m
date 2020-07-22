Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654C2C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 01:00:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE6C32077D
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 01:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RRvIoUfL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iejbyqoi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6C32077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F8511674;
	Wed, 22 Jul 2020 02:59:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F8511674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595379610;
	bh=ixbCeX47fIGI9Saa2Wc+hbWi7zHZVD3equCOUqRHMbI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RRvIoUfLCwhwqLgss15Au0Emv/E0ZUT5DXL3RiD6tWMg9Uw/vuD+jfYXh7ZiXIOhl
	 xVdBShUmTwEi16ZGeWrAKiY0SU/2Z+xnXIZDUAxn558DFzUPUSX0du93XL2q/1ZjA3
	 8CL0hPuUIoZVEqKYjWbORK+fVSlqG8CEFQPIjYMQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86601F80290;
	Wed, 22 Jul 2020 02:57:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7DE17F802C2; Wed, 22 Jul 2020 02:57:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB688F80290
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 02:57:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB688F80290
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Iejbyqoi"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F243D20792;
 Wed, 22 Jul 2020 00:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595379432;
 bh=ixbCeX47fIGI9Saa2Wc+hbWi7zHZVD3equCOUqRHMbI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=IejbyqoiNK7Luy4TAyeeNNy7rPXl8xiL0ZdWgT1hijD3gJTwstjjH5P78lak6wDZS
 Fu8wufz5ryTGUOOyWf9zraOO3TI2ICHYjVQmflFC/uvRmll/wyjDaEdiZvPvIGcC93
 xQD4+WuhqBY2X0HBtP8FRpD1LiQFMe8u1GZJhpVI=
Date: Wed, 22 Jul 2020 01:56:59 +0100
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, perex@perex.cz, Dan Murphy <dmurphy@ti.com>,
 lgirdwood@gmail.com
In-Reply-To: <20200720181202.31000-1-dmurphy@ti.com>
References: <20200720181202.31000-1-dmurphy@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: tas2770: Convert tas2770 binding to
 yaml
Message-Id: <159537940424.49432.10532525399520468723.b4-ty@kernel.org>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Mon, 20 Jul 2020 13:12:01 -0500, Dan Murphy wrote:
> Convert the tas2770 binding to yaml format.
> Add in the reset-gpio to the binding as it is in the code but not
> documented in the binding.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tas2770: Convert tas2770 binding to yaml
      commit: ad0ddbb9ba3d5216bf3035db6684c1507c90b93b
[2/2] ASoC: tas2770: Fix reset gpio property name
      commit: 58b868f51d6e38146e44cb09fcd92b5fc35d83bc

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
