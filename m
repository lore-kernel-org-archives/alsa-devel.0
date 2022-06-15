Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87853C43334
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jun 2022 17:09:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C1AF193D;
	Wed, 15 Jun 2022 19:08:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C1AF193D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655312979;
	bh=Wcvp8mCTF0vA1Izf8dbxoQE7s/QBBKvOMJdR6TDX1nE=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nQsDwgIL+I3W3Ifs9MKsJRcS17MUBv/E0rcdv/GRvWQYn9awYLmbXvkGk2zGyDK+L
	 Xe3sp7Ch15ZBs377O3eqbNimwN4w/ru2705VV7u1JyQOse/Mf/K5KZ6GkDpWKP+gar
	 jY2FjB39IgS+YnYb5mvYrTLJhVO7FNCnuGwGbGNE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3CEEF80162;
	Wed, 15 Jun 2022 19:08:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 319CDF8012B; Wed, 15 Jun 2022 19:08:47 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D623DF8012B;
 Wed, 15 Jun 2022 19:08:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D623DF8012B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Q+AmjVG1"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 1549CB81FF0;
 Wed, 15 Jun 2022 17:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A64CC34115;
 Wed, 15 Jun 2022 17:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655312918;
 bh=Wcvp8mCTF0vA1Izf8dbxoQE7s/QBBKvOMJdR6TDX1nE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Q+AmjVG1yX//0RTOk2NZsCrpHZ342RhxY/RE7Y15d151OqRkHWEDHp3rh8Kx7lfFc
 pmEJtElprkPA40vW4SolGJ37QtUdO9FpyokWuINtpWy8dE20H+ur4lE9FMTVWHRWPC
 g0fsUSq1vZTOhqmzo/r6v664VObEnaewO7YyYY+mZEbdBEa7GG3YjSB6POskxi3mTP
 2u9VzI9e/79Bcm5STijGhaaSPXLpybR5H9hd5vvMHyANUtfVt8LBfQwLakGZlVsNzg
 4qknUsPn+1C/A6ZBll1/2+evkXn+JbNf9FKypbmQv1g3eP6cmgNtGsSvPIHo0zEYYG
 XRqqtZFKIAA1w==
From: Mark Brown <broonie@kernel.org>
To: dan.carpenter@oracle.com, tinghan.shen@mediatek.com,
 pierre-louis.bossart@linux.intel.com
In-Reply-To: <YqmWIK8sTj578OJP@kili>
References: <YqmWIK8sTj578OJP@kili>
Subject: Re: [PATCH] ASoC: SOF: mediatek: Fix error code in probe
Message-Id: <165531291502.3574042.3082631572005013512.b4-ty@kernel.org>
Date: Wed, 15 Jun 2022 18:08:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Allen-KH.Cheng@mediatek.com,
 kai.vehmanen@linux.intel.com, peter.ujfalusi@linux.intel.com,
 yangyingliang@huawei.com, kernel-janitors@vger.kernel.org, lgirdwood@gmail.com,
 tiwai@suse.com, linux-mediatek@lists.infradead.org,
 ranjani.sridharan@linux.intel.com, yc.hung@mediatek.com,
 matthias.bgg@gmail.com, daniel.baluta@nxp.com,
 sound-open-firmware@alsa-project.org
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

On Wed, 15 Jun 2022 11:19:44 +0300, Dan Carpenter wrote:
> This should return PTR_ERR() instead of IS_ERR().
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: mediatek: Fix error code in probe
      commit: 62257638170eee07926c9df5a4c9059ec69a3734

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
