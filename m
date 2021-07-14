Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA48C07E9A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 15:58:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69A0613CB
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 15:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69A0613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AB8C1695;
	Wed, 14 Jul 2021 17:57:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AB8C1695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626278290;
	bh=3TyinCZ5VJB7rC227gcyLdONuq3SVei/vupew92auTU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SmmoWbVKf0xePFZCLgLWXtC1Dss0CptSiWDbZ4Z+FrnSK/rYHsVEvIpIEM5McNJyM
	 LG7DHP2JmW6juSkJO2YDT2MMd9wFHk/quGV3EHD5jVazsMc2Ypqv4SypCydiHXnCF2
	 /eDwvOtqGiX7rKklSyL2D1ENS1lVp6KiNwbqcSY4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BCB0DF80300;
	Wed, 14 Jul 2021 17:56:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1B55CF804DF; Wed, 14 Jul 2021 17:56:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80EAFF80269
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 17:56:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80EAFF80269
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="K0USNMBT"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10000613CB;
 Wed, 14 Jul 2021 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626278182;
 bh=3TyinCZ5VJB7rC227gcyLdONuq3SVei/vupew92auTU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=K0USNMBTi0S4kTI6KR5gowr+5wN5CppjeLuB9fxPSjLtuU4re+a7L5Tz6CToKd6vo
 fDjGXxJ8tKtmAuUWrAF203HC7obrEzoCRrdpIrnSbDTbi9VRizjkqva67dxZBzcXHe
 I4uiwEdbOLToQ1uxqgFU4Dm9m7zgdqefYHlBNvJ7gVwcRctolGMQj4nm5nTp+dklaz
 onPpDbWQSUsU85N0WkA84BOfVW5XVOqgM+tYjcEobW91GsnH1N1XPnCZRXoP9EugO/
 CsS/2R/a9WJunJA7vjY+lRAR5BRcI9bnh92O8wImC2SOT48RFbAZoCu1ByUFItrOdg
 1P2crKxanIYFw==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/7] ASoC: Intel: updates for JasperLake and SoundWire
 machines
Date: Wed, 14 Jul 2021 16:55:22 +0100
Message-Id: <162627737186.54838.11058997567485079628.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210712203240.46960-1-pierre-louis.bossart@linux.intel.com>
References: <20210712203240.46960-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Mark Brown <broonie@kernel.org>
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

On Mon, 12 Jul 2021 15:32:33 -0500, Pierre-Louis Bossart wrote:
> The first 4 patches enable the use of a Maxim 98360a amplifier on
> JasperLake using the existing sof_cs42l42 machine driver, and a
> slightly different hardware layout compared to GeminiLake devices.
> 
> The last 3 patches reflect recent changes in the RT711 codec driver:
> we want to avoid duplicating the JD modes and can following the
> definitions from the codec driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: Intel: sof_cs42l42: support arbitrary DAI link sequence
      commit: 3cb97cf3a65a7fdbf4844ccd39b7e96fe14f762b
[2/7] ASoC: Intel: maxim-common: support max98360a
      commit: 07acee589f4293cb0ebd77aa201d616e9a296bb9
[3/7] ASoC: Intel: sof_cs42l42: add support for jsl_cs4242_mx98360a
      commit: 7d1bf46cb233aa80e684f61cde5f91530da3f3ea
[4/7] ASoC: Intel: sof_rt5682: code refactor for max98360a
      commit: 542d7050da19343ffe61f7b5d1fe2d44ccb0451a
[5/7] ASoC: Intel: sof_sdw: extends SOF_RT711_JDSRC to 4 bits
      commit: 368fa526e6e396972d5f0ed7c2a86ac0c3399ff3
[6/7] ASoC: Intel: sof_sdw: include rt711.h for RT711 JD mode
      commit: 8e6c00f1fdea9fdf727969d7485d417240d2a1f9
[7/7] ASoC: Intel: sof_sdw: update quirk for jack detection in ADL RVP
      commit: f28fbe57e84b4a6cfad314ea9bc3442d96f4fa08

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
