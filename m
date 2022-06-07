Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F53AC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jun 2022 10:54:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F8E11AB4;
	Tue,  7 Jun 2022 12:53:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F8E11AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654599268;
	bh=0D+tn4T5VwkAbtlCnkNSQiUQ+Bka36vahBMW9yn7jWs=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h/ctmJiumccfue6MxWUDioCe6gg+G3Ecat3BCCLemT8QcPSIhfPOtlYxdQK0qz8xS
	 Q+UGMxbh/hyAqPPpLu1Gf9xZovlAWdIKUsjL2aqz8ckfolZeaJdgBHlUi2X7G1McEv
	 4aN6L0PCIDYyxGu7SZM+00AtAdrMamtb1KYt6CTU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2EC5EF80606;
	Tue,  7 Jun 2022 12:46:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C70EF80607; Tue,  7 Jun 2022 12:46:30 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0C5EF805FD
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2022 12:46:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0C5EF805FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XN4OtEC1"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 68F7E61563;
 Tue,  7 Jun 2022 10:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DB8C34114;
 Tue,  7 Jun 2022 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654598786;
 bh=0D+tn4T5VwkAbtlCnkNSQiUQ+Bka36vahBMW9yn7jWs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=XN4OtEC1ReiFN5hrpvP9Cq0PlQPq7YfJvoOUz4LGPyKKlCkjQsrmUKdomdFAAM9Te
 fyZcmp7oO2ftDXjge+iSNiy13lm0+l8lD0CsQ6V6jnWbkgwr52PaswPwc5atqcLSH4
 3ABphjfscleAu/awS3918OV5qLYnVhXgoS5Gh74VzTsQmI2bajgKp66YztbgS5lnu6
 hAhGwTsVAnbjIF/70ySUiM/TwVhYdRKQCm+HbtRuKN5UVKpIgZrmgmUIfoEnoC3QiZ
 VqOvuz+DlJdyKmMonFsv0vuS+1wK8VF8xdTS9l9csNkz1nt+fgRXZApaosIZDCcEPn
 5ihB1ZNmT3Rnw==
From: Mark Brown <broonie@kernel.org>
To: aford173@gmail.com, alsa-devel@alsa-project.org
In-Reply-To: <20220526182129.538472-1-aford173@gmail.com>
References: <20220526182129.538472-1-aford173@gmail.com>
Subject: Re: [PATCH] ASoC: wm8962: Fix suspend while playing music
Message-Id: <165459878357.301808.15345032675363899374.b4-ty@kernel.org>
Date: Tue, 07 Jun 2022 11:46:23 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: ckeepax@opensource.cirrus.com, geert+renesas@glider.be,
 open list <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 aford@beaconembedded.com, Takashi Iwai <tiwai@suse.com>,
 chi.minghao@zte.com.cn,
 "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.cirrus.com>,
 steve@sk2.org
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

On Thu, 26 May 2022 13:21:28 -0500, Adam Ford wrote:
> If the audio CODEC is playing sound when the system is suspended,
> it can be left in a state which throws the following error:
> 
> wm8962 3-001a: ASoC: error at soc_component_read_no_lock on wm8962.3-001a: -16
> 
> Once this error has occurred, the audio will not work again until rebooted.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8962: Fix suspend while playing music
      commit: d1f5272c0f7d2e53c6f2480f46725442776f5f78

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
