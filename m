Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427E7CA90AF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 16:46:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B995F20714
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 16:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TZd0d0E0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdXK2HcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B995F20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1D44816E7;
	Tue, 12 May 2020 18:45:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1D44816E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589302004;
	bh=HIPh/7Pej6FxAyJY1UIQvN4prK7E723HFpfiw6vDSfk=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TZd0d0E03ly15yggstV9hRkDaklrshQrjJJFzfBeuTlnE4KJPMoboZlrFZs5Y99jf
	 6SHi8FbGGCEq0TqWkr5ihSJS1stgMaOL6t3GdHXjn2M/ussZLFB0s8J3T+CvTeTMzK
	 vTDqLqiQyNic0oiMETO9sqSiJHuLfIzeOm5x82oY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7585AF8014C;
	Tue, 12 May 2020 18:45:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E04CF80291; Tue, 12 May 2020 18:45:05 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8695FF8021D
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 18:45:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8695FF8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="SdXK2HcD"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D50F20720;
 Tue, 12 May 2020 16:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589301899;
 bh=HIPh/7Pej6FxAyJY1UIQvN4prK7E723HFpfiw6vDSfk=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=SdXK2HcDTUQNahZO54CHbOKW0fQNrt//a/8i+Nwgy52LLng9X2Gq9TmQ7UZltrKRT
 xkvuAbUYYxEDu3a/45b5sustEBFxAGcpuCPWjvNAQLxWNDKNVfHJ0wVJS8uGxbtTjX
 +XWOhYI0/02jNATWfj7kXndA0HqvJnY1UY0GCtyY=
Date: Tue, 12 May 2020 17:44:56 +0100
From: Mark Brown <broonie@kernel.org>
To: lee.jones@linaro.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linus.walleij@linaro.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
In-Reply-To: <20200512100705.246349-1-christophe.jaillet@wanadoo.fr>
References: <20200512100705.246349-1-christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: ux500: mop500: Fix some refcounted resources issues
Message-Id: <158930188456.55827.11720310632308061350.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
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

On Tue, 12 May 2020 12:07:05 +0200, Christophe JAILLET wrote:
> There are 2 issues here:
>    - if one of the 'of_parse_phandle' fails, calling 'mop500_of_node_put()'
>      is a no-op because the 'mop500_dai_links' structure has not been
>      initialized yet, so the referenced are not decremented
>    - The reference stored in 'mop500_dai_links[i].codecs' is refcounted
>      only once in the probe and must be decremented only once.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: ux500: mop500: Fix some refcounted resources issues
      commit: 4e8748fcaeec073e3ba794871ce86c545e4f961f

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
