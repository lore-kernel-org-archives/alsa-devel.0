Return-Path: <SRS0=LwrQ=AT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58F6C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:04:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3006E2078D
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HbyCpYl4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2VF3kW0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3006E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7F471661;
	Wed,  8 Jul 2020 19:03:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7F471661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594227841;
	bh=mr6TEDk7rxgL1d8Hp+zwmyH6+KJ3ZLYAHThoUllaPNI=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HbyCpYl49sGkfkdjxNl1Ib7Zc4QDcRaCSd1Cgzk0c1eomgkhqI55K4BO2NGq2wOlf
	 +xOYPBezU7DECxFv9IhvgfJ9dw6WjrFg7+L1SshbPwRVqh3zE9Cdni/O4uw6HBPDDB
	 nq0NDYj8OJ5dIeOoCnUjp790nQz5E/4tcA7hGB+Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CA75F802EC;
	Wed,  8 Jul 2020 19:00:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9E6FF8015C; Wed,  8 Jul 2020 19:00:24 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC2A8F802EC
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2020 19:00:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC2A8F802EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="2VF3kW0M"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B7730207C4;
 Wed,  8 Jul 2020 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594227620;
 bh=mr6TEDk7rxgL1d8Hp+zwmyH6+KJ3ZLYAHThoUllaPNI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=2VF3kW0MHtOzhfEb4vVHOdZT92koA5bl+8/WYdUPTNGQdqxhi03xRiDWiNDesqutY
 Or7Rdzof0XTaJ3+26+g9tahl1lQGnkt122dNl0IlZAzSd4b+9Q8r8eH/FqsVDo/03x
 hoY7ygLvBm0cEGiFtJKD4cPQPnwucMJbHuiX0DRo=
Date: Wed, 08 Jul 2020 18:00:14 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200707204027.114169-1-pierre-louis.bossart@linux.intel.com>
References: <20200707204027.114169-1-pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: core: fix null-ptr-deref bug during device
 removal
Message-Id: <159422758800.28431.12015908556070138804.b4-ty@kernel.org>
Cc: tiwai@suse.de, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

On Tue, 7 Jul 2020 15:40:27 -0500, Pierre-Louis Bossart wrote:
> The DSP should be notified for device removal only if the
> probe was successful. Fixes the following KASAN bug:
> BUG: KASAN: null-ptr-deref in sof_ipc_tx_message+0x80/0x160 [snd_sof]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: core: fix null-ptr-deref bug during device removal
      commit: eceb5437ed0d41be5d12af3add58b3be2d5719e5

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
