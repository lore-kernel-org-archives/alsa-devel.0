Return-Path: <SRS0=gQoH=JR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3975EC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Apr 2021 18:38:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CE93613CD
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Apr 2021 18:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE93613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7D3681689;
	Tue, 20 Apr 2021 20:37:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7D3681689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618943879;
	bh=AZ50wh5+xEK7TNhiqGAWpMLLPp2hx2jHeqmU08zWIYw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=czJQjwi9ZDPlNMe4TCDJmoGJYhM6U0DNwKQqww++Hqzm2ZmCWQuz3B1IrS6LuVop8
	 9tZzCzfKEMWPizFYP/JZ5TKoqIECvcWKmnJnmGaNlmEM6daL7MCP6IXBTjNhMOGE2a
	 ZGFb4Fw9TVDT4wNfOyewPzKUNUHn2UnrOf0oB2J0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DFFA9F80273;
	Tue, 20 Apr 2021 20:36:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88368F80277; Tue, 20 Apr 2021 20:36:18 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C2F96F80168
 for <alsa-devel@alsa-project.org>; Tue, 20 Apr 2021 20:36:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C2F96F80168
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jULQTBTI"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 839B9613E3;
 Tue, 20 Apr 2021 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618943773;
 bh=AZ50wh5+xEK7TNhiqGAWpMLLPp2hx2jHeqmU08zWIYw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jULQTBTIQy23eRJVM3assRxFGiD32DeSpAV/DoMmo5Y3hzJlHj09Crf4Vt4f5Rro+
 v4rJWi/O1Y7otkfUikkGaL1X5YaTHMK78UINBKwkBGf+QprYoXIDpyz39SGHREF5Vk
 K2MWeB/jULvi7wKJ/aFlS/TrHWp11oi9S86r3jgEBZO9r1hCzEU02ySUR6IkBTVfuj
 ExvuEGIcX/MGWvuBIrX8dfrdPMeOFzImA3228VwV+3zsWSkP4VmSteR1DPwbAzw41x
 y6fGoFvOTWnGV2yPa14dpJoIds9RDOWD+tZAwV4NeW6VZc3BJ3SwG7HuBdCAMG6gEr
 Olui6TB8MhzTg==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/6] ASoC: audio-graph: cleanups
Date: Tue, 20 Apr 2021 19:35:33 +0100
Message-Id: <161894359363.35105.13324305632207883989.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <871rb758x7.wl-kuninori.morimoto.gx@renesas.com>
References: <871rb758x7.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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

On 19 Apr 2021 11:01:56 +0900, Kuninori Morimoto wrote:
> These patches cleanups audio-graph.
> This is part of prepare for new audio-graph-card2.
> 
> Kuninori Morimoto (6):
>   ASoC: audio-graph: move audio_graph_card_probe() to simple-card-utils.c
>   ASoC: audio-graph: move audio_graph_remove() to simple-card-utils.c
>   ASoC: audio-graph: check ports if exists
>   ASoC: audio-graph: remove "audio-graph-card," preix support
>   ASoC: audio-graph: remove unused "node" from graph_parse_mclk_fs()
>   ASoC: audio-graph: remove Platform support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: audio-graph: move audio_graph_card_probe() to simple-card-utils.c
      commit: 1a456b1c6be13514a8fc5c1a99e6763f491d17e9
[2/6] ASoC: audio-graph: move audio_graph_remove() to simple-card-utils.c
      commit: f6fcc820e0c96664e2f21c0d6bb60630243ef36a
[3/6] ASoC: audio-graph: check ports if exists
      commit: 6769ea1e4315999624ce4637c9c338b9d88a85e6
[4/6] ASoC: audio-graph: remove "audio-graph-card, " preix support
      commit: 14d78d74d7bc47c6ff3a66fb9d405084de7b6b02
[5/6] ASoC: audio-graph: remove unused "node" from graph_parse_mclk_fs()
      commit: 67800ae93982eb4496f446cfd06f98ba7382ce36
[6/6] ASoC: audio-graph: remove Platform support
      commit: 63f2f9cceb09f8e5f668e36c1cf764eea468ebed

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
