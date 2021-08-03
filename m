Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BA1C432BE
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 22:38:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18950601FD
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 22:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18950601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A86FE173B;
	Wed,  4 Aug 2021 00:37:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A86FE173B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628030284;
	bh=LXhoBeBzUTqbh8mDn29zpcWCz1WKAtQq4APb31gMywI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mS8MXYtWgAHfwNiqlg3NeYiYjjBEIBrEXAxfdy6QyVJSsgLWaoqInuPUDD41Mz2ck
	 3YQmN2RK3PB8ZI3+TZYHp0iv5aq0bn0eQdhM6nJBfr4D93o4z2hofYUid80pJ4bf2p
	 jPFlIhSLQA83NYUi/5X1IFE5qwMmB0IM4gbFaLUg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 07A82F804D8;
	Wed,  4 Aug 2021 00:36:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6D0FF8049E; Wed,  4 Aug 2021 00:36:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D798F804AB
 for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2021 00:36:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D798F804AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="as3eYrOE"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF24360EBB;
 Tue,  3 Aug 2021 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628030177;
 bh=LXhoBeBzUTqbh8mDn29zpcWCz1WKAtQq4APb31gMywI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=as3eYrOEj1INmODgOgzQjzwKcBchk8y0e9ltc9kyj+McqYMklyah52uvSJzVkphfO
 LUoSTnLuEPZHVtRzlkwbj1+S1WSWo5akkJD2DDfRjM2vJgi//clAjHdaOIedmcRbfi
 0uSSgjq9uj69PV8wPZokDtpENqa1tNSAOVpcvWwbJyjJ+YNpfIOXUC/cbO3lRQrLfo
 YqA5b7lYEjagGVDC1KeG7mMK6Q/jBFdAIHMWRLTigAjzdemM2MZ5fj68ky2k2eKhHq
 dfldOI4LwqfgFkJsej4YEOVClo0+mtvpMOv2ZLy4rW3wYM+4FkYx1svp4khYxejdd6
 e4Bqvpwp7QSQw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>,
 Colin King <colin.king@canonical.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ASoC: rt5514: make array div static const,
 makes object smaller
Date: Tue,  3 Aug 2021 23:35:37 +0100
Message-Id: <162802985540.42099.11025103485301142729.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210801064023.138359-1-colin.king@canonical.com>
References: <20210801064023.138359-1-colin.king@canonical.com>
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

On Sun, 1 Aug 2021 07:40:23 +0100, Colin King wrote:
> Don't populate the array div on the stack but instead it
> static const. Makes the object code smaller by 48 bytes.
> 
> Before:
>    text    data     bss     dec     hex filename
>   53894   16368     128   70390   112f6 ./sound/soc/codecs/rt5514.o
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5514: make array div static const, makes object smaller
      commit: 5c8a7efc2fd5eb716c48d7d7ab4295effbc09ba3

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
