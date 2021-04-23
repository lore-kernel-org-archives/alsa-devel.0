Return-Path: <SRS0=7xvc=JU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFC8C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 18:08:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DAF6121D
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Apr 2021 18:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49DAF6121D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3A1E16D7;
	Fri, 23 Apr 2021 20:07:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3A1E16D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619201327;
	bh=xZMAFfIwOC8JNKwHNeamVmEBHf7rzE0y5ZofLPrLSIM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lb5YOITKoC/SSyjeF0Lo1EYIG5jM93+RItNrlqhianqEe5pTiZG7ArJyiTCt36d5m
	 7c+vbGT2GlS65oOexOxRFYnjZ1f52wWfWnhF/TO4fTi0Q7xGdB5qUzh1R0babpaGbK
	 5DNp09+pYP1unYBr/4KY0n/46NpiNzTipN4BzZek=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 25346F80274;
	Fri, 23 Apr 2021 20:07:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 690E4F8028B; Fri, 23 Apr 2021 20:07:07 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F3DCDF80227
 for <alsa-devel@alsa-project.org>; Fri, 23 Apr 2021 20:07:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3DCDF80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YYadOGkO"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2D2D61153;
 Fri, 23 Apr 2021 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619201220;
 bh=xZMAFfIwOC8JNKwHNeamVmEBHf7rzE0y5ZofLPrLSIM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YYadOGkOqrmeK++lXeRhF2MT+h2eOTcTKObJU7vD1ke9WMKgnnwGImCBDuVr6kFNd
 SM9ziciYl6ftpNeHkH9oFs2ZTu9ylc+PCWi3/NjKGjmCb8gqZEMVfd88w4v8y5UEdN
 3V+iIke41IGbdb6Nr7KN2hJAcMP5ZFsywfHyvTecYlxNbVib9Bf0QkjVjFK8QE3itT
 g8nGA7sY9v5R0iKcwxV3YUaKPJfLaGLoH8U/7Dkz31s5JLVDJyksIN+m1HSYYvaslN
 33i+y4wDzD0uZXca3o+NWLQADSog/m1RMU9ZVgOdUeCJz7NnrRXeWXfaiqD9vGPX4p
 4KM4C2K/qzEzw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com,
	shumingf@realtek.com
Subject: Re: [PATCH v2] ASoC: rt711-sdca: add the notification when volume
 changed
Date: Fri, 23 Apr 2021 19:06:20 +0100
Message-Id: <161920094856.15254.718425922012159843.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210422103235.22048-1-shumingf@realtek.com>
References: <20210422103235.22048-1-shumingf@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, libin.yang@intel.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, jack.yu@realtek.com, Mark Brown <broonie@kernel.org>,
 derek.fang@realtek.com, flove@realtek.com
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

On Thu, 22 Apr 2021 18:32:35 +0800, shumingf@realtek.com wrote:
> This patch adds the return value when the volume settings were changed.
> The userspace application might monitor the kcontrols to check which control changed.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt711-sdca: add the notification when volume changed
      commit: a1aee7f7b71155595a06f21f2d021b6a58d04017

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
