Return-Path: <SRS0=vWr5=BC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F7DC433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:24:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3D62065F
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NPeLo1H2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj9Kudv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3D62065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 550A51698;
	Thu, 23 Jul 2020 22:23:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 550A51698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595535847;
	bh=m9fN9R0RLf9EORdUqrD39Ga3LCQrNVMins4vQKdmgkY=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NPeLo1H2Y1muZXJnvOVx3h8AYQOdfTNfDt8kTwWSMR/Y0kvxS4+a/WrZsFl72UPcW
	 IaHDuXH8vDwQENj70/tLmzeCte0/N9FptfiEC+fp1hfocLwYu6zbRuMa7fVg69674Z
	 75GyWotPOQM4evvQidYVEVCMyELX9/huCw7qi5ec=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF08AF802E8;
	Thu, 23 Jul 2020 22:20:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3C62BF802E9; Thu, 23 Jul 2020 22:20:18 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E11C6F802E2
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 22:20:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E11C6F802E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Qj9Kudv4"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DEAF12065F;
 Thu, 23 Jul 2020 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595535614;
 bh=m9fN9R0RLf9EORdUqrD39Ga3LCQrNVMins4vQKdmgkY=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Qj9Kudv4h9bucJglhlPdbHIU7UvfhGkLfQcS+L02jHfVyGKoUvpucoKbGN9RmmFiX
 PHcid1k8dmgQdun0E+mvOz2ViY0iel/N2rio1oIfSiBlSkM5n+pQx2f8uQMD/dkG/G
 gkwjjg1IuWmdeKf0NdnlqV+1SFc1Z59yJxbfscbY=
Date: Thu, 23 Jul 2020 21:19:59 +0100
From: Mark Brown <broonie@kernel.org>
To: perex@perex.cz, nicoleotsuka@gmail.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, festevam@gmail.com, Xiubo.Lee@gmail.com,
 devicetree@vger.kernel.org, tiwai@suse.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, timur@kernel.org, robh+dt@kernel.org
In-Reply-To: <1595302910-19688-1-git-send-email-shengjiu.wang@nxp.com>
References: <1595302910-19688-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: fsl-asoc-card: Support configuring dai fmt from
 DT
Message-Id: <159553557415.41908.10792905322230723477.b4-ty@kernel.org>
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

On Tue, 21 Jul 2020 11:41:49 +0800, Shengjiu Wang wrote:
> Support same propeties as simple card for configuring fmt
> from DT.
> In order to make this change compatible with old DT, these
> properties are optional.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl-asoc-card: Support configuring dai fmt from DT
      commit: 08b54b5e38e67b7e99f71b35cb8841b53e006759
[2/2] ASoC: bindings: fsl-asoc-card: Support properties for configuring dai fmt
      commit: ca168352cf94bbbc523794f2a2972adcf84d8639

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
