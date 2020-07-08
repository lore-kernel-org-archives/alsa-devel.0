Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35703C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:01:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B399A2078D
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pJmW/ixv";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWCzLywa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B399A2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 170161679;
	Wed,  8 Jul 2020 19:00:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 170161679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594227673;
	bh=WJGWw2GOGxEKG1Lf2nq70geUMNdU1XULEN+/0s34JEc=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pJmW/ixvLgLXorjoVl/sE/vT7ewBzu6i4aKHDGWhI/he1sQV28sJhxYxMprROhU4Y
	 fktdtR1CXedXHBt8RHRpx2HyZKWHbtC+NLSdCBVP3XvfGELXD0TZZd8nkETJ9qL5t2
	 CYpmjHbPuUgzOZb/Qlju41vkZM0XaMRRuabkTc00=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14142F80269;
	Wed,  8 Jul 2020 19:00:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09CDFF80269; Wed,  8 Jul 2020 19:00:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A727BF80150
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 18:59:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A727BF80150
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uWCzLywa"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AAEC7206F6;
 Wed,  8 Jul 2020 16:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594227593;
 bh=WJGWw2GOGxEKG1Lf2nq70geUMNdU1XULEN+/0s34JEc=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=uWCzLywai1Y1fFKLuQ62Ss/72sGv5tZGhq0IByKjprMJs6lMCrbwPm2CZ+WN0h7Ld
 Z9ZVSfSlKBBKdVQuzMISalSV4wHS7nHBrItIx95xEZn0uXIbYyFnnY7sRMYzlEiv+j
 OhJafdLPaBppksVuee3jH8RP4kodRdrYszHoKGUM=
Date: Wed, 08 Jul 2020 17:59:48 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200707205740.114927-1-pierre-louis.bossart@linux.intel.com>
References: <20200707205740.114927-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 0/6] ASoC: codecs: add MAX98373 Soundwire driver
Message-Id: <159422758800.28431.3605238994646318402.b4-ty@kernel.org>
Cc: tiwai@suse.de
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

On Tue, 7 Jul 2020 15:57:34 -0500, Pierre-Louis Bossart wrote:
> V2 with a number of cleanups:
> split between I2C and SoundWire modes, as done for rt5682, and updated
> Kconfigs.
> removed useless initializations common to both modes
> removed idle_bias on
> fixed register classified as volatile in error
> fixed SPDX comments
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: codecs: max98373: Removed superfluous volume control from chip default
      commit: a53bacc04d7e2b813ebe0ca4dae38716c00d7953
[2/2] ASoc: codecs: max98373: remove Idle_bias_on to let codec suspend
      commit: 0fd3935ef888b7231fde87eba3fdf613c4923b4a

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
