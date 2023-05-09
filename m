Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B46DC77B7C
	for <alsa-devel@archiver.kernel.org>; Tue,  9 May 2023 06:42:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6483B113C;
	Tue,  9 May 2023 08:41:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6483B113C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683614530;
	bh=w22KuX01pMZbO/Eaa6JLtKePa21cyYmG8SwUr9hiNyw=;
	h=From:To:In-Reply-To:References:Subject:Date:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=n3UdoaNtpJwpqTImdZuSMx2+cyjLoZruY+FIyz/NabvrdIqUOZRIBzwFRESfTrEzG
	 0/mmwiAniddlj2i6mHKFx0Eq9mkzUrsNXOhc4cY6ZKk5Rrj7zp0r2dsFVKKmFpot9z
	 bfpfNsZoLSo+nrdXZuHAtsmuqk1+0XynluhHHVkU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D6B2EF80589;
	Tue,  9 May 2023 08:39:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D004FF8057F; Tue,  9 May 2023 08:39:11 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9C728F80567
	for <alsa-devel@alsa-project.org>; Tue,  9 May 2023 08:39:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C728F80567
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=IlTXY2aC
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 670626445F;
	Tue,  9 May 2023 06:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B629C433EF;
	Tue,  9 May 2023 06:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683614348;
	bh=w22KuX01pMZbO/Eaa6JLtKePa21cyYmG8SwUr9hiNyw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IlTXY2aCEu3Kl2vnXKCZZeoatsDFBy1icDMudOcR8MwKfg8GF4CyU+J0ULOaggod6
	 59qXgpp7PyhhHfp8MCeDCdflybDeEFgRSxfAADu1zRj82SmwmbUwi/xKLXGPhS5Ede
	 aubQxRLVVoym0NzqSpINOLJqvKsgFQsEh/LItG5orBwMH2IyyiG7K+oWGctHrOseRl
	 UD/i/G6Iqj3R4I7zRHKNHIM1I6s/YZnrnqht83bnf/CYkg/pqxf966b5wi6UuSdZ8X
	 A5mesHEWClaSKcI/2OSv4KsK1BHEN8w2xoitPSCpe3hJ0BX3lAzlcudu8gQ8mneJI9
	 gWVMjtPNm86Cw==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, Anup Sharma <anupnewsmail@gmail.com>
In-Reply-To: <ZFYxWVdE9YkMKvXv@yoga>
References: <ZFYxWVdE9YkMKvXv@yoga>
Subject: Re: [PATCH v2] ASoC: dt-bindings: nau8540: Convert to dtschema
Message-Id: <168361434507.303059.8363951498743127692.b4-ty@kernel.org>
Date: Tue, 09 May 2023 15:39:05 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-bfdf5
Message-ID-Hash: PXPJLLSSCCBJRIDXVYXRATJTQQIWIN2E
X-Message-ID-Hash: PXPJLLSSCCBJRIDXVYXRATJTQQIWIN2E
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, KCHSU0@nuvoton.com, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PXPJLLSSCCBJRIDXVYXRATJTQQIWIN2E/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, 06 May 2023 16:22:09 +0530, Anup Sharma wrote:
> Convert the NAU8540 audio CODEC bindings to DT schema
> 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> 
> Changes:
> V1 -> V2: Adhere to the correct procedure by including the maintainer's name.
>           Drop Mark from maintainer.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: nau8540: Convert to dtschema
      commit: 0f0d70c2881f8c28e6d449349e057963a742f842

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

