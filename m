Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6A4C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Apr 2022 22:28:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67791186E;
	Wed, 13 Apr 2022 00:27:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67791186E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649802479;
	bh=VqRfAFLFoRfWJldgRiRIY25GFSd4Ta7g9o7aklHvEBM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OLciFwY3/4mtFWk5ngBj5bnfElLfGFch9PbVIfFPdvk6P3h5vu66irgoO4J+R0im0
	 eaqeEw5xqwdg9qhbLgJQ6Fphsp83NzNfeUj/AMAvz3tMJaarh+rQ+JOS4juS1hc5Gj
	 yc8CE9HZTL6GAJNpCiE4yUKXlRkvnnL6DHPYTICM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAA10F80249;
	Wed, 13 Apr 2022 00:26:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3EACAF80134; Wed, 13 Apr 2022 00:26:38 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A82B4F80134
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2022 00:26:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A82B4F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="e6yfAnhC"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3D33DB82050;
 Tue, 12 Apr 2022 22:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3900C385A6;
 Tue, 12 Apr 2022 22:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649802391;
 bh=VqRfAFLFoRfWJldgRiRIY25GFSd4Ta7g9o7aklHvEBM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=e6yfAnhCdjKjb/cHk+E0lN3HbyLHNcsjIAGOjYMbTo7g4oYwefbjU630vbH2zoBDe
 8C2mBwIZvn1hosXmPoNHVUmKSXUVfDIwiedR/u3Rr5hNMBrkzj0U9GW8n4/xenWHoB
 83aqUpYaxPhVFZsNlDavPnD2Jc4MQzCs108d6FStpHaQDc/cDzN8ThF4mpOrYhu9hf
 nL2IMmXU/s36quFXT84Lsh2IyPLsvTTnjL+Ut1jOtMGzY1ZgtXSQGqC+P/ZabH7rUv
 yn9B+WZiOGUoSjJabjb6Y4YsthVHVKSg4wCs7JPo5Ej00Oay7RVXZ+RSeWO35+usPh
 2Y1aSej9TR+SA==
From: Mark Brown <broonie@kernel.org>
To: jmkrzyszt@gmail.com
In-Reply-To: <20220407191202.46206-1-jmkrzyszt@gmail.com>
References: <20220402120106.131118-1-jmkrzyszt@gmail.com>
 <20220407191202.46206-1-jmkrzyszt@gmail.com>
Subject: Re: [PATCH v2] ASoC: ti: osk5912: Make it CCF clk API compatible
Message-Id: <164980238972.480306.7278363796389340760.b4-ty@kernel.org>
Date: Tue, 12 Apr 2022 23:26:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
 peter.ujfalusi@gmail.com, lgirdwood@gmail.com
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

On Thu, 7 Apr 2022 21:12:02 +0200, Janusz Krzysztofik wrote:
> The driver, OMAP1 specific, now omits clk_prepare/unprepare() steps, not
> supported by OMAP1 custom implementation of clock API.  However, non-CCF
> stubs of those functions exist for use on such platforms until converted
> to CCF.
> 
> Update the driver to be compatible with CCF implementation of clock API.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: osk5912: Make it CCF clk API compatible
      commit: 90b76a3cb9bf208286851560cfc70830c91c1d3f

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
