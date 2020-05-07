Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63484C38A2A
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 11:52:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E242820735
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 11:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qIODq+7l";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1RFNlgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E242820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32C9A17CB;
	Thu,  7 May 2020 13:51:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32C9A17CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588852369;
	bh=aQfoRTL+03GAIlVMFqFOQVntNI2o67UPHaZ7kUx0kjY=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qIODq+7lH6qQi/qVlwuY0yvqFmOmPeJ1aNUN9HevHabRS0wpw7H+jn3fdIjNuoodm
	 DX8AvQaH5awnOGFv1jmQ0foNWg1MVSHxcIDmOB/Wxz9MwiaZ2IAwLqc29dNhxdnxn2
	 FSI/I06/sDIOgaoygnbvgQZBDDjXmpoG+VGCqdwM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0DAEF800F6;
	Thu,  7 May 2020 13:51:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6C3BF8015F; Thu,  7 May 2020 13:51:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 433EAF8011C
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2020 13:51:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 433EAF8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="d1RFNlgC"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id BE78820735;
 Thu,  7 May 2020 11:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588852304;
 bh=aQfoRTL+03GAIlVMFqFOQVntNI2o67UPHaZ7kUx0kjY=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=d1RFNlgC50Hge2FiWLjq+y65XWKt40zVW/xNbbBYlAPcguCUdS+P9qSRAAW7QpSkj
 nz5pWbMZGNOXsORPhkS8z+ER6zySlV3p5d2R5CnroD9uBHid9O+C1GDpPWT9JX4HJp
 vfTxzQDs1Lf5tNF9nJQO9NPa4xgto6jzuh4/uCoI=
Date: Thu, 07 May 2020 12:51:41 +0100
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20200507015442.191336-1-tzungbi@google.com>
References: <20200507015442.191336-1-tzungbi@google.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8183: fix error handling of
 platform_get_irq()
Message-Id: <158885230163.13599.13759878447141400028.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org
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

On Thu, 7 May 2020 09:54:42 +0800, Tzung-Bi Shih wrote:
> platform_get_irq() returns negative value on error instead of 0.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
>  sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: mediatek: mt8183: fix error handling of platform_get_irq()
      commit: fe944625194515e99fcbfb0d190d50986e2b6480

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
