Return-Path: <SRS0=J9ZO=6P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633F1C47253
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 11:28:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E160F2166E
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 11:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uwK9efvw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="elpgVYOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E160F2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 290941692;
	Fri,  1 May 2020 13:27:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 290941692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588332507;
	bh=UH6cTiMh0sv5Uy7J2+m2eO6ibhJIWZOkBT9Uo7gNtjE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uwK9efvwRgi6q2wxC9pqxnlzMWPvSHEOIacUXuEc7YHSfyGgruY4+Gn319UfwmXFv
	 Wzq5i0CB63nmKz7ZJqMphcO5OOIXtZvuK9yXxXZdCXEPFFI06E2waWlTibWB+jnd4F
	 JIF5UTsmfnxADXTLvqDk5n4mQEXxkuwvdVzlSbIo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A87E2F80217;
	Fri,  1 May 2020 13:27:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F1D5F8022B; Fri,  1 May 2020 13:27:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15298F800B9;
 Fri,  1 May 2020 13:27:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15298F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="elpgVYOX"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A167120787;
 Fri,  1 May 2020 11:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588332447;
 bh=UH6cTiMh0sv5Uy7J2+m2eO6ibhJIWZOkBT9Uo7gNtjE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=elpgVYOXj6j3U2dToXz5PGIE7ixbJugnDAw13DbcaZMBI/kD8DsbeurAAFxgyu9eU
 YKyW7NlKD+rX/Mw9nMAt5n8nIsgXxfh3Sv/v9yU26hx80y+JsXJ/Rk+YGG4VyzuUVY
 mv5ej7bWO0eJUo/RUJ/bjJSNYOzloYCBrGUrFhY4=
Date: Fri, 01 May 2020 12:27:23 +0100
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, ranjani.sridharan@linux.intel.com
In-Reply-To: <20200430091139.7003-1-kai.heng.feng@canonical.com>
References: <20200430091139.7003-1-kai.heng.feng@canonical.com>
Subject: Re: [PATCH] ASoC: SOF: Update correct LED status at the first time
 usage of update_mute_led()
Message-Id: <158833244366.11565.11159142364410757346.b4-ty@kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE SOF DRIVERS"
 <sound-open-firmware@alsa-project.org>, Takashi Iwai <tiwai@suse.com>,
 Jaska Uimonen <jaska.uimonen@linux.intel.com>
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

On Thu, 30 Apr 2020 17:11:39 +0800, Kai-Heng Feng wrote:
> At the first time update_mute_led() gets called, if channels are already
> muted, the temp value equals to led_value as 0, skipping the following
> LED setting.
> 
> So set led_value to -1 as an uninitialized state, to update the correct
> LED status at first time usage.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

Thanks!

[1/1] ASoC: SOF: Update correct LED status at the first time usage of update_mute_led()
      commit: 49c22696348d6e7c8a2ecfd7e60fddfe188ded82

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
