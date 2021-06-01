Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E55C47080
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 17:39:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21CB613CE
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 17:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21CB613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4956C16CF;
	Tue,  1 Jun 2021 19:38:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4956C16CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622569189;
	bh=dAtxZOy1vRvHAbbRbK/qBv+43wjWQ0+17BwlinOpq4s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K7k27+wRNYfMowbZS8dKbOc9V35QbM3kQgHzXGDlVPO46F+fmZGmftFr2DkpRa0Uh
	 QpkI1FdbUtq2DH4r7MOjtzypqMS1ftMF4pMIEW+Jp09syYnz+Fzm1U9dhIUEjG5by5
	 cc9laEsossMneRuLTKw37fYX5XulN3pBwG9zVQTg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BC345F80141;
	Tue,  1 Jun 2021 19:38:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D63B4F80141; Tue,  1 Jun 2021 19:38:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E36FDF80141
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 19:38:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E36FDF80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="V5K+MU+E"
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA8AE613D1;
 Tue,  1 Jun 2021 17:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622569132;
 bh=dAtxZOy1vRvHAbbRbK/qBv+43wjWQ0+17BwlinOpq4s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V5K+MU+E8r8RLJtvkb2wbKyLDXWTxj5VGJ+xsGStLbL9GGI3dHtupY3M4JG4d5fVU
 2sFB/xkNe4jDFCUaRb+Z2mim35bODFuO8XI83N464YGgGWp9oHNfElMGowE4DES5CY
 PgfXWwRczf+1iyznnUz7FMb5eYcvj02lTmqMiYnBaawwkR3Eb3edGGCCNHF/5dnLtU
 YGmG05CK6TWgCjUU4GBrc8FkTgHFx0q8tFXQ4CC1aWYCaMsqgr9zCzllcv/d3s+sFc
 O3oFMhsOgw1dJ9Qds+U+Vuy0S8QG9uiQRd9LhKEW1Z+INiYLoXX4gJ7cu60NhllvfN
 bm/3xkVlpxvVA==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
 perex@perex.cz, jarkko.nikula@bitmer.com, peter.ujfalusi@gmail.com
Subject: Re: [PATCH -next] ASoC: ti: omap-mcbsp: use DEVICE_ATTR_RW macro
Date: Tue,  1 Jun 2021 18:38:09 +0100
Message-Id: <162256892743.19919.2315027944025849805.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210528063033.19904-1-yuehaibing@huawei.com>
References: <20210528063033.19904-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
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

On Fri, 28 May 2021 14:30:33 +0800, YueHaibing wrote:
> Use DEVICE_ATTR_RW() helper instead of plain DEVICE_ATTR(),
> which makes the code a bit shorter and easier to read.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: ti: omap-mcbsp: use DEVICE_ATTR_RW macro
      commit: b1b384de0a9be2d2913c8a308f381da0b9184e91

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
