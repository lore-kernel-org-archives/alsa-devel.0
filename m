Return-Path: <SRS0=afjW=74=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6737C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:09:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40EC820739
	for <alsa-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m4y0wazD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ldg4Kbuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40EC820739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B56891674;
	Mon, 15 Jun 2020 17:08:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B56891674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592233754;
	bh=8P4ykyY8jMlSD8oJWEmDnxXO3o+Qr3wpbMtJbKmW9TI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m4y0wazDxJ1ru4ws2lCK/A+/Zmw/sYuliPCMTc0Ta8tsMdNWavwgD/72fFuQxQX7v
	 9sLy5BFrf/pF2iriQekPYxEvgX4h3Jl1aAm53J7NhQNFToCVF1vvRfB9gHxTc8pz3W
	 CI3ZQUB5a+H+jdrtaW1yNImWZM9IXGI42mjKG4g0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B73AFF802E0;
	Mon, 15 Jun 2020 17:06:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A445CF802E3; Mon, 15 Jun 2020 17:06:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B310F802DC
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2020 17:05:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B310F802DC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ldg4Kbuf"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7A9442074D;
 Mon, 15 Jun 2020 15:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592233553;
 bh=8P4ykyY8jMlSD8oJWEmDnxXO3o+Qr3wpbMtJbKmW9TI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Ldg4KbufKcgTOoKDAfoTn2Ai3j7ShEZqCqVryxxNOI7mvxCIT+FIf57U37craYpCI
 t4hZL1ckrme8kKqbfi8cDh9tiVVglAi10+YE5c5Dutvz4KeiPUC/gXxnAhto2MREPq
 QX0lnF/DiXaDxnTRa/MHsuazsyV9wXUATd4YhIPc=
Date: Mon, 15 Jun 2020 16:05:50 +0100
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, "jack.yu@realtek.com" <jack.yu@realtek.com>
In-Reply-To: <20200615032433.31061-1-jack.yu@realtek.com>
References: <20200615032433.31061-1-jack.yu@realtek.com>
Subject: Re: [PATCH 1/2] ASoC: rt1015: Update rt1015 default register value
 according to spec modification.
Message-Id: <159223353044.8967.16766188900025141454.b4-ty@kernel.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 kent_chen@realtek.com, kenny_chen@realtek.com, derek.fang@realtek.com,
 shumingf@realtek.com, flove@realtek.com
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

On Mon, 15 Jun 2020 11:24:32 +0800, jack.yu@realtek.com wrote:
> Update rt1015 default register value according to spec modification.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt1015: Update rt1015 default register value according to spec modification.
      commit: e74a1e7eaed95f2c6422e7cf9ed70154f17a6db3

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
