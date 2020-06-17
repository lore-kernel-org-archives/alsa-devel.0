Return-Path: <SRS0=fhRg=76=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A00C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:51:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B31721527
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o3mdAgBC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yp2qLsca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B31721527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1F658167E;
	Wed, 17 Jun 2020 18:50:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1F658167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592412706;
	bh=jKmBqGMw//TDq5d1AN61mPbBQRkBy3ivxqxYjKASoVA=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o3mdAgBCRVkm8CkuaNYvGnlWCjHHNVD3QoO2XJZt8UBbEyvEoz9LWTuw5e0Xd4WtC
	 UBgAbJCBqgCXXDq9WL8/XaB7qz7R4aLDAodIzrY6f++2vC7Xdhj55K2Bg9dXWfp8LF
	 YootnEXTMXZziO+iyIcBQjewPDCQ3E0JuJftaYFY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A42FF802DD;
	Wed, 17 Jun 2020 18:48:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6CF8BF802DF; Wed, 17 Jun 2020 18:48:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84CA7F802DC
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2020 18:48:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84CA7F802DC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="yp2qLsca"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1632E21532;
 Wed, 17 Jun 2020 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592412518;
 bh=jKmBqGMw//TDq5d1AN61mPbBQRkBy3ivxqxYjKASoVA=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=yp2qLscaYNDIVwrFhkLWX2B5HzhY7YccM3l+pUBHKnUwKRVEcmVTgaWk7CnhvqLmY
 OnhO4lTymyuSDYGW5bY2oCVivdPCCj4uYbJgD04NYyI3gietIFrORHzxhKWFfkLdMW
 psKHjNOdVbiAqyDAwnD8ITA/AJ/kJy5UKyjUm8Yk=
Date: Wed, 17 Jun 2020 17:48:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jerome Brunet <jbrunet@baylibre.com>
In-Reply-To: <20200617155047.1187256-1-jbrunet@baylibre.com>
References: <20200617155047.1187256-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] ASoC: meson: imply acodec glue on axg sound card
Message-Id: <159241251642.14602.5400773312595061016.b4-ty@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
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

On Wed, 17 Jun 2020 17:50:47 +0200, Jerome Brunet wrote:
> When axg card driver support is enabled, lets enable the related
> internal DAC glue by default.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: meson: imply acodec glue on axg sound card
      commit: e50186e1dae67e070d4725b1f0b35b131969141d

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
