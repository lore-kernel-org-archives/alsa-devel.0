Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A861BC83F1B
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:34:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB8BF60205;
	Mon, 14 Jul 2025 12:34:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB8BF60205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1752489274;
	bh=yI8EfP8IXLrM7V/tHScyWULlwSdLP8DcCGe3U71eCUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jHVAz8ikTIG1+tcjAwYeB2nAmAwxHlvWc6M4OFisosvbscW1MeMTOPlGiKtukXU8z
	 RyRgmbDXUuGrnvSxtcnCy/2JcTX9jqO6K5ZkpVIk+weDIZ/4gPpWd8dFEdwSzXVJIO
	 nTbkLFTDKnbrneEEcK397sgg3kHRcd2cfhluJ/BI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5657CF805D5; Mon, 14 Jul 2025 12:33:56 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1199AF805CA;
	Mon, 14 Jul 2025 12:33:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E9B4F804E5; Mon, 14 Jul 2025 12:33:42 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C2AC4F800F8
	for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2025 12:33:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2AC4F800F8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=LATsXYy7
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DA4C34426C;
	Mon, 14 Jul 2025 10:33:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B386C4CEF4;
	Mon, 14 Jul 2025 10:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752489209;
	bh=yI8EfP8IXLrM7V/tHScyWULlwSdLP8DcCGe3U71eCUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LATsXYy741y/jS6q8W0GAT84DCA8DkSeF5tIHVPbVRhcsx44cy2wsH0qX4HUuN/Kx
	 fY8D6orciZj6wshTIzGRnKmtDOIrWHbTheWZMUx6GOPhVTUhrcEWo+Fd7wJyGLWnnw
	 xLU64Qou3271qTc5zpWS7+p37mBnRpaegkA+skbBw4BKDX4qd6POYim2RqjGVjMZVH
	 3SdFQAk7uN9GA72DxhjhblNYUhyAPJQvAKf1bhkqtM37z+ss+pALxgAvqXX+naMPgQ
	 rne7p8QCJJ+WPlebcHAKQiVa6mnn8M/qeUwygyvlzBUvMbuVLkTaMePrkPdoBONd/q
	 bpD/Z6PwiAqSA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, flove@realtek.com, shumingf@realtek.com,
 jack.yu@realtek.com, derek.fang@realtek.com
In-Reply-To: <20250711034813.3278989-1-oder_chiou@realtek.com>
References: <20250711034813.3278989-1-oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5660: Fix the dmic data source from GPIO2
Message-Id: <175248920817.18169.12928022931333712208.b4-ty@kernel.org>
Date: Mon, 14 Jul 2025 11:33:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91
Message-ID-Hash: OIN5ICWJPVRVSTRRDZDXJP3Y3FTPJAPV
X-Message-ID-Hash: OIN5ICWJPVRVSTRRDZDXJP3Y3FTPJAPV
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OIN5ICWJPVRVSTRRDZDXJP3Y3FTPJAPV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 11 Jul 2025 11:48:13 +0800, Oder Chiou wrote:
> The patch fixes an issue with the dmic data pin connected to GPIO2.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5660: Fix the dmic data source from GPIO2
      commit: d235538723e6c95f354b49a8c4760be43c234579

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

