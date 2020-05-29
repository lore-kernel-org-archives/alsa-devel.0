Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457C6C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 19:05:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB13C207D4
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 19:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Knzd8tRu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="loTPW2Wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB13C207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17608176A;
	Fri, 29 May 2020 21:04:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17608176A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590779140;
	bh=oCLmuSFOYKgFT6nDA7OcDA0Y9yeomZLxOtkTEkoHh1s=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Knzd8tRuew3szVVwhiWNIM2f90aAdVlyoqi8lkWUfP2q2XfwFv0Scc5EaPIamyPMp
	 jHHowOORoHLFaLJBt9NT5RPKo/fXUr5fIgDJpxjlcBcR/WwyOpaSVM77gtZDbvwmX9
	 uaEgDZQNYZSGiCtjI/sR5WUBlhJ1Cw8MaWAsTYyQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 652BFF80107;
	Fri, 29 May 2020 21:04:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E2429F80107; Fri, 29 May 2020 21:04:47 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F37DF80107
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2020 21:04:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F37DF80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="loTPW2Wd"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 905A92077D;
 Fri, 29 May 2020 19:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590779082;
 bh=oCLmuSFOYKgFT6nDA7OcDA0Y9yeomZLxOtkTEkoHh1s=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=loTPW2WdPd7Ynta7qQoa9HqeHBeQ8tad0m2Un6fXeRc4t2bCOfDWg8ztibQzH8umr
 24JhrkJPQ2LRzL+n3MZOOBbAzbnkR6tExA8+eAdFj83TWogKXbciWc/8P+NVadI8VL
 TEnDk8EkAjRPDZlHiWJT8x43gRarT/iwzux1ukNg=
Date: Fri, 29 May 2020 20:04:39 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>
In-Reply-To: <20200529160358.12134-1-kai.vehmanen@linux.intel.com>
References: <20200529160358.12134-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: hda: fix generic hda codec support
Message-Id: <159077907947.45368.11792432375349674.b4-ty@kernel.org>
Cc: Hui Wang <hui.wang@canonical.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 daniel.baluta@nxp.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

On Fri, 29 May 2020 19:03:58 +0300, Kai Vehmanen wrote:
> Add support for using generic codec driver with SOF. Generic driver
> is used if:
>  - snd_sof_intel_hda_common.hda_model="generic" is set, or
>  - fallback if no other codec driver is found
> 
> The implementation is aligned with snd-hda-intel driver, and fixes audio
> support for systems like Acer Swift 3 SF314-57G, on which this issue was
> originally reported.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: hda: fix generic hda codec support
      commit: 89d73ccab20a684d8446cea4d8ac6a2608c8d390

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
