Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00830C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 00:59:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A602077D
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 00:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EKaFx9ap";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSPbLo1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A602077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E98631675;
	Wed, 22 Jul 2020 02:58:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E98631675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595379577;
	bh=koNxJKTh7G56Ng1o3vV6ECm51Ywis8J9Y2mpLAnScC0=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EKaFx9apZRtZMsDRufCvSKXB9Bu3Xxs5RXsIGdsrSpU0/4jS072WxJn38R6K6pktW
	 AXLLQSJerrYAKXv7d9dsP/w9kiHOj1FIGnl6vp90KruUpzUDcaOznVyY5sHi0Exf09
	 vwJt6Ff9RuCgJ75foO1b7XgRzKXlqRg340YAizOI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BEADF8028C;
	Wed, 22 Jul 2020 02:57:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A4EFBF80278; Wed, 22 Jul 2020 02:57:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6A05F80087
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 02:57:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6A05F80087
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="kSPbLo1M"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E71F92077D;
 Wed, 22 Jul 2020 00:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595379427;
 bh=koNxJKTh7G56Ng1o3vV6ECm51Ywis8J9Y2mpLAnScC0=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=kSPbLo1MeunulSDuATEGZ9Rl/xynpCbOnuzduchnnmu1aFgmpoVmCDaOcg+e6MWBK
 ilxgF+sDkwH98LChixBoRvMZTWDmQkyaJ8sr6l7Swr9vd4lzvl3iLg285tewLv9lUn
 IBx7raMYhsrxp/g/IJJ2MwqUQeyPXybIutWIKnlE=
Date: Wed, 22 Jul 2020 01:56:54 +0100
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, tiwai@suse.com, perex@perex.cz, shifu0704@thundersoft.com,
 Dan Murphy <dmurphy@ti.com>, lgirdwood@gmail.com
In-Reply-To: <20200612171342.25364-1-dmurphy@ti.com>
References: <20200612171342.25364-1-dmurphy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: tas2770: Convert tas2770 binding to yaml
Message-Id: <159537940423.49432.13949737957627950066.b4-ty@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
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

On Fri, 12 Jun 2020 12:13:41 -0500, Dan Murphy wrote:
> Convert the tas2770 binding to yaml format.
> Add in the reset-gpio to the binding as it is in the code but not
> documented in the binding.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] dt-bindings: tas2770: Convert tas2770 binding to yaml
      (no commit info)
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
