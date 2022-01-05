Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7BEC433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Jan 2022 16:56:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AE7331A9F;
	Wed,  5 Jan 2022 17:55:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AE7331A9F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641401789;
	bh=jOZyDqbriAt4/oGntRUJgLrwZ2zrzE1/1/piE+VON2E=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tvmopj+8BkQATFpZmb5K6B6600gm5rOfCyTYrqfUTdbWLQB1Emw+L3ZjCErj8NQFo
	 EG5kTpT3vCxo3PmRrQ8RrWotuS2wlI3kYWRwoXSX4uW2d2QbvVfW+qqZJRJ8secjul
	 qyg8xfOb1ebZC6ayY3WC1l6VItfmaMy+AA5VaWcI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54F5EF8007E;
	Wed,  5 Jan 2022 17:55:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 628B7F801D8; Wed,  5 Jan 2022 17:55:38 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DED0EF80089
 for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2022 17:55:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DED0EF80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YDbHE4T/"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5CE18617B7;
 Wed,  5 Jan 2022 16:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20558C36AE0;
 Wed,  5 Jan 2022 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641401730;
 bh=jOZyDqbriAt4/oGntRUJgLrwZ2zrzE1/1/piE+VON2E=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=YDbHE4T/eixDVUn11TeRiD/cx7ojIPqoS4uZm8MeGALa77Rm0m/wlfuT6+8mDchv+
 qIyFMrspcgVliBFbDnpvERhWtklaGsLuUFn72Y4yRW7kffBdGrSjM0weRBkxhx5qeZ
 fSA9hdQ4lRsTcedyXYwZIDNXp4Ya9VnMu03tSl9J90H6LSeSAywiuxo37XZqEUmcBl
 XNQ9V/m712CcGN9J0WUEuMCyOaCsK0dfZSg/l2TKdKGBIHJnK6/QmzeZpBGlNhQ3B5
 9uxarLVknKEkEQXFlabZ0YFWoOXsbrV4QC2Lswg1w9vRPUbgjfROFF2ofSbLmu8BhX
 tewEiywvqzrHg==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <20220105162409.20635-1-tiwai@suse.de>
References: <20220105162409.20635-1-tiwai@suse.de>
Subject: Re: [PATCH] ASoC: ak4375: Fix unused function error
Message-Id: <164140172980.3903034.5736291727659829206.b4-ty@kernel.org>
Date: Wed, 05 Jan 2022 16:55:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Vincent Knecht <vincent.knecht@mailoo.org>
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

On Wed, 5 Jan 2022 17:24:09 +0100, Takashi Iwai wrote:
> A randconfig caught a compile warning that is now treated as a fatal
> error:
>   sound/soc/codecs/ak4375.c:415:13: error: ‘ak4375_power_off’ defined but not used [-Werror=unused-function]
> 
> where ak4375_power_off() is used only from the PM handler.
> 
> As both suspend and resumes are already marked with __maybe_unused,
> let's rip off the superfluous ifdef CONFIG_PM, so that the error above
> can be avoided.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ak4375: Fix unused function error
      commit: e4c35e75209bda13e57c9bc8d280366c2b9275a5

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
