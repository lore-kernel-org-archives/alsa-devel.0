Return-Path: <SRS0=sGsA=BJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE68C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 22:34:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C372083B
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2020 22:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OVZNvejG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE0YmItW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C372083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C7AFA1682;
	Fri, 31 Jul 2020 00:33:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C7AFA1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596148444;
	bh=zV95HL8SiThWl99gHhMxUo7zgd/K+JP8lD48u7D8vS8=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OVZNvejG9uXk/oL/1S9ZeHyY19fqauHM/zqktywRKQhYFSowUXJf+2sa39yuqToIA
	 +91sBZG4535Sjw90wswi4BSAhyYXcMHT1bazkI0TMS63jcfe5fjMnPDtyCD+YvsBlK
	 prcZZ3VV5BJPlq6jLMIdBF7nI+3uFV/lu5c0Ow3Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F153F802FF;
	Fri, 31 Jul 2020 00:28:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47B75F80303; Fri, 31 Jul 2020 00:28:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA333F802FB
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 00:28:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA333F802FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dE0YmItW"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AEE7C20829;
 Thu, 30 Jul 2020 22:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596148115;
 bh=zV95HL8SiThWl99gHhMxUo7zgd/K+JP8lD48u7D8vS8=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=dE0YmItWDJy+dUK35JvMCpL3X4lH4YuKFqkCsFGHGxSv0cpqADgL2heblv5aJ+Zfl
 wXodFudpjtOrxrkwVzbumcPxAYUBkDROgSQYT4ypiOJsTCD5osmMJPkrnpUJEj6rzz
 Sm5UPQLR4k2YvChdRd2P59/jxvIKnJVMzLGyIHLk=
Date: Thu, 30 Jul 2020 23:28:15 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
In-Reply-To: <20200730055319.1522-1-michael.wei.hong.sit@intel.com>
References: <20200730055319.1522-1-michael.wei.hong.sit@intel.com>
Subject: Re: [PATCH 0/4] ASoC: Intel: KMB: TDM Enablement patches
Message-Id: <159614804535.1473.8423240572348836819.b4-ty@kernel.org>
Cc: cezary.rojewski@intel.com, andriy.shevchenko@intel.com,
 pierre-louis.bossart@linux.intel.com, jee.heng.sia@intel.com, tiwai@suse.com,
 liam.r.girdwood@linux.intel.com
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

On Thu, 30 Jul 2020 13:53:15 +0800, Michael Sit Wei Hong wrote:
> This patch series is to enable multiple features on the Keembay Platform
> 
> Michael Sit Wei Hong (4):
>   ASoC: Intel: KMB: Add 8kHz audio support
>   ASoC: Intel: KMB: Rework disable channel function
>   ASoC: Intel: KMB: Enable TDM audio capture
>   dt-bindings: sound: intel,keembay-i2s: Add channel-max property
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: Intel: KMB: Add 8kHz audio support
      commit: b81f8df8039e6dca8f9533fe0b549139b907e61f
[2/2] ASoC: Intel: KMB: Rework disable channel function
      commit: d13389849caf05d79141d317bdf2f6b318e65f87

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
