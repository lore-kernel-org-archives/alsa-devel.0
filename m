Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77495C001DD
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Jul 2023 11:48:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1854F845;
	Wed, 12 Jul 2023 13:47:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1854F845
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689162505;
	bh=JfAJmko1aJRSaP7TINdHFWcUEpNZeyWnoLSyFMLbQ1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=sho2yJlMdLBbTBwv9qpCoBW8Dk7ryQGInp5I+zX+wKNe6PxxqZ+PSalKrAKHgr76I
	 oOMnXO5fbhaGUE/ZNVd2OTa42UMF2tiktke5c7U5C1QhqmSA8Cfb8HAizW8lmUr1v+
	 /7+lUP4dY8L+llTCtG/czfru4+gcFf1FLHKPwfNI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B29D8F80563; Wed, 12 Jul 2023 13:46:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 46C8FF80548;
	Wed, 12 Jul 2023 13:46:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E9DF0F80153; Wed, 12 Jul 2023 13:46:40 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BA61FF80153
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2023 13:46:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA61FF80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fwbpSHkS
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6367461794;
	Wed, 12 Jul 2023 11:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4125CC433C7;
	Wed, 12 Jul 2023 11:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689162396;
	bh=JfAJmko1aJRSaP7TINdHFWcUEpNZeyWnoLSyFMLbQ1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fwbpSHkSXzwXLCUhn047ZFcWSacGcEuAI3FDal2kLkvEmN39lD+7PDhxfYRCXZrHH
	 w0HOqNOcH20Y0qrmGnVy2eLJut+lLO9XHdDcw/uiBcETj1UyzgmgLT5RBa6Fpnp4c+
	 2yR8H4TXW2u4+NjQG97ywb7kWsOFqAHG4ZdmOue0c5hPmzgOpJrfD8Ria0HuuPxI61
	 bO3Vq2w0tqvVG8XEHoPx3R8yTfYqWV4s1nRyX+l001yhhhjcyu/uGf0vaH3PG/G+oe
	 DmDC4SMntNDHHCfk4a256P/5VOV8lXOEYxw5CdxODFv1Ef+XlOsZPzaMP3HPdthIsW
	 FOo8jn/OD1JUA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Maxim Kochetkov <fido_max@inbox.ru>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 linux-kernel@vger.kernel.org
In-Reply-To: <20230622200031.120168-1-fido_max@inbox.ru>
References: <20230622200031.120168-1-fido_max@inbox.ru>
Subject: Re: [PATCH 1/1] ASoC: dwc: Add TDM mode support
Message-Id: <168916239498.46574.17040114171305737838.b4-ty@kernel.org>
Date: Wed, 12 Jul 2023 12:46:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Message-ID-Hash: E33GYBUQTO352SD4ACUZY3MTH7SGSHDW
X-Message-ID-Hash: E33GYBUQTO352SD4ACUZY3MTH7SGSHDW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E33GYBUQTO352SD4ACUZY3MTH7SGSHDW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Thu, 22 Jun 2023 23:00:29 +0300, Maxim Kochetkov wrote:
> Depending on hardware implementaion of DWC I2S controller may support
> TDM mode if enabled in SoC at design time.
> Unfortunately there is no way to detect TDM capability for DWC by
> reading registers. Anyway, if such capability enabled, TDM mode
> can be enabled and configured by dai-tdm-slot-* DT options.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dwc: Add TDM mode support
      commit: 221acc16aee16eb246bad32a6b9014021218b7cd

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

