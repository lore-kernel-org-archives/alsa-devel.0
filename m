Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4084C433E5
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:47:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBA42065D
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sHdE2F94";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aj7wifMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBA42065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C51BC1664;
	Wed, 22 Jul 2020 15:46:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C51BC1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595425645;
	bh=pVSFwe9WAZVAYOyGMf4RoJKSgLIxFtnJSZePlHiqGrc=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sHdE2F94ysp/4ys3VqeJvdhDpPo09xwTl6f9RSezgSUuA7dljSgCZiEhIphnoAjIF
	 u9sazZkyRwKz4nrK/1CIxPEfN8ZGDDOvHXdrOaAtObEXV5pFHixqDENBJP3C36lb5v
	 vMGC+gor+w68BkgRQDqEIlrZpyBSqu894Do2bsG8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 968B7F8028C;
	Wed, 22 Jul 2020 15:45:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD035F80290; Wed, 22 Jul 2020 15:45:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83D6AF80161
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 15:44:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83D6AF80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="aj7wifMJ"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 68C3F20729;
 Wed, 22 Jul 2020 13:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595425497;
 bh=pVSFwe9WAZVAYOyGMf4RoJKSgLIxFtnJSZePlHiqGrc=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=aj7wifMJfNbiBNwUUX2VmkAaWR0SwxE8gSVwzMPBjgS5ZE4GhOYPkj9XdYQb458W4
 ODeEz2ALjG7X0k65ysMGcjDZLAQLG6ZABxg5JxU8MYfDcIN6crzhCU68m9wgXhqJ/T
 02VWjAHj/4iK9Hx8i+f5FtUjURcJxAH8Nxe6AC8g=
Date: Wed, 22 Jul 2020 14:44:44 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20200720072046.8152-1-daniel.baluta@oss.nxp.com>
References: <20200720072046.8152-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 0/7] SOF IMX fixes
Message-Id: <159542547441.19620.1737685462805157717.b4-ty@kernel.org>
Cc: shengjiu.wang@nxp.com, festevam@gmail.com, linux-kernel@vger.kernel.org,
 linux-imx@nxp.com
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

On Mon, 20 Jul 2020 10:20:39 +0300, Daniel Baluta wrote:
> This patchseries contains a couple of SOF IMX fixes
> found during our first IMX SOF release.
> 
> Daniel Baluta (7):
>   ASoC: SOF: define INFO_ flags in dsp_ops for imx8
>   ASoC: SOF: imx: Use ARRAY_SIZE instead of hardcoded value
>   ASoC: SOF: imx8: Fix ESAI DAI driver name for i.MX8/iMX8X
>   ASoC: SOF: imx8m: Fix SAI DAI driver for i.MX8M
>   ASoC: SOF: imx8: Add SAI dai driver for i.MX/i.MX8X
>   ASoC: SOF: topology: Update SAI config bclk/fsync rate
>   ASoC: SOF: pcm: Update rate/channels for SAI/ESAI DAIs
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: SOF: define INFO_ flags in dsp_ops for imx8
      commit: 45b7262174dcc2ca62e23220219eee1462dcada9
[2/7] ASoC: SOF: imx: Use ARRAY_SIZE instead of hardcoded value
      commit: beaa7bd10dce348b033aff3f466ab1a78b33fed3
[3/7] ASoC: SOF: imx8: Fix ESAI DAI driver name for i.MX8/iMX8X
      commit: bcba2c9d62f391cd2cd6acb7f658d47bfb10e8b9
[4/7] ASoC: SOF: imx8m: Fix SAI DAI driver for i.MX8M
      commit: f23a8e9402f899e3555ac8aff3d3d050adafe39e
[5/7] ASoC: SOF: imx8: Add SAI dai driver for i.MX/i.MX8X
      commit: 68f56f618c3fbc4b1af0428f715f952cdada7a54
[6/7] ASoC: SOF: topology: Update SAI config bclk/fsync rate
      commit: 72bb9564fd97cd4f6dec88c8363acc3ab642673f
[7/7] ASoC: SOF: pcm: Update rate/channels for SAI/ESAI DAIs
      commit: 51b0243aefaa554ca57817562da8eb269280d4ae

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
