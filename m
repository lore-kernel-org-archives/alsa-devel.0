Return-Path: <SRS0=qQ1O=7L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFF5C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 16:52:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F5F120C09
	for <alsa-devel@archiver.kernel.org>; Fri, 29 May 2020 16:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jrkzi7uL";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZMc6Lru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5F120C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8EA32175A;
	Fri, 29 May 2020 18:51:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8EA32175A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590771120;
	bh=k/KbgaxAuU8Kzg+I9jX7eOI5MVtZSeTZ5oe2BAObqgo=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jrkzi7uLU4ss1a2tYYNPxl0y8dES5tgewLb+6UzpyRKBHcRdY4OY6kGIgIb0CBVgk
	 vMJ//qhwc+H1vZnti1qSgv0KP+PJG/jzvOYUeJBOX5UaRqrElVCcDcyh4Tt5/tCvdR
	 tjAuEF8EiqRx8J++NqU62Pk5rVhvSFp/1H2OKzGg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3564F8014E;
	Fri, 29 May 2020 18:51:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 12729F8014E; Fri, 29 May 2020 18:51:02 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C47BF80125
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2020 18:50:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C47BF80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SZMc6Lru"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 756E22075A;
 Fri, 29 May 2020 16:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590771055;
 bh=k/KbgaxAuU8Kzg+I9jX7eOI5MVtZSeTZ5oe2BAObqgo=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=SZMc6LruxJm2MXb9LAMfDf/xgZZYY7vD7017UM8f/ed0rCUbdyBqaCGMAuP+zzdwN
 Jv7fKd7oGMFkuUNT20EHf9tuRwZwmfb64bxCPMVXNN5uKMih2mIsuYkZ4Pgi6JbNoa
 FHVSTDkurtd4ovvP8+2HeIdRSOq/UZYyV5SzVVBA=
Date: Fri, 29 May 2020 17:50:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20200529123613.13447-1-pierre-louis.bossart@linux.intel.com>
References: <20200529123613.13447-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: reduce verbosity of error messages for sof-dai
 and sof-link
Message-Id: <159077105220.28617.1538116256300660047.b4-ty@kernel.org>
Cc: tiwai@suse.de, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

On Fri, 29 May 2020 07:36:13 -0500, Pierre-Louis Bossart wrote:
> Recent changes result in multiple dmesg traces such as:
> 
> [ 14.410435] Audio Port: ASoC: error at snd_soc_link_startup on Audio
> Port: 1
> 
> [ 14.410446] sst-mfld-platform sst-mfld-platform: ASoC: error at
> snd_soc_dai_startup on media-cpu-dai: 1
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: reduce verbosity of error messages for sof-dai and sof-link
      commit: 28ff437a44fa618a14bc7402c7472b278af4c9eb

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
