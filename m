Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0406C43219
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Nov 2022 17:36:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE539E12;
	Fri, 11 Nov 2022 18:35:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE539E12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668188171;
	bh=UKdG0jYcvCg9PJRFKc1XAZPF2v8tjzpdbjn0X62H8MI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L4Y6wM2HO8B9KJMl0pvuXA4vm7g8UoHHkLZKjvcy606Kx4UVtZWvg8pl8XnJUkiVp
	 oIvI0c8/Pk64NyyswsneIz6t41Jz1JM36DRJ3qaKcu9QbzmO9Jowcc9HXJNMam3lxE
	 ht0cVsNw0uyTLMENvtNMsm+5zFfVKbqPlET8V62o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D12AF80249;
	Fri, 11 Nov 2022 18:34:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C37D4F80249; Fri, 11 Nov 2022 18:34:33 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82FC1F80249
 for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2022 18:34:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82FC1F80249
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pi0fc0qY"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D82AD62074;
 Fri, 11 Nov 2022 17:34:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9A2C433D6;
 Fri, 11 Nov 2022 17:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668188065;
 bh=UKdG0jYcvCg9PJRFKc1XAZPF2v8tjzpdbjn0X62H8MI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=pi0fc0qYYaGXRh5klnRGyneB79bIjlR6DVFCn3phZ+sYywMzRlyXaCBp2YznkVAED
 AsAmBCcMNl13dwCj5G0bAQImw8/nGX3ym1HDTD9zx2T9BzlR3ZPBtpOcVkc7aMyz3X
 729rSemK9tdrnP75KOS/cIts6LOwMUCjg5h0KJ+fDmaDr0oYeFg6+WlA+78MRU4OpZ
 QsTZ4Njwuu2UaM5uGQmFOKKZUEsHKDZtA+TwPRtAP8FrF3sWZYDzwz/g8fIkf+v9eH
 8utnm0y4gXcd94NpdcRLrksQ6sbhL/Y3994SLI5UpusnS+Ds230CByYtrPT7IQOwUa
 i/MJDNYsB4yMQ==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k042nm6s.wl-kuninori.morimoto.gx@renesas.com>
References: <87k042nm6s.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: audio-graph-card2: remove Experimental announce
Message-Id: <166818806450.535544.9386351140585214973.b4-ty@kernel.org>
Date: Fri, 11 Nov 2022 17:34:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fc921
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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

On Fri, 11 Nov 2022 04:34:51 +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Audio Graph Card2 has been announcing "Audio Graph Card2 is
> still under Experimental stage", but it is time to remove it.
> This patch removes it.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: audio-graph-card2: remove Experimental announce
      commit: 1985fa962a6dd8fc002cbf7b2c894ebcc44b2eb2

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
