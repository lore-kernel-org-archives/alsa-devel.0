Return-Path: <SRS0=F1iH=ME=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E38C07E99
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 10:48:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E914961182
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 10:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E914961182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E00E0167C;
	Mon, 12 Jul 2021 12:47:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E00E0167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626086922;
	bh=5PffPv5m03zjdC6dKPsQKTxZb3xwC3EG8J4GrquSg/4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TVevW9/CCXsleSzPYvg+AHil2KD8h/CofRdLGA3QW1G4UXyTVN2k39MJTwfanC1rU
	 ysGlwCku5QUtCI9R5SsZwhbnfQXVH5SsNUvW/Azwww7IY2llj4wBD7jH7b1IgDiJBd
	 8HlDjyFAxsTlyG0M/lZSwOWTrqddS8lN37uCwZuM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58FBAF8025B;
	Mon, 12 Jul 2021 12:47:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8765F8025B; Mon, 12 Jul 2021 12:47:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 32266F800EB
 for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2021 12:47:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32266F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TFJeMjff"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4374561156;
 Mon, 12 Jul 2021 10:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626086857;
 bh=5PffPv5m03zjdC6dKPsQKTxZb3xwC3EG8J4GrquSg/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TFJeMjffarDB8EMjr4V5bym8i3Qv3YX433R8f5mlPxa9/1fpjhLDELX0n2/uVdgAw
 VIKghoFvKIabOKzsKUZ9FuAEqGERaxq/ZBH7giyCCCX4Yjs4opr93Gv7h7pW+q1fpn
 FktncyLWGIlSVywjMfEuJVXi48k+6hz9cFof1X4YoJe6h54w7ModDD1KVybWibhFz+
 ktVOnNL3GVfN8hkqGmBvFZcg2nZrF7LUSo6MPB9YtbLmzuq7fUZjckmJQKKkOZM/gi
 JfMb5HS5xJkKU02Yyfi7IhdJd4W7xDMGFLnI8VEzlxQfCtBXA4qKnqPpo8azvmxmtw
 4E5to9MyWAvIQ==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ASoC: ti: delete some dead code in omap_abe_probe()
Date: Mon, 12 Jul 2021 11:45:56 +0100
Message-Id: <162608623151.3192.14557258432919824298.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YNxTHXz58dhgbFtG@mwanda>
References: <YNxTHXz58dhgbFtG@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
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

On Wed, 30 Jun 2021 14:18:53 +0300, Dan Carpenter wrote:
> This code checks "priv->mclk_freq" twice and the second check is not
> required.  The code is left over from when removed support for legacy
> boot.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: delete some dead code in omap_abe_probe()
      commit: 3666a8f820075e99539ab50687e80fadf997822f

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
