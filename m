Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57176C77B7D
	for <alsa-devel@archiver.kernel.org>; Mon, 15 May 2023 11:11:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21C6E83A;
	Mon, 15 May 2023 13:10:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21C6E83A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684149097;
	bh=lwjgziLcEsIzBPxxZ1N8abCwzxvPGfURke6CIpHvtww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=UJL+fa8U1aHyfFcCwAbLbOY4t42CEzKUVdSPO81SF+RnCucKKoNUF1a/6u8Qv5piN
	 qP84bCT+e8LMSAT1tmqMchN3t0AAtCafw48bi0zUIZQT5QtHMKGryn6nzmQ6hpFu9F
	 tRkeF2H5P043jxoaAM9ieFMBWJ7nFxXyhpYSv/oE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6FABEF8056F; Mon, 15 May 2023 13:09:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D9789F8056F;
	Mon, 15 May 2023 13:09:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C0B2F80431; Mon, 15 May 2023 13:09:46 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0C066F8016A
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 13:09:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C066F8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YuNMzPkb
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6CCD6615FE;
	Mon, 15 May 2023 11:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76DBC433EF;
	Mon, 15 May 2023 11:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684148975;
	bh=lwjgziLcEsIzBPxxZ1N8abCwzxvPGfURke6CIpHvtww=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YuNMzPkbzr28+j0Zo8hTdy3k5Ja8MNwey/47bnhvvp39UClQ1RjDBJwvXkB3vK9jb
	 +FrQrprKO/3/gtG3k7KoorIUtPuMv/luFfVAxrafGmthNLmIDUmKqGIwaWAF/SATn7
	 DUPtBx9KtK8L5f05ze+WfcJA40mLLtEa0+X7KAE9GVOmHT9xQx0WirJgS7VZdHM5uq
	 aUYxWWdb6FD/9QlHZvIIlvG1pSS56OmLLhdZCQq7WLyl7x3Fmp4DsRcDBQPu39Lhk2
	 KcJG5M1oISFsZBpcXsU/H4ckjQ8TmGFpIf/eLrVmvTEARafIxwNF6EanGDG9HGgYmS
	 i3fXELO7XL3mg==
From: Mark Brown <broonie@kernel.org>
To: linux-samsung-soc@vger.kernel.org,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
 Olof Johansson <olof@lixom.net>
In-Reply-To: <20230513090228.4340-1-krzysztof.kozlowski@linaro.org>
References: <20230513090228.4340-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: MAINTAINERS: drop Krzysztof Kozlowski from
 Samsung audio
Message-Id: <168414897357.394037.3389766402303422512.b4-ty@kernel.org>
Date: Mon, 15 May 2023 20:09:33 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: R4IIBSA34OFD4GUVQS542FR657C3AD7W
X-Message-ID-Hash: R4IIBSA34OFD4GUVQS542FR657C3AD7W
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/R4IIBSA34OFD4GUVQS542FR657C3AD7W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 13 May 2023 11:02:28 +0200, Krzysztof Kozlowski wrote:
> Remove Krzysztof Kozlowski from maintainer of Samsung SoC Audio drivers
> and change the status to maintenance (no one is reality being paid for
> looking at this).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: MAINTAINERS: drop Krzysztof Kozlowski from Samsung audio
      commit: 647b5f5fdcbaba6f6fd8db69508fcbeb1fdfc2a6

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

