Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B5AC433E3
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:10:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B1020786
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TH3J0UrY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4zuPDC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B1020786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3699617E4;
	Tue, 18 Aug 2020 19:09:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3699617E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597770611;
	bh=ak6+QCL5n29G4GLWbvhUOxpo7V6NC6tHUrZDrPnF8Pc=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TH3J0UrYvmFsbVTQ+kEYf0Qeu4GbSRTg1j2fd1pHmj+HKmPtLijkOXecOrQHIFWJ2
	 CkbwxUsSe9PQPjbyYMIOaeolFIu5ZUI+JYFk/oxBaaPYWMsW3EwkdVs3BWka4oZ0V4
	 bsvNxOBej3KO2q/RubIQsBGq2jt4y+pWqbW8aTnw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4784EF803A6;
	Tue, 18 Aug 2020 18:56:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6724DF803A6; Tue, 18 Aug 2020 18:56:20 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8531F802A8
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 18:56:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8531F802A8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Q4zuPDC4"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D82F920825;
 Tue, 18 Aug 2020 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597769776;
 bh=ak6+QCL5n29G4GLWbvhUOxpo7V6NC6tHUrZDrPnF8Pc=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Q4zuPDC4Obrg7RPGEUput1lScWOndJrBqR+KVJcVRXyS42FLRHADsncbSCT2jMp4r
 1seJ867b9hUM6uZ2/rwGB7e/pzCLsdtgx5NmkHrPnrNbAz5Y3wX6pYIfbKGjsv1yWL
 R6LGyEqG4l9fZGzun99/SOoEWm0UcbzElnd+SLi4=
Date: Tue, 18 Aug 2020 17:55:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
 Takashi Iwai <tiwai@suse.com>
In-Reply-To: <cover.1597164865.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1597164865.git.Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 0/3] ASoC: da7219: Reorganise device/codec level
 probe/remove
Message-Id: <159776961932.56094.1814239239605160041.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, Yong Zhi <yong.zhi@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Support Opensource <support.opensource@diasemi.com>,
 linux-kernel@vger.kernel.org
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

On Tue, 11 Aug 2020 17:57:22 +0100, Adam Thomson wrote:
> This patch set reorganises and fixes device and codec level probe/remove
> handling within the driver, to allow clean probe and remove at the codec level.
> 
> This set relates to an issue raised by Yong Zhi where a codec level re-probe
> would fail due to clks still being registered from the previous instantiation.
> In addition some improvements around regulator handling and soft reset have
> also been included.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: da7219: Move required devm_* allocations to device level code
      commit: 21f279f34c212e82f0330697394840898908f7a6
[2/3] ASoC: da7219: Move soft reset handling to codec level probe
      commit: aa5b18d1c29023b315073661b74c67f91bf2f27c
[3/3] ASoC: da7219: Fix clock handling around codec level probe
      commit: 78013a1cf2971684775f6956d5666237ac53a1aa

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
