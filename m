Return-Path: <SRS0=W2oN=D2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C55FC43457
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:30:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E303A2231B
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="iuoaO1Ja";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="el6/GZIc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E303A2231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01A0D16FE;
	Mon, 19 Oct 2020 17:29:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01A0D16FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603121429;
	bh=BnYGr50OcLEGJPUKBBxaA6+WCjeux/4suQUJmQJG9y4=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iuoaO1Ja25rGFiLxSmBQvkB5x3EUzGHLzGkCFREY7Lkt7uXBGHaU1RxGPkj4Kr6BX
	 H7IllZWoK/RVAoTmhur7Fw24Z9vVw1IAe4FSnzrBZc/dEMiOfRJtehnP5CsxYTE2Ch
	 9DYvUfwOA+5GmiqgWXZZSMCkWUXf5t+iCgjGPD8Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 79F45F801D5;
	Mon, 19 Oct 2020 17:29:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C0EEF80247; Mon, 19 Oct 2020 17:29:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C6A14F801A3
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2020 17:29:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6A14F801A3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="el6/GZIc"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 62AF32231B;
 Mon, 19 Oct 2020 15:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603121365;
 bh=BnYGr50OcLEGJPUKBBxaA6+WCjeux/4suQUJmQJG9y4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=el6/GZIcVBjTJG1TSj5t5pTA/RFwY8nYW8h51AN1wvMDGSxb/jjmpYbI0toQbW6+h
 25OHF+Nm3pKKOScAyih3XdWRaEDTV8Mw3SMgJy5MohoOxbhCH1xXA0J6HWxmxqYX4I
 ycYMGwCS2D02wveWE2Ng2YTVopl/SumBSU3KoAHo=
Date: Mon, 19 Oct 2020 16:29:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20201019044724.1601476-1-tzungbi@google.com>
References: <20201019044724.1601476-1-tzungbi@google.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8183-da7219: fix DAPM paths for rt1015
Message-Id: <160312135572.55985.2663710685809756775.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org
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

On Mon, 19 Oct 2020 12:47:24 +0800, Tzung-Bi Shih wrote:
> RT1015's output widget name is "SPO" instead of "Speaker".  Fixes it to
> use the correct names.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8183-da7219: fix DAPM paths for rt1015
      commit: eb5a558705c7f63d06b4ddd072898b1ca894e053

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
