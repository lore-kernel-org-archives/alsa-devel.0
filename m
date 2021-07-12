Return-Path: <SRS0=F1iH=ME=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062A9C07E99
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 10:53:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8739160698
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 10:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8739160698
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F96C1684;
	Mon, 12 Jul 2021 12:52:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F96C1684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626087187;
	bh=Q0LmCKQCfSGQOND5wXq1ayQltdByrVvEHp3u5Nb9hAo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GDwBjrcAI74mekg+xMIHXnYZG1nT+SfC1eS1T4iPQtP09Awn8dWkpJde+vEASBvio
	 l5jGL6d3vndrmvzrvORjJYB85D6oYjuUS2H0rT9v9IIrjGiTne+NPlfzG/mzNBjFwI
	 j/DKldkGQ/gXVYoMnMUdujJA3jxCPSyiTrzc97pQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04747F80526;
	Mon, 12 Jul 2021 12:48:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7DD2F80515; Mon, 12 Jul 2021 12:48:18 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D9E2F8051B
 for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2021 12:48:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D9E2F8051B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OjzSBlw+"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 532BC61156;
 Mon, 12 Jul 2021 10:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626086890;
 bh=Q0LmCKQCfSGQOND5wXq1ayQltdByrVvEHp3u5Nb9hAo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OjzSBlw+Jag83c6fTsDidspwoNOir2H7BVY60natVm45ehitMnbfA9ZABVDFbMXpY
 XGsJfr/pUB31vykZ5C23N+q2TodcsoILwlrkDApoRPl7zFEt/S38c1ry1ClRzG8v6o
 8Oyr/1ZbW6z4c9K2x2jDbg3wEPAeRpfX9Mc5OoqY+/XNwV1mvPYHebYXnHFp1KCecR
 PT0VltXhuY585NBM1J5m6pWWkZoCMs0i4HIVKBYUmOl10Jq88YzlQkHYcFJrKOOsgP
 /zORv7l+m6RyZR+Qlt8+y2mdPohY5sHHO+hTyiPfE+6w7DksfsqM/4CeLOph6nXMRv
 arjYtGoWdIxdA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH RFC] ASoC: sh: rcar: dma: : use proper DMAENGINE API for
 termination
Date: Mon, 12 Jul 2021 11:46:09 +0100
Message-Id: <162608623151.3192.11307653106365626153.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210623100545.3926-1-wsa+renesas@sang-engineering.com>
References: <20210623100545.3926-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
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

On Wed, 23 Jun 2021 12:05:45 +0200, Wolfram Sang wrote:
> dmaengine_terminate_all() is deprecated in favor of explicitly saying if
> it should be sync or async. Here, we want dmaengine_terminate_sync()
> because there is no other synchronization code in the driver to handle
> an async case.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sh: rcar: dma: : use proper DMAENGINE API for termination
      commit: d5bb69dc54ec1e09f3fd626fdb9c340c0511dbd5

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
