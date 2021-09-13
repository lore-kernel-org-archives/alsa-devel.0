Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9769AC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:59:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280F961029
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 10:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 280F961029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5E0B1673;
	Mon, 13 Sep 2021 12:58:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5E0B1673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631530744;
	bh=urr39NOGuja/lGKt2SGPTT+gIVGhKMI6/EA0sZmCwDU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qu8sOZOh6hNLXuVh/bAUus67SWtWJwWZ9Vui0Dy/ZAmaXOr/pJuI5tj8vgpAduWS6
	 E1XeTPc93sPZ7LjrKK101zyExIMB4UyT8J3l8806W0VBphUE6+kqBENmCsK7jTboBs
	 XGDFUgwSvCnFT23Ze+TtiKcFO5m9pkOEgNvDo+E4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A329BF80520;
	Mon, 13 Sep 2021 12:55:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1CAAF80517; Mon, 13 Sep 2021 12:55:11 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B40AF80511
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 12:55:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B40AF80511
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AJfJr76P"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98ADF60F12;
 Mon, 13 Sep 2021 10:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631530507;
 bh=urr39NOGuja/lGKt2SGPTT+gIVGhKMI6/EA0sZmCwDU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AJfJr76POGgvpM5rCUsq+i2wYlQgi5jAlIBZU+b//YVvDtLhmziQWAfMVyxQ8fvgD
 v0B25QhGiO2PBZYWPM1NmGG0OLxxUhh0rxVnKxf5HDUnOPknRIBq0RDvqo4HBEd0u2
 XubiicoX6qQvLA4ciQssPr/JjemugSu65hjA+1xCCQSHotfUzrBZCiQ9bqRsKoWpki
 XdHTIXZflo9yc5QHN96hXVzjfK7Lr5TVAPgaXb/FKhvxcmbEVjbDGppx2yo7J9Y4nT
 zREmLQrhM7wqeZ0tyniIOkmTfBKPB6M8xma9kaWpejNYx0KxmMr1t9hWnaTCjEveXV
 j4WI4k6zbdkBg==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	lgirdwood@gmail.com
Subject: Re: [PATCH v2] ASoC: SOF: Handle control change notification from
 firmware
Date: Mon, 13 Sep 2021 11:53:25 +0100
Message-Id: <163152996584.45703.5186420214553492923.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210903114018.2962-1-peter.ujfalusi@linux.intel.com>
References: <20210903114018.2962-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, seppo.ingalsuo@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, Mark Brown <broonie@kernel.org>
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

On Fri, 3 Sep 2021 14:40:18 +0300, Peter Ujfalusi wrote:
> If the value/data associated with a control changes in SOF it will send a
> notification (SOF_IPC_GLB_COMP_MSG with SOF_IPC_COMP_GET_VALUE/DATA).
> 
> We have support for binary volatile control type, but we might have
> features where enum/switch/volume changes. Re-implementing everything as
> volatile as well would be not much of a gain for several reasons:
> - volatile controls would do an IPC all the time, regardless if there is a
>   need or not.
> - We still don't have notification which forces userspace to continuously
>   poll.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Handle control change notification from firmware
      commit: 756bbe4205bc63a84ab032a1b76970afe55e2d9d

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
