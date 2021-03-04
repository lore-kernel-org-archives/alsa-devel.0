Return-Path: <SRS0=cpFx=IC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BA0C4332B
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84BC664DF2
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Mar 2021 01:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BC664DF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C2C21A9E;
	Thu,  4 Mar 2021 02:00:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C2C21A9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614819684;
	bh=W6uJ0LRqqdSu0y1TNFM4Cx4MwH09KexgWtJhcfuKeUc=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QajHGxfAzTolILbIdF8pFT80fN7v1+5BPdEi3qUUpl6MKIRNBoaoMdSn8H8j9oslU
	 5+dThNyEV/bqP7bxGxUiyg4XMFB3/ss6VhmL+VWDbfQhiI0pVTPMXozbDIQ7ZUEuRx
	 fz7awefL03uEQysgHQRzid+QlBvxSZEdrGW0Cgro=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B441F804FE;
	Thu,  4 Mar 2021 01:56:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61AEAF804FE; Thu,  4 Mar 2021 01:56:24 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99E58F804FD
 for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2021 01:56:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99E58F804FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jxHEpJba"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89E9064E7C;
 Thu,  4 Mar 2021 00:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614819380;
 bh=W6uJ0LRqqdSu0y1TNFM4Cx4MwH09KexgWtJhcfuKeUc=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=jxHEpJbasDjsC7LnOAP+1N8JfdQfyInxClGESqtIUUxSeoBErDdFdTmiOYOZqESrI
 hSp/2bJVM2zkUD5Rxns26ejmWpPhhObNGiUHFHgOVRaRaaptceLYnAxbeBfPbn+QtU
 kmwO0aHYGZFOJgxpP8Qvg/+xEm7mDCKRSzbVLPAW1nQ+u9azQxqSu6EOtLyYN8smyS
 v72YAv7mIiglLDKohcNXEwkeyc43Ii3slzCJrxMmRme0ARmiGVYYAW5++0eq+KFJDw
 KTQsavmBJ0M1ViV+sUGC+CR27GbSxutO2eOigQJuIfhnfEz0V6Wl6JbxAYqYFlkVXb
 Ags9Vdv61g8Ow==
From: Mark Brown <broonie@kernel.org>
To: paul@crapouillou.net, perex@perex.cz, lgirdwood@gmail.com, tiwai@suse.com,
 Tang Bin <tangbin@cmss.chinamobile.com>
In-Reply-To: <20210302135630.11456-1-tangbin@cmss.chinamobile.com>
References: <20210302135630.11456-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH v2] ASoC: codec: Omit superfluous error message in
 jz4760_codec_probe()
Message-Id: <161481924070.9553.9652910375356726257.b4-ty@kernel.org>
Date: Thu, 04 Mar 2021 00:54:00 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 2 Mar 2021 21:56:30 +0800, Tang Bin wrote:
> The function devm_platform_ioremap_resource has already contained
> error message, so remove the redundant dev_err here.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codec: Omit superfluous error message in jz4760_codec_probe()
      commit: 046c4e329066c50ff3ffd174ab95a0ac638807b4

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
