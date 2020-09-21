Return-Path: <SRS0=AR4N=C6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331BEC43466
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:59:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A1E20C09
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KTcWQQn6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1d9KeBWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A1E20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DB3116AD;
	Mon, 21 Sep 2020 18:58:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DB3116AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600707574;
	bh=mNJcpgufw1VRaRkLPvUMtGyZTZPcUX4LYP4cj3IjjKI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KTcWQQn61Aa6t0XCZuD9KkTR2XkT3ciMXxb5Be8F/li53I55Gla9GroZJCXVLKkC5
	 f6E9eh91gpEfXDKdLRgKam9Ek/dM/2v7v9Zh7li/cYQE6HBOCE92SE6jMKEORvZ/NU
	 ceL32Sw6js1MTIngzV+6ylSPngJEX9YuoVs0zGX4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 084EDF80162;
	Mon, 21 Sep 2020 18:58:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3EA09F80171; Mon, 21 Sep 2020 18:58:42 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF8EFF8010A
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2020 18:58:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF8EFF8010A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="1d9KeBWs"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5B6FE20C09;
 Mon, 21 Sep 2020 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600707510;
 bh=mNJcpgufw1VRaRkLPvUMtGyZTZPcUX4LYP4cj3IjjKI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=1d9KeBWs+A777+jilEp0jFpDF3jNwsyOKSGm4Kof2nOH/tWp0gDgQBanHxc4491F+
 DWUhXjF5YZLNBce83qV5zk/KT2FgypH7cKa4BsojR0yAGcruQuTeW5YrFkmH1Ds1Is
 vsnsPwrDGHuEUDxEywJKJxFSq1emK7MeelUJW0NY=
Date: Mon, 21 Sep 2020 17:57:38 +0100
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200921104544.2897112-1-kai.vehmanen@linux.intel.com>
References: <20200921104544.2897112-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: topology: fix the process being scheduled on
 core0 always
Message-Id: <160070745847.56122.6304873079726187313.b4-ty@kernel.org>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Jaska Uimonen <jaska.uimonen@intel.com>, Keyon Jie <yang.jie@linux.intel.com>,
 pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

On Mon, 21 Sep 2020 13:45:44 +0300, Kai Vehmanen wrote:
> In commit 783898ce68de ("ASoC: SOF: append extended data to
> sof_ipc_comp_process") the process components are set to run on the
> fixed core 0, this break us from scheduling components on any other DSP
> core.
> 
> Since we can get the DSP core index from swidget->core, it is duplicated
> to pass the extra 'core' argument for those sof_widget_load_xx()
> functions.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: topology: fix the process being scheduled on core0 always
      commit: 2263063fc4880d544a1eb87713f642384fe03cb7

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
