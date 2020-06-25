Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8DEC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:13:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0C52075A
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jbUUzyqJ";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2i1pA4R0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0C52075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B18BA1944;
	Thu, 25 Jun 2020 21:13:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B18BA1944
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593112430;
	bh=tOQefQlo/4WDe+47uHGcZESDTbY90cFY/SuuWR2gmZE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jbUUzyqJ9wwVeq3G802uxlM150iEGCnvtoQuHtgDzJNMBt2ESTASHq7RZaLH92Yok
	 7PrXBrzUjOZb8WUYBILNCSHI0WXVyrRTZAldWCCQBFgrm7lOFPQZt0ktBnZ9NPLCY1
	 hoIhKAQfK53elp5lH9enFbmIteBvZtt8ixKgVGSA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C098F80249;
	Thu, 25 Jun 2020 21:12:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AF2CF80234; Thu, 25 Jun 2020 21:12:10 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68DADF80234
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 21:12:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68DADF80234
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="2i1pA4R0"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7183B2076E;
 Thu, 25 Jun 2020 19:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593112325;
 bh=tOQefQlo/4WDe+47uHGcZESDTbY90cFY/SuuWR2gmZE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=2i1pA4R0O0vpEKWtLxHOZwVCvEavX5cbf1yVu/YA6b5whxhDCGLRkLpX4DG3KwJtW
 wpXceyTXGx3NGjlr2d5C9vQWg0IMmnO5h+uENxBNLLRzpcxOv6QZ4I3KAdIptM+4cc
 rYAW78k/NlZRy6D8Nb4McnMZxRndq6xoVzItwQuI=
Date: Thu, 25 Jun 2020 20:12:02 +0100
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20200625153543.85039-1-tzungbi@google.com>
References: <20200625153543.85039-1-tzungbi@google.com>
Subject: Re: [PATCH v2 0/3] ASoC: rt1015: fix compilation errors and warnings
Message-Id: <159311231750.10637.12370136760007816881.b4-ty@kernel.org>
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

On Thu, 25 Jun 2020 23:35:40 +0800, Tzung-Bi Shih wrote:
> The series fixes compilation errors and warnings discovered in the thread
> https://patchwork.kernel.org/patch/11622319/.
> 
> The original patch:
> (1) adds acpi.h for fixing implicit declaration of function 'ACPI_PTR'
> (2) sorts header inclusions in alphabetical
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: core: move definition of enum snd_soc_bias_level
      commit: 10e834099d38dd2c02bf2bd5feaa3997cfcf139f
[2/3] ASoC: dapm: declare missing structure prototypes
      commit: 3d62ef4280a377bb2ccaee4e8f6c5093f5b8f9d4
[3/3] ASoC: rt1015: add missing header inclusion
      commit: 72ac4a4bef48e67bb26bc5a01d68c8163def013d

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
