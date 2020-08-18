Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16F0C433E3
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:06:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C9F620786
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iEJf/3O3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuzu4QCh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C9F620786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92C7F17C7;
	Tue, 18 Aug 2020 19:05:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92C7F17C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597770407;
	bh=hHSmtDVIY9wvCckcynP2ozCoanH9pd5YofVkNjRLhvw=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iEJf/3O377Wj5DeQgkRZbSCrLSeG76uDcl4z9K5in/+zfFC98J9RMkMjiCqB+mNkj
	 5uYN+bpz+zAu7HjqoZHKhnkWUTWZ1gixPBGj8gHkekmQ0ygoGJe4g8KjnOOAuSvatK
	 A5Ph8z4hOslmCekB7+u6/ofvIX+vn+efHH2zfiHA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33ADAF8036D;
	Tue, 18 Aug 2020 18:55:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D4AAF8036E; Tue, 18 Aug 2020 18:55:49 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BBD8F8036C
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 18:55:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BBD8F8036C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fuzu4QCh"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7CB53207D3;
 Tue, 18 Aug 2020 16:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597769746;
 bh=hHSmtDVIY9wvCckcynP2ozCoanH9pd5YofVkNjRLhvw=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=fuzu4QCh/eUBqZVlnQLyDENXfe9fP6ZthCN3610AvoWiTn7BCcOPS0T96/oP51LVU
 GdZsNCZeLCPSfZJfNZM5290KevDyv+sMdVuEoLp2UlDXyg9ZxCYi+AY/+sHxvGxv6Q
 EwkylO4JS/mbmzg4mOh1/m+gilnyP8NDjg/K+mk4=
Date: Tue, 18 Aug 2020 17:55:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20200804141043.11425-1-s.nawrocki@samsung.com>
References: <CGME20200804141056eucas1p176f970fa509a9caa677837118c7ed50c@eucas1p1.samsung.com>
 <20200804141043.11425-1-s.nawrocki@samsung.com>
Subject: Re: [PATCH] ASoC: wm8994: Prevent access to invalid VU register bits
 on WM1811
Message-Id: <159776961933.56094.4140080567231152559.b4-ty@kernel.org>
Cc: simon@lineageos.org, alsa-devel@alsa-project.org,
 ckeepax@opensource.cirrus.com, b.zolnierkie@samsung.com,
 patches@opensource.cirrus.com, lgirdwood@gmail.com, m.szyprowski@samsung.com
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

On Tue, 4 Aug 2020 16:10:43 +0200, Sylwester Nawrocki wrote:
> The ADC2 and DAC2 are not available on WM1811 device. This patch moves
> the ADC2, DAC2 VU bitfields to a separate array so we can skip accessing
> them and avoid unreadable register access on WM1811.
> 
> This allows to get rid of warnings during boot like:
> wm8994-codec: ASoC: error at soc_component_read_no_lock on wm8994-codec: -5

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8994: Prevent access to invalid VU register bits on WM1811
      commit: 314213c15702f7598c486cf8c94f617719dfe339

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
