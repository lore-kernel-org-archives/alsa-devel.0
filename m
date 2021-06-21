Return-Path: <SRS0=WNc7=LP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EB7C4743C
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:50:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97ED61245
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Jun 2021 18:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97ED61245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5A5D91700;
	Mon, 21 Jun 2021 20:49:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5A5D91700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624301448;
	bh=Hvqbvb8PEP9vWPndDQlnnurh023iAvKbgDVNy5Fy/VE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oPsRRzVnNq7mf9cE9kJj0umJ3J4GVdIQ4Ayy6uJDCsj8U8OmVy7zdNvLwq9dLWcuK
	 8i5dBquxtRq6Vm2KNbzp3bMIOcjh0s7PX8OUIQpAiCGPqQUAjBQgHvCu66knNE+thf
	 fMeR/gbo/f5i2YXnZEF9sVSTvcKlhEHTnw3FHSzg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F7BEF804FF;
	Mon, 21 Jun 2021 20:47:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72457F804E5; Mon, 21 Jun 2021 20:47:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE506F804DA
 for <alsa-devel@alsa-project.org>; Mon, 21 Jun 2021 20:47:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE506F804DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qpz7GK5d"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C260F6128A;
 Mon, 21 Jun 2021 18:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624301229;
 bh=Hvqbvb8PEP9vWPndDQlnnurh023iAvKbgDVNy5Fy/VE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qpz7GK5doKWuCvFcAPBastocIb80UdJmfCuF8sXGOyIznO4YQ2NJmnH8ivpKT/lS+
 aFhnzUSTd4sRjSQxs3kr0ah17nPIJ9tSj5c7yFvQnWfY8Q1E7mh6gxCVoNXAQyZdc4
 e4hFcziXubn77RvcnhZYmp3EC49+EZl1u5Od0liYs+1s4YeytWumcDgPdXvcSxhZO8
 b+iXyWM1izHzt3ZZFJxuM2ZwW2QW9IQLKw2q0YdM5wWKph89Q97rq3Cl9u90H/Ldnb
 +SCsI9571ubZJQu2KTRoWYf4qz9x3rINElkDfF3Lfq8qhj6SUjDkebvM58ZxC9Qr0h
 D5UI2yUa43dnw==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v3 0/8] ASoC: tidyup snd_soc_of_parse_daifmt()
Date: Mon, 21 Jun 2021 19:46:03 +0100
Message-Id: <162430055264.9224.15415217994628967307.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87bl89w9fw.wl-kuninori.morimoto.gx@renesas.com>
References: <87bl89w9fw.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Neil Armstrong <narmstrong@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Sameer Pujar <spujar@nvidia.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Fabio Estevam <festevam@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>
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

On 14 Jun 2021 09:56:19 +0900, Kuninori Morimoto wrote:
> These are v3 of parsing for daifmt.
> 
> I want to add new audio-graph-card2 sound card driver,
> and this is last part of necessary soc-core cleanup for it.
> 
> Current some drivers are using DT, and then,
> snd_soc_of_parse_daifmt() parses daifmt, but bitclock/frame provider
> parsing part is one of headache, because we are assuming below both cases.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: soc-core: add snd_soc_daifmt_clock_provider_from_bitmap()
      commit: 91ae447762517c814672e2e5ff2383348101a032
[2/8] ASoC: soc-core: add snd_soc_daifmt_clock_provider_fliped()
      commit: b44a67f89366597364693e07e814660d5df8c66f
[3/8] ASoC: soc-core: add snd_soc_daifmt_parse_format/clock_provider()
      commit: 7766861d1f8d3afc35361ab599eee6851fcd4416
[4/8] ASoC: atmel: switch to use snd_soc_daifmt_parse_format/clock_provider()
      commit: 22108b9c2248f187d2b50af14e48807a0fb3db79
[5/8] ASoC: fsl: switch to use snd_soc_daifmt_parse_format/clock_provider()
      commit: 3bba9414512fc16c96c4cd25ee6447c8da4b4a76
[6/8] ASoC: meson: switch to use snd_soc_daifmt_parse_format/clock_provider()
      commit: 0c4c7a9667daf52c88cfc7fe44201ff653eab8f9
[7/8] ASoC: simple-card-utils: switch to use snd_soc_daifmt_parse_format/clock_provider()
      commit: 2c7fd9de8956ea1d8ea18b11d33fcf2fde9da81e
[8/8] ASoC: soc-core: remove snd_soc_of_parse_daifmt()
      commit: 8439c5861cf0c88037f6e9cdd3ba5f1c472f847a

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
