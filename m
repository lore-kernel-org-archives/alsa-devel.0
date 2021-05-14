Return-Path: <SRS0=jeAA=KJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF902C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 15:54:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1162961446
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 15:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1162961446
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4669F175B;
	Fri, 14 May 2021 17:53:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4669F175B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621007663;
	bh=cVqiY7ShKf5bwHuqghVTdTvGT23m3+ogzrUveS3Oj3Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ECLbeKTowOsv92AvQhlGK1ZsRXMsK62xWSEgArSUNgUbrJ4ViHVd9wWhnSWA8ZTnT
	 nuRwOT785dJ4BRN6VbTp1LGw53gUOXih8NsyDrYbwMoFPGgHPlmuo2GPVbkTrj1eM4
	 PYACk68T/qXcJtUkClc022hAt05jIf2GFyFHfALQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3278F8013A;
	Fri, 14 May 2021 17:53:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD17AF80240; Fri, 14 May 2021 17:53:30 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77509F8013A
 for <alsa-devel@alsa-project.org>; Fri, 14 May 2021 17:53:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77509F8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="XySPMDjr"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A9AC613B9;
 Fri, 14 May 2021 15:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621007601;
 bh=cVqiY7ShKf5bwHuqghVTdTvGT23m3+ogzrUveS3Oj3Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XySPMDjrpVjzmLnjaBcfxQGcgZEJ2LIaPBweWi6MeW2pZmkupGo6+DXUm2xEMsmUi
 0rgU2Hbm0DNxDi5LLnaagxNeCSdxxk/iwCSWoaqxM2aiIY/nxCHzbXO21P/idUWjxq
 fk+KEmdW41meAUWdFGFmO5whHsdUSO7kb83qLjs08+NzqEJJ5Wtyv86eXasgQzrQtM
 7Da0z/ID4a6ge0pz37aWGrW107ZrL26oFDQH6M48t3RdBgqujBmK/cBMRNS3P6tWlk
 Nrt6Q4nFW+8B+RKrI6HNqD6SrhpxfOQFjpyJ3koAOiK4ZNWdHMf4/UVK4IisTwwama
 OQYBbRSviqfWg==
From: Mark Brown <broonie@kernel.org>
To: Jaska Uimonen <jaska.uimonen@linux.intel.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH v6] ASoC: topology: Add support for multiple kcontrol
 types to a widget
Date: Fri, 14 May 2021 16:52:40 +0100
Message-Id: <162100742208.4481.17045708754225729406.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210507070246.404446-1-jaska.uimonen@linux.intel.com>
References: <20210507070246.404446-1-jaska.uimonen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

On Fri, 7 May 2021 10:02:46 +0300, Jaska Uimonen wrote:
> Current dapm widget has a single variable to describe its kcontrol's
> type. As there can be many kcontrols in one widget it is inherently
> presumed that the types are the same.
> 
> Lately there has been use cases where different types of kcontrols would
> be needed for a single widget. Thus add pointer to dapm widget to hold
> an array for different kcontrol types and modify the kcontrol creation
> to operate in a loop based on individual kcontrol type.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: topology: Add support for multiple kcontrol types to a widget
      commit: d29d41e28eea65493395dda0b6d1fff23ca374f4

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
