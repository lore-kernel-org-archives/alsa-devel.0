Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E61C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 11:02:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8518C61051
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 11:02:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8518C61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 255F61670;
	Mon, 13 Sep 2021 13:01:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 255F61670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631530948;
	bh=kGs+OZXsbrIogk6381WUNP6EKwqGTAnYr3RIhU3WhAc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h5BVP5E0kLzj5asnuMWDODKFPqI6jS7H6KUbbnp2VwgTuklFulow1IZBpJlyOBwy9
	 YUY19iK0Ujgw1gcvw/hwwvVCYju63FY3MZPNut0xUN5cCtDGtItVK2yzQB1a/9LfEB
	 JR2e06EP4lrS8M2g7LqftNWhOuRTjryrPkTgfCWo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AF06F80578;
	Mon, 13 Sep 2021 12:55:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D071F80579; Mon, 13 Sep 2021 12:55:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98CD4F8055B
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 12:55:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98CD4F8055B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hDXyV3lI"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B1C961051;
 Mon, 13 Sep 2021 10:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631530529;
 bh=kGs+OZXsbrIogk6381WUNP6EKwqGTAnYr3RIhU3WhAc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hDXyV3lIQc9EqHpNl20CDXwNBLMZImqhYXbqEmGkZMps+z+IpwxuijXlIyIk89VRN
 EV+dmoyy1eFCrNoZIWXNsDmdmT7jUYrA/klAUrM0aqA6CSGNiMF/XkXRxGqDqdsLyc
 xyXF1JIHbq+hcSd8z9FHrl9bH9KiSiWPS3YHVsJELy7EO1cns2uTeHT3CqADZgB0x4
 XMEar/d/bThNBNx39gGXiMXaE61TzyWoGaT+zN08ziyJyWS00PLjc1ja1dVIHnAKEw
 NNgj5uJjcYsEjE4ntf5tH4toXhq1yHs2nvxG/JS7/74FUUVo5LUZD6NgLDzEXMP3G7
 kGnMVkmoweHgA==
From: Mark Brown <broonie@kernel.org>
To: gearhead <ys3al35l@gmail.com>
Subject: Re: [PATCH] ASoC: pcm5102a: increase rate from 192k to 384k
Date: Mon, 13 Sep 2021 11:53:34 +0100
Message-Id: <163152996585.45703.8666875215162171211.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210907210130.116769-1-ys3al35l@gmail.com>
References: <20210907210130.116769-1-ys3al35l@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
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

On Tue, 7 Sep 2021 16:01:25 -0500, gearhead wrote:
> the pcm5102a is capable of 384k, but the current code limits it to 192k.
> This commit extends to 384k
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pcm5102a: increase rate from 192k to 384k
      commit: 0beeb330300f082e8b6849a9f83d34efa2578edd

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
