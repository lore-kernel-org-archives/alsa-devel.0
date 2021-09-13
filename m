Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C12C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 11:00:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5444610CB
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 11:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E5444610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F212166E;
	Mon, 13 Sep 2021 12:59:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F212166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631530824;
	bh=zKLNgw/N4ItjnA37Dj4lWg1ihUlvavhEp8ANwqjfJvw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jAvPbo8vEJbFX6yiOUGn0Ca9TJEvzpTdQn+f9a9qJ2hHL+563HU+QUhSnMgBw0l5U
	 8pYlMe8oOyrP/BEZufAvM8R9k31L7jgUddJ0epqh3feQ45x2N3+3Q3hKDx6H/K4lJv
	 3f+NM4J6yNXkTcaZ0LarQm87nnMwoCDeAruHyy18=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DC229F8053C;
	Mon, 13 Sep 2021 12:55:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D559CF80539; Mon, 13 Sep 2021 12:55:19 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F2969F80527
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 12:55:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F2969F80527
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="KGPQxch5"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1878961029;
 Mon, 13 Sep 2021 10:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631530514;
 bh=zKLNgw/N4ItjnA37Dj4lWg1ihUlvavhEp8ANwqjfJvw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KGPQxch5+yPc4VcVRwpqf2VL3nRO/bkDV2re8vxL1YIatShnClBCFFeCifLfTrmdZ
 yPV2Z7fYnUAwAlyt75G7RTm/ehoKVGgdoIo4/i47Gyyky+ma+VuGxhxEEpllOvHP/p
 vZvuN3YIi6f88jRp1xVBup39aZbD0ibbC90bJoZqOURTMpGHEzI48VdTp3Cu9ErCPo
 KtLcsajpz6plwfZXfxy2MPoUm5vaX3i4wlk2st4x76/6ETtVdi/aGaIG3HL9nTxWq8
 /qIVDHJxk4vCb/CrDbUnQ+rwfR/HYcffifxW6yrboqQ/BaHGz5mf2uQEw0TdiOGrkr
 6rej39/4c4U2w==
From: Mark Brown <broonie@kernel.org>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	lgirdwood@gmail.com
Subject: Re: [PATCH] ASoC: SOF: Handle control change notification from
 firmware
Date: Mon, 13 Sep 2021 11:53:28 +0100
Message-Id: <163152996583.45703.2526487392915647281.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210902115328.28478-1-peter.ujfalusi@linux.intel.com>
References: <20210902115328.28478-1-peter.ujfalusi@linux.intel.com>
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

On Thu, 2 Sep 2021 14:53:28 +0300, Peter Ujfalusi wrote:
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
