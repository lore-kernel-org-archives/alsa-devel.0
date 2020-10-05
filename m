Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F14C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:57:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B13F20E65
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 17:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n23atxVS";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQOvT5nd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B13F20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF4C017A5;
	Mon,  5 Oct 2020 19:56:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF4C017A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601920652;
	bh=SQKQkTNhfPb6XvFeRuzE4kaFpekDmiYNXRhJtOtVZQE=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n23atxVScGIeXQL6nyICqvvxLMnFZmkY3QcRDgrgiRcnChSn8VIBXwrqM1EJEJPia
	 vCqmL1+x52fUzRlMHsM+ZnqoCIJwIsnRlMoz2uBZuHiLxH49dPpIblJASSjzJGmz1e
	 NlsdycXWSgE9OGQyLU7i9zOiLyLsUsrR4kZK9AiE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAA73F802A0;
	Mon,  5 Oct 2020 19:55:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 740EBF802A0; Mon,  5 Oct 2020 19:55:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F67EF800C9
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 19:55:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F67EF800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bQOvT5nd"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1872C207BC;
 Mon,  5 Oct 2020 17:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601920503;
 bh=SQKQkTNhfPb6XvFeRuzE4kaFpekDmiYNXRhJtOtVZQE=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=bQOvT5ndovLzvoydmZqVFCAkMTo9euKmQMeLWCi2pG5rKUs1+LLGaH8FuCHAUq94+
 TqQyY4jVgySrPXSJILsu50BUKulLItrd75+/f29Z8kAqJHHwSbJWYoAk71ZXxkF9jB
 IthixkZcsnrYgvo9yYgx/6DXf3AEFW9m16lsn8FM=
Date: Mon, 05 Oct 2020 18:54:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Tzung-Bi Shih <tzungbi@google.com>
In-Reply-To: <20201005074748.3394630-1-tzungbi@google.com>
References: <20201005074748.3394630-1-tzungbi@google.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8183-da7219: support jack detection for
 LINEOUT
Message-Id: <160192043040.23051.16492567737153672198.b4-ty@kernel.org>
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

On Mon, 5 Oct 2020 15:47:48 +0800, Tzung-Bi Shih wrote:
> Supports jack detection for LINEOUT.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8183-da7219: support jack detection for LINEOUT
      commit: 859ffd0af117e7ebc4d744a648551443cc90f150

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
