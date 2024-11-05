Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76449D31765
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2024 16:39:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BDC9EC0;
	Tue,  5 Nov 2024 17:39:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BDC9EC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1730824753;
	bh=Fma6XFgCqfjYGnYfDtMUvnzfc/WI0JtMlx9ImAuLeyc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Sc1F715JL7FNVeAaghx6dlRhh9i7o/O3FiVrvrH9s4767DTC7J8v472xZV9v7QHw+
	 um6DJrVdy79HE3KLDZLZh/hhmGlsO/gfDhcm22Q4fJ69DPevYuKfIEABJfkaa/ulvI
	 KZSTnvFsOHKY+8B2X/ywTLbVm/9CjniwCtlc2UfY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8F77AF805E3; Tue,  5 Nov 2024 17:38:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F3C30F8059F;
	Tue,  5 Nov 2024 17:38:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BEB4FF805C0; Tue,  5 Nov 2024 17:38:26 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DE584F8059F
	for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2024 17:38:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE584F8059F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=t0ug9P1x
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EA0F9A435F3;
	Tue,  5 Nov 2024 16:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DF8C4CED3;
	Tue,  5 Nov 2024 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730824702;
	bh=Fma6XFgCqfjYGnYfDtMUvnzfc/WI0JtMlx9ImAuLeyc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=t0ug9P1xSRFfLjOY8qw7KoTG8Fpae8qE/dbeKDyC1DjIKlLX3htFFn3SMh58rk7eG
	 PhGvNEVy0DMnZu6UB7LchNEfudNim7MlKhR4eiUn80BDyimNE1Qz061uHHaT32bU5t
	 caTdOvSuNmkrqtlMUJBenL06t6BrqWL5uH2XqzB+z6rZWmpBzKFJxesshaAqJar9f8
	 S4InGPH3r3c5DsMgchCD/go/h1cTnXMB8rQXKlSWS4Gl2lXaMciVicEuvVci+VknNU
	 YJrdrQpmUY44Susjv6Ovt0QK+U+qPYpZt1NavRmjUAsprQnDiPEwXgMv5H6R5XsrSk
	 2eVp9TMAororw==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20241023124152.130706-1-krzysztof.kozlowski@linaro.org>
References: <20241023124152.130706-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: qcom: x1e80100: Support boards with two speakers
Message-Id: <173082470066.77847.3145634719799599408.b4-ty@kernel.org>
Date: Tue, 05 Nov 2024 16:38:20 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746
Message-ID-Hash: 4D5PDRVYZPWTVVZ3NQIS3NEDM7OO3FQF
X-Message-ID-Hash: 4D5PDRVYZPWTVVZ3NQIS3NEDM7OO3FQF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4D5PDRVYZPWTVVZ3NQIS3NEDM7OO3FQF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 23 Oct 2024 14:41:52 +0200, Krzysztof Kozlowski wrote:
> Some Qualcomm X1E laptops have only two speakers.  Regardless whether
> this sound card driver is suitable for them (we could re-use one for
> some older SoC), we should set reasonable channel map depending on the
> number of channels, not always 4-speaker setup.
> 
> This change is necessary for bringing audio support on Lenovo Thinkpad
> T14s with Qualcomm X1E78100 and only two speakers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: x1e80100: Support boards with two speakers
      commit: 159098859bf6d46b34a1e1f7d44d28987b875878

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

