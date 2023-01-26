Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636D6C54EAA
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Jan 2023 22:57:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C3C1E86;
	Thu, 26 Jan 2023 23:56:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C3C1E86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674773844;
	bh=qfldkDJmgn8vOuHq7v2bCTrIuy1CxDE4Iarz21xaH6Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=JB1L6aFOAp5CRUIKRgpWFAjFxEeo3wF2sCJrSvkbSpWieazk1oTCL6bGJJfJ9+5nv
	 FPPAMx/ZJ9nsWUhvUuBUiGyQy7M7ygpW4Fpifh0o2TwhIfnSti3Ur07XFmoNcNik1q
	 zqTTXHBnCBdLX62JuMDUE8ujpKJqS3ogECRIYdTw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3B10F8025D;
	Thu, 26 Jan 2023 23:56:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 615C7F803DC; Thu, 26 Jan 2023 23:56:08 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF6DBF80224
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2023 23:56:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF6DBF80224
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BKdbrxpU
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 00CF161923;
 Thu, 26 Jan 2023 22:56:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418FAC4339B;
 Thu, 26 Jan 2023 22:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674773761;
 bh=qfldkDJmgn8vOuHq7v2bCTrIuy1CxDE4Iarz21xaH6Q=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=BKdbrxpUufkzeGg6jzq8xY8GiE0oDAeZu6u8EUnAd0C65AwfgU63WgymQ244cEggh
 5eKthtI0iBnTnRp78Tdt1P0Wg2+Do419IEu0wBsAlYJjwiZF1zzx0z8YTQsqa64lm0
 OISNwauKTsOH+z0GlPZTYZ5raNdcSuCh14iBnfgWPzQQFCau295T27hMqJnSXQaoas
 +CmS+KKsbKCorjSLK72Tq+pdA4Mksy//121/joEQaRPk9IgTHw3BjQykUTad8i19E+
 hmZORYywe/OhJ/J64tPPEV1ag5cVsCKjpY3xp+N4NlREkLuemO1ZBE6ykcxX2LyooK
 lBqumV/FMpXNw==
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
In-Reply-To: <20230126162203.2986339-1-arnd@kernel.org>
References: <20230126162203.2986339-1-arnd@kernel.org>
Subject: Re: [PATCH] [v2] ASoC: cs42l56: fix DT probe
Message-Id: <167477375787.524795.5320623623703804107.b4-ty@kernel.org>
Date: Thu, 26 Jan 2023 22:55:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, Zheyu Ma <zheyuma97@gmail.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, Arnd Bergmann <arnd@arndb.de>,
 Lucas Tanure <tanureal@opensource.cirrus.com>, patches@opensource.cirrus.com,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 James Schulman <james.schulman@cirrus.com>, linux-kernel@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, 26 Jan 2023 17:21:24 +0100, Arnd Bergmann wrote:
> While looking through legacy platform data users, I noticed that
> the DT probing never uses data from the DT properties, as the
> platform_data structure gets overwritten directly after it
> is initialized.
> 
> There have never been any boards defining the platform_data in
> the mainline kernel either, so this driver so far only worked
> with patched kernels or with the default values.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l56: fix DT probe
      commit: e18c6da62edc780e4f4f3c9ce07bdacd69505182

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

