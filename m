Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B53C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:09:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03A9065210
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A9065210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78BF318D3;
	Mon,  8 Mar 2021 17:08:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78BF318D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615219768;
	bh=380awQUJ4zxtwBAnBEvClAaNwFFI/taHEzoIObE5N+U=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QKTaV5hHLhAlYj48R9BWbZIVweel9rnKH2bQDGDNMD6S15hmyEElO0osQn2xI1SbC
	 LKvtGRhcYEzlXoSg6sGJ+HP5bwf8WUXN9fnLKpxZzP3sltcwFafxU5YZSv4ikjPTFB
	 kJZQgJEwqCWQ5guUitvf5UMGxqIB2lgPXKVxldZs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC41BF801ED;
	Mon,  8 Mar 2021 17:08:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 67429F8032B; Mon,  8 Mar 2021 17:08:13 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E0E0F801ED
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 17:08:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E0E0F801ED
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fD2Tacyf"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D73A665226;
 Mon,  8 Mar 2021 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615219684;
 bh=380awQUJ4zxtwBAnBEvClAaNwFFI/taHEzoIObE5N+U=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=fD2TacyfcRYmPT1qdd2W8uYEHaZokSdyalnyzkyyKnwohZOUbYYENriJCEgB7sF3B
 los6uptq+LLtTnPHoWbgNKK9C07A1Xae6dGmPkcAICYdYHhZQ9dVi5TbVSBWQ8Hh6N
 0SqR7shRcMvhIoqxCaWeRXYdHLdA3VwXdrMB7YWXvhsKnPl+RKAU3h6ldgW0f+Wxa+
 d/3UNjIpmvFL4mOtWQ5lXnw/kLWIuWpS4zQaLUfp1Z6wziB02qtuY4Xybn8dmiPhcT
 XB/ZwLAe24HjJLLzbNfJ5UOiBX349eQMkaoz17KKmh4LQ192qowmlJksgD0f4uEZ4W
 Rj9nFw9VGvvZw==
From: Mark Brown <broonie@kernel.org>
To: jack.yu@realtek.com, lgirdwood@gmail.com
In-Reply-To: <20210302103042.19528-1-jack.yu@realtek.com>
References: <20210302103042.19528-1-jack.yu@realtek.com>
Subject: Re: [PATCH] ASoC: rt715-sdca: Add RT715 sdca vendor-specific driver
Message-Id: <161521960848.9621.9461420031194370810.b4-ty@kernel.org>
Date: Mon, 08 Mar 2021 16:06:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 derek.fang@realtek.com, bard.liao@intel.com, shumingf@realtek.com,
 flove@realtek.com, pierre-louis.bossart@intel.com
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

On Tue, 2 Mar 2021 18:30:42 +0800, jack.yu@realtek.com wrote:
> This is initial sdca version of codec driver for rt715.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt715-sdca: Add RT715 sdca vendor-specific driver
      commit: 393c52d2d109c802e211bbfc2f66f123620775ef

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
