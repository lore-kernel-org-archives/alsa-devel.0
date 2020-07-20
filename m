Return-Path: <SRS0=gPEE=A7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E60C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:42:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155E322B4D
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I7U9LTPK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="djWD4X4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155E322B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93C8F1674;
	Mon, 20 Jul 2020 16:41:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93C8F1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595256128;
	bh=+auK55a4lJcssKkr7Cej4IkQyyeqOsJrBcmvKvm9b2M=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I7U9LTPKnuGaLFZKyFfvpeNganbGbUppVKy0c5BT8N+qpvk0B/iuO6p6xLVGE25p/
	 RwLdMjlnSzQdbtsIi31AW3YyaMAsQSbj2IzSCjR+VwcImcj1IDDB1/HUQxu/vkxPT4
	 7PGI99WRbuQmDQujLhv9CBxCp2ouKM8gd8sFnUjU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAF69F80290;
	Mon, 20 Jul 2020 16:39:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BBD92F802BD; Mon, 20 Jul 2020 16:39:00 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 05136F800F5
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2020 16:38:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 05136F800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="djWD4X4L"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 094DE22B4D;
 Mon, 20 Jul 2020 14:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595255931;
 bh=+auK55a4lJcssKkr7Cej4IkQyyeqOsJrBcmvKvm9b2M=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=djWD4X4Lcf415yldlZd+jRvzOVMBSvuXUMPmz7QKB4+OdKYT2tTvgTyT/Op9SM/qB
 4zVGFRCxneiDRsodjXiqU21i23Yz27pU+LkJa3x/H5gov5QpmAycTYG1hVe3t8bRae
 ONCNYfColjJ4PrOpldU9g6tpwEjnfz56ZrXjdfF8=
Date: Mon, 20 Jul 2020 15:38:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
In-Reply-To: <20200717215500.GA13910@embeddedor>
References: <20200717215500.GA13910@embeddedor>
Subject: Re: [PATCH][next] ASoC: Intel: Skylake: Avoid the use of one-element
 array
Message-Id: <159525589434.6792.8045971060889896063.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

On Fri, 17 Jul 2020 16:55:00 -0500, Gustavo A. R. Silva wrote:
> One-element arrays are being deprecated[1]. Replace the one-element
> array with a simple value type 'u8 reserved'[2], once it seems this
> is just a placeholder for alignment.
> 
> [1] https://github.com/KSPP/linux/issues/79
> [2] https://github.com/KSPP/linux/issues/86

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Skylake: Avoid the use of one-element array
      commit: 23f8d964f15a21991a166f0d1a7cf3cf8e4bfc9b

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
