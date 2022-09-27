Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10B9C6FA90
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Sep 2022 10:35:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 184A03E8;
	Tue, 27 Sep 2022 12:34:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 184A03E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664274913;
	bh=dxrNytRFV6EqbpGuOkh5hlMremNyjN6dwpaC+XQ0mQQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VU8YFGDkz6sARnOaylMZ0s+TvsoqPKSudT+6I8fOqBAsLKWaSF8dg721XlC0fd21w
	 ga+OvDyrmuFxr8iyKiBndB/cptIr0HcTEB5l3eR7lnWjG5pdSrQuN2wnq2+iQxQ9dG
	 eoX8hZcQ+U6IfbI8zkGCkOwrzl8iQGSXlwPhH0co=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C2A0F8011C;
	Tue, 27 Sep 2022 12:34:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24020F80496; Tue, 27 Sep 2022 12:34:21 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CBC77F80166
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 12:34:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CBC77F80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SsxHWDtr"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4EAA9B80AFF;
 Tue, 27 Sep 2022 10:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0110DC433C1;
 Tue, 27 Sep 2022 10:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664274856;
 bh=dxrNytRFV6EqbpGuOkh5hlMremNyjN6dwpaC+XQ0mQQ=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=SsxHWDtrfZKFBNax/LzCTWTpAWdB4fBFygE4AU4XASGMePNmj2WdNTn1RmvPzsxxA
 fWYO6Li1Ym+pgZeNsXpaYmt5sThyR2i+CfPq/2yfGyAgtkUNJAU8Xw2JJd5O3jBr/K
 dwXQg1F5yUyk1A9cAg/OTAgtovV3fflwe0e/EJvKeEOCHV/qRddfmvqQXm+M5nRC7e
 FT289dCH3rjJbyxyrLFvDsLgSKPVmEiCtES5p8w51z3eKElmYwzdI84hxy2XmuwWOx
 Nbr+eT1a0LqEzywGZ9+mY5LsLEllqtia4PVsMAcaxRdNZKcHrA1jRLmxFl27wB+qx2
 tUXJvR02e+Dfw==
From: Mark Brown <broonie@kernel.org>
To: Zhang Qilong <zhangqilong3@huawei.com>, lgirdwood@gmail.com, tiwai@suse.com,
 perex@perex.cz
In-Reply-To: <20220922145846.114312-1-zhangqilong3@huawei.com>
References: <20220922145846.114312-1-zhangqilong3@huawei.com>
Subject: Re: [PATCH -next] ASoC: soc-component: using
 pm_runtime_resume_and_get instead of pm_runtime_get_sync
Message-Id: <166427485472.60697.6028231863825833908.b4-ty@kernel.org>
Date: Tue, 27 Sep 2022 11:34:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: alsa-devel@alsa-project.org
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

On Thu, 22 Sep 2022 22:58:46 +0800, Zhang Qilong wrote:
> Using the newest pm_runtime_resume_and_get is more appropriate
> for simplifing code here.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-component: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 08fc2a7448afc1660ec2f1b5c437fcd14155a7ee

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
