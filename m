Return-Path: <SRS0=wzGW=65=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C13C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 11:11:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A42C206B6
	for <alsa-devel@archiver.kernel.org>; Fri, 15 May 2020 11:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="PGXuSsYh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2OKpYtBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A42C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D1AF844;
	Fri, 15 May 2020 13:10:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D1AF844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589541081;
	bh=SLJ8q9ALaDgv+nU5BF1TbEJ2mglM/zXsGZrXaSF5RsM=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PGXuSsYhA1hGElDy5MmNEWSOl2JvCJIbPpzRRPCyc5viRZZYcalDvTTI0fyymsZ82
	 nOeFebxOekEZtVOrvJR7l+4Fy8SYKVwwSFbQSoRy/TN/4KLQs76l3wl97hn5DG2Uv+
	 iUyPJK44ISY+JAKIfA2zisntjjxitQjQ2zDIqqOA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D9E22F8022D;
	Fri, 15 May 2020 13:10:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76F72F80247; Fri, 15 May 2020 13:10:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 966D4F800B8
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2020 13:10:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 966D4F800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="2OKpYtBF"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A1FDB2074D;
 Fri, 15 May 2020 11:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589541023;
 bh=SLJ8q9ALaDgv+nU5BF1TbEJ2mglM/zXsGZrXaSF5RsM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=2OKpYtBFi78dOyoTHb5nG6B3uf262CEL31o5mUV0yWCV11KTrU1ZGh68tURsMZLib
 s9/tQAYeeTVvOU+AfihLQ5n4Sn3J7DFtrSccZWJdBPJZ0v4wqpp27+tM/KN8INudmv
 se6BD/ZE3sy5SJ/Huo2J2voX/QAxLh2z5RhsNN+s=
Date: Fri, 15 May 2020 12:10:20 +0100
From: Mark Brown <broonie@kernel.org>
To: nicoleotsuka@gmail.com, robh+dt@kernel.org, lgirdwood@gmail.com,
 tiwai@suse.com, alsa-devel@alsa-project.org, timur@kernel.org,
 Xiubo.Lee@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
 festevam@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <cover.1589537601.git.shengjiu.wang@nxp.com>
References: <cover.1589537601.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 0/2] ASoC: fsl_esai: Add support for imx8qm
Message-Id: <158954102051.28239.13020944644998998751.b4-ty@kernel.org>
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

On Fri, 15 May 2020 18:10:49 +0800, Shengjiu Wang wrote:
> Add support for imx8qm.
> 
> Shengjiu Wang (2):
>   ASoC: fsl_esai: introduce SoC specific data
>   ASoC: fsl_esai: Add new compatible string for imx8qm
> 
> Changes in v2
> - drop the 0002 patch in v1, the dma relate limitation should
>   be done in dma driver, or define a new DMA API for it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/2] ASoC: fsl_esai: introduce SoC specific data
      commit: 6878e75204e1d0420fd8130bad33f88053ba44de
[2/2] ASoC: fsl_esai: Add new compatible string for imx8qm
      commit: d59628b310a77e616ce2e5857e6ede5bf96c6784

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
