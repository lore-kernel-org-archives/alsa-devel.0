Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44345C433E6
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:19:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5AF02137B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Vk18uFnD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUHaCQ7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AF02137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 15E2F17BB;
	Tue,  1 Sep 2020 17:18:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 15E2F17BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598973559;
	bh=G9lRoCqtutdJhrTRAYTbOfsRmk/iYWksD4gRggGFpF0=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vk18uFnDT5mTuMeJ493f0kgqevZDW7yMB7exxGbXhyM1KI87PuY0dC3Em/TKytBKl
	 JFOCyNElW4CRVQwa7nC5MzHudFu7Y4HVQGvkQyklTZop0ysYb8ORZ8TTv3ipn+TuWb
	 Zw7/4sSrSPRxtkuvJREyvlS0yPGV7JnVlD2s63lI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D2FBF8020D;
	Tue,  1 Sep 2020 17:18:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E593AF80217; Tue,  1 Sep 2020 17:18:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0665F801DA
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 17:18:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0665F801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PUHaCQ7M"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A9B09214F1;
 Tue,  1 Sep 2020 15:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598973501;
 bh=G9lRoCqtutdJhrTRAYTbOfsRmk/iYWksD4gRggGFpF0=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=PUHaCQ7MHB9fNoxA52ESx3JqtH57jOx6fl017yOgjt+PabE3DmJPNbHso4Kuzk2WI
 ooVNY52/SDRcDxZDZU3rzL/CcHT2PKnNR/xVd7zMhg+txyQqdSVkR5KkNFwHTAO6vP
 6M4AZop+jfTjbbP2PRygCSj552WxSa1hVgoXnxB4=
Date: Tue, 01 Sep 2020 16:17:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Camel Guo <camel.guo@axis.com>, perex@perex.cz, tiwai@suse.com,
 lgirdwood@gmail.com, dmurphy@ti.com
In-Reply-To: <20200901135736.32036-1-camel.guo@axis.com>
References: <20200901135736.32036-1-camel.guo@axis.com>
Subject: Re: [PATCH v4] ASoC: tlv320adcx140: Fix accessing uninitialized
 adcx140->dev
Message-Id: <159897346138.26776.4795793830784524613.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, kernel@axis.com, linux-kernel@vger.kernel.org,
 Camel Guo <camelg@axis.com>
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

On Tue, 1 Sep 2020 15:57:35 +0200, Camel Guo wrote:
> In adcx140_i2c_probe, adcx140->dev is accessed before its
> initialization. This commit fixes this bug.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tlv320adcx140: Fix accessing uninitialized adcx140->dev
      commit: 2569231d71dff82cfd6e82ab3871776f72ec53b6

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
