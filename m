Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF0EC433ED
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 16:27:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF4A46105A
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 16:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4A46105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4FF0F169F;
	Fri,  9 Apr 2021 18:26:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4FF0F169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617985667;
	bh=hc+nGdCIR0RhdyvtSUaXj933Q2AXVmJxWbXIcJq4laM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WQnxO1GV4ikXEr+C+n3hGSDAOR1q2y4c6pB4WGyK2Wb0zh5F02mFKmxynuwWa/ymd
	 E0Jt7ZmdFl26S4pflmtSlZxYHQLd7G1FMliGS6DVwKdjDErvAvGyHxhpFAYnK4eAH1
	 1T17wE1gkggEKDJPVVUCA/RZZdvcYvPQv/Y10T6Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 97D92F804E4;
	Fri,  9 Apr 2021 18:24:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 363DFF804B0; Fri,  9 Apr 2021 18:24:10 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1AF53F80431
 for <alsa-devel@alsa-project.org>; Fri,  9 Apr 2021 18:24:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1AF53F80431
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="M71tah5e"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 150936115B;
 Fri,  9 Apr 2021 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617985445;
 bh=hc+nGdCIR0RhdyvtSUaXj933Q2AXVmJxWbXIcJq4laM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M71tah5epmyf9sWSVrX/f8HpoUhZVgC+V9nOgaIiEJVSfK4xni7nVXRFlBGPhQHw8
 EvnbC8ztMSvl0ygzTwgpL9Eof8alVZzHUGarmdB9jqg1t+vcZJT3h3tUbffqfL2c7Z
 sqZiVVWUT9Pzbt4IZ03MYQNETGMMSp11g1DK2xoW0B4TQNKFOnube2VxaFZmxhh8Tp
 I4O+1jk8m8s7JOYjXCzwUJ+PGnS/ZY54l8CONx/Zz+jZjSKKRZ7dUa+KaxtBVNYatP
 jGUfblYPmujTaefRr8GrEIDTy0idInxtF3FCdHpOLc5AU7z2YkHRZlSry/UJ+6wIR0
 4NQc5IX9nkq9g==
From: Mark Brown <broonie@kernel.org>
To: Jack Yu <jack.yu@realtek.com>,
	lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: rt1019: remove registers to sync with rt1019
 datasheet
Date: Fri,  9 Apr 2021 17:22:56 +0100
Message-Id: <161798344182.47643.887391618307908705.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <01e6409f0db0451aa1e45ca7d82cca9c@realtek.com>
References: <01e6409f0db0451aa1e45ca7d82cca9c@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 lars@metafoo.de,
 =?UTF-8?q?kent=5Fchen=20=40=20realtek=20=2E=20com=20=5B=E9=99=B3=E5=BB=BA=E5=AE=8F=5D?=
 <kent_chen@realtek.com>,
 =?UTF-8?q?=E9=99=B3=E6=98=B6=E5=BF=97?= <kenny_chen@realtek.com>,
 Mark Brown <broonie@kernel.org>,
 =?UTF-8?q?Derek=20=5B=E6=96=B9=E5=BE=B7=E7=BE=A9=5D?= <derek.fang@realtek.com>,
 =?UTF-8?q?Shuming=20=5B=E8=8C=83=E6=9B=B8=E9=8A=98=5D?= <shumingf@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>
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

On Fri, 9 Apr 2021 08:52:29 +0000, Jack Yu wrote:
> Remove some registers to synchronize with the latest rt1019 datasheet.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1019: remove registers to sync with rt1019 datasheet
      commit: 4f3b0f8e364029f2674875396f0e65a98ef84498

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
