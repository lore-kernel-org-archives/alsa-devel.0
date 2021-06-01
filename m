Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FA8C4708F
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 17:40:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C86C61378
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 17:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C86C61378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D981116D8;
	Tue,  1 Jun 2021 19:39:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D981116D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622569245;
	bh=jGFulKz5aiIUyaEwffq5AU8/gNHWfcxCHNazCV/IHJo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aoxLbkXjVhShml5q5yN67h1KyXYeMFffcTda6Mz59UrQCtpHyN85seJ+iwe458RO6
	 MNnVcV6JVKZhDjdkZM7eEG4dZC6krgxYce4fbaf7dWnlwFRHOR/JpXdBaFyLz5O3iX
	 tScf2RLK6Ayjopju1vsG1VwwkOvEfXphWgiWvNZI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3923BF804BB;
	Tue,  1 Jun 2021 19:39:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A431FF80254; Tue,  1 Jun 2021 19:38:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22176F80253
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 19:38:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22176F80253
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="psJlrYnK"
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2AF361378;
 Tue,  1 Jun 2021 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622569134;
 bh=jGFulKz5aiIUyaEwffq5AU8/gNHWfcxCHNazCV/IHJo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=psJlrYnKpNgKJ8SUR1ZFoFLqC1ZviwVUVQ6LdWWqboHYBzNXoTBEEGdUs7f7xVlcp
 UYOAewfuzFyylB9bqXtjJtt3TyuSVZ2A0+mcGSJOfhsGkQWn84aaPsP2oz4h/4o9de
 X9wridsH0+4A4UcvpgLqzBeOMwX4J09RVQJ+Q9dAM0mt6eOHlSTIxDGTCZIl6gfemn
 b4Q6F2MwjQchf1Ejfx0e196M36JkKEB8dxvZwaqcH+JfZlMhRjs5poIkSEz0JFjTzZ
 dVEZ5NFX7sJU3lK+MTTbx8Rr09Xa6zYWPukfOVkBqQIdz3FkFEp2DQaE3QTRjn37yV
 J28oDvKvqYyzA==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] ASoC: topology: Fix spelling mistake "vesion" -> "version"
Date: Tue,  1 Jun 2021 18:38:10 +0100
Message-Id: <162256892745.19919.2249782146567901885.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210601103506.9477-1-colin.king@canonical.com>
References: <20210601103506.9477-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org,
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

On Tue, 1 Jun 2021 11:35:06 +0100, Colin King wrote:
> There are spelling mistakes in comments. Fix them.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: topology: Fix spelling mistake "vesion" -> "version"
      commit: ce1f25718b2520d0210c24f1e4145d75c5620c9f

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
