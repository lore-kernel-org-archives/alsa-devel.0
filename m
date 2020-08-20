Return-Path: <SRS0=2rKR=B6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2E4C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:52:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5BC2075E
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 21:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JeO4peP9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqZcfU2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5BC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C14471685;
	Thu, 20 Aug 2020 23:51:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C14471685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597960347;
	bh=GEiMUPdq4Yn8Xbr6iPLvmCiQIufX+SZ8b6auUiYHqk4=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JeO4peP9ZBTGdf+6j19r+djhREwIWeI2GPDCXV613HljFj6vzqJzjaC8gUzyZQShV
	 Fv5VggdG1WOzsosv6VYTNSiicU6YRSrBDbZKlJEW0sn2B4VOlt1+RoCX9QqR3wm8B8
	 MM+8aDsYHznjE08XGfnYXXkvps2SuiW4vIbObu0E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D96DF802C4;
	Thu, 20 Aug 2020 23:49:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AAC0CF80228; Thu, 20 Aug 2020 23:48:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16DF9F800D3
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2020 23:48:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16DF9F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="oqZcfU2j"
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 [82.37.168.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2935A21734;
 Thu, 20 Aug 2020 21:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597960134;
 bh=GEiMUPdq4Yn8Xbr6iPLvmCiQIufX+SZ8b6auUiYHqk4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=oqZcfU2jqXqP0QUV2M/vVo4cRz4mA7eEc+8ew05glqrgeFC5Ozjfh+0pUHsqWD5DH
 tkbLddD/0uUKdF/u7scmaTFOL5InTpx/BhXa+nm0Ar1xF3/Hmn+6ydNHRh96FU9lNj
 +3DqmvL1u55BYTexi+GaC/m5DoBdD5TNG1jZs43E=
Date: Thu, 20 Aug 2020 22:48:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>, tiwai@suse.de
In-Reply-To: <20200819124429.3785-1-yung-chuan.liao@linux.intel.com>
References: <20200819124429.3785-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [RESEND] ASoC: SOF: Intel: add build support for SoundWire
Message-Id: <159796008815.44152.2549401443245945810.b4-ty@kernel.org>
Cc: vkoul@kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
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

On Wed, 19 Aug 2020 20:44:29 +0800, Bard Liao wrote:
> Select SoundWire capabilities on newer Intel platforms, starting with
> CannonLake/CoffeeLake/CometLake.
> 
> As done for HDaudio, the SoundWire link is an opt-in capability. We
> explicitly test for ACPI to avoid warnings on unmet dependencies on
> the SoundWire side.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: add build support for SoundWire
      commit: 82cb71d68c22137099a0d34f1ecf00aecc951d6b

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
