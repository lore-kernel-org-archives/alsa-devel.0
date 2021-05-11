Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0A3C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:29:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACAB61107
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACAB61107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8380177E;
	Tue, 11 May 2021 10:28:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8380177E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620721738;
	bh=L30a1+4Tbl/TeaJh6vWKaiZWOzmpIRsaaA0ATQLX8Fw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jBG+cqEZ1nvDi4vhYeA4abzoBAAtHLXS7uZfygtoIYhpxdAMuz1uBxQ3wTyG/mkwF
	 Xa8BLpzq30vi5+c0jrwy0dbhec7OKe5Md3Qsd9fLWOAb/RxFVBlfpDVWbCYWvu943/
	 Wn/8eo7n7rZ1kfMlGGw4x3W/1REumJZynnQR3OCM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 002FAF802E0;
	Tue, 11 May 2021 10:27:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D9F6F80425; Tue, 11 May 2021 10:27:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8778AF80279
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 10:27:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8778AF80279
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hYOqVl3Y"
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD29B61107;
 Tue, 11 May 2021 08:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620721652;
 bh=L30a1+4Tbl/TeaJh6vWKaiZWOzmpIRsaaA0ATQLX8Fw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hYOqVl3Y5hv0W0JZNBCv8IU5kRSZusxLVqsYh6s8j8WVTrIjgplw8db0CMcnga7y1
 JTH63nQA73gD9L9XjuIS2GKSGR2gkOQMnN08f8xvWpFpqj7WZIgpDUL0hJshCR/cDG
 fO8Roq9I7kVz2eMn7s+c/38+05F6heGXyZpDU305krCvZnL3FnH2pIiMC+FANCrlIP
 xPKpSgyc3QRa0wt+LgYESAaXRDwR6YIKPjvcwPQwsEHWqu79QoE7SEMrfUc3URLwl+
 Jr7bNVvQ62af/ziZlQVMZyGXhIH7Vp0z8AYaXk0JqXFZOtd0iXdziPRUM2UTGwA5fR
 ekTUWCmFT7JkA==
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
Subject: Re: [PATCH 0/4] ASoC: cppcheck fixes of the week
Date: Tue, 11 May 2021 09:25:46 +0100
Message-Id: <162072058167.33157.12131676069474491177.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210426214701.235106-1-pierre-louis.bossart@linux.intel.com>
References: <20210426214701.235106-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Mark Brown <broonie@kernel.org>
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

On Mon, 26 Apr 2021 16:46:57 -0500, Pierre-Louis Bossart wrote:
> While running some checks on a rebased branch, I realized I missed a
> couple of trivial cases on newer code.
> 
> Pierre-Louis Bossart (4):
>   ASoC: codecs: mt6359-accdet: remove useless initialization
>   ASoc: codecs: mt6359: remove useless initializations
>   ASoC: codecs: rt1019: clarify expression
>   ASoC: fsl: imx-pcm-rpmsg: remove useless initialization
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: codecs: mt6359-accdet: remove useless initialization
      commit: b76d1d86a456fa495f8f74c967b5d646f20915c3
[2/4] ASoc: codecs: mt6359: remove useless initializations
      commit: d51f6dfb9c9843f82825187baa78f0f4c1ec6ac7
[3/4] ASoC: codecs: rt1019: clarify expression
      commit: 16255d4155da9ec8fcafcd7460a334e2e52f934e
[4/4] ASoC: fsl: imx-pcm-rpmsg: remove useless initialization
      commit: cccc16dc175eafa2dec98002dde35d19ace0a696

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
