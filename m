Return-Path: <SRS0=J9ZO=6P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ADAC4724C
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 16:48:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E4D206D6
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 16:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ODo01Px0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkkvTRn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E4D206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D30A16C5;
	Fri,  1 May 2020 18:47:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D30A16C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588351698;
	bh=Iteoj9IBmz6lTyQcpwnK4Bu1UwXFaMlfQlefpG9nMBs=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ODo01Px0uM89sIt9K5k0WeTsejaU9Ucu4ePuJTDRUvfshjk590d5bqkkpiAmcDPU4
	 DIY34I7nV49IHQPF8rN7Crwwno/53hGw0oP0OQwzqRy5T2UN7b/zZu/YSr+KAF9anS
	 kKJkUtlIYbUnte0ElRnVtVRBdpX/IfzPiKiS1szw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A6261F8028D;
	Fri,  1 May 2020 18:45:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35E7EF80257; Fri,  1 May 2020 18:45:50 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D5917F800B9
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2020 18:45:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5917F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="LkkvTRn6"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CA84D24954;
 Fri,  1 May 2020 16:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588351546;
 bh=Iteoj9IBmz6lTyQcpwnK4Bu1UwXFaMlfQlefpG9nMBs=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=LkkvTRn6uNas0WywmWidQ2JFb8Z4zeWNUlbXKnvjdXJRe8o/qu1rKfX9YanCKNQtP
 aGHXX34ctNbrpEdOjnMDtKXG8dp0W+Ukmkey3hq7AKaym2/lemft8h1C+Lne4Nf1cn
 hYOSoEGfUdWp3rAKTYPVlgzjeJcGHH+ZvMSVDhLE=
Date: Fri, 01 May 2020 17:45:43 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200501150611.15395-1-pierre-louis.bossart@linux.intel.com>
References: <20200501150611.15395-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: boards: sof-wm8804: support for Hifiberry
 Digiplus boards
Message-Id: <158835153189.13173.9938366604623937165.b4-ty@kernel.org>
Cc: tiwai@suse.de, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

On Fri, 1 May 2020 10:06:11 -0500, Pierre-Louis Bossart wrote:
> Add a new machine driver to interface with WM8804. The code is based
> on settings found in sound/soc/bcm/hifiberry-digi.c in the Raspberry
> PI tree.
> 
> Tested on Up2 with Digi+ IO (capture+playback) and Digi+ PRO (playback
> with two local oscillators supported). The codec is clock master in
> both cases.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: Intel: boards: sof-wm8804: support for Hifiberry Digiplus boards
      commit: f139546fb7d436145cbbffa346de7d5353c84fdf

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
