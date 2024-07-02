Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0019C31D97
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:22:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D523193B;
	Tue,  2 Jul 2024 22:22:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D523193B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719951748;
	bh=kWqtMEy8NiJo/fu7ZdT4UQqXiPF3djtgdRsFAOR4Afw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FdShvpWxW3EIfEX2j6JIVMLclQiLlVmGrGr4Oq+RgGXEVB1kPPuC4ivWx++gdbSzG
	 lx2bSULtMtZR+HQ5QbhPNdIMg2OVwaWdRpvStKENsCeiCmQOaLFttgKdGCNov1mB9R
	 Bw7zWy5Xwun4dddUhEMxi2LNYw9CCPEQMuyyEz+g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 03BCCF805B6; Tue,  2 Jul 2024 22:21:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C2F7F80589;
	Tue,  2 Jul 2024 22:21:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E77CCF8025E; Tue,  2 Jul 2024 22:21:49 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1398F800FE
	for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2024 22:21:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1398F800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WxJ3aaQY
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 061B861F7B;
	Tue,  2 Jul 2024 20:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3729DC116B1;
	Tue,  2 Jul 2024 20:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719951699;
	bh=kWqtMEy8NiJo/fu7ZdT4UQqXiPF3djtgdRsFAOR4Afw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WxJ3aaQYCW2CjCLULVLN3y/0y1IH09ffW3+est+9t4CZRMV+EfMZvWc8wlYtz4JuV
	 hYh4NgAXuQ1U42MSr1yLcMSp30HZjb3Bn/UAR0o0Tx8CBWLNRRYB5cKisCgg4o0T1q
	 nM1lbb3XXo/6e0nEc9kS/6fxg/gHGaD78D/VFuwiQD6xSlfb50nd/KdprE9PGBXPyl
	 pXr0LmLwyTENAGWhF7KdLOoIaLyIOD6AbXne7aNsqGEybvFWwxiwCXv+lv3CH1r5cg
	 1rP9nZBkevXAHt/yZTanoskdLWZkfi8+bdLYizda6kG+Gaeky1C227ERqEv9YIAENp
	 H5xof790cPFtg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, John Hsu <KCHSU0@nuvoton.com>,
 Maxim Kochetkov <fido_max@inbox.ru>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org
In-Reply-To: <20240701211631.92384-1-fido_max@inbox.ru>
References: <20240701211631.92384-1-fido_max@inbox.ru>
Subject: Re: [PATCH v3 0/2] Add master clock handling for nau8824
Message-Id: <171995169693.1021506.3631768688604058732.b4-ty@kernel.org>
Date: Tue, 02 Jul 2024 21:21:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: 6RXTVHLEQAGUQWFBD5O7RWWOSJOOWXY7
X-Message-ID-Hash: 6RXTVHLEQAGUQWFBD5O7RWWOSJOOWXY7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6RXTVHLEQAGUQWFBD5O7RWWOSJOOWXY7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, 02 Jul 2024 00:16:20 +0300, Maxim Kochetkov wrote:
> nau8824 has external MCLK pin. So add enable/disable external clock
> management.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: nau8824: Add master clock handling
      commit: fcad7177eb7854ce244ce863c82583d8a6ce5952
[2/2] ASoC: codecs: nau8824: Add master clock handling
      commit: 1d3724c92dc20584f76033347384b8c1536480af

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

