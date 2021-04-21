Return-Path: <SRS0=sv+a=JS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4C3C433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Apr 2021 19:06:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6E261453
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Apr 2021 19:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6E261453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18DEE168A;
	Wed, 21 Apr 2021 21:05:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18DEE168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619031997;
	bh=tLQTUh4e7DfCE9Z9YqpaiZt6xSkNNq7hbOzBkeS5Oz0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aXZd7WZf2aF+69LqQNWrlXuKmLgn7UIw12Nm8PmkIMvkHBW31o/5JNvyBQNMXgmBc
	 6xOMu6p44Q/lhYvpXDr+P6NlNyGtqIh2rFP/Cfc+JoynnMrCI4g5fTAEkI/Q5pJjre
	 ptGiqfBQX3cs+UNTf/oXtJA1kQCnztjoQdRO/I+E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C21ADF8028B;
	Wed, 21 Apr 2021 21:04:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 995BDF80227; Wed, 21 Apr 2021 21:04:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96823F800FE
 for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2021 21:04:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96823F800FE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="M5jRhFTU"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72E4A61457;
 Wed, 21 Apr 2021 19:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619031883;
 bh=tLQTUh4e7DfCE9Z9YqpaiZt6xSkNNq7hbOzBkeS5Oz0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M5jRhFTUvREUKkvEnVUq82BkhEffyzkoGRCB077ObpVivCmWbWdL3L7JMJ3KpEK3Y
 2rLqM4XYSMmMoQ5g7WepRybVV7aWGU7vvZEjsFFzmxDSu3/IesQLTcsVZXiCdqYCWO
 ZVJXLxHC74fU6g8pw+fB2qrO2VPg2qTILGLwCUIEAjaQYH77OI/t6Tj19aPc1AY52y
 Lak9dMpS6ckeb+PHUA/+yJg0qYGsYViA+KV3s/96g0WJHbr3pBDjuDiyJy2TMeLFra
 V2L7gOpC42v2V6Cq3FaWJEdVH9MJFIjncVFuzkQhusEM3jyBNPGK5FWZWjclRfiB/C
 LvSyYsesj3OOQ==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/5] ASoC: simple-card/audio-graph: cleanups
Date: Wed, 21 Apr 2021 20:03:37 +0100
Message-Id: <161903027033.13397.4295701981761619527.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87h7k0i437.wl-kuninori.morimoto.gx@renesas.com>
References: <87h7k0i437.wl-kuninori.morimoto.gx@renesas.com>
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

On 21 Apr 2021 14:44:44 +0900, Kuninori Morimoto wrote:
> These patches cleanups simple-card / audio-graph.
> This is part of prepare for new audio-graph-card2.
> 
> Kuninori Morimoto (5):
>   ASoC: audio-graph: add graph_parse_node()
>   ASoC: audio-graph: add graph_link_init()
>   ASoC: simple-card: add simple_parse_node()
>   ASoC: simple-card: add simple_link_init()
>   ASoC: audio-graph: tidyup graph_dai_link_of_dpcm()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: audio-graph: add graph_parse_node()
      commit: 8859f809c7d5813c28ab90f5335f182e634d77af
[2/5] ASoC: audio-graph: add graph_link_init()
      commit: e51237b8d3052251421770468903fa6e4446d158
[3/5] ASoC: simple-card: add simple_parse_node()
      commit: 59c35c44a9cf89a83a92a8d26749e59497d0317d
[4/5] ASoC: simple-card: add simple_link_init()
      commit: 434392271afcff350fe11730f12b831fffaf33eb
[5/5] ASoC: audio-graph: tidyup graph_dai_link_of_dpcm()
      commit: 73371bacf0475a20ab6f3e7b6310e378ec5b3023

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
