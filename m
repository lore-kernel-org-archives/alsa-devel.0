Return-Path: <SRS0=e91y=7R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2489C433DF
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:06:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7D220772
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ViteCgje";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeFc3hPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7D220772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0357B1658;
	Thu,  4 Jun 2020 16:05:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0357B1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591279577;
	bh=yoZ+4NGxMSMul3HfyneR0IDhwul9qnZTStsDEn2Zgu4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ViteCgjeF8B++Uh0nU6aG7CLyA4vp6ZaZR42qGjJhM7QHbxEZUGGkwFOA5hYqONS9
	 ddNCAtUSW90gkzLIXoz+T0f5D4oFtgvmXJ2pS6L5aMPPKwsfnjOusTMNj1ldBExACQ
	 T2qVvUp5SS5pNx8SFOr0On9lOygXQIwVGBianBqA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B1ECF8013C;
	Thu,  4 Jun 2020 16:05:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4F92F80254; Thu,  4 Jun 2020 16:05:22 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00588F800BC
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2020 16:05:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00588F800BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="oeFc3hPL"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2478D2063A;
 Thu,  4 Jun 2020 14:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591279516;
 bh=yoZ+4NGxMSMul3HfyneR0IDhwul9qnZTStsDEn2Zgu4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=oeFc3hPLn/eJQ8jT52aunzJxLu4etI3QaAS0voXxIyWb+xCQUXFs6CYPnG7kZSz4Z
 W02MtBf5aUl1PlWgDlyRlA8VcIuklXBwBcu1xxB/A88NyMLvcvI+DXZTmdPNF/jxy6
 d/80c9Z2fGRqsih7m2/4sskqDpGkrXcAosf72Ip4=
Date: Thu, 04 Jun 2020 15:05:14 +0100
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, timur@kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <1591251930-4111-1-git-send-email-shengjiu.wang@nxp.com>
References: <1591251930-4111-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Defer probe when fail to find codec
 device
Message-Id: <159127951451.54171.5112369332405594522.b4-ty@kernel.org>
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

On Thu, 4 Jun 2020 14:25:30 +0800, Shengjiu Wang wrote:
> Defer probe when fail to find codec device, because the codec
> device maybe probed later than machine driver.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl-asoc-card: Defer probe when fail to find codec device
      commit: e396dec46c5600d426b2ca8a01a877928b50d1d9

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
