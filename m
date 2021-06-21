Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D68C4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:50:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A0E06115A
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0E06115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9AF0825;
	Mon, 21 Jun 2021 20:49:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9AF0825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624301425;
	bh=4ynnjLFGqT7jeVoGFXKGU1jJH+2RzYGaTP4Lm67YYMU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c92ifnSA4fZRwAGMBZ+Uv3nvMnB4THd1SbPhejzDEjoT5AkilL70r0AF/h44VG38m
	 WSEvv5WieY5vqg5mBUBJoifDUA2AvC5Th+PgPk/ni61Iw/GZmb0KA5wEd1bOun9mSX
	 aYYh6Eu3tR7xnrpPZf7JkpcE6bibRPJcmCmILOro=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08670F804FB;
	Mon, 21 Jun 2021 20:47:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82C96F804E5; Mon, 21 Jun 2021 20:47:10 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F409F804E2
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:47:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F409F804E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ny0E3T5R"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D78B6128C;
 Mon, 21 Jun 2021 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624301226;
 bh=4ynnjLFGqT7jeVoGFXKGU1jJH+2RzYGaTP4Lm67YYMU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ny0E3T5RoNSybmXudw3iIbk8cMmu/KS9qAH9i8fLgRzSJaZmj2gYncYDR1q4PxVWF
 b53Dac9NfbCRhF4c/Pu5hqX2OOncLEZdiud6h9ABGt4UKzGoaqoeXkNAkTIikKcjED
 ZpUyFrsKKDml4i5FpwOV/Jf8nt47FRt25QdyDC5x16cjpaCr2mlwMYA7GTBo+++NBc
 fjzRr5kPx0J3mIRqqqSHtG23xpNgsE4279mr18+yvS2zd4Y355uLorxYYaBb33HCP7
 ZfuXWv8qN/8uYwdhiJ+7gcHryjUsEKraB5b9igFkVt7KpP2GxEXbmqRmfv05P5jNdt
 IpdJ4mewPLiqQ==
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Dmitry Osipenko <digetx@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: tegra: Fix a NULL vs IS_ERR() check
Date: Mon, 21 Jun 2021 19:46:02 +0100
Message-Id: <162430055263.9224.14507478089189972560.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YMyjOKFsPe9SietU@mwanda>
References: <YMyjOKFsPe9SietU@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ion Agorria <ion@agorria.com>,
 linux-tegra@vger.kernel.org
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

On Fri, 18 Jun 2021 16:44:24 +0300, Dan Carpenter wrote:
> The tegra_machine_parse_phandle() function doesn't return NULL, it returns
> error pointers.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tegra: Fix a NULL vs IS_ERR() check
      commit: 3aed3ddf9639a4f915984177ff8a2253f3f8acfe

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
