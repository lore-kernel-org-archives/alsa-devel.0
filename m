Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2986EC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:56:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F67620855
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pkBavuLi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RuLvDdVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F67620855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 010A5179E;
	Tue, 18 Aug 2020 18:55:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 010A5179E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597769772;
	bh=Rofmd0QiMs/9k+UeK1IF5bpm3qfZbJPjgTGC8mXF5mo=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pkBavuLincekYdspq+9G2OGRuU/L6aMTkrqaS464rVN57O5lh7i7j3GyVYCcuV4hI
	 JE6ghlPgip22FT8ItAet+XBxavN/qyYlR2INgsnhlUtaJIVg8EKDm2a2rs0ov+SNgt
	 +JE/ysTgPSTDeWnYWUltxpSYCwaEaNlOG7zt2af0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB3BDF802A2;
	Tue, 18 Aug 2020 18:54:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD739F800D3; Tue, 18 Aug 2020 18:54:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14048F800D3
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 18:54:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14048F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RuLvDdVL"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 957D3207D3;
 Tue, 18 Aug 2020 16:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597769655;
 bh=Rofmd0QiMs/9k+UeK1IF5bpm3qfZbJPjgTGC8mXF5mo=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=RuLvDdVLs1Oeefo7spMC8e0Ij5aM8bFFrsLuPKzM9D5Wzsz2MvNc7mMhAsl1hALMl
 Nf11Lqt2Y3X5wb/dzEbKuj7NJExtqMZv/o18SmuzEq8vQALb9lxqvlOaffeuFza0OI
 +O2nP3ITQ9psaIqAM7xB7MSgL915CJ7g4RBtHDfM=
Date: Tue, 18 Aug 2020 17:53:44 +0100
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20200811105818.7890-1-srinivas.kandagatla@linaro.org>
References: <20200811105818.7890-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: add a dedicated menuconfig
Message-Id: <159776961932.56094.5932457968960769416.b4-ty@kernel.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 john.stultz@linaro.org, tiwai@suse.com, lgirdwood@gmail.com
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

On Tue, 11 Aug 2020 11:58:18 +0100, Srinivas Kandagatla wrote:
> Currently list of Qualcomm drivers is growing, so put them in to a
> proper menu so that it does not mix up with other ASOC configs in menuconfig.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: add a dedicated menuconfig
      commit: db24fa5756e944a711a66692af7e25a2189bfe52

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
