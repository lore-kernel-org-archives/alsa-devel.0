Return-Path: <SRS0=htQG=NI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02336C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 14:24:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BDC60F5C
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 14:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70BDC60F5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 97EA61679;
	Tue, 17 Aug 2021 16:23:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 97EA61679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629210279;
	bh=R6w9f3DNaAwvzEWdkV1n2SQA2vQEt45LORZO+y06V+Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sGZG/Ak6UqHVYAp74AATOcVKL5YcSOViGveYcVQYtdlu5jnfWFqkJutpOOnx4nCjR
	 rA9aDTAAoqHBEZX/WD7uMIE0exiIBk96V0Mnx3TiCLfT3nOERGxWhlaR5tPo9NV+jd
	 9eXdFmbd01jypuDIG8Oqq0zi3REyd8W2InLmLEsk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E50DF804EB;
	Tue, 17 Aug 2021 16:23:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0852DF804EC; Tue, 17 Aug 2021 16:23:15 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B024AF804E1
 for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2021 16:23:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B024AF804E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YS1wWj4c"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4269A60FA0;
 Tue, 17 Aug 2021 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629210185;
 bh=R6w9f3DNaAwvzEWdkV1n2SQA2vQEt45LORZO+y06V+Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YS1wWj4ceAAMHWuKUcRLm/+Xv6lot2Q/PulxXhIz2h7O7QVICDLy2RJqo06zk8S69
 Rk/w7tT5t0nJza7q2zUV0rcZd/GKzfhnGVr263FhjVVFxhm9i9yD3op6r7qmpYwpPY
 NR0JoXcpafteup7W+7E6dxz1YETYvSpXFDxtfSt7NijgVwlkbIy9V4QP5rrM6Y1fje
 AQ5ifhgjg9yfv7s9hnAE/SZII1FZpg0ns2DBYdkhxMI/lkH5A4VejpTcBMZF0a+eg+
 Xw+4i37q0PVtyoNyCcY5dRew7E5qqtTj3++qefRudXmGx7IHWeZhuias2tiPtuczn9
 IFiIEt+Uy7f/g==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Biju Das <biju.das.jz@bp.renesas.com>,
 Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: sh: rz-ssi: Fix wrong operator used issue
Date: Tue, 17 Aug 2021 15:22:35 +0100
Message-Id: <162920984133.3104.6780936326749389022.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210816182336.29959-1-biju.das.jz@bp.renesas.com>
References: <20210816182336.29959-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Biju Das <biju.das@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Chris Paterson <Chris.Paterson2@renesas.com>
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

On Mon, 16 Aug 2021 19:23:36 +0100, Biju Das wrote:
> Fix wrong operator used issue reported by Coverity by replacing |
> operator with & operator.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sh: rz-ssi: Fix wrong operator used issue
      commit: 1b5d1d3a2f77250707225509cadc17997bab4353

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
