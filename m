Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9B1C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:33:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48C221548
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kzeSfBHQ";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKf6Z44y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48C221548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 203C11688;
	Wed, 17 Jun 2020 15:32:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 203C11688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592400811;
	bh=h59fElqc1jeHbztqEARrRAX1SSJF4qJsEPNo7Yvqo98=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kzeSfBHQ7C2Z1m8jTMZXYNFw3kkFuKSIo9r3kN+Pt5ZoVbPHBtXDV0hvdF1arBVJM
	 RucmL1a6eKng1tbvUIrUlwsRXm9mGN2cpioSjwI+hbb/lg5a4zITb1IWiCFlgGrAxo
	 rbSy3GcAuSiZVq9lhvwAbMa1WVQkdwxretngrrSg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84353F802A7;
	Wed, 17 Jun 2020 15:31:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02294F802A1; Wed, 17 Jun 2020 15:30:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CCF0F801D9
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 15:30:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CCF0F801D9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uKf6Z44y"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id EC9EC20853;
 Wed, 17 Jun 2020 13:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592400650;
 bh=h59fElqc1jeHbztqEARrRAX1SSJF4qJsEPNo7Yvqo98=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=uKf6Z44ycUVkHYFYbemkXBrdIXw4kYDV891C4aMKMaQ2t5lkj7DlMSa0f2vTf2Fgw
 3mFUoCan86WrGy/RdL2X3EAEGH0d4VEWY6kgNW1X/89XRRHzUelHuw1mWAiRlYzp0Z
 1T2SCvXo4ky6/MK4Cfmom25jgL/sVjzWatyCuNi4=
Date: Wed, 17 Jun 2020 14:30:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, robh+dt@kernel.org, tiwai@suse.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, devicetree@vger.kernel.org,
 festevam@gmail.com, timur@kernel.org, perex@perex.cz
In-Reply-To: <2185a3ec866bc59f82d93b73d1a732a896fd8f48.1592369271.git.shengjiu.wang@nxp.com>
References: <2185a3ec866bc59f82d93b73d1a732a896fd8f48.1592369271.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 1/2] ASoC: bindings: fsl-asoc-card: Add compatible
 string for MQS
Message-Id: <159240063808.19287.9726215695470911719.b4-ty@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Wed, 17 Jun 2020 12:48:24 +0800, Shengjiu Wang wrote:
> Add compatible string "fsl,imx-audio-mqs" for MQS, and move
> "audio-routing" property to be optional for MQS doesn't need
> such property.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: bindings: fsl-asoc-card: Add compatible string for MQS
      commit: 56d6663d41f982542097775a3a8a6a1b867fe608
[2/2] ASoC: fsl-asoc-card: Add MQS support
      commit: 039652a5b965404aee1fa8f61017f822668f41d4

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
