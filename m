Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4D1C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 00:01:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49CF7206F4
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 00:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NkCsbADY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAZ+uyuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49CF7206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D73FB15DC;
	Fri, 17 Jul 2020 02:00:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D73FB15DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594944071;
	bh=aELeuDsG4IY2ptyNPTOY+HaVRZce7/9sRpGlxA+LYKA=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NkCsbADYoYTb5F2qLgmG1KbfiUknUItAlguOGxhZqrVEIhppmNtdnV3Wpqu4nqngk
	 cbw+lXMQ6++vGsLIx9MJOed5Wdcv6c/tJqcHZyPlmWMl86A8b8355uFNhNtoiQCq4U
	 atCzBYCcA1H5pNRDVUldjwwtyw3TPCWmsygO/wcg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0E64F802E0;
	Fri, 17 Jul 2020 01:57:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C725F802C3; Fri, 17 Jul 2020 01:57:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 719BDF8027B
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 01:57:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 719BDF8027B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gAZ+uyuR"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6E2C920760;
 Thu, 16 Jul 2020 23:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594943842;
 bh=aELeuDsG4IY2ptyNPTOY+HaVRZce7/9sRpGlxA+LYKA=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=gAZ+uyuRpnmBVpS5fO5WGexMX7v6Xn2G4g/SHVKCoixrcqdhxAMrw+wSKz8WOFP6R
 qSjJyOn3QUg58rEjTij3UtF3MqOcdgSA/v/jNwLBLAeycnvGvSnBxez4TuS0BxanrP
 yG5VvutjwIM2IKUdosZMA1DGujmJoJ2eKj6HxX4M=
Date: Fri, 17 Jul 2020 00:57:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>, lgirdwood@gmail.com
In-Reply-To: <20200716030123.27122-1-oder_chiou@realtek.com>
References: <20200716030123.27122-1-oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5682: Report the button event in the headset type
 only
Message-Id: <159494380522.42174.10990228154241696852.b4-ty@kernel.org>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, cychiang@google.com,
 albertchen@realtek.com, derek.fang@realtek.com, shumingf@realtek.com,
 flove@realtek.com
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

On Thu, 16 Jul 2020 11:01:23 +0800, Oder Chiou wrote:
> The irq work will be manipulated by resume function, and it will report
> the wrong jack type while the jack type is headphone in the button event.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt5682: Report the button event in the headset type only
      commit: fe0a53044b4bce947045eadd7fa1adbc4685afab

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
