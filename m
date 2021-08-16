Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FE6C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 17:07:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3AB60560
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 17:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7D3AB60560
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28AA216A4;
	Mon, 16 Aug 2021 19:06:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28AA216A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629133621;
	bh=RrPpirxSrKSMhGZJ+QCIH5ubgH4kZX6FvSaNS2s3bXQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=arVDTlPlipZR93V9v8V/Ci6A9FRm5ai5jsNJO6OW6QpcxZSNhwKT7a7ZX5LXCTGi0
	 DgIQ45lyEVt4urf44/X+/oEXHJNskrHF6xQ3jo+mqqG2aVJ+LX0Oo1iez/Pk56zyZJ
	 SvYnBpgtEqw9/c178rWgrfEbrv//8KmyJmER+/68=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8060EF804AC;
	Mon, 16 Aug 2021 19:05:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62B15F802BE; Mon, 16 Aug 2021 19:05:17 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1377BF80249
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 19:05:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1377BF80249
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="inuI2C2j"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 206CC60E76;
 Mon, 16 Aug 2021 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629133508;
 bh=RrPpirxSrKSMhGZJ+QCIH5ubgH4kZX6FvSaNS2s3bXQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=inuI2C2jITpMS8AKBKtJoXTf2zBpon/qSOFvDvMFs9vw9YUxzFHKdDaKaHPn5Qqeh
 RNBlEGqXdKULxwF2io8nQwSMfq59mOLIGKazvnA6NJqGafauTdoQnyB8XzM/YGyYzD
 K2QvcSVxWZC2re7K7KmlWLXE6jms0bxjyFVTcOBJgPXTOrHKGESRItexrbXUDyqpw6
 U9L/R0OqjEfux9335576InPpj9BdcZaeYQ4BYHaSG4IiYP8YeWMLV+0pbxXUdCOCou
 COvEWGf06XG9WmU77ipHafHzgWNHgAZIECGmsZCEayGWLuz1rdddf1eUbrW+YYOJ9i
 aKl57NGa3PIpw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Aakash Hemadri <aakashhemadri123@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: tegra: Use of_device_get_match_data
Date: Mon, 16 Aug 2021 18:04:40 +0100
Message-Id: <162913223312.13582.10888100799475599538.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628971397.git.aakashhemadri123@gmail.com>
References: <cover.1628971397.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Helgaas <bjorn@helgaas.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Shuah Khan <skhan@linuxfoundation.org>,
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

On Sun, 15 Aug 2021 01:42:17 +0530, Aakash Hemadri wrote:
> 	Prefer `of_device_get_match_data` over `of_match_device`. This patch
> replaces of_match_device with of_device_get_match_data.
> 
> This patch series will apply cleanly on for-next
> 
> Aakash Hemadri (2):
>   ASoC: tegra30: ahub: Use of_device_get_match_data
>   ASoC: tegra30: i2s: Use of_device_get_match_data
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tegra30: ahub: Use of_device_get_match_data
      commit: 80165bb8043391f4ef4916bde947a4d805a54aa6
[2/2] ASoC: tegra30: i2s: Use of_device_get_match_data
      commit: 356b94a32a75203616e5a7c3cd2b19101bc87086

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
