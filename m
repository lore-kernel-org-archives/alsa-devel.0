Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF4FC30658
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:08:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D4FC238B;
	Fri, 28 Jun 2024 19:07:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D4FC238B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1719594479;
	bh=1RFinm/cPZYC9mpxmSXlKDXt3LLEft9BIYps8Te54Xo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=oXRTx/wX2ccMeEqUWZJq+b+hqMb5b7VdzOcG91iVWD0CuxWXwvVB8FKHT/9IkZIjO
	 mkCAUng/kd0x5F0aiTId8KeYaqkoEKgaND9Gows2QklIV6wm6qXbnO9LgYOIJg+4kx
	 3CBJBLjap2miqpSWqWtQ4y/2yzS32+6lvK3eLZNo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6E51CF805E4; Fri, 28 Jun 2024 19:07:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 84C3CF805E4;
	Fri, 28 Jun 2024 19:07:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F293EF80423; Fri, 28 Jun 2024 19:07:09 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 14294F8016E
	for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2024 19:07:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 14294F8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=B8K04298
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 033B06211B;
	Fri, 28 Jun 2024 17:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D947AC116B1;
	Fri, 28 Jun 2024 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719594421;
	bh=1RFinm/cPZYC9mpxmSXlKDXt3LLEft9BIYps8Te54Xo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B8K04298o2v0tFF0KY1zlUqG1QWe2B38/9UUfJwyAswB+gdI4+ROcnDz9Q98mh6Ih
	 VMP0+BYNNHiwbY0uEQkuqbzyDCa4UtG7DJb+c9hiNFWRZUFrBmiCJsPNfeaBZY6Jhi
	 0bWv1X4fWRBLeoerfR61nRl9FHqaAIIKiQzqAyBzAuKSzAHbIQSIAnIEigRY4jqOWY
	 SK1zJg5KDgnRg8j86iPFthSCh8yS9lE/W6QLN2IXPLoaEANISF8Dw2MqI5drwyMWEQ
	 bm9X545hcSi1TmXsqOPDJPEben9/qm276GrWZJlobRNjtnVFz3/eqBbujaQ7oG1kzh
	 uDzs/MCGziMFQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
 Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240628123256.2019224-1-jbrunet@baylibre.com>
References: <20240628123256.2019224-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: tdm: add sample rate support up to 768kHz
Message-Id: <171959441961.130075.4855510935970492560.b4-ty@kernel.org>
Date: Fri, 28 Jun 2024 18:06:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707
Message-ID-Hash: PJGMHVOL3OW2AAMK2JM354BMXXPJMNJJ
X-Message-ID-Hash: PJGMHVOL3OW2AAMK2JM354BMXXPJMNJJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PJGMHVOL3OW2AAMK2JM354BMXXPJMNJJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 28 Jun 2024 14:32:54 +0200, Jerome Brunet wrote:
> Add support for 705.6kHz and 768kHz sample rates
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: tdm: add sample rate support up to 768kHz
      commit: 730674b21db12be6ea6b3034c618de5d7a16987d

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

