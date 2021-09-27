Return-Path: <SRS0=nO8j=OR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E85CC433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:49:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0098060F92
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Sep 2021 17:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0098060F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9972E16BE;
	Mon, 27 Sep 2021 19:48:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9972E16BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632764959;
	bh=i7blgZyfS+mFt4Ld57udc69/YXBlJ3xJDR6msSxUss0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KtnHHBD7ZNYz9Zklhohq2IMAMrdi4uH8XBvrA4PkD295xvBUQpJ73HPWTCZXt0+3l
	 eriOlmFWis0P+jFtKc7a590nNsWolev5C2/GICg4WNswkICagwFUBt3mWbAJpR4TV5
	 sP6pC/rJi82y0Y1vCz2V7g6jBV+5SI3Y4bs54FxM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3411DF804E6;
	Mon, 27 Sep 2021 19:47:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EAA4BF804E7; Mon, 27 Sep 2021 19:47:18 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 10637F804CA
 for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2021 19:47:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10637F804CA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DvEZzOqg"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE73560F44;
 Mon, 27 Sep 2021 17:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632764831;
 bh=i7blgZyfS+mFt4Ld57udc69/YXBlJ3xJDR6msSxUss0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DvEZzOqgxcVKBWCu+ZsDamv8nRi+d3PdzasFCR5Fo3wyJWYJheVfUXyL2KQT/9mCY
 lRVdJPkfOdW0GgNVnG68B3kxp8DULCEqhdCH9SBwwsEf3+0/JilAK+mF4aBV7mElzY
 Gsp0EffL0o0xGoU0sUfaKdvHN5hURWuHe/RVqi2LlBT+652j331D28NY2EPfuppSam
 Tf37q2rJZ3OVldRK0j8GTsBs01Ds6v2SgSX5bvZBSvNyhpGAV7NCz+ECJoffrVKsmb
 NO4v9uUyvYnfaaSoMWEK8HjjNdjc11o0BtIBTmDSuNOUiZqfaF51BCJ+0bULL5cNcY
 gKN6qgL+IBi+g==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Arnd Bergmann <arnd@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] ASoC: samsung: add missing "fallthrough;"
Date: Mon, 27 Sep 2021 18:45:26 +0100
Message-Id: <163276442024.18200.3747071344382107374.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210927095449.1070639-1-arnd@kernel.org>
References: <20210927095449.1070639-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
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

On Mon, 27 Sep 2021 11:54:34 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With gcc, we get a warning in this file:
> 
> In file included from include/linux/io.h:13,
>                  from sound/soc/samsung/s3c-i2s-v2.c:16:
> sound/soc/samsung/s3c-i2s-v2.c: In function 's3c2412_i2s_trigger':
> arch/arm/include/asm/io.h:92:22: error: this statement may fall through [-Werror=implicit-fallthrough=]
>  #define __raw_writel __raw_writel
>                       ^
> arch/arm/include/asm/io.h:299:29: note: in expansion of macro '__raw_writel'
>  #define writel_relaxed(v,c) __raw_writel((__force u32) cpu_to_le32(v),c)
>                              ^~~~~~~~~~~~
> arch/arm/include/asm/io.h:307:36: note: in expansion of macro 'writel_relaxed'
>  #define writel(v,c)  ({ __iowmb(); writel_relaxed(v,c); })
>                                     ^~~~~~~~~~~~~~
> sound/soc/samsung/s3c-i2s-v2.c:398:3: note: in expansion of macro 'writel'
>    writel(0x0, i2s->regs + S3C2412_IISFIC);
>    ^~~~~~
> sound/soc/samsung/s3c-i2s-v2.c:400:2: note: here
>   case SNDRV_PCM_TRIGGER_RESUME:
>   ^~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: samsung: add missing "fallthrough;"
      commit: 501849d97e532ca77371498e5a1b1881aab2e6d2

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
