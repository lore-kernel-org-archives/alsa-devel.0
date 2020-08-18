Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF66C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:42:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B0E2054F
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GC59JqfN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JITDFbdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B0E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5ABA17F9;
	Tue, 18 Aug 2020 19:41:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5ABA17F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597772549;
	bh=jw0rqgoKOxJjeFzL3PLrNSOLSmVzOndyFsCJBt1RmBE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GC59JqfNF99fw3BXJ5cHw3c/OJiU4al41pMZcGp/wVqT6Cg9+2iU7jJLaMKX1TEVn
	 ejj2i3XJTpByookh9egQOeIpgHgX4iELVzyuX1CQk0Sf/rP4Z+6/npCGnwOuV7Zt2D
	 hhxvsdEJXJXJpH9kJuq2kJSG7S9Nbg5BHVBiPKJw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 404C0F802A8;
	Tue, 18 Aug 2020 19:40:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9612CF802A9; Tue, 18 Aug 2020 19:40:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B718F802A1
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 19:39:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B718F802A1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="JITDFbdX"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5ED2D20738;
 Tue, 18 Aug 2020 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597772397;
 bh=jw0rqgoKOxJjeFzL3PLrNSOLSmVzOndyFsCJBt1RmBE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=JITDFbdXUSdL3CAO6S6oBsDueJ6T92UpvF2cvgIOiROsih1Att03rFWG8fDHlw8Kr
 5gt3MWB6+E0LwEoKV+J6QXsnwHozg+mfEoWWSvEb1Q5SEj1klVTkoZKaAbgD8OMGnD
 3qc8wxSPdiMVAh95d49Qx9j8IJ2vMKLzaQUYDKLo=
Date: Tue, 18 Aug 2020 18:39:27 +0100
From: Mark Brown <broonie@kernel.org>
To: heiko@sntech.de, Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20200818143727.5882-1-jbx6244@gmail.com>
References: <20200818143727.5882-1-jbx6244@gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: rockchip-spdif: add description for rk3308
Message-Id: <159777235702.24785.2371871958311959848.b4-ty@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, sugar.zhang@rock-chips.com,
 linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
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

On Tue, 18 Aug 2020 16:37:26 +0200, Johan Jonker wrote:
> A test with the command below shows that the compatible string
> 
> "rockchip,rk3308-spdif", "rockchip,rk3328-spdif"
> 
> is already in use, but is not added to a document.
> The current fallback string "rockchip,rk3328-spdif" points to a data
> set enum RK_SPDIF_RK3366 in rockchip_spdif.c that is not used both
> in the mainline as in the manufacturer kernel.
> (Of the enum only RK_SPDIF_RK3288 is used.)
> So if the properties don't change we might as well use the first SoC
> in line as fallback string and add the description for rk3308 as:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip-spdif: add description for rk3308
      commit: a8535ae7034e3547f4f7a8c7ca03a6ee72097fb0

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
