Return-Path: <SRS0=0cRQ=NR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02D2C4320A
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 14:18:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5322660F25
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Aug 2021 14:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5322660F25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACAE816C5;
	Thu, 26 Aug 2021 16:17:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACAE816C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629987489;
	bh=Id9hdMS4ZVRLE8sX6tHUAZFHZyYA74j1rQP2S76OPIs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t95E/GLqusoaBiZFUxS+Wkkhf0Rfx40bnaq/H4jcDI5GSwOVzdioZ1p7Lo2GQbX7a
	 ggX3Nwn5Iry+BlueF37FlYFnNpHwLqgSSkeFiXRdWQBAqai9VTnt43FlCYMWToWDhF
	 hUjvOW4MVstz6qlCU9KypjCjZT7HXCnJsUZBpZgk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF23DF80054;
	Thu, 26 Aug 2021 16:16:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B339F804D6; Thu, 26 Aug 2021 16:16:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBEDBF80054
 for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2021 16:16:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBEDBF80054
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="h3hLyQPw"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4D4260E78;
 Thu, 26 Aug 2021 14:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629987383;
 bh=Id9hdMS4ZVRLE8sX6tHUAZFHZyYA74j1rQP2S76OPIs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h3hLyQPwalKZygt/4rARZPh/L7wWvt3/aLK27jxsyYNxuZ3pe/n4X0J3cF4UWEEMW
 Pu7M3vDvPlvzJEwXitSWmyUJfECA7ej52IPb8x2XXL2+4GAEM2t7H5md29y4lFz5uu
 kik/jTyhhV3+nHwQULaNcssBhRN7DaDHbrJ3wv8gno7FUicqk1D3N5un125cStujUj
 F/cseX3ayQDm2fKaz+WY1PFapnBPus01BocUdoAtTD1g3wyc61wC9yzMtoBANnpkX+
 6qwQBeTiVoArdogg0Iu0JnV+/sIKUiig9bb1q9Jl+FkeAlHn+UnCULPNNJnfGDnRoJ
 Aoqfzfw+EDUHQ==
From: Mark Brown <broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Colin King <colin.king@canonical.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH][next] ASoC: mediatek: mt8195: Fix spelling mistake
 "bitwiedh" -> "bitwidth"
Date: Thu, 26 Aug 2021 15:15:45 +0100
Message-Id: <162998707936.5647.1881702741528479360.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210826112611.10356-1-colin.king@canonical.com>
References: <20210826112611.10356-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
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

On Thu, 26 Aug 2021 12:26:11 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a dev_dbg message. Fix it.
> 
> 
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Fix spelling mistake "bitwiedh" -> "bitwidth"
      commit: 11a08e05079a9328023d236b82bd7981bcde0852

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
