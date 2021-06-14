Return-Path: <SRS0=68EG=LI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4941BC2B9F4
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:56:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE71611CE
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jun 2021 19:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE71611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB7F81696;
	Mon, 14 Jun 2021 21:55:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB7F81696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623700596;
	bh=HlsVAzqQjfkYgEn5Uwml8vyPXW7gRkMvnO5wAcmT3sA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rb+Ti8nZq80PTBMva0gttgawCplu1vlCaLTAL+XKSy6EG7OmC/LH22fPhRtCeLfDt
	 b4WyQpFu3GFOqGGaCxu+zzGAVJYspCemaq29Zn1qaJtVr9W9L6umZl6YFB2ar1GhhB
	 hZWrvJdsmweeKDfnVxinf7ORwArBvA3kFUbkGUls=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CF11F804D0;
	Mon, 14 Jun 2021 21:54:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33E05F8025E; Mon, 14 Jun 2021 21:54:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90557F802E8
 for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2021 21:54:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90557F802E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cLz9DXFF"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EBF36124B;
 Mon, 14 Jun 2021 19:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623700485;
 bh=HlsVAzqQjfkYgEn5Uwml8vyPXW7gRkMvnO5wAcmT3sA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cLz9DXFFqQk4W21hI+v0aFHln9fjlY4TKBmAxrUtvqOQbeoU1/3nLm7eaNTqHdfu9
 l6/iWlIz2hci7NRsjO6kv9qjHnjvShdImpsFkeDU2GveEKv/tg1LHKrbaLdZrV1Vwt
 qkZXLtKFOmw2GKQTdIpZ+2tyezH0QW6HteKFgJ9GC5F2C3a0g4kYPIfkBLMzkb2x2y
 PJKpHlSbYyhUP9ZcGPWBcdylcVB6RhHauGC0kCblNXpgmNLDfv3tcBy3HiYhOliV77
 CLuzqQl4PXuWXQbM5MYauCptZu2avb5UyRadhzxU38Kh6mpPuq4yQUQ8aR/16zNEoT
 Fl/S2zkHUiVkQ==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH -next] ASoC: axi-i2s: Use
 devm_platform_get_and_ioremap_resource()
Date: Mon, 14 Jun 2021 20:53:41 +0100
Message-Id: <162369994009.34524.14636427113168434063.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210610132705.138706-1-yangyingliang@huawei.com>
References: <20210610132705.138706-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, tiwai@suse.com, lgirdwood@gmail.com
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

On Thu, 10 Jun 2021 21:27:05 +0800, Yang Yingliang wrote:
> Use devm_platform_get_and_ioremap_resource() to simplify
> code.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: axi-i2s: Use devm_platform_get_and_ioremap_resource()
      commit: 1b7f94dd20fc9eb63c8470f9f20544b0f6742440

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
