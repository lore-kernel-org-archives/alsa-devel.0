Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46611C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:43:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A0020738
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tUrLcLL9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hzo+tP9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A0020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E9921704;
	Fri, 21 Aug 2020 18:42:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E9921704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598028180;
	bh=QnjY/VFcbewfBWY2oBMpyWaYVXU9vNfdgnD66ugBr9A=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tUrLcLL9ArdsbPOrpaQlxwcGzI5xLDuZP+ouhX8v0Qr+NyXHrtqwqxepHrPWgi+Tn
	 dFAJ0PZIpLMaIN4/Ta98BthF+uHJPH1kx+06ygtiQ1NOijYtoaAO0Vp/IKoVLjNsjG
	 jYHu1s14r2QdVb7SEDbnyL0FyTiJGrDbPOpv1oqQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 12AD6F80260;
	Fri, 21 Aug 2020 18:40:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03F4BF80216; Fri, 21 Aug 2020 18:40:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62B95F800D2
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 18:40:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62B95F800D2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Hzo+tP9c"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6795A20738;
 Fri, 21 Aug 2020 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598028024;
 bh=QnjY/VFcbewfBWY2oBMpyWaYVXU9vNfdgnD66ugBr9A=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Hzo+tP9cvaHeSnm2808MqPMmTAtavmx4LQZDUF6xhXGpz3heLn5SH99io6n9tbiXn
 lacU8teN/F6hkhGYRTLxu8M0No78jvvfFWjjG9aoFWKx8V+4i6X1MAsvAoo+kd5l/E
 PmuIi04W/XThl+C9Gc8/5FNaoraUbuvYlfyvWNpU=
Date: Fri, 21 Aug 2020 17:39:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
In-Reply-To: <20200820154511.203072-1-stephan@gerhold.net>
References: <20200820154511.203072-1-stephan@gerhold.net>
Subject: Re: [PATCH] ASoC: qcom: Set card->owner to avoid warnings
Message-Id: <159802798183.25503.1648627855917940970.b4-ty@kernel.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>,
 Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org,
 Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rohit kumar <rohitkr@codeaurora.org>
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

On Thu, 20 Aug 2020 17:45:11 +0200, Stephan Gerhold wrote:
> On Linux 5.9-rc1 I get the following warning with apq8016-sbc:
> 
> WARNING: CPU: 2 PID: 69 at sound/core/init.c:207 snd_card_new+0x36c/0x3b0 [snd]
> CPU: 2 PID: 69 Comm: kworker/2:1 Not tainted 5.9.0-rc1 #1
> Workqueue: events deferred_probe_work_func
> pc : snd_card_new+0x36c/0x3b0 [snd]
> lr : snd_card_new+0xf4/0x3b0 [snd]
> Call trace:
>  snd_card_new+0x36c/0x3b0 [snd]
>  snd_soc_bind_card+0x340/0x9a0 [snd_soc_core]
>  snd_soc_register_card+0xf4/0x110 [snd_soc_core]
>  devm_snd_soc_register_card+0x44/0xa0 [snd_soc_core]
>  apq8016_sbc_platform_probe+0x11c/0x140 [snd_soc_apq8016_sbc]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Set card->owner to avoid warnings
      commit: 3c27ea23ffb43262da6c64964163895951aaed4e

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
