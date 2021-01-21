Return-Path: <SRS0=oBR+=GY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070ECC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 19:42:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C84223A56
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Jan 2021 19:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C84223A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B20401925;
	Thu, 21 Jan 2021 20:41:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B20401925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611258114;
	bh=Z08XuO/i/H87bLMWqgNVVGwyiF87YONwHi5l79flqbY=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AnsZCcJ1sQpsfuuC5bvPUDpcaCTaDt4bDarNumvIH2OTdgbUUbvvjifGnWAbgaVzQ
	 ufZAMAkxahneQ+0eU4Vi0SFp7TwO3oSs8/2lWMDKvAeGcydpPnLwVO/qH3rYr5c4B+
	 JBf8g4OL0YDxFrUzDF9e8NaK7roEaEv58gyZelAI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AD163F80162;
	Thu, 21 Jan 2021 20:40:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9991BF8027D; Thu, 21 Jan 2021 20:40:09 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9A1CF80162
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2021 20:40:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9A1CF80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RVdrhUeV"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93E0323A53;
 Thu, 21 Jan 2021 19:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611258000;
 bh=Z08XuO/i/H87bLMWqgNVVGwyiF87YONwHi5l79flqbY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=RVdrhUeVJzMwhQk6yoKaq2QmvdS3CKPxeSe/CXH+4DelU3NxAIUE/MhstCE1PKQZu
 xD/UQ7JIspuil8FqKAqTecfq4Z6ghxfCvrkP3ehMIUXmgWXNvo2rmpWlok1dyNCmKh
 pFWoSniaisZImkM+stRsDl/kT8AY0d9TKEjY7wyqqP5GRWald8HrSqIy1CEKXNJVU3
 Hb5bFzNfDKmNudKtjKL4Pgthw6viMw+ZBIJ6pzCfBYBIlYSolYmgdnAIOQ3nkK5PP1
 3vG5vOPhBYAta66Nu+3rwd935j6kr0VPIN6OhAe2iPzFiubDNRnGp+WwouBBjA/vUf
 AKxxCQyYaOZSQ==
From: Mark Brown <broonie@kernel.org>
To: shumingf@realtek.com, lgirdwood@gmail.com
In-Reply-To: <20210121100353.6402-1-shumingf@realtek.com>
References: <20210121100353.6402-1-shumingf@realtek.com>
Subject: Re: [PATCH] ASoC: rt5682: remove connection with LDO2 in DAPM graph
Message-Id: <161125795422.35635.1685765991531727317.b4-ty@kernel.org>
Date: Thu, 21 Jan 2021 19:39:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, albertchen@realtek.com, derek.fang@realtek.com,
 flove@realtek.com
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

On Thu, 21 Jan 2021 18:03:53 +0800, shumingf@realtek.com wrote:
> The application circuit shall provide MICVDD power.
> In default, the codec driver doesn't need to enable LDO2.
> In case, a board wants to use VBAT for micbias,
> it should add a DAPM route which IN1P connects with LDO2 in the machine driver.
> e.g. { "IN1P", NULL, "LDO2" },

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: remove connection with LDO2 in DAPM graph
      commit: 06c8456753f6fc89ff5894cc8cca24b1ac92a5d6

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
