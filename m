Return-Path: <SRS0=bSXK=AE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE87C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:42:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B61A20738
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pL1bkWGl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkQJx3Do"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B61A20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3CDF17E8;
	Tue, 23 Jun 2020 14:41:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3CDF17E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592916158;
	bh=V4CYw5A9wOH8JAZwZiQucKjp4FHIDURRUQ6BozzfRFw=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pL1bkWGl8YWGfx/pz/VxVyd6kk4WkjONl2HTSgCK3cw17EwXlfNM0GvysVSRWTiCh
	 xTthBsflNsNilMHhiW/fgGEhPCo2iyZI7EwxQ7RSpDhRhf8J7OHd1Dkpl3YUDEsbcq
	 78is/Zg1Zs9YlCql5a93bKFPTRklD9Jyeqgu3/rQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DA86AF802BE;
	Tue, 23 Jun 2020 14:39:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A441F802C2; Tue, 23 Jun 2020 14:39:32 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 888CBF802BD
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2020 14:39:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 888CBF802BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OkQJx3Do"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 399E520738;
 Tue, 23 Jun 2020 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592915966;
 bh=V4CYw5A9wOH8JAZwZiQucKjp4FHIDURRUQ6BozzfRFw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=OkQJx3Do4CsxQcOavWIULwLzvYTO5qSV8wgntrMSeqgmkbtyDNjhXd59d/jKEexJk
 O+Z/zDEd2AQHDMdRIHZOx2EFM68gDYIoUtqAl1o6jRM/Zz3TvW3cz2ilTUZrwAxpr7
 9glIhYdtafnadX7xexMJ3nQtXPkS6Jnit16bFqIA=
Date: Tue, 23 Jun 2020 13:39:24 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200622154241.29053-1-pierre-louis.bossart@linux.intel.com>
References: <20200622154241.29053-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/5] ASoC: add dailink .exit() callback
Message-Id: <159291594453.44561.7556325943085132251.b4-ty@kernel.org>
Cc: tiwai@suse.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

On Mon, 22 Jun 2020 10:42:36 -0500, Pierre-Louis Bossart wrote:
> While looking at reboot issues and module load/unload tests, I found
> out some resources allocated in the dailink .init() callback are not
> properly released - there is no existing mechanism in the soc-core to
> do so.
> 
> The addition of a dailink .exit() callback seems to be the simplest
> solution overall. It can be argued that the existing machine platform
> device .remove() callback can also perform the necessary cleanups,
> however as shown in the last two examples this might require a loop to
> identify components whereas the dailink .exit() already has all the
> necessary information to revert the actions done in the .init() step.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: soc-link: introduce exit() callback
      commit: 21a00fb33790f828a34b9ce50ab9f9130bc1ffb4
[2/5] ASoC: Intel: bdw-rt5677: fix module load/unload issues
      commit: bcb43fdae1c0d08b772b792cf46f323ad0d17968
[3/5] ASoC: Intel: kbl-rt5660: use .exit() dailink callback to release gpiod
      commit: e56054e75325c347f09c1be2f6400ef67bb9662d
[4/5] ASoC: intel: sof_rt5682: move disabling jack to dai link's exit()
      commit: b0c96fc1ab2947e331f817cecc5ca733eaf5619b
[5/5] ASoC: intel: cml_rt1011_rt5682: disable jack in dailink .exit()
      commit: 4fcc922cb31179f9bc1e99cd707f2b36138fbcf8

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
