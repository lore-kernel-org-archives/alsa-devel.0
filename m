Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A30C6FA82
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 23:16:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A29CE11;
	Tue, 20 Sep 2022 01:15:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A29CE11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663629382;
	bh=cBqstNirVp3/LMuUXyvejfY8+hDyu9PM9y6tIN40Ns8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CBHigQcT05PLVMJmJgUs0Th0zVlPUjHjKfdUmPmD+ms0SBelkWUIs6E9+uYauFnqX
	 lJVVy5oX7OF8qIQamWlHsaF3KXFR1vN7Najg2wMOW4MmlI+7fMkOLvxKkYwc0AQALx
	 dtj6UfWcT2f5YJ6RpqhZkgbPwJ18gniDXUMFrLUM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B0C1F805C2;
	Tue, 20 Sep 2022 01:10:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5911DF805C2; Tue, 20 Sep 2022 01:10:52 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E38CBF805C2
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2022 01:10:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E38CBF805C2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="W8/NtMe9"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8BB48B821D1;
 Mon, 19 Sep 2022 23:10:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEA3C433D6;
 Mon, 19 Sep 2022 23:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663629048;
 bh=cBqstNirVp3/LMuUXyvejfY8+hDyu9PM9y6tIN40Ns8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=W8/NtMe9xnaROAp8gN8JdYtjSBMspTUF946nQawzwiMcwyDXI9gLP0NiKs8ZqL34b
 MBKiNnKZ/AT/CaDMjMqtb1MC7Dxz/mdodgJDB18yUBcHL93cf5mShwNoaR/0jx2inG
 s2vF+zxmCCesL8tgK8B9VPdlnTW+8bfNPI2N7oarlnw7v/QMaXsm0isK9LemyrI19H
 COWv4fqk3i7sAT7BSTMGX1OcKcmvXr57FWA+Bgzz+f2mhN5CnuKO0E6pixAyE9Ert7
 Pzt9ffOlj5YySWpMBlez7e+oSCFeHjiZEmHYSEnCFTUVN5k+UbFSlMnWPBUGjjS7ef
 6ietrQW7ZgPIg==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Jaroslav Kysela <perex@perex.cz>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Li Chen <lchen@ambarella.com>, 
 Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
 Mikhail Rudenko <mike.rudenko@gmail.com>
In-Reply-To: <20220913212256.151799-1-mike.rudenko@gmail.com>
References: <YyCqC2EypxnoJFk7@sirena.org.uk>
 <20220913212256.151799-1-mike.rudenko@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: sunxi: sun4i-codec: silence misleading error
 in probe
Message-Id: <166362904468.3419825.3057946964587586588.b4-ty@kernel.org>
Date: Tue, 20 Sep 2022 00:10:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-8af31
Cc: alsa-devel@alsa-project.org, linux-sunxi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, 14 Sep 2022 00:22:54 +0300, Mikhail Rudenko wrote:
> In the case when a codec device is probed before codec analog
> controls, snd_soc_register_card() returns -EPROBE_DEFER, resulting in
> a misleading error message
> 
>     sun4i-codec 1c22c00.codec: Failed to register our card
> 
> even if the device is probed successfully later. Use dev_err_probe()
> to demote the above error to a debug message.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/2] ASoC: sunxi: sun4i-codec: silence misleading error in probe
      commit: 30248f618d30cf1ad9d5a72126799f2f0239860c
[2/2] ASoC: sunxi: sun4i-codec: set debugfs_prefix for CPU DAI component
      commit: 717a8ff20f32792d6a94f2883e771482c37d844b

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
