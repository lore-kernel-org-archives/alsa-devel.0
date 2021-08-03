Return-Path: <SRS0=EjE+=M2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57496C4338F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 22:39:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C453760EBB
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Aug 2021 22:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C453760EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D6121710;
	Wed,  4 Aug 2021 00:38:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D6121710
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628030384;
	bh=W6wGwDkGz1Q64FWYoYQlIjt/pCG+c+LwgzT4EQZImK0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sXr0G1XZi77uemgHr4w5sEw6ISLjLxwgyITplf6GdnzfWVtuu4Hp6tagqPwCbcJ5v
	 hLXREWH7fACBxJWK2/g8hsbji3sRX4nklnxBCyqOzzluopr8Bdf3t1r505ZRi0aa2n
	 b3hHHWlyO66PTsfmlNC1waMDWQ+uPVZ4QEEJ+pXE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E6D0F80506;
	Wed,  4 Aug 2021 00:36:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1898F8050F; Wed,  4 Aug 2021 00:36:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 53121F80506
 for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2021 00:36:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 53121F80506
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Vk1ewMc3"
Received: by mail.kernel.org (Postfix) with ESMTPSA id D403D6103C;
 Tue,  3 Aug 2021 22:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628030191;
 bh=W6wGwDkGz1Q64FWYoYQlIjt/pCG+c+LwgzT4EQZImK0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vk1ewMc3/UZsXVOgFGT8sZanMhVR9mwXvw4h2uBKLfbhPNUE/7lc4gkuKI1zOOflo
 L399NSzkqLdmV//zD9coxdk+3OuOMQW8Ga6s0SdUJ6Kzw+/Ef/7Fy5/U7Nead2Hg5d
 S2atCRLFKAEx5vfcNqcsvkbiIf9eTCyVr/S9ErK1IMrhLYY7J0SnlmcdeLD0r7g2XW
 aXYjIfymSosKxhNOMOQpjrrIAP3+/lAbMT4IriWPyKEDd6IFUsy39Y/2mQrZz3fSqp
 y7D354iWDU/+NbZCNVWM6HraAkF8+x+QCU3CQAteaQ/vn9j1LGEIldZ1fh+YKy6NIw
 K7eDcTNJqgLvw==
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/4] ASoC: soc-ops: cleanup cppcheck warning
Date: Tue,  3 Aug 2021 23:35:42 +0100
Message-Id: <162802985540.42099.16970663853785518537.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <875ywnw2ar.wl-kuninori.morimoto.gx@renesas.com>
References: <875ywnw2ar.wl-kuninori.morimoto.gx@renesas.com>
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

On 03 Aug 2021 14:00:12 +0900, Kuninori Morimoto wrote:
> Now I'm posting audio-graph-card2 patch-set, but it seems it needs longer
> discussion. Thus I want to post more easy patch first, and reduce my
> local patches.
> 
> These are cppcheck warning cleanup patches for soc-ops.
> 
> Kuninori Morimoto (4):
>   ASoC: soc-ops: cleanup cppcheck warning at snd_soc_put_volsw_sx()
>   ASoC: soc-ops: cleanup cppcheck warning at snd_soc_limit_volume()
>   ASoC: soc-ops: cleanup cppcheck warning at snd_soc_get_xr_sx()
>   ASoC: soc-ops: cleanup cppcheck warning at snd_soc_put_xr_sx()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: soc-ops: cleanup cppcheck warning at snd_soc_put_volsw_sx()
      commit: 58f42dfd7977599b060996491412fcec688d025d
[2/4] ASoC: soc-ops: cleanup cppcheck warning at snd_soc_limit_volume()
      commit: 872040f7980b929d75877e7b9d721ea808ce06e1
[3/4] ASoC: soc-ops: cleanup cppcheck warning at snd_soc_get_xr_sx()
      commit: b1ebecb90bf69fbd288e873bbf545061f5a6c144
[4/4] ASoC: soc-ops: cleanup cppcheck warning at snd_soc_put_xr_sx()
      commit: b285b51018a7ca206401829fb83c8b967c22bfa5

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
