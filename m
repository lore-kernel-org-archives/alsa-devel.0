Return-Path: <SRS0=W9hU=NK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B43C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 19:24:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F4C60F39
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 19:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70F4C60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1224A1693;
	Thu, 19 Aug 2021 21:23:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1224A1693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629401054;
	bh=hjanTyI3N9VyIXFopjH48AbrKtMvCkP6wd0U5aKuEHM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iTpZOMDy2LY/d1idbnioMIDC6ySNdlZorUO5N7rd6QDwA69u3SHaeLaPSfXc5MgWp
	 GaPocMjAmv7NcBWYrb3MLE72SIyNmWlCtoYUyPP46axpbkL5L2FD2mnPptl4OCE25T
	 u0Y+VDz2mZg1pGVQdUgdtcMolToHj7SSMPTw86BM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99897F802C4;
	Thu, 19 Aug 2021 21:22:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBF38F800EC; Thu, 19 Aug 2021 21:22:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5643AF800CC
 for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2021 21:22:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5643AF800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ZPcyTnsU"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E119610A0;
 Thu, 19 Aug 2021 19:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629400956;
 bh=hjanTyI3N9VyIXFopjH48AbrKtMvCkP6wd0U5aKuEHM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZPcyTnsUdognRf0uS/SnvDWG8oK3+/BsQay7ExsRyKgzV5TT/XWrL4nga3lwwSKZP
 fiMnksbLLlbXNaNBna5PlAPzMCZT0iNVOIne7Nb69k4QzxgKvIuqmw/BOx+ojq1TKi
 gUZhz0fpal7VU8p2B5TKDgX2P26NZFbVS6gCq3xCx9h9PmY6mf/VrKlv3lm2/3h0Ha
 DiixDjenXQ9I6FxVCQ2bOtHCtdPezRxbP3yXl40ORldbu/lPOpn0UwCQMX0gBmGMxT
 4qbtMBaRsjtAWdvS18q+0lrS7gSObwSiLY6vbQua5Lf+1k+Pt9eVsZFoHTl4dojPa4
 CuppptZDsxWlQ==
From: Mark Brown <broonie@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
 Colin King <colin.king@canonical.com>, Takashi Iwai <tiwai@suse.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: uniphier: make arrays mul and div static const,
 makes object smaller
Date: Thu, 19 Aug 2021 20:22:08 +0100
Message-Id: <162940023650.48070.9595577624316730352.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818151746.38520-1-colin.king@canonical.com>
References: <20210818151746.38520-1-colin.king@canonical.com>
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

On Wed, 18 Aug 2021 16:17:46 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the arrays mul and div on the stack but instead make them
> static const. Makes the object code smaller by 4 bytes.
> 
> Before:
>    text    data     bss     dec     hex filename
>   16226    4984      64   21274    531a ./sound/soc/uniphier/aio-cpu.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: uniphier: make arrays mul and div static const, makes object smaller
      commit: 5d925d9823aaf18d55fab784bd4ef11f80fe1099

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
