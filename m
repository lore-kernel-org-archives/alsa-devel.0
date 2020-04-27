Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144EEC54FD0
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:03:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8A62064A
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 15:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="csXhbGmS";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayhIGIu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8A62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C737B1682;
	Mon, 27 Apr 2020 17:02:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C737B1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587999823;
	bh=1Mdyuy+BUWcMPG3/ptw4CkLusoUHJBQy1eqeG4yf+NM=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=csXhbGmSrQXxwz29afnebsPc/qAQZGdA7kBwEw0BbleoU2diBDlcy3pqh2pv3juiu
	 bARq75gT7LcV8wNZ7MmCu0ITzEwLnSF7kDjhw9Gd+/Lx6GrkMafDHbZQYGeK7PWH4I
	 ywHAktKq1YliAY+eOK1zjT47wKdZypsNx8JRpupc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4E381F80217;
	Mon, 27 Apr 2020 17:02:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03F91F8022B; Mon, 27 Apr 2020 17:02:51 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1650DF8010A
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 17:02:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1650DF8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ayhIGIu9"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AA2BB206B9;
 Mon, 27 Apr 2020 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587999765;
 bh=1Mdyuy+BUWcMPG3/ptw4CkLusoUHJBQy1eqeG4yf+NM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=ayhIGIu9oHKTwba7BIJOhNarh6yduLqX3eyF24TOBKrOz5ov9dLKc2QJLD1/o2zZL
 g48IK8bYFyFPltyMIAozp5VqRZAD2lHaHC2G1rVNfKuK76lRypx0ILbR4tPp2S0ri6
 0HXlnGyK48J1Y+DT1Lhc4s9E2TQgh7/9F3zQlILY=
Date: Mon, 27 Apr 2020 16:02:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Mateusz Gorski <mateusz.gorski@linux.intel.com>,
 alsa-devel@alsa-project.org
In-Reply-To: <20200427132727.24942-1-mateusz.gorski@linux.intel.com>
References: <20200427132727.24942-1-mateusz.gorski@linux.intel.com>
Subject: Re: [PATCH v6 0/3] Add support for different DMIC configurations
Message-Id: <158799976245.32503.2644976069397596987.b4-ty@kernel.org>
Cc: cezary.rojewski@intel.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com
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

On Mon, 27 Apr 2020 15:27:24 +0200, Mateusz Gorski wrote:
> Set of patches to enable DMIC capture on different hardware
> configurations.
> Information about supported DMIC configuration is read from NHLT and
> correct pipeline configuration is selected automatically.
> Also, adding additional option for topology binary name which is
> based on used machine driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/3] ASoC: Intel: Skylake: Add alternative topology binary name
      commit: 1b290ef023b3eeb4f4688b582fecb773915ef937
[2/3] ASoC: Intel: Multiple I/O PCM format support for pipe
      commit: 1b450791d517d4d6666ab9ab6d9a20c8819e3572
[3/3] ASoC: Intel: Skylake: Automatic DMIC format configuration according to information from NHLT
      commit: 2d744ecf2b98405723a2138a547e5c75009bc4e5

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
