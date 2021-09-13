Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19BDC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 11:01:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F45760F4C
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 11:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F45760F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DEEF01694;
	Mon, 13 Sep 2021 13:00:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DEEF01694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631530905;
	bh=jjg6yzmoYmrgF/kupfGziCDMx2GVtuJGY7oPruMvnVk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QgyA5TjYz8UWIhLZyq+vuNH5DAICXivGypPcx1GG7gGEIMQL+pOiatK+mlYNMaSVF
	 KT6OREatsqUaW/SB5mmUDYEHBp0REQIt/HjTFHbqj2LW+eg/R9PxYn01Nak93DjZVH
	 vGDYOs7P+7iXgv/2C/fBy43+L/IIMQ5Cq1SemKQo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5722F8055C;
	Mon, 13 Sep 2021 12:55:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11140F80559; Mon, 13 Sep 2021 12:55:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1B4D0F8053E
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 12:55:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B4D0F8053E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VrrT8olo"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B31660F12;
 Mon, 13 Sep 2021 10:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631530524;
 bh=jjg6yzmoYmrgF/kupfGziCDMx2GVtuJGY7oPruMvnVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VrrT8olopk85eVfPt+B6eBAre8D1nMrLOz9HALE8hjM1WyJcVSwNt+Kf6t6xrnj0y
 jv5CgAfOMv2lTIPy5fypia/YhLZ00ixv0yTwrq4qnB52NKJy0WEvD8r/28yBLArUa6
 umHdxhSjwMzLteVcJPngl1UPpeU7GQfd+nxm/R1/ojOES7h0Hcqlswt/nOmPeQMGR5
 ngfw5HoaafYETLg3fsNsp0+eee/FQ5X/cmb60qqR/PZF+cQ0+yL8xj1BczkK0yt/RW
 Uia9w7RCdtQIGtSgCQdPvK6iaiHcjLLKWdqbVeBMG/uzZkzjpCYXSFFZW0gWck8CN0
 r/ObDk9j3MdVw==
From: Mark Brown <broonie@kernel.org>
To: Cai Huoqing <caihuoqing@baidu.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8195: Make use of the helper function
 devm_platform_ioremap_resource()
Date: Mon, 13 Sep 2021 11:53:32 +0100
Message-Id: <163152996580.45703.9693182447056291147.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210901132742.31714-1-caihuoqing@baidu.com>
References: <20210901132742.31714-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

On Wed, 1 Sep 2021 21:27:41 +0800, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Make use of the helper function devm_platform_ioremap_resource()
      commit: c6b1b57469b4768b83e9ccc9bc3e5c2c7eb93013

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
