Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E14C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 22:26:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2EE20853
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 22:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="usll/uUE";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ybfuOJs9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2EE20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CDD61681;
	Thu,  2 Jul 2020 00:25:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CDD61681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593642378;
	bh=qR6b0seueX1BWelGymIepBrH7Jm0QvYZYSibZfidNYw=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=usll/uUEqF57Pcv1/kO3cauMdlPKBDFrBqKkle3a2MmsYpjikHZNNfIT/yfkRd/bS
	 GMDQ8Aqge/GlrDzW9xjfylf8GKWLCT4aZECSELq1SXEsY4QQMVL2j+yWVXJ009XJH0
	 NQpfL6ZgBMLE01HCOpuL6WCUcC0hh4cy5ynZnCQc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BA4FAF802E2;
	Thu,  2 Jul 2020 00:23:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 75339F802E3; Thu,  2 Jul 2020 00:23:02 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B2E9F802E1
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 00:22:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B2E9F802E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ybfuOJs9"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B3347207E8;
 Wed,  1 Jul 2020 22:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593642178;
 bh=qR6b0seueX1BWelGymIepBrH7Jm0QvYZYSibZfidNYw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=ybfuOJs9Vmbfe4ObII/sYSTuo+YClxTRqYIrdBxAyiM0aJd4f3dszsnJI5I2cS56c
 Io6TIbicvRPVE0epumlQ9rhyFeaw+fmO7gcxFUwM8n8nrDNpcxmYhwms3XbZeiEbPF
 OSZG1Xp5CZASNqiARSsBmmzvNZ6MkkU0192ooJp0=
Date: Wed, 01 Jul 2020 23:22:56 +0100
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, alsa-devel@alsa-project.org, tiwai@suse.com,
 Xiubo.Lee@gmail.com, timur@kernel.org, festevam@gmail.com,
 nicoleotsuka@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1593412953-10897-1-git-send-email-shengjiu.wang@nxp.com>
References: <1593412953-10897-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Refine regcache usage with pm runtime
Message-Id: <159364215573.10630.10167601683932305726.b4-ty@kernel.org>
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

On Mon, 29 Jun 2020 14:42:33 +0800, Shengjiu Wang wrote:
> When there is dedicated power domain bound with device, after probing
> the power will be disabled, then registers are not accessible in
> fsl_sai_dai_probe(), so regcache only need to be enabled in end of
> probe() and regcache_mark_dirty should be moved to pm runtime resume
> callback function.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Refine regcache usage with pm runtime
      commit: d8d702e19e997cf3f172487e0659d0e68aa5ede5

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
