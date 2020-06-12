Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0750FC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:00:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874DE206A4
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Swaep+8X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9ioPCMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874DE206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FB431670;
	Fri, 12 Jun 2020 15:59:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FB431670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591970401;
	bh=7lLROIKj308gj2dNhR1qP0gVcCU/EHvwMTDRiLNOYnI=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Swaep+8XJPZGIYKzArSHQW6L0/5w55EGLCSfO7MBYCHdjiWPHI1KUDF7J5W1HZpWF
	 ICYRy810Klgn+XBU3CSFOFimzw6KRYQgfMSmLeAZqXeQs5S5IxzQ5jmtECAPsGyzOR
	 KhHc5ttAtWCXh92GLbLaFdoxoPAE9rXCdszaTfLo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 931B3F801F7;
	Fri, 12 Jun 2020 15:59:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 836DFF80058; Fri, 12 Jun 2020 15:59:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D87A4F80058
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 15:59:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D87A4F80058
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Z9ioPCMu"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B6AA9206A4;
 Fri, 12 Jun 2020 13:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591970343;
 bh=7lLROIKj308gj2dNhR1qP0gVcCU/EHvwMTDRiLNOYnI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Z9ioPCMuDYl8KiWosYw3x0x+Vd03QskUIPH0bfkOcra/fTIx585gVcevB/XFbO9/H
 c9zURyT4/PlsW9+HY39b2xaPbA7BXwGWsd+BaoScDLcyVhqGtdhEgo2uOm9XDO9XaX
 7A2xgcZPQwYdp9m0/Ban4Q9tL1YmtesLKFgpIZ4o=
Date: Fri, 12 Jun 2020 14:59:01 +0100
From: Mark Brown <broonie@kernel.org>
To: nicoleotsuka@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
 timur@kernel.org, tiwai@suse.com, festevam@gmail.com, lars@metafoo.de,
 Xiubo.Lee@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 perex@perex.cz, lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1591947428.git.shengjiu.wang@nxp.com>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
Subject: Re: [RFC PATCH v3 0/4] Reuse the dma channel if available in Back-End
Message-Id: <159197034097.50978.12090792972224185067.b4-ty@kernel.org>
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

On Fri, 12 Jun 2020 15:37:47 +0800, Shengjiu Wang wrote:
> Reuse the dma channel if available in Back-End
> 
> Shengjiu Wang (4):
>   ASoC: soc-card: export snd_soc_lookup_component_nolocked
>   ASoC: dmaengine_pcm: export soc_component_to_pcm
>   ASoC: fsl_asrc_dma: Reuse the dma channel if available in Back-End
>   ASoC: fsl_asrc_dma: Fix data copying speed issue with EDMA
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: soc-card: export snd_soc_lookup_component_nolocked
      commit: 6fbea6b6a838f9aa941fe53a3637fd8d8aab1eba
[2/4] ASoC: dmaengine_pcm: export soc_component_to_pcm
      commit: a9a21e1eafc94b79502cab8272b392f7f63ef7bb
[3/4] ASoC: fsl_asrc_dma: Reuse the dma channel if available in Back-End
      commit: 706e2c8811585f42612b6cff218ab3adbe63a4ee
[4/4] ASoC: fsl_asrc_dma: Fix data copying speed issue with EDMA
      commit: b287a6d9723c601dd947f1c27d4cc0192e384a5a

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
