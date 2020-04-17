Return-Path: <SRS0=YLi8=6B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A0C2D0EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:57:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26073206E9
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Apr 2020 18:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rNVN/cyN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w/oKa7SX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26073206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A28915F2;
	Fri, 17 Apr 2020 20:56:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A28915F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587149818;
	bh=chjoPw0QUGIW5xQ9zvKzRGErH9x28BDTGValPKJegBs=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rNVN/cyNFk2VRwBVZSURzAybbREN/JoeZw+flFDIn8bVz01TPDIDsKxfGRFEUeEwb
	 Ht/BZ6C3yY7glYYjKDtWEkoumUICkPxXhQLBW0c/ZC25r8+0Tzv2KTNrnvmS6LaIUY
	 YNLeE0iyL8+jPWf0dJomO8U3nRaxV2YJpH9A4Uuc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E8EF8F8012E;
	Fri, 17 Apr 2020 20:56:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8074DF80245; Fri, 17 Apr 2020 20:56:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 426C7F8012E
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2020 20:56:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 426C7F8012E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="w/oKa7SX"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B18B7206E9;
 Fri, 17 Apr 2020 18:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587149760;
 bh=chjoPw0QUGIW5xQ9zvKzRGErH9x28BDTGValPKJegBs=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=w/oKa7SXrOteaMWQK1FD7GVJAENyCJqO5iqkNsNUuOFx0saAum+QS1S3qZAr7bSmR
 JjsUBuz2CYOjgbPbHGmBwKKS3k6GcmFWtPNh8NBc7A7VTYMJmWdZ3eOToy0nIkgBPb
 3TTGEot36dTzrVIAEVyNK5YJuYXmVFCkBcGQohu4=
Date: Fri, 17 Apr 2020 19:55:57 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200417172014.11760-1-pierre-louis.bossart@linux.intel.com>
References: <20200417172014.11760-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: add min/max channels for SSP on
 Baytrail/Broadwell
Message-Id: <158714975762.9428.18237000588388245061.b4-ty@kernel.org>
Cc: tiwai@suse.de, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

On Fri, 17 Apr 2020 12:20:14 -0500, Pierre-Louis Bossart wrote:
> Major regressions were detected by SOF CI on CherryTrail and Broadwell:
> 
> [   25.705750]  SSP2-Codec: ASoC: no backend playback stream
> [   27.923378]  SSP2-Codec: ASoC: no users playback at close - state
> 
> This is root-caused to the introduction of the DAI capability checks
> with snd_soc_dai_stream_valid(). Its use in soc-pcm.c makes it a
> requirement for all DAIs to report at least a non-zero min_channels
> field.
> 
> [...]

Applied, thanks!

[1/1] ASoC: SOF: Intel: add min/max channels for SSP on Baytrail/Broadwell
      commit: 8c05246c0b58cbe80580ea4be05f6d51228af8a9

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
