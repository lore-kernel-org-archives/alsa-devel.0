Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5611EC00A8F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Oct 2023 18:55:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6758286E;
	Tue, 24 Oct 2023 20:54:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6758286E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1698173733;
	bh=tqKKyqDACaNThpvov4ZEREo0ocu9Uu1TB1KubL2Jyrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MMIVXUq6Hsmp7sb54GwjJ9cYMv555Royw2+WEz0CtTa5NIo3z0OZXhHLLjL8lW8HP
	 MDImWZVUMnHNeD7O1ST4nvZtarh00ytOwMWeehVih5XN0ibX7jFvz2CsahtrXJhpn8
	 gk6kRtVay/lgMmkH1caYPfj6ibWzOMxN6TpQHbCc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69D36F8057D; Tue, 24 Oct 2023 20:53:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 528D0F8057B;
	Tue, 24 Oct 2023 20:53:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83970F8014B; Tue, 24 Oct 2023 20:53:40 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AB760F8014B
	for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2023 20:53:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB760F8014B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=upJ/xPXU
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0743FCE31CB;
	Tue, 24 Oct 2023 18:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E3DC433C7;
	Tue, 24 Oct 2023 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698173613;
	bh=tqKKyqDACaNThpvov4ZEREo0ocu9Uu1TB1KubL2Jyrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=upJ/xPXUUl2MVFWJAnynPy1fEw+RcVMCd7BRbMNgQG8LRpN+NXeVsBxbbX7DTvVQ1
	 MxxK2JTWCB3XWh6z0nqsuBV47X9edm7/QsIS86/UgbOMgRzDYUW8QIyXY+ea773pjU
	 yPLTSX0U1EZwK92rSSpGag2/n5im7zDXFwWWpxEU3/RV0aY4dWgrP1pGDfBOrDmWVE
	 quaW4R4NBl50hwxFKo/Sw1IbFixev5TDxpWX5HdjB71o/Sx/a0Bk7MVf0IpZIn17Cy
	 TC8KpsHAXYh4IB25/glnpHNIe9tDyrcvgFGxaNvTm/bqskNYwovn/Bg6ukA93+JfZq
	 2FVlR1jK+zR9w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231023151704.670240-1-colin.i.king@gmail.com>
References: <20231023151704.670240-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: mediatek: mt8186: remove redundant
 assignments to variable tdm_con
Message-Id: <169817361079.82257.18121881250208985059.b4-ty@kernel.org>
Date: Tue, 24 Oct 2023 19:53:30 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c
Message-ID-Hash: GJXHUYLAEMELMHG4EOKS3NXPHOUTQBH6
X-Message-ID-Hash: GJXHUYLAEMELMHG4EOKS3NXPHOUTQBH6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GJXHUYLAEMELMHG4EOKS3NXPHOUTQBH6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 23 Oct 2023 16:17:04 +0100, Colin Ian King wrote:
> There are two occurrences where variable tdm_con is being initialized
> to zero and the next statement re-assigns tdm_con to a new value. The
> initializations are redundant and can be removed.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8186: remove redundant assignments to variable tdm_con
      commit: 2e2a1613342658962250873cb8a0406bebdab9e3

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

