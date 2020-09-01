Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DED8C433E7
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:03:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45CA2078B
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dlk6OUVU";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohBjwVWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45CA2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 138F217DB;
	Tue,  1 Sep 2020 18:02:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 138F217DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598976222;
	bh=EohlkPrTmZYziZCW44UpLRtyArYsiF02rQBDE48FNz4=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dlk6OUVUuA1wpK3qEvahApZqn+441T9MorXH0uYtSQsxSc7bvtu4Fv//Cv3jHicky
	 RJFl0ADoxLWpftTNrjeaBwN3qQAdaoNDtk1sa7337ZtREP9MSk0r8SQoWl/Y+MgIAy
	 4AlcwwZcsjUpo1JEmHuYZfmEGd5KVC0SNUWTv5Ho=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CEAEF8020D;
	Tue,  1 Sep 2020 18:02:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 750D5F80217; Tue,  1 Sep 2020 18:02:41 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D963F800BA
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 18:02:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D963F800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ohBjwVWd"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C6069206A5;
 Tue,  1 Sep 2020 16:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598976145;
 bh=EohlkPrTmZYziZCW44UpLRtyArYsiF02rQBDE48FNz4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=ohBjwVWdIas8DC3ImS2me8k+ox8p57Ll4Dr1QR8FesqujVMRyu//5nnfePjfthuE0
 t0AkSCHjFnPcws4YE/oN8JALblTYARJIMOHJLJ4tR04MaG5WKQdDA2RCmo85u+aQn7
 5jZTYiRs4sSDnSo8ClliP9chK2DVGX1iC6aQKXyU=
Date: Tue, 01 Sep 2020 17:01:45 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20200901153041.14771-1-cezary.rojewski@intel.com>
References: <20200901153041.14771-1-cezary.rojewski@intel.com>
Subject: Re: [PATCH] Revert "ASoC: Intel: haswell: Power transition refactor"
Message-Id: <159897610552.55058.10979702357094392907.b4-ty@kernel.org>
Cc: pierre-louis.bossart@linux.intel.com, tiwai@suse.com
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

On Tue, 1 Sep 2020 17:30:41 +0200, Cezary Rojewski wrote:
> This reverts commit 8ec7d6043263ecf250b9b7c0dd8ade899487538a.
> 
> While addressing existing power-cycle limitations for
> sound/soc/intel/haswell solution, change brings regression for standard
> audio userspace flows e.g.: when using PulseAudio.
> 
> Occasional sound-card initialization fail is still better than
> pernament audio distortions, so revert the change.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: haswell: Fix power transition refactor
      commit: 154549558a622b31702fcaa01ccd85e6e34073de

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
