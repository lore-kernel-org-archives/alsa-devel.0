Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A7BC433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 00:58:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E5E20771
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 00:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h2y/rYtP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMP8D02V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E5E20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC0CC1673;
	Wed, 22 Jul 2020 02:57:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC0CC1673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595379529;
	bh=LI9NjXKtPYnT9ESNFxpH/NeSTaxYRhwryItg9StDoQM=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h2y/rYtP5OYFSTSUSwupK/2U1EG12Rj7n5M5iDcUMmtfWTMxl2mJk2JNbbMCEiaA6
	 EE4hbNYEm0UCZFe44D/a0YaLqScizRhvtjDE6K3mfxTH/44k/pqT4LiNthWCLqhcHk
	 2MO60sAOYe3xLUKxHskH6timIPTR67yddr6kOnkk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21A7BF80274;
	Wed, 22 Jul 2020 02:57:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 765FAF80117; Wed, 22 Jul 2020 02:57:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CFD19F80117
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 02:57:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFD19F80117
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nMP8D02V"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0629C20771;
 Wed, 22 Jul 2020 00:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595379422;
 bh=LI9NjXKtPYnT9ESNFxpH/NeSTaxYRhwryItg9StDoQM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=nMP8D02Vmf1m1HLB/JTz7Mh1RIoyd8sZIAWdzNw80tVsutGXKcTRWktWgprOXArFi
 55JU7Lqzmu4TeMVZ4IxRg8gkdLk9T/f1GNMvbXPQd5Cl2X3CGX+7QjxoT3OvUqXAi2
 2X+0QyJdFGymAGzXxa/mKYTwddUSFXNngfkX1R2s=
Date: Wed, 22 Jul 2020 01:56:49 +0100
From: Mark Brown <broonie@kernel.org>
To: kuninori.morimoto.gx@renesas.com, tiwai@suse.com, robh+dt@kernel.org,
 perex@perex.cz, Sameer Pujar <spujar@nvidia.com>, lgirdwood@gmail.com
In-Reply-To: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
References: <1595134890-16470-1-git-send-email-spujar@nvidia.com>
Subject: Re: [PATCH v5 00/11] Add ASoC AHUB components for Tegra210 and later
Message-Id: <159537940424.49432.12585025490958205269.b4-ty@kernel.org>
Cc: viswanathl@nvidia.com, alsa-devel@alsa-project.org, swarren@nvidia.com,
 nwartikar@nvidia.com, atalambedu@nvidia.com, linux-kernel@vger.kernel.org,
 nicoleotsuka@gmail.com, linux-tegra@vger.kernel.org, thierry.reding@gmail.com,
 sharadg@nvidia.com, digetx@gmail.com, jonathanh@nvidia.com,
 rlokhande@nvidia.com, mkumard@nvidia.com, dramesh@nvidia.com
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

On Sun, 19 Jul 2020 10:31:19 +0530, Sameer Pujar wrote:
> Overview
> ========
> Audio Processing Engine (APE) comprises of Audio DMA (ADMA) and Audio
> Hub (AHUB) unit. AHUB is a collection of hardware accelerators for audio
> pre-processing and post-processing. It also includes a programmable full
> crossbar for routing audio data across these accelerators.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: Add Tegra210 based ADMAIF driver
      commit: f74028e159bb8e1de840d945af344bf93b59ada2

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
