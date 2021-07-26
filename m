Return-Path: <SRS0=yf6i=MS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FE2C4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jul 2021 21:36:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A3560F6C
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jul 2021 21:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90A3560F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39C611E09;
	Mon, 26 Jul 2021 23:35:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39C611E09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627335362;
	bh=ud/bDg76pisMKyTi3ZScc5QF2EnZJ+utcc66IN3N/UM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eK1Y/g2IjHCIMwvvtpa+QMup3pN0uVXRSvIoJmvyXC62iEL7I2BKHU2t5GA1OIjxl
	 Dio46UgAlDjY0ncM8j44Hrv1lwqXONNKNjuyA1WZV63VwIqzeWRPplqjqUkEeD3SCb
	 +HZWOnMvTiaW70kZBHikBIf1gaSwI8bn33e7JZKs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86E51F80253;
	Mon, 26 Jul 2021 23:35:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 502A7F8020D; Mon, 26 Jul 2021 23:35:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACC68F8020D
 for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2021 23:34:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACC68F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RKLLLot+"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D36360F91;
 Mon, 26 Jul 2021 21:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627335298;
 bh=ud/bDg76pisMKyTi3ZScc5QF2EnZJ+utcc66IN3N/UM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RKLLLot+zCCRPB0K8QOX5nO9DXHwrvg792OA3RUkuaMkQ9PZ4H6rebWN8dOS1JWE4
 8lhkW/MQLHEKuGo2p+us9t+eJICxAXjRh2G6de8RVecR+wsp0227sqxZ7keOsRau4f
 cHcjrdRERu8fITsq+xhyJ00g0THG4KWfumTO8SLzZuwTIx3fHwHbci+F4u1/D30+DZ
 SbhTb6PZeb3m3qrQ9BvMfKkqONTvJrbWCZpqV8gxUuOlpqzDeJRmSOPAHHAusO/RMh
 lYU6s7xp4VMf73DGO6Sd3en3LYvY2vVMMIRUDtJOJon5dVxWZgKdzp+OQs/sChtDRE
 jimezCHPrvhJg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com,
	Jack Yu <jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt1015: Remove unnecessary flush work on rt1015
 driver
Date: Mon, 26 Jul 2021 22:34:43 +0100
Message-Id: <162733475031.22497.9106912316392785369.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <3ef458a6ad754589b96d6a94abda1e55@realtek.com>
References: <3ef458a6ad754589b96d6a94abda1e55@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 lars@metafoo.de,
 =?UTF-8?q?kent=5Fchen=20=40=20realtek=20=2E=20com=20=5B=E9=99=B3=E5=BB=BA=E5=AE=8F=5D?=
 <kent_chen@realtek.com>, yuhsuan@google.com, Mark Brown <broonie@kernel.org>,
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

On Mon, 26 Jul 2021 09:15:41 +0000, Jack Yu wrote:
> Remove workqueue of flush work in rt1015 driver since we don't need it
> after internal discussion, and there is no impact on performance
> without this workqueue.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1015: Remove unnecessary flush work on rt1015 driver
      commit: bc1c8e4eee79646b9ae10ededed06a569c7c2bc9

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
