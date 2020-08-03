Return-Path: <SRS0=KW3j=BN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1840C433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:56:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C70A2072A
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TXWJiOot";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v2errDj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C70A2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 067C01664;
	Mon,  3 Aug 2020 17:55:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 067C01664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596470175;
	bh=Se9xPPu7Ir9plSWudvrqQcGkclizmxTeOejta7bCwjk=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TXWJiOotxSHAuRuDdQ46KMeOHJ8dhanRF2KGSdkI7PGWK7SHF9haI/VKnQH3wJsD1
	 ofq4cM4KTmfAA/g8CzMBbskRfBYTrwYtGywLM/IvNh5F2hdGALsMY/O/fU+C+Hiz5L
	 ES+5XO5Pl1QWLqcRxHtS4DcPsahcnPpBjmdkwdFI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9D8FAF800BD;
	Mon,  3 Aug 2020 17:53:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91540F802E1; Mon,  3 Aug 2020 17:53:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0679DF800BD
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2020 17:52:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0679DF800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="v2errDj2"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 10D6E2072A;
 Mon,  3 Aug 2020 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596469976;
 bh=Se9xPPu7Ir9plSWudvrqQcGkclizmxTeOejta7bCwjk=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=v2errDj24iRQDkZaKKzhWm7/+MzXtcdslguEReyIXSnaRCy8UYS5hlnwhRArLi7Je
 3fmJYmQB5JalOu9yUnR2Ea+FTNjmEd6+ZwbyGZOYga4hYUn9Q00dcn/b7BUz09TkYq
 7AO7Ty+GPYaetSvxMTZMFeBmwDYrYswUutpYJi78=
Date: Mon, 03 Aug 2020 16:52:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
In-Reply-To: <20200803115233.19034-1-festevam@gmail.com>
References: <20200803115233.19034-1-festevam@gmail.com>
Subject: Re: [PATCH] ASoC: wm8962: Do not remove ADDITIONAL_CONTROL_4 from
 readable register list
Message-Id: <159646994088.2524.9039806092640487657.b4-ty@kernel.org>
Cc: shengjiu.wang@nxp.com, ckeepax@opensource.cirrus.com,
 alsa-devel@alsa-project.org
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

On Mon, 3 Aug 2020 08:52:33 -0300, Fabio Estevam wrote:
> Removing ADDITIONAL_CONTROL_4 from the list of readable registers cause
> audio distortion.
> 
> This change was sent as a comment below the --- line when submitting
> commit 658bb297e393 ("ASoC: wm8962: Do not access WM8962_GPIO_BASE"), so
> it was not supposed to get merged.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8962: Do not remove ADDITIONAL_CONTROL_4 from readable register list
      commit: b023666e6c0165651de18cabcbb65ba14f2db153

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
