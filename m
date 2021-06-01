Return-Path: <SRS0=jKKe=K3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D282CC4708F
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 17:42:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C84613D2
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Jun 2021 17:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C84613D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E738316E4;
	Tue,  1 Jun 2021 19:41:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E738316E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622569336;
	bh=Y09JlCg2MGQstt58qhLtjjam7xzv7mhqTxwW01p4Eyg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=klCUmPg4IQadxTkIugWzFFxg77ADiDQkgesakmmhlOEYyMmhbfVoZWtCn/gCSsETT
	 PyKQhoFba4vWn55e+Gpzi+UhBse0hZAqkHaXWUsDzdg4dHJPP7qWXkp/06bfe2WmIl
	 HhrGo7qrNcPMea/wiVOBtKrF3oYT3HOZ4gj8pLuE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EBB8F804DA;
	Tue,  1 Jun 2021 19:39:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C8D6F804DA; Tue,  1 Jun 2021 19:39:08 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68238F804CC
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 19:39:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68238F804CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jik9CqIp"
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC3B2613DD;
 Tue,  1 Jun 2021 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622569143;
 bh=Y09JlCg2MGQstt58qhLtjjam7xzv7mhqTxwW01p4Eyg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jik9CqIpYkOPFmt6j54ZsPVwqpboLLXo57xFx5MbXBVwBiQpSM6KK9C2wsFtRhK33
 ADPsqnCvAEg/YyjwQFpp3ZLVN4vmSFFRZWqhWjc/wcrJY+4TCgUj28Bk9wz0vaYDfY
 kKawhDaZPC41wgqQ7hK/Xy8lUz20hnjWJXU8fO7abfMwS2PJ4TDJH45lnpXMwm5X/I
 EzAL3b6k3MSv5c+3VW7PDIqeDn0G4NKKlotspMlpN0zw3KJSxHNjAtOHstRaYROh1s
 wFYmkk6BCWYfHApY5G9UpwsuSQsBoqSpRYozrQFL89DCeGvZ9xjsRB5QzwpIIjLWhT
 pmRxxFqSyulTQ==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: SOF: Intel: hda: clean up hda_dsp_dump()
Date: Tue,  1 Jun 2021 18:38:14 +0100
Message-Id: <162256892744.19919.17769123257057992096.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210528160551.10145-1-kai.vehmanen@linux.intel.com>
References: <20210528160551.10145-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: daniel.baluta@nxp.com, pierre-louis.bossart@linux.intel.com,
 lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
 Bard Liao <bard.liao@intel.com>
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

On Fri, 28 May 2021 19:05:50 +0300, Kai Vehmanen wrote:
> Clean up the hda_dsp_dump() function to avoid duplicating
> the ROM status and error.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: Intel: hda: clean up hda_dsp_dump()
      commit: 7ff562fed98043b9e9eafa11db6100feb08412aa
[2/2] ASoC: SOF: Intel: hda: don't print ROM status if cl_dsp_init() fails
      commit: d95eca7e3b9f7c1361fc1e1329247490abec678c

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
