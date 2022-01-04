Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8929EC433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Jan 2022 16:03:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 54A9C17CA;
	Tue,  4 Jan 2022 17:02:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 54A9C17CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1641312189;
	bh=9KxTeCJsKsjATFxUvGibyDM6eKFv4bAjCOg9AG/Ir1U=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GNIGqlxhk1CNvl6I/9GMuMdP4T+C9qRyXeuKdfOUlumcyMBbko38LsUcRijgmgcK9
	 ZG4cfwDZrqBwvDUPHf9r4w2wtLlbWA3tt5dOD2doyhpPIqy6U/jwgOje25+Y24EqmR
	 TW/rGiUXiB0eXAbxmkfSXzqVuLL+uF78b+RYEzKs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA9D1F80089;
	Tue,  4 Jan 2022 17:02:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 370C3F80310; Tue,  4 Jan 2022 17:02:17 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D43CEF80089
 for <alsa-devel@alsa-project.org>; Tue,  4 Jan 2022 17:02:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D43CEF80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ir698UmB"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0EDC9B8172F;
 Tue,  4 Jan 2022 16:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA46C36AE9;
 Tue,  4 Jan 2022 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641312131;
 bh=9KxTeCJsKsjATFxUvGibyDM6eKFv4bAjCOg9AG/Ir1U=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ir698UmBabo+QGYf/X1gZM9FVfEJrrw7rJOf8j5Oxt4IG3DeEqNDL88fb2CZ0bgvl
 B76WoYfC2inrl2w/mlVX4UrnrQc4V+7ZLpy7DPO3l2Sk2ZqoXEBid/oke4KvQlPuoo
 /5uxnJGx0CHf1tomRGW7fw1qyjMqg8zPLCzK5LRVqXJxkUKV1GqbfN7A3rilm8RpDX
 k2zSbK6XqKN1KYlGrBfyhIIcfHnvGiELYszYTlbQc0fmcfmT7c3V9oJrtcpoAYi2Cx
 V3tiiFy9MWlBH7FO+fpjljVMRHqQFeFgImyDYz04veWmmcwUxgQMCNn4P4O5FOC1kS
 b7F/P95Zt4cCw==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Fabio Estevam <festevam@gmail.com>,
 Alyssa Ross <hi@alyssa.is>, Xiubo Li <Xiubo.Lee@gmail.com>
In-Reply-To: <20220104132218.1690103-1-hi@alyssa.is>
References: <20220104132218.1690103-1-hi@alyssa.is>
Subject: Re: [PATCH] ASoC: fsl_mqs: fix MODULE_ALIAS
Message-Id: <164131212940.2665058.488131982799251609.b4-ty@kernel.org>
Date: Tue, 04 Jan 2022 16:02:09 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: "moderated list:FREESCALE SOC SOUND DRIVERS" <alsa-devel@alsa-project.org>,
 "open list:FREESCALE SOC SOUND DRIVERS" <linuxppc-dev@lists.ozlabs.org>,
 open list <linux-kernel@vger.kernel.org>
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

On Tue, 4 Jan 2022 13:22:16 +0000, Alyssa Ross wrote:
> modprobe can't handle spaces in aliases.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_mqs: fix MODULE_ALIAS
      commit: 9f3d45318dd9e739ed62e4218839a7a824d3cced

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
