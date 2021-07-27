Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA6C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 15:48:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEBD261B66
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 15:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEBD261B66
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A48B1F29;
	Tue, 27 Jul 2021 17:47:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A48B1F29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627400921;
	bh=C91IOFLpn/xlTe/YVqK/AkLDbvPKJZILi/jlymQD7Mw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UFnjdyHvSqtTQ6QyyrZMjUV83v+NzGfurnSG6JLReOTtHLORMNGXtuONgf6bog4lt
	 p54VUUJTNq5MBcPI0PgveRxTQsdYbJ6jnplIroNK4/ys2HE5K1P8KHRBRSqUtKgZ2A
	 DcR2Zm+y3QtwPNEJl9PRoprP9UiYrvjs3LNbGdNg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CAABBF804E3;
	Tue, 27 Jul 2021 17:47:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3999F804E5; Tue, 27 Jul 2021 17:47:17 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 06294F804E2
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 17:47:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06294F804E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pZ66KAPY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1242761B66;
 Tue, 27 Jul 2021 15:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627400824;
 bh=C91IOFLpn/xlTe/YVqK/AkLDbvPKJZILi/jlymQD7Mw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pZ66KAPYPX8myWetK+eJPLri9mdjl2h4JEvsee0o/ZItxGSCv7hxi3BnYY5yp3PcH
 4xQtaubLk9ii3LtvHgD1G7OkSPUMkXQ4O0TTdUnFADFRIIatGtkYr6C/LAVZDb5/6n
 WBYRcd31vG8OhKBvBeCBXOkfhLfEBivie+ubJ/LmE00nyusreAktEH3Z/3Y79W+oIj
 dmdMRsRntLWF8fbrLQu0QhyBe7XJikNiUeSma2MOIR+tSepeifCXiIEy9DWOjX0CsW
 XPNcaywtzmNDnEPqfn0j2fwgDcAjoMxlSiwlKfTvE0/4Biamt38hKsE2/wWAKLztvk
 riAhgcdKvBNdw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: fix an IS_ERR() vs NULL bug in probe
Date: Tue, 27 Jul 2021 16:46:26 +0100
Message-Id: <162739969149.18968.15163991241105613933.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210727081756.GA19121@kili>
References: <20210727081756.GA19121@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
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

On Tue, 27 Jul 2021 11:17:56 +0300, Dan Carpenter wrote:
> The devm_ioremap() function returns NULL on error, it doesn't return
> error pointers.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: fix an IS_ERR() vs NULL bug in probe
      commit: 37108ef45ae9021d23174ce89e76ad41443090bf

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
