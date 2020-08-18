Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6C7C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:57:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E7020786
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="suiidjhH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iun5+gKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E7020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D93881796;
	Tue, 18 Aug 2020 18:56:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D93881796
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597769829;
	bh=o+F/8MUlDhT4G3FDAIPoSIgrE0yLotwO8+CXdKAqBY4=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=suiidjhHJ2WIe4SfWIkjuXknHbUm9ykzrAERhHHEcegyZWLI8InpNz4Hc7aZh1m5R
	 7XPkjz3cs+6yImnE7GNdh5B4As9avSp/f7qYEQt1uxD5fdZK+lyZgl1yvqRj0WpGT8
	 n09IbaPjpXlcnqi4vfTMtCLVjARRMx6/2aoEQusM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C876FF802E0;
	Tue, 18 Aug 2020 18:54:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5ADB8F802E1; Tue, 18 Aug 2020 18:54:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B089AF802D2
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 18:54:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B089AF802D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Iun5+gKm"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B60E8207D3;
 Tue, 18 Aug 2020 16:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597769665;
 bh=o+F/8MUlDhT4G3FDAIPoSIgrE0yLotwO8+CXdKAqBY4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Iun5+gKm4tPHsYcb3nSxK4BbBKAPkse89tlznPIX2KkHyqObmvaMLTz4PfHnSx3+F
 20m03IEQPtSeFQM7/ReUzHtGAGduJgD4sgNaLM1VBVY1RzirlzilPhaeRaORIeSSPC
 i9GNDLJcxnjGdEqdGhQNt3tCLGoomN+q2euB43Vw=
Date: Tue, 18 Aug 2020 17:53:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
In-Reply-To: <20200801100257.22658-1-stephan@gerhold.net>
References: <20200801100257.22658-1-stephan@gerhold.net>
Subject: Re: [PATCH 1/3] ASoC: core: Add common helper to parse aux devs from
 device tree
Message-Id: <159776961932.56094.9628533027830690530.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-amlogic@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
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

On Sat, 1 Aug 2020 12:02:55 +0200, Stephan Gerhold wrote:
> simple-card.c and meson-card-utils.c use pretty much the same
> helper function to parse auxiliary devices from the device tree.
> 
> Make it easier for other drivers to parse these from the device tree
> as well by adding a shared helper function to soc-core.c.
> 
> snd_soc_of_parse_aux_devs() is pretty much a copy of
> meson_card_add_aux_devices() from meson-card-utils.c
> with two minor changes:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: core: Add common helper to parse aux devs from device tree
      commit: 1ae0965dc21698ba41638c95b5478779f3c4a9e4
[2/3] ASoC: simple-card: Use snd_soc_of_parse_aux_devs()
      commit: d9ffff696c5b468ba5a4ddb2cbc05c9e4dd4b2d1
[3/3] ASoC: meson: Use snd_soc_of_parse_aux_devs()
      commit: 6bc37d32f630363b68059e3fa854383e6abf171e

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
