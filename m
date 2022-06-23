Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9A4C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jun 2022 13:59:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B95BA1AAB;
	Thu, 23 Jun 2022 15:58:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B95BA1AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655992789;
	bh=QTbgOAZwMyn05WBjxP2ZCaMwk4y/Iz2SpmqxwtERJAI=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sGZBaAZHSmOvGTO2S4uYtpmWeiWJsQ2vJe/zESvabVjeuA7LTS8a9na7DRW6ynOtD
	 6m9jtMiY8zDU0hh04KxQnHd//B7BfF7g9RxWBc6XfvkgRKw8wI6NwoflRzInL7gywp
	 yLCVSlSqY+TzMR/tBXgtB7gcteIMgEOmVuUdx9co=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44ED3F804C1;
	Thu, 23 Jun 2022 15:58:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1008F800BD; Thu, 23 Jun 2022 15:58:57 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56D80F800BD
 for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2022 15:58:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56D80F800BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Tf8T51sH"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9A36A61DE7;
 Thu, 23 Jun 2022 13:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05A9C3411B;
 Thu, 23 Jun 2022 13:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655992732;
 bh=QTbgOAZwMyn05WBjxP2ZCaMwk4y/Iz2SpmqxwtERJAI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Tf8T51sHVep8tOFxWqdD/A/vx48C12KeSiJbaKdh1dP9Iezx8bHHnvidqJWLKru/R
 MhGntlBojNf4fKWdLQeNdkee1okdmRMpUiPq+x6CeJwdPHsbA+Ei2THXufR/XvYT1X
 HwpJr4hAaXhrzx+0m1PERjB1RMJs1I6Dx1eQIDtWJNU3awfytnc6X3FWKKntI25fWj
 Q+E0pZWqqeFUUzXyqFg3eMa227a6lPgJm6jf4D7vMm7IP8E4JbfKvctjfY5YelOnF0
 GRw90IUQCwYL5hNJTpIKBtp5P1evPdB2tLDuIkI+I+OUyT9Iboh0C0zDTH7PNV6UoA
 mcodghDw7hcAA==
From: Mark Brown <broonie@kernel.org>
To: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
In-Reply-To: <20220622210629.286487-1-u.kleine-koenig@pengutronix.de>
References: <20220622210629.286487-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ASoC: topology: KUnit: Followup prototype change of
 snd_soc_unregister_card()
Message-Id: <165599272948.179867.17711982471875038786.b4-ty@kernel.org>
Date: Thu, 23 Jun 2022 14:58:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linmq006@gmail.com, lkp@intel.com, alexandre.belloni@bootlin.com,
 tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 kernel@pengutronix.de, codrin.ciubotariu@microchip.com,
 claudiu.beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
 nicolas.ferre@microchip.com
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

On Wed, 22 Jun 2022 23:06:29 +0200, Uwe Kleine-König wrote:
> snd_soc_unregister_card() was recently converted to return void. Only
> the first instance was adapted, so convert the remaining ones now to fix
> building the topology test.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: topology: KUnit: Followup prototype change of snd_soc_unregister_card()
      commit: d5017d1323d45db14d1db3d348779264ffce9fb2

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
