Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E48CC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:05:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E123920789
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FxyCN3jK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF7Qn1Kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E123920789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D11D17BC;
	Tue, 18 Aug 2020 19:04:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D11D17BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597770312;
	bh=gqv4Huqtni8WALhihVYDMsmUJhBHF0Kyvn6tC+rp3dA=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FxyCN3jKQmUM2qRU89VN7DmTJrvFWe9zkSxiVlFAs6Ng72+vEg1hM2BR7qFXD0O4K
	 Il4/vyKE2L4wjBxl9iW6rekOa9APH1i0/cau2NtoColafWyscIFe5daCx3MdPCB+58
	 ifACJ4Xev9OTym0hnOK9mGP1GBQxEstyI12Qt7Es=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B26EF80350;
	Tue, 18 Aug 2020 18:55:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17C67F8034A; Tue, 18 Aug 2020 18:55:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37E41F80344
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 18:55:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37E41F80344
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MF7Qn1Kx"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 60167207D3;
 Tue, 18 Aug 2020 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597769730;
 bh=gqv4Huqtni8WALhihVYDMsmUJhBHF0Kyvn6tC+rp3dA=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=MF7Qn1KxMy9y1LZxTDYdv3S7xHufl5P1ej0WwhlaQCngMDslbnAHLlLl4KSRabIOn
 U9F7AKIfqejCPwWwjbBsEQZ2XosCqnbfuRW+nYOuLaQcPWKj6z5X5ABLNwgSSaVWH9
 BMvjoKDAY6YRFh8CI6iuVN6iNokPSMb591NQqDtI=
Date: Tue, 18 Aug 2020 17:55:00 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
In-Reply-To: <20200818004413.12852-1-brent.lu@intel.com>
References: <20200814083436.19845-1-brent.lu@intel.com>
 <20200818004413.12852-1-brent.lu@intel.com>
Subject: Re: [PATCH v2] ASoC: hdac_hdmi: support 'ELD' mixer
Message-Id: <159776961933.56094.5631231288603647018.b4-ty@kernel.org>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
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

On Tue, 18 Aug 2020 08:44:13 +0800, Brent Lu wrote:
> Add an binary mixer 'ELD' to each HDMI PCM device so user space
> could read the ELD data of external HDMI display.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: hdac_hdmi: support 'ELD' mixer
      commit: 1f53bcb3fc952b55a0ad0e7f6eabfc93a170659d

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
