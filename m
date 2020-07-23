Return-Path: <SRS0=vWr5=BC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627BFC433F4
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:22:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D041A2065F
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MEfk7C9P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly0qRitC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D041A2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60F7E1697;
	Thu, 23 Jul 2020 22:21:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60F7E1697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595535746;
	bh=NFwgi/pOE2q/ao35kWntMVRcIXnbPddfd1MCJHYlDyE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MEfk7C9Pup9kjNCcRMNHDl3pvWKaZ5j4UEmZTe52JsK98pJM5vhmo0oXMR6OUkrrZ
	 Xqtg28+vzdhp8rFpZfnA+iYpohRuHd1iRrcROBxLTiZq0PAw/1TFtFBAO3IjqT0fAB
	 RUmjrz8tc3HuKL5pG8479E2//8ssyQ6CGqfMAYqc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC770F8028C;
	Thu, 23 Jul 2020 22:20:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BECDCF8028D; Thu, 23 Jul 2020 22:20:03 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBDB3F80279
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 22:20:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBDB3F80279
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ly0qRitC"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C5868207BB;
 Thu, 23 Jul 2020 20:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595535599;
 bh=NFwgi/pOE2q/ao35kWntMVRcIXnbPddfd1MCJHYlDyE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Ly0qRitCwTcxwKAeh54tYDClU/MphaQiCwKnFNRl9UZqZWjSBdcIFGYjQkosM8Fuz
 mYhnMRVaeTszKq4T8xSiiW55Nj94QcN4lxhyGDHCcdYSviosPxgdhSuPMrl3si3xDE
 5K0H+0e+SflFZwSOhZAt7pvLnzUObCqEAu7tcfCo=
Date: Thu, 23 Jul 2020 21:19:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
In-Reply-To: <20200723110321.16382-1-ckeepax@opensource.cirrus.com>
References: <20200723110321.16382-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm_adsp: Support new metadata block ID's
Message-Id: <159553557414.41908.3558420326327030438.b4-ty@kernel.org>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 james.schulman@cirrus.com, lgirdwood@gmail.com, david.rhodes@cirrus.com
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

On Thu, 23 Jul 2020 12:03:21 +0100, Charles Keepax wrote:
> Coefficient files now support additional metadata blocks, these
> contain machine parsable text strings describing the parameters
> contained in the coefficient file.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm_adsp: Support new metadata block ID's
      commit: 779bedff9bfaf34cae6bfcbdd98d972149f687e5

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
