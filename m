Return-Path: <SRS0=4tTe=BK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3205C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:57:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772F52076B
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bppnHclI";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="w6GInhuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772F52076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1812316A0;
	Fri, 31 Jul 2020 20:56:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1812316A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596221850;
	bh=yrJbVZUY5Pi6FcqOv/OWCi+mhu7SPWBUvA+KLyph9yE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bppnHclIAYAAfvBQBeEhAvVhgwx4YATiGtw+50QPAR20n8gorzdUFHRxEIgrhUdE4
	 QQ4HvW36fZ6/yp7es6xyO8172TH9DW/xhXvF3m+H8wpm0jAQU9so/MVFo3oVPpLBuk
	 NwZsHmCKlk+75WzbxaRjO6TuRgu9XNWZc3KY85RY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 55E8CF802C4;
	Fri, 31 Jul 2020 20:55:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00BF3F802D2; Fri, 31 Jul 2020 20:55:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0511F802C3
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 20:55:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0511F802C3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="w6GInhuM"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8584922B3F;
 Fri, 31 Jul 2020 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596221705;
 bh=yrJbVZUY5Pi6FcqOv/OWCi+mhu7SPWBUvA+KLyph9yE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=w6GInhuMlgRoMF4Y0VQ63WAuJ47Gxe8ZME7ePguAE7tPuQNTKaLlIoKSdUNekqlAn
 phVvxiQXFayq5iolI6i52T8ARalt+AM2ubrM7aCOXFOfMYTbkqdWf534sStw9zYvxo
 idpAkeIOb6KEIhiofxPOpWuqaOJ2cmf69HlenX3Q=
Date: Fri, 31 Jul 2020 19:54:44 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com>
References: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: core: use less strict tests for dailink capabilities
Message-Id: <159622167150.22822.3333498789357611340.b4-ty@kernel.org>
Cc: tiwai@suse.de, Jerome Brunet <jbrunet@baylibre.com>
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

On Thu, 23 Jul 2020 13:05:33 -0500, Pierre-Louis Bossart wrote:
> Previous updates to set dailink capabilities and check dailink
> capabilities were based on a flawed assumption that all dais support
> the same capabilities as the dailink. This is true for TDM
> configurations but existing configurations use an amplifier and a
> capture device on the same dailink, and the tests would prevent the
> card from probing.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: core: use less strict tests for dailink capabilities
      commit: 4f8721542f7b75954bfad98c51aa59d683d35b50

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
