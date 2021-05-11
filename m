Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC449C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 18:25:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E1AA6187E
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 18:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1AA6187E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 674DE18CE;
	Tue, 11 May 2021 20:24:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 674DE18CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620757549;
	bh=gYJ9w+uK7n3eS+W28JD+eHEj/qFkJTu/vjyvTNsl14A=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZspDI0wI2NEJ1mzL0L8VH3SlUFYqZhOwLx9YsuSRrJogHBI0k6vviUlWMIlDDuI4v
	 Tqp8MEGQoyyroDXlP0WmKC4sLABEkuGYwD6D6ARIYzFjNAyeI88+TAF15TGlYceXbt
	 fEz8fqzl0XKvYOkRf4NS0laCDnvrj1wOcb99aHB8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42B0FF804B2;
	Tue, 11 May 2021 20:22:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F98EF804AF; Tue, 11 May 2021 20:22:47 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FDEDF8016B
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 20:22:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FDEDF8016B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="BSUXLGvM"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51B31617ED;
 Tue, 11 May 2021 18:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620757358;
 bh=gYJ9w+uK7n3eS+W28JD+eHEj/qFkJTu/vjyvTNsl14A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BSUXLGvMe1wKh7Z2wX7wQdK/nrR5+/SA4QjFEgOp/hE8ZsNjDGlk+PwrekzQIG51m
 0TKVcBfzqwywcyi0dfIXgjiheHg/5btlQc+IC8Az8ym6i3wp2ROlQ4Yr+OUq+mnAQ8
 WAySxVmczWYDxNuOXKOKfbVOlM6vCs881iHunGLFh0vG9BLs8EroaVH2GYMek8zJpQ
 m6+onYTUJFC/kUpFQ6VoBJBLIlzagTeiHtez6X5BFqUUFYsHA+cLrOPEeyIWJK/d3a
 9zpoMJk4uowZA5jnHhUTaHmtkn7eCEdHvI6s62TsNT438dtXUONJ8sG5j1gdhvzb/0
 ZXVx+sr82RczQ==
From: Mark Brown <broonie@kernel.org>
To: Guillaume Tucker <guillaume.tucker@collabora.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 0/4] ASoC: simple-card / audio-graph re-cleanup
Date: Tue, 11 May 2021 19:21:32 +0100
Message-Id: <162075713910.17925.9413545992641276002.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <87im3qax4j.wl-kuninori.morimoto.gx@renesas.com>
References: <87im3qax4j.wl-kuninori.morimoto.gx@renesas.com>
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

On 11 May 2021 10:15:56 +0900, Kuninori Morimoto wrote:
> I'm so sorry to bother you again and again.
> These are v2 of simple-card / audio-graph re-cleanup.
> 
> KernelCI had reported that below patches broke kontron-sl28-var3-ads2
> sound card probing.
> 
> 	434392271afcff350fe "ASoC: simple-card: add simple_link_init()"
> 	59c35c44a9cf89a83a9 "ASoC: simple-card: add simple_parse_node()"
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: simple-card: add simple_parse_node()
      commit: 0919a3acc0c87049a7d787c4b8b9e64bd7c59eb3
[2/4] ASoC: simple-card: add simple_link_init()
      commit: 6ad76b573bb63ef229cf60386cc38c6e7c7625d7
[3/4] ASoC: audio-graph: tidyup graph_dai_link_of_dpcm()
      commit: f8090ffc91ffd788a73d4e6b5ca3107c94d9ec27
[4/4] ASoC: audio-graph: tidyup graph_parse_node()
      commit: 582f3503f96543f3afbaaaa085755fd167a0f71e

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
